# Task 1: Log

The rubric is in [README.md](README.md).

## Scores

| Round | Change | Score /5 | What improved, and what was still wrong |
|---|---|---|---|
| v1 | Lazy prompt | 4 (proposed) | Accurate on symptom, error, step and workaround. Fails the shape rule: about 20 lines, root cause stated as fact, unrequested fix list. |
| v2 | Role and purpose, task, rules (5 lines at most, Known vs Suspected, no fixes) | 5 (proposed) | Length and shape fixed, no fix list, guesses are labeled. Small nit: line 1 packs the symptom and the workaround together. |
| v3 | Added "Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected." | 4.5 (proposed) | The "when" is in line 1 and the fallback worked (no invented trigger). But there is a 6th line of preamble, and line 1 hedges a fact the ticket does give ("long conversations"). Not better than v2. |

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

### Rubric check (proposed)

| Criterion | Points | Why |
|---|---|---|
| Symptom: what the user sees, and when | 1 | "In long conversations... intermittently fails and the user sees an error instead of an answer." Line 5 adds the suspected trigger. |
| Error, exactly | 1 | OpenAI 400 `BadRequestError`, the `tool` / `tool_calls` message, `messages.[1]`, the `assistant` task. All in the trace. |
| Where | 1 | Line 4 names the trim or summarize step, labeled Suspected. |
| Status | 1 | Line 1: the summary feature is turned off. |
| Shape: 5 lines or fewer, known facts apart from guesses | 1 | Five lines. Every Known line is backed by the ticket, and the cause and the intermittency are Suspected. |
| Total | 5 | |

### Claims checked against `issue-1.md`
| Claim | Verdict | Evidence |
|---|---|---|
| Line 1 (Known): fails in long conversations, user sees an error, feature is off | True | The "Issue" section says all three. |
| Line 2 (Known): 400, `messages.[1]`, raised in the `assistant` task | True | The trace has `param: messages.[1].role` and `During task with name 'assistant'`. |
| Line 3 (Known): the first two `ToolMessage`s have no preceding `AIMessage` | True | They are the first two items in the dump. |
| Line 4 (Suspected): the history is cut and the `AIMessage` is dropped | Fits the dump | The issue never shows the summarize code, and the label says so. |
| Line 5 (Suspected): it fails only when the cut falls between a tool call and its reply | Guess, labeled | Needs the code (Day 2). |

The v1 doubts are gone. v2 doesn't say "the second orphaned message", doesn't add the unrequested fix list, and doesn't add the fine-tuned model question. It also dropped the `check_and_execute_query_tool` mistake.

### What changed from v1 to v2
| | v1 | v2 |
|---|---|---|
| Length | about 20 lines, six sections | 5 lines |
| Root cause | stated as fact | labeled Suspected |
| Fix list | included | gone |
| Open questions | two, one a distraction | gone |
| Score | 4 | 5 |

The rules block did most of the work: the line cap, the Known/Suspected labels and "no fixes yet". The role and purpose mattered less.

Nit: line 1 packs the symptom and the workaround together, and line 2 is the longest. It doesn't cost a point.

---

## v3: fix one gap

v2 already scores 5, so there is no rubric miss to fix. The one gap left is the nit: the "when" is spread over lines 1 and 5, and it never says the error starts only after the history is long enough to be trimmed.

The one change: added `Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected.` The fallback is there on purpose. A required field the ticket may not cover can make Claude invent it.

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

### Rubric check (proposed)

| Criterion | Points | Why |
|---|---|---|
| Symptom: what the user sees, and when | 1 | Line 1: an error instead of an answer, probably past a length or token threshold. The honest fallback worked. |
| Error, exactly | 1 | OpenAI 400, the `tool` / `tool_calls` rule, `messages.[1].role`, the `assistant` node. |
| Where | 1 | Line 5 names the summary or trimming step, labeled Suspected, and says the ticket doesn't confirm it. |
| Status | 1 | Line 2: the summary feature is turned off. |
| Shape: 5 lines or fewer, known facts apart from guesses | 0.5 | Five labeled items, but a preamble sentence sits above them, so the reply has six lines. Labels are correct. |
| Total | 4.5 | |

### Claims checked against `issue-1.md`
| Claim | Verdict | Evidence |
|---|---|---|
| Preamble: "the ticket never says when the error starts" | Half true | It gives no exact trigger, but the ticket does say "when a conversation gets long". So the "long conversations" part could be Known. |
| Line 1 (Suspected): a length or token threshold | Guess, labeled | Matches the ticket's "long", and a threshold fits the summary feature. The code isn't in the ticket. |
| Line 2 (Known): intermittent, summary feature off | True | "Does not happen every time" and the workaround are both in the Issue section. |
| Line 3 (Known): the 400, `messages.[1].role`, `assistant` node | True | In the trace. |
| Line 4 (Known): two orphan `ToolMessage`s at the start | True | The first two items in the dump. |
| Line 5 (Suspected): the cut falls inside a tool-call pair | Guess, labeled | It says the ticket does not confirm it. |

### Comparison

| | v1 lazy | v2 framed | v3 plus line 1 rule |
|---|---|---|---|
| Length | about 20 lines | 5 | 5 plus a preamble |
| Has the "when" | no, only "long" | partly (line 5) | yes, in line 1 (Suspected) |
| Invented or wrong facts | cause stated as fact | no | no |
| Fix list | yes | no | no |
| Score (proposed) | 4 | 5 | 4.5 |

What moved the score:
1. The rules block (a length cap, Known/Suspected labels, no fixes) took it from 4 to 5. This was the whole gain.
2. The line 1 rule moved the "when" into line 1 and did not invent anything, thanks to the fallback. It cost half a point: the preamble broke the 5-line cap, and line 1 hedged something the ticket does say.

Rule to keep: when you add a required field, say what to do when it is missing. Also repeat the format limit ("reply with the 5 lines only"), because a new rule can push Claude to explain itself.

---

## Best prompt (v2)
```
I'm a developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guess); no fixes yet.
<paste ticket>
```
If you want the "when" in line 1, use the v3 line plus `Reply with the 5 lines only.`
