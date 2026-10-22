# Task 1: Log

The rubric is in [README.md](README.md).

## Scores

| Round | Change | Score /5 | What improved, and what was still wrong |
|---|---|---|---|
| v1 | Lazy prompt | 4 (proposed) | Accurate on symptom, error, step and workaround. Fails the shape rule: about 20 lines, root cause stated as fact, unrequested fix list. |
| v2 | Stage / Task / Rules | | |
| v3 | Fix one gap | | |

---

## v1: lazy prompt

Prompt
````
summarize this bug:
```
<pasted @resources/practice/issues/issue-1.md>
```
````

Response
````
**Bug summary: Chatbot errors out in long conversations**

**What happens:** In long conversations, the chatbot intermittently fails and shows the user an error instead of an answer. It's not reproducible on demand. The current workaround is keeping the conversation summary feature turned off.

**Root cause (from the trace):** OpenAI returns a 400 `BadRequestError`: a message with role `tool` must follow a preceding message with `tool_calls`. The state dump shows why. The message list begins with two orphaned `ToolMessage`s (`sql_db_list_tables`, `sql_db_schema`), whose originating `AIMessage` with `tool_calls` is no longer in the history. The error points at `messages.[1]`, the second orphaned message.

This looks like the summarization/trimming step cutting the history in the middle of a tool-call sequence. It drops the `AIMessage` that issued the tool call but keeps the `ToolMessage` replies, which produces an invalid message sequence. It's intermittent because it only happens when the cut point lands inside a tool-call/response pair.

**Expected:** The chatbot answers normally at any conversation length, and the summary feature can be re-enabled without errors.

**Suggested fix direction:** Make summarization/trimming tool-call-aware, so the cut never separates a `ToolMessage` from its parent `AIMessage` (drop or keep them together, or start the retained history on a human message). Add a regression test with a history that has tool calls near the trim boundary.

**Open questions:**
- What threshold or condition triggers summarization or trimming?
- Does the fine-tuned model (`ft:gpt-4o-mini`) behave differently from the base model here, or is this purely a message-ordering issue?s
````

### Rubric check (proposed)

| Criterion | Points | Why |
|---|---|---|
| Symptom: what the user sees, and when | 1 | "An error instead of an answer", in long conversations, intermittently. The issue gives this "when", and the response ties it to the cut point. |
| Error, exactly | 1 | OpenAI 400 `BadRequestError`, a `tool` message with no preceding `tool_calls`, `messages.[1]`. The "second orphaned message" detail is doubtful (see below), but the error itself is exact. |
| Where | 1 | "The summarization/trimming step cutting the history in the middle of a tool-call sequence." It can't name the function because the issue doesn't show the code. |
| Status | 1 | "The current workaround is keeping the conversation summary feature turned off." |
| Shape: 5 lines or fewer, known facts apart from guesses | 0 | About 20 lines in six sections. The cause is stated as fact ("Root cause (from the trace)"), and the issue never shows the summary code. |
| Total | 4 | |

### Claims to verify
- [x] The list begins with two orphaned `ToolMessage`s (`sql_db_list_tables`, `sql_db_schema`) with no `AIMessage` before them. True. They are the first two messages in the dump.
- [x] The earlier mistake is gone: v1 no longer calls `check_and_execute_query_tool` orphaned. In the updated dump, `AIMessage(tool_calls=...)` `call_qhyEBn...` sits right before its `ToolMessage`, so that pair is intact.
- [ ] "The error points at `messages.[1]`, the second orphaned message". Doubtful. In `state["messages"]` the orphans are at index 0 and 1. The request to OpenAI usually has a system prompt first, which would make `messages.[1]` the *first* orphan. Neither the issue nor the response can settle it. Check how the `assistant` node builds the request (Day 2).
- [ ] "Drops the `AIMessage` that issued the tool call but keeps the `ToolMessage` replies". Plausible, and it matches the dump, but the issue never shows the summarize code. Suspected, not Known.
- [ ] "Intermittent because it only happens when the cut point lands inside a tool-call/response pair". A guess. Needs the code.
- [x] Open question 1 (what triggers summarization or trimming). A good question, and the right next thing to find out.
- [ ] Open question 2 (fine-tuned `ft:gpt-4o-mini` vs the base model). `ft:gpt-4o-mini-2024-07-18:...` is in the dump, so the model name is real. But the error is about message order, so this question is a distraction. There is also a stray `s` at the end of the line.

### Observations
- Good: the error, the pairing rule and the orphans are right. Its open questions point at what the issue is missing.
- Bad: "Root cause (from the trace)" claims more than the trace shows, and a guess reads as a fact.
- Bad: "Suggested fix direction" was not requested. The priority note from the earlier run is gone.
- Bad: it picked a concrete index ("the second orphaned message") without being able to check it.
- For v2: say who you are and where the summary goes, cap it at 5 lines, label each line Known or Suspected, and say no fixes.

---

## v2: Stage, Task, Rules

## v3: fix one gap
