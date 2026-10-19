# Task 1: Log

The rubric is in [README.md](README.md). Scores marked "proposed" are the teacher's first pass. Confirm or change them.

## Scores

| Round | Change | Score /5 | What improved, and what was still wrong |
|---|---|---|---|
| v1 | Lazy prompt | 3 (proposed) | See the v1 analysis below. |
| v2 | Role and purpose, task, rules (5 lines at most, Known vs Suspected, no fixes) | 4.5 (proposed) | The length and shape are fixed, there is no unrequested fix list, and guesses are labeled. It still doesn't say when the error starts (only once the history is long enough to be trimmed). |
| v3 | Added "Line 1 must say what a user sees and when it starts." | 4 (proposed) | Line 1 now has the "when", but it is labeled Known although the ticket doesn't say it, and line 2 holds a claim the ticket contradicts. |
| v4 | Added "If the ticket doesn't say, label it Suspected." | 5 (proposed) | No false claims. Missing information is admitted ("the ticket doesn't show the summary code"), and the "when" (the threshold) is labeled Suspected. |

---

## v1: lazy prompt

Prompt
````
summarize this bug
<paste issue.md>
````

Response
````
Bug summary: OpenAI 400 error when the conversation-summary feature runs

Symptom
Intermittently, the chat stream crashes with:
`openai.BadRequestError: 400 - messages with role 'tool' must be a response to a preceeding message with 'tool_calls'` (param: `messages.[1].role`).
The current workaround is to disable the summary feature.

Where it happens
`chat.py` → `graph.stream()` → the `assistant` node in `graph.py` → `ChatOpenAI._stream`. The agent is a LangGraph SQL agent using a fine-tuned `gpt-4o-mini`.

Root cause
The summary step trims or truncates `state["messages"]` and cuts the history in the middle of a tool-call sequence. When the `assistant` node then sends the history to OpenAI, it starts with orphaned `ToolMessage`s whose parent `AIMessage` (the one carrying `tool_calls`) was dropped.
The debug dump of the state shows this. The messages begin with `ToolMessage(sql_db_list_tables)` and `ToolMessage(sql_db_schema)`, which have no preceding AIMessage with `tool_calls`.
A second case appears later in the history. One AIMessage issued two parallel tool calls (`qK4F…` and `yc6c…`), producing two ToolMessages. A cut or filter that keeps only one of them, or removes the AIMessage, breaks the pairing too.

Why OpenAI rejects it
The API requires that every `role: tool` message directly follow an assistant message containing the matching `tool_call_id`, and that every tool call have a response.

Likely fixes
* When trimming or summarizing, cut only at safe boundaries (e.g., before a `HumanMessage`) so AIMessage/ToolMessage groups stay together.
* Use LangChain's `trim_messages` with `start_on="human"` and `end_on=("human", "tool")`.
* Add a sanitizer before the LLM call that drops any leading or orphaned `ToolMessage`s with no matching `tool_call_id` in a preceding AIMessage.
* Treat parallel tool calls as one atomic group.

Reference: https://github.com/langchain-ai/langgraph/discussions/1398
````

### Rubric check (proposed)

| Criterion | Points | Why |
|---|---|---|
| Symptom: what the user sees, and when | 0.5 | It says the stream crashes "intermittently" and ties it to the summary feature. It doesn't say the crash only starts once the history is long enough for summarization to trim it. |
| Error, exactly | 1 | The exception, message and `param` are exact. |
| Where | 1 | It names the summary step, `graph.py` and the `assistant` node. |
| Status | 1 | It mentions the workaround. |
| Shape: 5 lines or fewer, known facts apart from guesses | 0 | It runs about 25 lines. "Root cause" is stated as fact, but Claude only had `issue.md` and never saw the summarize code. |
| Total | 3.5, rounded down to 3 | |

### Claims to verify
- [ ] "fine-tuned `gpt-4o-mini`". Is this in `issue.md`? If not, where did it come from?
- [ ] "LangGraph SQL agent". Is it inferred from the tool names (`sql_db_*`)? Check the repo.
- [ ] "trims or truncates `state["messages"]`". The ticket never shows the summarize code. Confirm in `sample-project/server/agent/graph.py` (`summarize_conversation`).
- [ ] "A second case appears later... `qK4F...` and `yc6c...`". Confirm the IDs are in the dump. The ticket text mentions 2 tool messages.
- [ ] "Likely fixes". Are the `trim_messages` arguments (`start_on`, `end_on`) real and correct for the installed LangChain version?

### Observations
- Good: it is accurate on the error and the pairing rule, and it found the orphan `ToolMessage` in the dump on its own.
- Bad: it jumped to a root cause and a fix list nobody asked for, which made the answer too long. This is the "too generic, too long" pattern from your lesson 3 reflection.
- For v2: say who you are and where the summary goes, ask for a ticket summary, and add rules (5 lines at most, label each line Known or Suspected, no fixes).

---

## v2: Stage, Task, Rules

Prompt
````
I'm developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guesst); no fixes yet.
<paste issue.md>
````

Response
````
* Known: The summarize-conversation feature intermittently fails with an OpenAI `400 BadRequestError`: "messages with role 'tool' must be a response to a preceeding message with 'tool_calls'" (param `messages.[1].role`), raised in the `assistant` node. The only workaround so far is disabling the feature.
* Known: The state dump at the failure shows `state["messages"]` starting with `ToolMessage`s (`sql_db_list_tables`, `sql_db_schema`) whose originating `AIMessage` with `tool_calls` is absent, so the list begins with orphaned tool messages.
* Known: The latest turn ("Compare Gilded Prowl Skirt with Khaki Mini Skirt") has an `AIMessage` with two parallel `tool_calls` followed by two `ToolMessage` replies, and the ticket notes the history is cut so a `ToolMessage` ends up without its preceding `AIMessage`.
* Suspected: The summarization step trims or removes the oldest messages by count, cutting between an `AIMessage(tool_calls)` and its `ToolMessage`s, which leaves orphaned tool messages at the start of the history sent to the model.
* Suspected: It is intermittent because it only occurs when the cut point lands inside a tool-call group, which is more likely with parallel tool calls producing multiple `ToolMessage`s; this is unconfirmed until the summarization/trim code is inspected.
````

### Rubric check (proposed)

| Criterion | Points | Why |
|---|---|---|
| Symptom: what the user sees, and when | 0.5 | It says "intermittently" and gives a suspected trigger (the cut falls inside a tool-call group). It still doesn't say the error only happens once the history is long enough to be trimmed. |
| Error, exactly | 1 | The exception, message and `param` are exact. |
| Where | 1 | The summarization step and the `assistant` node. |
| Status | 1 | The workaround is stated. |
| Shape: 5 lines or fewer, known facts apart from guesses | 1 | Five bullets, each labeled Known or Suspected, and it says the intermittency is "unconfirmed until the summarization/trim code is inspected". |
| Total | 4.5 | |

### What I checked against `issue.md`
- [x] `Compare "Gilded Prowl Skirt" with "Khaki Mini Skirt"` is the human message in the dump, so the "latest turn" in bullet 3 is real.
- [x] It no longer invents "fine-tuned gpt-4o-mini" or a fix list. The Known/Suspected rule stopped those guesses.
- [ ] Still to check: bullet 3 says the ticket "notes the history is cut". The ticket only says one tool message has no `AIMessage` before it, and never says why. That claim is Suspected, not Known.
- [ ] Still to check: is "trims by count" correct? Open `summarize_conversation` in `sample-project/server/agent/graph.py` and `RECENT_MESSAGE_LIMIT` in `sample-project/server/utils/constants.py`.

### What changed from v1 to v2
| | v1 | v2 |
|---|---|---|
| Length | about 25 lines | 5 bullets |
| Root cause | stated as fact | labeled Suspected |
| Fix list | included | gone |
| Invented details (fine-tuned model) | yes | no |
| Score | 3 | 4.5 |

The rules block gave the biggest gain, in particular the length cap and the Known/Suspected labels. Giving Claude a role and context mattered less.

---

## v3: fix one gap

The one change: added `Line 1 must say what a user sees and when it starts.`

Prompt
````
I'm developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guesst); no fixes yet.
Line 1 must say what a user sees and when it starts.
<paste issue.md>
````

Response
````
Known: A user sees a failed or broken response on a follow-up question in a conversation (e.g. "Compare X with Y"), and it starts when the agent issues two parallel tool calls in one turn and the conversation is then summarized; the stream aborts with an OpenAI 400 error ("messages with role 'tool' must be a response to a preceeding message with 'tool_calls'").

1. Known: The state messages passed to the `assistant` node begin with orphaned `ToolMessage`s (no preceding `AIMessage` with `tool_calls`), and the failing param is `messages.[1].role`; the same error appears with the summary feature on, and the current temp workaround is disabling it.
2. Known: The last two messages in state are `ToolMessage`s from one parallel `check_and_execute_query_tool` pair (Gilded Prowl Skirt / Khaki Mini Skirt), and the `AIMessage` that issued those calls is the one missing from the end of the list.
3. Suspected: The summarization step trims or cuts the message history at a point that separates an `AIMessage` (with `tool_calls`) from its `ToolMessage` responses, leaving orphans at the start or end of the list (OpenAI requires them paired).
4. Suspected: The bug is intermittent ("sometime") because it only triggers when the cut-off boundary lands inside a tool-call/tool-response group, which parallel tool calls make more likely; the linked LangGraph discussion (#1398) may describe the same pattern.
````

### Rubric check (proposed)

| Criterion | Points | Why |
|---|---|---|
| Symptom: what the user sees, and when | 1 | Line 1 now covers both and ties the trigger to the conversation being summarized. This is the half point v2 missed. |
| Error, exactly | 1 | The message and `param` are exact. |
| Where | 1 | The summarization step and the `assistant` node. |
| Status | 1 | The workaround is mentioned (line 1 of the list). |
| Shape: 5 lines or fewer, known facts apart from guesses | 0 | Line 1 puts a guess under Known, and item 2 states a false fact under Known. The ticket reader relies on those labels. |
| Total | 4 | |

### Claims checked against the dump in `issue.md`

| Claim (v3) | Verdict | Evidence |
|---|---|---|
| Line 1 (Known): "starts when the agent issues two parallel tool calls in one turn and the conversation is then summarized" | Guess labeled Known | The ticket only says summarization is involved (the title and the temporary fix). It never says parallel calls are the trigger. This should be Suspected. |
| Line 1 (Known): "a failed or broken response on a follow-up question" | Guess | The ticket shows a stack trace, not what the user sees. |
| Item 1: the state starts with orphaned `ToolMessage`s | True | The first two messages in the dump are the `sql_db_list_tables` and `sql_db_schema` tool messages, with no `AIMessage` before them. |
| Item 2 (Known): the `AIMessage` that issued the last two tool calls "is the one missing from the end of the list" | False | The dump has an `AIMessage` with the two parallel calls (`call_qK4F...`, `call_yc6c...`) right before the last two `ToolMessage`s. Those two are paired correctly. The orphans are at the start. |
| Item 3: separates an `AIMessage` from its tool replies "at the start or end" | Half true | "Start" matches the dump. "End" has no support. |

The Known/Suspected rule only works if Claude follows it honestly. When the new rule demanded a "when" on line 1, Claude filled the gap with a guess and marked it Known, then misread the dump in item 2. v3 is more complete than v2 and less trustworthy.

My mistake as teacher: I suggested a v3 line that demanded a "when" even when the ticket doesn't give one, and that pushed Claude to invent it. A better line is `Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected.`

---

## v4: v3 with an honesty rule

The one change from v3: `If the ticket doesn't say, label it Suspected.`

Prompt
````
I'm developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guesst); no fixes yet.
Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected.
<paste issue.md>
````

Response
````
Known: Users sometimes get an error instead of a reply when the "summary conversation" feature is on; the ticket says it happens "sometime" and gives no exact trigger, and the temp workaround is to disable the feature.
Known: The OpenAI API returns a 400 `BadRequestError` ("messages with role 'tool' must be a response to a preceeding message with 'tool_calls'", param `messages.[1].role`), raised from the `assistant` node in `graph.py` while streaming via `chat.py`.
Known: The debugged `state["messages"]` begins with orphaned `ToolMessage`s (the first two, with no preceding `AIMessage` carrying `tool_calls`), and later has an `AIMessage` with two `tool_calls` followed by two `ToolMessage`s.
Suspected: The summarization step trims or replaces earlier history and cuts between an `AIMessage(tool_calls)` and its `ToolMessage`s, leaving tool responses at the start of the list; the ticket doesn't show the summary code.
Suspected: It only fails sometimes because the cut falls inside a tool-call group only when the history reaches the summarization threshold, so shorter conversations work.
````

### Rubric check (proposed)

| Criterion | Points | Why |
|---|---|---|
| Symptom: what the user sees, and when | 1 | It gives an error instead of a reply, "sometimes", and the "when" (only once the history reaches the summarization threshold) labeled Suspected. |
| Error, exactly | 1 | The message and `param` are exact. |
| Where | 1 | The `assistant` node in `graph.py`, streamed through `chat.py`, and the summarization step. |
| Status | 1 | The workaround is stated. |
| Shape: 5 lines or fewer, known facts apart from guesses | 1 | Five lines. Every Known is backed by the ticket, the guesses are labeled, and it admits the summary code isn't in the ticket. |
| Total | 5 | |

### Claims checked against `issue.md` and the repo
| Claim | Verdict | Evidence |
|---|---|---|
| Line 3: the first two messages are orphan `ToolMessage`s | True | The `sql_db_list_tables` and `sql_db_schema` tool messages open the dump. |
| Line 3: later, an `AIMessage` with two `tool_calls` followed by two `ToolMessage`s | True | `call_qK4F...` and `call_yc6c...`, then the Gilded Prowl and Khaki Mini replies. v3 got this wrong. |
| Line 2: raised from the `assistant` node in `graph.py`, streaming through `chat.py` | True | In the traceback, `chat.py` line 64 is `stream_agent_response` and `graph.py` line 53 is `__call__`. |
| Line 5: it fails only once the history reaches the threshold | Matches the code | `summarize_conversation` returns early when `len(messages) <= RECENT_MESSAGE_LIMIT + 1` (default 5). Claude didn't see the code, so this was a good guess. |
| Line 4: the cut falls between an `AIMessage(tool_calls)` and its `ToolMessage`s | Unproven | `handle_keep_recent_messages` tries to keep these pairs together. Whether it always does is the Day 2 question. |

A small nit: line 1 is labeled Known, but "an error instead of a reply" is inferred from a stack trace. It is honest about the trigger ("gives no exact trigger"), so it doesn't cost a point.

---

## Comparison

| | v1 lazy | v2 framed | v3 plus line 1 | v4 plus honesty rule |
|---|---|---|---|---|
| Length | about 25 lines | 5 | 5 | 5 |
| Has the "when" | no | partly | yes (as Known, a guess) | yes (as Suspected) |
| Invented or wrong facts | yes | no | yes | no |
| Fix list | yes | no | no | no |
| Score (proposed) | 3 | 4.5 | 4 | 5 |

What moved the score:
1. The rules block (a length cap and Known/Suspected labels) took it from 3 to 4.5, the biggest jump.
2. "Line 1 must say what a user sees and when" took it from 4.5 to 4. It forced Claude to invent.
3. "If the ticket doesn't say, label it Suspected" took it from 4 to 5. It gave Claude an honest way out.

Rule to keep: whenever you require a field the source may not contain, say what to do when it is missing.

---

## Best prompt (v4)
```
I'm a developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guess); no fixes yet.
Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected.
<paste ticket>
```

## Surprises
- Good: adding the rules block cut the answer from about 25 lines to 5 and removed an invented detail.
- Bad: when I forced a "when it starts" line, Claude filled the gap with a guess labeled Known, then misread the dump and said an `AIMessage` was missing when it was there.
- Good: telling Claude what to do when the source is silent ("label it Suspected") fixed the invention problem without making the answer longer.
