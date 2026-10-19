# Task 2 — Log

Rubric: see [README.md](README.md). Scores marked *(proposed)* are the teacher's first pass. Confirm or change them.

## Scores

Scores include +1 for your own claim check (done).

| Round | Change | Score /5 | What improved / what was still wrong |
|---|---|---|---|
| v1 | lazy prompt **+ 2 files attached** (`graph.py`, `utils.py`) | 4 *(3 + 1 for your claim check)* | Accurate on the flow and the summarize steps. Too long, added an unrequested code review, and two claims are wrong (see claim check). |
| v2 | Stage (new to LangGraph, fixing a bug tomorrow) + Task + Rules (≤250 words, 1 diagram, no review, `file:line` or "unsure", 3 self-check questions) | 4 *(3 + 1 for your claim check)* | Length, structure and honesty fixed, and every line reference is correct. Still repeats the helper's *intent* as if it works. |
| v3 | Added a hand trace: "trace `handle_keep_recent_messages` by hand with N=5 on this history… is any ToolMessage left without its AIMessage?" | 5 *(4 + 1 for your claim check)* | Found the bug. The trace matches my stub run, with the deciding lines quoted. |

## Claim check (Discernment)

Teacher pre-check of v1 (verified against the repo). **You verified 2 claims yourself** (which two: add the rows below).

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
| Verified 2 claims | 1 | You checked 2 claims against the code. |
| **Total** | **4** | 3 before your claim check. |

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
I'm a developer new to LangGraph. I need to fix a bug in this summarization code tomorrow, so I need to understand how it works, not review it. Explain how `summarize_conversation` and `handle_keep_recent_messages` work together. Rules: max 250 words; one small diagram; no code review or fixes; after every claim about the code, give the file:line, or say "unsure". End with 3 questions I should able to answer if I understand it.
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
| Verified 2 claims | 1 | You checked 2 claims against the code. |
| **Total** | **4** | 3 before your claim check. The rubric doesn't score honesty, which is v2's best gain. |

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
3. In `state["summary"]` (a plain string), persisted by the checkpointer. The only reader is `summarize_conversation` itself on the next run (`graph.py:105-110`). Nothing in the prompt reads it (`prompt.py:26-33`).
</details>

### Your answers to the 3 self-check questions

| # | Your answer | Grade | Fix |
|---|---|---|---|
| 1 | It appends messages back to `recent_messages` if the kept messages have a tool call id | **Mostly right** | Add the base: it starts as the last N of `messages` (`utils.py:165`). Appends then go at the *end*, so the order changes. Only the ids matter for `RemoveMessage`, so state order isn't affected. |
| 2 | The state messages and the summary human message | **Mostly right** | The question was what the list has that the saved state *doesn't*. That's only the summary `HumanMessage`. The state messages are in both. |
| 3 | Nothing reads the state summary | **Half right** | Nothing in the *prompt* reads it (`prompt.py:26-33`), which is the important finding. But `summarize_conversation` itself reads it next time to extend it (`graph.py:105-110`). It ends up in `state["summary"]`, saved by the checkpointer. |

**Score: 2.5/3.** Q3 is the one to remember. "Nothing reads it" is true for the model call and false for the graph. The summary is written, read by the summarizer, and never shown to the assistant. So the model forgets what was deleted, and the summary only ever feeds the next summary.

I also said "nothing reads it" in my last message. That was too loose. The wording above is the precise one.

---

### What changed v1 → v2
| | v1 (+files) | v2 |
|---|---|---|
| Length | ~600 words + code review | ~230 words |
| `file:line` refs | none | all correct |
| Admits gaps | one hedge | 2 "Unsure" items, both real |
| False claims | 2 (helper works; memories frozen) | 1 (helper's purpose) |
| Score (proposed) | 4 | 4 |

Rules gave you the shape. **They did not make Claude check the code.** "Explain" asks for a description, and a description can't find a bug in what it describes.

**v3 idea (one change):** ask Claude to *execute* instead of explain. Give it a concrete input and tell it to trace the helper by hand:
```
Trace `handle_keep_recent_messages` by hand with N=5 on this history and show the returned list:
[Human, AI(tool_calls a,b), Tool a, Tool b, AI, Human, AI, Human]
Is any ToolMessage left without its AIMessage? Quote the lines that decide it.
```

---

## v3: add a trace (execute, don't just explain)

**Change (one thing only, vs v2):** appended a hand trace on a concrete input and asked whether any `ToolMessage` is left without its `AIMessage`.

**Prompt** (files attached: `graph.py`, `utils.py`)
````
I'm a developer new to LangGraph. I need to fix a bug in this summarization code tomorrow, so I need to understand how it works, not review it. Explain how `summarize_conversation` and `handle_keep_recent_messages` work together.
Rules: max 250 words; one small diagram; no code review or fixes; after every claim about the code, give the file:line, or say "unsure". End with 3 questions I should be able to answer if I understand it.

Then trace `handle_keep_recent_messages` by hand (this part does not count toward the 250 words). Use recent_messages_number=5 and this input list:
[Human, AI(tool_calls a,b), Tool a, Tool b, AI, Human, AI, Human]
Show the returned list. Is any ToolMessage left without the AIMessage that called it? Quote the lines that decide it.
````

**Response** (diagram fence re-laid out from the paste)
`````
How they work together
`summarize_conversation` runs first after START (graph.py:163-164). It returns early if there are `RECENT_MESSAGE_LIMIT + 1` messages or fewer (graph.py:100-103). The constant's value is unsure, because constants.py wasn't provided.
Otherwise it appends a summary-request HumanMessage (graph.py:117) and asks gpt-4o-mini for the summary (graph.py:118). It then asks `handle_keep_recent_messages` which messages to keep (graph.py:121-124). Everything not returned becomes a `RemoveMessage` (graph.py:125-128). The node returns the summary text plus those deletions (graph.py:130-133).
The helper slices the last N messages (utils.py:165) and collects tool-call IDs from them (utils.py:169-171). It then scans the older messages and re-adds any ToolMessage or AIMessage matching those IDs (utils.py:174-183).

state.messages ──(+prompt, graph:117)──┬─► LLM ─► state["summary"] (graph:131)
                                       └─► handle_keep_recent_messages (graph:121)
                                              last N + rescued (utils:165-183)
everything else ─► RemoveMessage (graph:125-128)

Whether `summary` reaches the prompt: unsure (`get_chat_prompt` isn't shown).
Check yourself:

1. Which messages does the LLM summarize: the full list or only the ones being deleted?
2. Which message types contribute IDs to `tool_call_ids`?
3. The node returns only RemoveMessages in `messages`. What does that do to state?

Hand trace (n=5)
Input indices: 0 Human, 1 AI(a,b), 2 Tool a, 3 Tool b, 4 AI, 5 Human, 6 AI, 7 Human.

* `recent_messages = messages[-5:]` gives idx 3-7 (utils.py:165).
* `remove_messages = messages[:-5]` gives idx 0-2 (utils.py:166).
* Loop at utils.py:169-171: this assumes AIMessage always has a `tool_calls` attribute, empty by default, and Human/Tool messages don't. AI(4) and AI(6) contribute nothing, so `tool_call_ids` stays empty.
* Rescue loop at utils.py:174-183: Human(0) matches neither branch. Tool a (2) fails the `in tool_call_ids` test, and AI(1) fails the `any(...)` test, both against an empty set. Nothing is appended.

Returned list: `[Tool b, AI(4), Human(5), AI(6), Human(7)]`
Is a ToolMessage orphaned? Yes. Tool b is kept, but its calling AI(a,b) at idx 1 is not.
Lines that decide it:

* utils.py:165: `recent_messages = messages[-recent_messages_number:]` puts Tool b inside the kept slice.
* utils.py:170-171: `if hasattr(msg, 'tool_calls'): tool_call_ids.update([tc["id"] for tc in msg.tool_calls])` collects IDs only from AI messages in the recent slice. None of them have tool calls, so the set is empty.
* utils.py:176: `if isinstance(msg, ToolMessage) and msg.tool_call_id in tool_call_ids:`
* utils.py:178-181: `isinstance(msg, AIMessage) and msg.tool_calls and any(tc["id"] in tool_call_ids ...)`

Both rescue checks test against that empty set, so AI(1) can never be pulled back in.
`````

### Rubric check (proposed)

| Criterion | Pt | Why |
|---|---|---|
| Graph flow | 0.5 | Still only `START → summarize_conversation → assistant`. The tool loop and `END` are missing. |
| What is kept / deleted | 1 | Last N + rescued, `RemoveMessage` for the rest. |
| Tool-call pairing rule and why trimming can break it | 1 | Now concrete: it shows exactly how the cut leaves `Tool b` without `AI(a,b)`, with the deciding lines quoted. |
| Level and length | 1 | Explanation about 200 words, trace excluded as I allowed. |
| Verified 2 claims | 1 | You checked 2 claims against the code. |
| **Total** | **4.5, rounded to 5** | 4 before your claim check. |

### Discernment: teacher pre-check
| Claim | Verdict |
|---|---|
| Returned list is `[Tool b, AI(4), Human(5), AI(6), Human(7)]` | **Matches my stub run.** I ran the real function body with stub message classes and got `[Tool:b, AI, Human, AI, Human]` for the same input. |
| `tool_call_ids` stays empty because AI(4) and AI(6) have no tool calls | **True.** It only reads `tool_calls` on the recent `AIMessage`s. |
| Both rescue checks test against that empty set, so `AI(1)` can never be pulled back in | **True, and this is the bug.** The ids needed are the recent `ToolMessage.tool_call_id`s. |
| "constants.py wasn't provided", so the limit's value is unsure | **Good.** The default is 5 (`constants.py:37`). |
| All `file:line` refs | **Correct** (same ones as v2, plus `utils.py:170-171`, `176`, `178-181`). |

**Caveat:** the trace is Claude reasoning, not execution. It matches my stub run, and the stub run used copied code with fake message classes, not real LangChain. **Day 2 must reproduce it with real LangChain and write the failing test.** Also, I picked this input, so real histories may break in other ways too (for example when the cut lands between two parallel `Tool` messages, as in the ticket).

### Answers to the 3 self-check questions (v3)
<details><summary>Teacher's answers</summary>

1. The **full** list, plus the throwaway prompt (`graph.py:117-118`). The LLM sees everything, not only the messages to be deleted.
2. Only messages with a `tool_calls` attribute, which means `AIMessage`s in the **recent** slice (`utils.py:169-171`). `ToolMessage`s contribute nothing. That is the bug.
3. `RemoveMessage(id=…)` entries go through the `add_messages` reducer, which deletes those ids from the saved state. Nothing new is added, so the history shrinks.
</details>

### What changed across rounds
| | v1 (+files) | v2 | v3 |
|---|---|---|---|
| Length | ~600 words + review | ~230 | ~200 + trace |
| `file:line` refs | none | all correct | all correct |
| False claims | 2 | 1 | **0** |
| Finds the bug | no (said it works) | no (said it works) | **yes** |
| Score (proposed) | 4 | 4 | **5** |

**Which change moved the score:**
1. Attaching the code made the answer about *your* code, not generic LangGraph.
2. Rules (length, `file:line`, "unsure") gave the shape and the honesty.
3. **Asking for a trace on a concrete input** found the bug. Both earlier rounds described what the function is meant to do. A trace forces Claude to follow what it actually does.

**Rule to keep:** to check code, ask Claude to run it on an input, not to explain it. Then confirm with real execution (a test).

---

---

**Best prompt (copy to `../../notes.md`):** v3
```
I'm a developer new to LangGraph. I need to fix a bug in this summarization code tomorrow, so I need to understand how it works, not review it. Explain how `summarize_conversation` and `handle_keep_recent_messages` work together.
Rules: max 250 words; one small diagram; no code review or fixes; after every claim about the code, give the file:line, or say "unsure". End with 3 questions I should be able to answer if I understand it.

Then trace `handle_keep_recent_messages` by hand (this part does not count toward the 250 words). Use recent_messages_number=5 and this input list:
[Human, AI(tool_calls a,b), Tool a, Tool b, AI, Human, AI, Human]
Show the returned list. Is any ToolMessage left without the AIMessage that called it? Quote the lines that decide it.
```
**Surprise (good/bad):**
- Good: a hand trace on a concrete input found the bug that two explanations missed. Claude followed the code instead of repeating what it is meant to do.
- Bad: Claude described the helper as working in v1 and v2, with correct line numbers. Accurate citations don't mean the claim about behavior is right.
