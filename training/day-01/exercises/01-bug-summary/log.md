# Task 1: Log

Rubric: [README.md](README.md). Scores are proposed.

| Round | Change | Score /5 | Result |
|---|---|---|---|
| v1 | Lazy prompt | 4 | Right on symptom, error, step and workaround. Fails shape: about 20 lines, cause stated as fact, unrequested fix list. |
| v2 | Role and purpose, task, rules (5 lines, Known/Suspected, no fixes) | 5 | Short, labeled, no fixes. Nit: line 1 mixes symptom and workaround. |
| v3 | Line 1 rule: what a user sees and when; Suspected if the ticket doesn't say | 4.5 | "When" is in line 1 and nothing is invented. A preamble made it 6 lines, and line 1 hedged "long conversations", which the ticket does state. |

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

Score 4/5. Symptom, error, where and status all hit. Shape scored 0: about 20 lines in six sections.

Checks against the issue
- True: the list starts with two orphan `ToolMessage`s (`sql_db_list_tables`, `sql_db_schema`).
- Doubtful: "`messages.[1]` is the second orphan". The orphans are at state index 0 and 1. If a system prompt comes first, `messages.[1]` is the first orphan. The issue can't settle it. Check how the `assistant` node builds the request (Day 2).
- Guess stated as fact: the cut drops the `AIMessage` but keeps the replies, and it is intermittent because of where the cut falls. The issue has no summarize code.
- Distraction: the fine-tuned model question. The error is about message order.

Problems: "Root cause (from the trace)" claims more than the trace shows, the fix section wasn't requested, and it named a concrete index it couldn't check.

---

## v2: Stage, Task, Rules

Prompt
````
I'm a developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guess); no fixes yet.
```
<pasted @resources/practice/issues/issue-1.md>
```
````

Response
````
Known: In long conversations the chatbot intermittently fails and the user sees an error instead of an answer; the summary feature is currently turned off as a workaround.
Known: The failure is an OpenAI 400 BadRequestError ("messages with role 'tool' must be a response to a preceding message with 'tool_calls'"), pointing at messages.[1], raised in the 'assistant' task.
Known: The captured state["messages"] begins with two ToolMessages (sql_db_list_tables, sql_db_schema) that have no preceding AIMessage containing their tool_calls.
Suspected: The conversation history is being trimmed or summarized in a way that cuts off the AIMessage carrying the tool_calls and leaves its ToolMessage responses orphaned at the start of the list.
Suspected: Failures are intermittent because they only occur when the cut point falls between a tool_calls message and its tool responses, which depends on conversation length and tool usage.
````

Score 5/5. Every Known line matches `issue-1.md` (long conversations, the 400 at `messages.[1]` in the `assistant` task, the two orphans). The cause and the intermittency are labeled Suspected.

v1 to v2: about 20 lines became 5, the cause went from fact to Suspected, and the fix list and open questions are gone. The rules block did the work (line cap, labels, no fixes). Role and purpose mattered less.

---

## v3: fix one gap

v2 already scores 5, so the target is the nit: the "when" is split across lines 1 and 5. One change: `Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected.` The fallback is deliberate, because a required field the ticket may not cover can make Claude invent it.

Prompt
````
I'm a developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guess); no fixes yet.
Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected.
```
<pasted @resources/practice/issues/issue-1.md>
```
````

Response
````
Line 1 has to be Suspected, since the ticket never says when the error starts. It only says "long conversations", and the state dump shows no turn count or token size.

1. **Suspected:** The user sends a message and gets an error instead of an answer, probably once the conversation passes some length or token threshold; the ticket gives no exact trigger point.
2. **Known:** The failure is intermittent ("sometimes", "does not happen every time"), and the conversation summary feature is currently turned off as a workaround.
3. **Known:** The API call fails with an OpenAI 400 `BadRequestError`: a message with role `tool` must follow an earlier message that has `tool_calls` (`messages.[1].role`, raised in the `assistant` node).
4. **Known:** In the captured state, `messages` starts with two `ToolMessage`s (`sql_db_list_tables`, `sql_db_schema`) whose originating `AIMessage` with `tool_calls` is missing.
5. **Suspected:** The summary or trimming step cuts the history in the middle of a tool-call pair, leaving orphaned `ToolMessage`s at the front; the ticket does not confirm that this step is the cause.
````

Score 4.5/5. All content points hit, and the fallback worked (no invented trigger). Shape got half: the preamble makes six lines. The preamble is also half wrong, because the ticket does say "when a conversation gets long".

---

## Comparison

| | v1 | v2 | v3 |
|---|---|---|---|
| Length | about 20 lines | 5 | 5 plus a preamble |
| Has the "when" | only "long" | partly (line 5) | yes, line 1 (Suspected) |
| Wrong or invented | cause as fact | no | no |
| Fix list | yes | no | no |
| Score | 4 | 5 | 4.5 |

Rule to keep: when you add a required field, say what to do if it's missing. Repeat the format limit ("reply with the 5 lines only"), because a new rule can push Claude to explain itself.

## Best prompt (v2)
```
I'm a developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guess); no fixes yet.
<paste ticket>
```
For the "when" in line 1, add the v3 line plus `Reply with the 5 lines only.`
