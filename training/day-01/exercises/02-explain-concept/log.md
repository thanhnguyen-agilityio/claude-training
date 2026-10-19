# Task 2 — Log

Rubric: see [README.md](README.md). Scores marked *(proposed)* are the teacher's first pass. Confirm or change them.

## Scores

| Round | Change | Score /5 | What improved / what was still wrong |
|---|---|---|---|
| v1 | lazy prompt **+ 2 files attached** (`graph.py`, `utils.py`) | 3 *(proposed, before your own claim check)* | Accurate on the flow and the summarize steps. Too long, added an unrequested code review, and two claims are wrong (see claim check). |
| v2 | Stage (new to LangGraph, fixing a bug tomorrow) + Task + Rules (≤250 words, 1 diagram, no review, `file:line` or "unsure", 3 self-check questions) | 3 *(proposed; 4 once you verify 2 claims)* | Length, structure and honesty fixed, and every line reference is correct. Still repeats the helper's *intent* as if it works. |
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

**Prompt**
````
(paste your exact v2 prompt here. It was not included when the response was logged.)
(+ attached: graph.py, utils.py)
````

**Response** (diagram fence re-laid out from the paste)
`````
Flow (graph.py:163-164): START → `summarize_conversation` → `assistant`

messages ──► [+ summary prompt] ──► LLM ──► summary text
   │
   └─► keep_recent(last N + linked tool msgs) ──► delete the rest

`summarize_conversation`

* It does nothing if messages ≤ limit+1 (graph.py:100-103).
* It builds an "extend" or "create" prompt depending on the existing summary (107-113).
* It appends that prompt as a HumanMessage and asks the LLM for a summary (117-118).
* It asks the helper which messages to keep (121-124), then makes a RemoveMessage for every other message (125-128).
* It returns the new summary and the removals (130-133).

`handle_keep_recent_messages`

* It takes the last N messages (utils.py:165) and sets aside the older ones (166).
* It collects tool-call IDs from the kept messages (169-171).
* It then rescues older ToolMessages and AIMessages that belong to those IDs, so tool pairs aren't split (174-183), and returns the list (185).

Unsure

* Whether the assistant ever reads `summary`. `Assistant` doesn't (graph.py:42-55), and the prompt builder isn't in the files you pasted.
* How `RemoveMessage` interacts with messages lacking IDs. Nothing here shows it.

Line numbers are counted from the pasted text, so confirm them in your editor.

Check yourself

1. Which messages does `recent_messages` contain after the helper returns, and why can it exceed N?
2. What does the `messages` list passed to the helper contain that the saved state doesn't?
3. Where does the new `summary` end up after this node, and what reads it?
`````

### Rubric check (proposed)

| Criterion | Pt | Why |
|---|---|---|
| Graph flow | 0.5 | Shows `START → summarize_conversation → assistant`. Leaves out the tool loop and `END`. |
| What is kept / deleted | 1 | Summary + last N + linked tool messages, `RemoveMessage` for the rest. |
| Tool-call pairing rule and why trimming can break it | 0.5 | Says tool pairs "aren't split" but not how the cut can break them. It also says the helper does this, which it doesn't (below). Never mentions the `trim_messages` risk. |
| Level and length | 1 | About 230 words, one small diagram, no unrequested review. |
| Verified 2 claims | 0 | Waiting on you. Teacher pre-check below. |
| **Total** | **3** | 4 once you verify 2 claims. The rubric doesn't score honesty, which is v2's best gain. |

### Discernment: teacher pre-check
| Claim | Verdict |
|---|---|
| All `file:line` refs (graph.py 100-103, 107-113, 117-118, 121-128, 130-133, 163-164, 42-55; utils.py 165, 166, 169-171, 174-183, 185) | **All correct.** The "unsure" note about counting from pasted text was needless but harmless. |
| "Whether the assistant ever reads `summary`" is unknown | **Good call.** `get_chat_prompt` has no `{summary}` slot, so nothing reads it. |
| "It collects tool-call IDs from the kept messages (169-171)" | **True.** It does this from the recent `AIMessage.tool_calls`. |
| "…rescues older messages that belong to those IDs, **so tool pairs aren't split**" | **Wrong in effect.** The ids come from the recent `AIMessage`s, so a recent `ToolMessage` whose `AIMessage` was cut isn't rescued. Claude described the intent again. |

### Answers to the 3 self-check questions (try them first; open after)
<details><summary>Teacher's answers</summary>

1. `recent_messages` is the last N of `messages` (which includes the throwaway summary `HumanMessage`), plus any older messages the loop appends at the end (176-183). It can exceed N only through those appends. Note: the appended ones go after the recent ones, so the order in the returned list isn't the original order. Only ids matter for `RemoveMessage`, so it doesn't change state order.
2. The throwaway summary `HumanMessage` (`graph.py:117`). It has no id and was never saved to state.
3. In `state["summary"]` (a plain string) and, through the checkpointer, persisted. Nothing in the prompt reads it (`prompt.py:26-33`).
</details>

### What changed v1 → v2
| | v1 (+files) | v2 |
|---|---|---|
| Length | ~600 words + code review | ~230 words |
| `file:line` refs | none | all correct |
| Admits gaps | one hedge | 2 "Unsure" items, both real |
| False claims | 2 (helper works; memories frozen) | 1 (helper's purpose) |
| Score (proposed) | 3 | 3 |

Rules gave you the shape. **They did not make Claude check the code.** "Explain" asks for a description, and a description can't find a bug in what it describes.

**v3 idea (one change):** ask Claude to *execute* instead of explain. Give it a concrete input and tell it to trace the helper by hand:
```
Trace `handle_keep_recent_messages` by hand with N=5 on this history and show the returned list:
[Human, AI(tool_calls a,b), Tool a, Tool b, AI, Human, AI, Human]
Is any ToolMessage left without its AIMessage? Quote the lines that decide it.
```

---

## v3: fix one gap

_To do._

---

**Best prompt (copy to `../../notes.md`):**
```

```
**Surprise (good/bad):**
