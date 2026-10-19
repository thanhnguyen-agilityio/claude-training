# Task 2 — Log

Rubric: see [README.md](README.md). Scores marked *(proposed)* are the teacher's first pass. Confirm or change them.

## Scores

| Round | Change | Score /5 | What improved / what was still wrong |
|---|---|---|---|
| v1 | lazy prompt **+ 2 files attached** (`graph.py`, `utils.py`) | 3 *(proposed, before your own claim check)* | Accurate on the flow and the summarize steps. Too long, added an unrequested code review, and two claims are wrong (see claim check). |
| v2 | | | |
| v3 | | | |

## Claim check (Discernment)

Teacher pre-check of v1 (verified against the repo). **Pick 2 of these and re-check them yourself**, or add your own rows.

| Claim Claude made | File:line you checked | True / false / partly |
|---|---|---|
| Flow: `START → summarize_conversation → assistant ⇄ tools → END`, summarizer runs once per turn | `graph.py:163-171` | **True** |
| No-op when history has `RECENT_MESSAGE_LIMIT + 1` messages or fewer | `graph.py:99-102`, `constants.py:37` (default 5) | **True** |
| `handle_keep_recent_messages` keeps the last N and "pulls back" any older `AIMessage`/`ToolMessage` so there is no orphaned tool result | `utils.py:156-184` | **False.** It collects ids from `tool_calls` of the *recent* `AIMessage`s, but the orphan case needs the ids from the recent `ToolMessage`s. A stub run (see Findings) kept `[Tool:b, AI, Human, AI, Human]` with the `AI['a','b']` deleted. |
| The `summary` string probably never reaches the model | `prompt.py:26-33` | **True.** `get_chat_prompt` has only a system message with memories, plus `{messages}`. No `{summary}`. Claude hedged correctly ("unless `get_chat_prompt` has a slot I can't see"). |
| Off-by-one: `messages[-N:]` includes the throwaway summary `HumanMessage`, so only N−1 real messages stay | `graph.py:117,121-124` | **True** |
| `Assistant` trims to 1000 tokens (`trim_messages`), local only, nothing deleted from the checkpoint | `graph.py:42-55` | **True** |
| Re-triggers "almost every turn" | `graph.py:99-102` | **Partly.** After a prune you hold about 4-5 messages. A plain Q&A adds 2 per turn, so it fires roughly every other turn. Tool calls add more, so it fires more often then. |
| Memories are frozen, "won't appear until the graph is rebuilt" | `chat.py:26,62,112,126` | **Mostly false.** `init_graph` is called on every request, so memories are re-read each request. They are frozen only within one request. |
| `trim_messages` without `start_on="human"` can start mid-tool-sequence | `graph.py:44-50` | **Plausible, and a second suspect for the Task 1 bug.** The ticket's failing call is at `graph.py:53`, right after this trim. Not tested. |

---

## v1: lazy prompt (+ 2 files)

**Deviation from the plan:** the task said to send the prompt with *no* code attached. This run attached `graph.py` and `utils.py`. So v1 already has the main fix planned for v2. Keep that in mind when comparing rounds.
Shared chat (not readable by the teacher, response pasted below): https://claude.ai/share/b7d22d92-91fa-4995-a0aa-ac718716bbde

**Prompt**
````
explain langraph conversation summary
(+ attached: sample-project/server/agent/graph.py, sample-project/server/utils/utils.py)
````

**Response** (code fences re-laid out from the paste)
`````
How conversation summary works in your graph

The flow

START → summarize_conversation → assistant ⇄ (safe_tools | sensitive_tools) → END

`summarize_conversation` runs once at the start of every user turn. The tool loop goes back to `assistant`, not to the summarizer, so it doesn't re-run mid-turn.

What `summarize_conversation` does

1. Threshold check. If the history has `RECENT_MESSAGE_LIMIT + 1` messages or fewer, it returns without doing anything.
2. Build the summary prompt.
   * If `state["summary"]` already exists, it asks the model to extend it.
   * Otherwise it asks for a fresh summary.
   * Either way, the instruction is appended to the history as a `HumanMessage`.
3. Call `gpt-4o-mini`. The response text becomes the new `summary`.
4. Choose what to keep. `handle_keep_recent_messages` keeps the last N messages. It also pulls back any older `AIMessage` with `tool_calls` and any `ToolMessage` that pairs with a tool call in the kept window. This stops you from leaving an orphaned tool result, which would cause an `INVALID_CHAT_HISTORY` error.
5. Delete the rest. It returns `RemoveMessage(id=...)` for everything not kept. LangGraph's `add_messages` reducer treats these as deletions, and the checkpointer persists the trimmed history along with the `summary` string.

So the design is a rolling summary: old messages are compressed into one string that is updated each time, and only recent messages stay verbatim.

Second layer: `trim_messages` in `Assistant`

Before each model call, `Assistant.__call__` trims to 1000 tokens, keeping the last messages. This only affects what the model sees on that call. It writes to the local `state` and returns only `{"messages": result}`, so nothing is deleted from the checkpoint. It's a token safety net, while the summarizer controls what persists.

Problems I see

1. The summary probably never reaches the model. `summary` is saved in state, but `Assistant` only passes `state` to a runnable built from `get_chat_prompt(system_message, memories)`. Unless `get_chat_prompt` has a `{summary}` slot that I can't see in `prompt.py`, the deleted messages are lost. A fix is to inject it in `Assistant.__call__`:

   if state.get("summary"):
       messages = [SystemMessage(content=f"Conversation summary so far: {state['summary']}")] + messages

2. Off-by-one in the kept window. `messages` already includes the summary-instruction `HumanMessage`, so `messages[-N:]` includes that throwaway prompt. You effectively keep N-1 real messages.
3. It re-triggers almost every turn. After pruning to about N messages, one new exchange pushes you back over `N + 1`, so you pay for an LLM call nearly every turn. A larger gap between the trigger threshold and the kept count (say trigger at 12, keep 4) would summarize less often.
4. Early return. `return state` returns the full message list instead of `{}`. It's harmless but wasteful, since it re-writes every message through the reducer.
5. Trimming can split tool pairs. `trim_messages` with `allow_partial=False` can still start mid-tool-sequence. Adding `start_on="human"` avoids that.
6. Memories are frozen. `create_assistant_runnable` reads the store once in `init_graph`, so memories added during a session won't appear until the graph is rebuilt.

If you share `prompt.py`, I can confirm whether problem 1 applies and suggest the exact change.
`````

### Rubric check (proposed)

| Criterion | Pt | Why |
|---|---|---|
| Graph flow | 1 | Correct, and the "once per turn, not mid-tool-loop" detail is right. |
| What is kept / deleted | 1 | Summary string + last N, `RemoveMessage` through `add_messages`. All correct. |
| Tool-call pairing rule and why trimming can break it | 0.5 | States the rule and the 1000-token `trim_messages` risk. But it says `handle_keep_recent_messages` *prevents* orphans, and it doesn't. |
| Level and length | 0.5 | Right level for a developer. But about 600 words, and a 6-point code review nobody asked for. |
| Verified 2 claims | 0 | Waiting on you. Teacher pre-check is in the claim table above. |
| **Total** | **3** | Could reach 4 to 5 once you verify 2 claims. |

### Findings

**1. The biggest "False" is the one that matters.** Claude read the intent of `handle_keep_recent_messages` (and its docstring) and described it as working. The logic runs the wrong way:
- It builds `tool_call_ids` from `tool_calls` on the *recent* `AIMessage`s.
- An orphan happens when a recent `ToolMessage` has its `AIMessage` in the *removed* part. The ids needed are the recent `ToolMessage.tool_call_id`s.
- Stub run (copied function, stub message classes, **not real LangChain**): history `[H, AI[a,b], Tool:a, Tool:b, AI, H, AI, H]` with N=5 keeps `[Tool:b, AI, H, AI, H]`. The `AI[a,b]` is deleted, so `Tool:b` is an orphan. That matches the Task 1 error.

This is a strong candidate for the Task 1 root cause. **Day 2 still has to reproduce it with the real code and write the failing test.** The second candidate is `trim_messages` without `start_on`.

**2. Attaching the files made the answer mostly right, and it still got the key claim wrong.** This repeats the Task 1 lesson: Claude can describe what code is meant to do instead of what it does.

**3. Claude's problem 1 is real and worth a ticket.** The summary is saved and never used by the prompt, so after a summarization the model loses the older context. It is separate from the 400 error.

**4. Problem 6 is wrong** because `init_graph` runs per request.

---

## v2: framed (Stage / Task / Rules)

_To do._

## v3: fix one gap

_To do._

---

**Best prompt (copy to `../../notes.md`):**
```

```
**Surprise (good/bad):**
