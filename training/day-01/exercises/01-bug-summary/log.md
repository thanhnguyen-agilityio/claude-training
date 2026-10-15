# Task 1 — Log

Rubric: see [README.md](README.md). Scores marked *(proposed)* are the teacher's first pass. Confirm or change them.

## Scores

| Round | Change | Score /5 | What improved / what was still wrong |
|---|---|---|---|
| v1 | lazy prompt | 3 *(proposed)* | See v1 analysis below |
| v2 | Stage (role + purpose) / Task / Rules (≤5 lines, Known vs Suspected, no fixes) | 4.5 *(proposed)* | Length and shape fixed, no unrequested fix list, guesses labelled. Still missing: *when* it starts (only once the history is long enough to be trimmed). |
| v3 | Added: "Line 1 must say what a user sees and when it starts." | 4 *(proposed)* | Line 1 now has "when", but it is labelled Known although the ticket doesn't say it, and line 2 contains a claim the ticket contradicts. See v3 analysis. |
| v4 | Fixed v3: "If the ticket doesn't say, label it Suspected." | 5 *(proposed)* | No false claims. Missing info is admitted ("the ticket doesn't show the summary code"), and the "when" (threshold) is labelled Suspected. |

---

## v1: lazy prompt

**Prompt**
````
summarize this bug
<paste issue.md>
````

**Response**
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

| Criterion | Pt | Why |
|---|---|---|
| Symptom: what the user sees, and when | 0.5 | Says the stream crashes "intermittently" and ties it to the summary feature, but doesn't say it only starts once the history is long enough for summarization to trim it. |
| Error, precisely | 1 | Exact exception, message and `param`. |
| Where | 1 | Names the summary step, `graph.py` and the `assistant` node. |
| Status / impact | 1 | Workaround mentioned. |
| Shape: ≤ 5 lines, known vs guessed separated | 0 | About 25 lines. "Root cause" is stated as fact even though only `issue.md` was provided and Claude never saw the summarize code. |
| **Total** | **3.5, rounded down to 3** | |

### Discernment: claims to verify
- [ ] "fine-tuned `gpt-4o-mini`": is this in `issue.md`? If not, where did it come from?
- [ ] "LangGraph SQL agent": inferred from the tool names (`sql_db_*`)? Check the repo.
- [ ] "trims or truncates `state["messages"]`": the ticket never shows the summarize code. Confirm in `sample-project/server/agent/graph.py` (`summarize_conversation`).
- [ ] "A second case appears later... `qK4F…` and `yc6c…`": confirm the IDs are in the dump. The ticket text mentions 2 tool messages.
- [ ] "Likely fixes": are the `trim_messages` arguments (`start_on`, `end_on`) real and correct for the installed LangChain version?

### Observations
- **Good:** accurate on the error and the pairing rule, and it found the orphan `ToolMessage` in the dump on its own.
- **Bad:** it jumped to a root cause and a fix list nobody asked for, so the answer is too long. This is the "too generic / too long" pattern from your Lesson 3 reflection.
- **Next change for v2:** Stage (who you are, where it goes) + Task (ticket summary) + Rules (≤ 5 lines, label *Known* vs *Suspected*, no fixes).

---

## v2: framed (Stage / Task / Rules)

**Prompt**
````
I'm developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guesst); no fixes yet.
<paste issue.md>
````

**Response**
````
* Known: The summarize-conversation feature intermittently fails with an OpenAI `400 BadRequestError`: "messages with role 'tool' must be a response to a preceeding message with 'tool_calls'" (param `messages.[1].role`), raised in the `assistant` node. The only workaround so far is disabling the feature.
* Known: The state dump at the failure shows `state["messages"]` starting with `ToolMessage`s (`sql_db_list_tables`, `sql_db_schema`) whose originating `AIMessage` with `tool_calls` is absent, so the list begins with orphaned tool messages.
* Known: The latest turn ("Compare Gilded Prowl Skirt with Khaki Mini Skirt") has an `AIMessage` with two parallel `tool_calls` followed by two `ToolMessage` replies, and the ticket notes the history is cut so a `ToolMessage` ends up without its preceding `AIMessage`.
* Suspected: The summarization step trims or removes the oldest messages by count, cutting between an `AIMessage(tool_calls)` and its `ToolMessage`s, which leaves orphaned tool messages at the start of the history sent to the model.
* Suspected: It is intermittent because it only occurs when the cut point lands inside a tool-call group, which is more likely with parallel tool calls producing multiple `ToolMessage`s; this is unconfirmed until the summarization/trim code is inspected.
````

### Rubric check (proposed)

| Criterion | Pt | Why |
|---|---|---|
| Symptom: what the user sees, and when | 0.5 | Says "intermittently" and gives a *suspected* trigger (cut point inside a tool-call group). Still doesn't say it only happens once the history is long enough to be trimmed. |
| Error, precisely | 1 | Exact exception, message and `param`. |
| Where | 1 | Summarization step plus the `assistant` node. |
| Status / impact | 1 | Workaround stated. |
| Shape: ≤ 5 lines, known vs guessed separated | 1 | 5 bullets, each labelled **Known** or **Suspected**, and it says the intermittency is "unconfirmed until the summarization/trim code is inspected". |
| **Total** | **4.5** | |

### Discernment: what I verified against `issue.md`
- [x] `Compare "Gilded Prowl Skirt" with "Khaki Mini Skirt"` is the human message in the dump, so the "latest turn" in bullet 3 is real.
- [x] It no longer invents "fine-tuned gpt-4o-mini" or a fix list. The Known/Suspected rule stopped those guesses.
- [ ] **Still check:** bullet 3 says the ticket "notes the history is cut". The ticket only says one tool message has no `AIMessage` before it. It never says why. That is Suspected, not Known.
- [ ] **Still check:** is "trims by count" correct? Open `summarize_conversation` in `sample-project/server/agent/graph.py` and `RECENT_MESSAGE_LIMIT` in `sample-project/server/utils/constants.py`.

### What changed v1 → v2
| | v1 | v2 |
|---|---|---|
| Length | ~25 lines | 5 bullets |
| Root cause | stated as fact | labelled Suspected |
| Fix list | included | gone |
| Invented details (fine-tuned model) | yes | no |
| Score | 3 | 4.5 |

The biggest gain came from the **Rules** block, specifically the length cap and the Known/Suspected labels. Giving Claude a role and context mattered less.

---

## v3: fix one gap

**Change (one thing only):** added `Line 1 must say what a user sees and when it starts.`

**Prompt**
````
I'm developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guesst); no fixes yet.
Line 1 must say what a user sees and when it starts.
<paste issue.md>
````

**Response**
````
Known: A user sees a failed or broken response on a follow-up question in a conversation (e.g. "Compare X with Y"), and it starts when the agent issues two parallel tool calls in one turn and the conversation is then summarized; the stream aborts with an OpenAI 400 error ("messages with role 'tool' must be a response to a preceeding message with 'tool_calls'").

1. Known: The state messages passed to the `assistant` node begin with orphaned `ToolMessage`s (no preceding `AIMessage` with `tool_calls`), and the failing param is `messages.[1].role`; the same error appears with the summary feature on, and the current temp workaround is disabling it.
2. Known: The last two messages in state are `ToolMessage`s from one parallel `check_and_execute_query_tool` pair (Gilded Prowl Skirt / Khaki Mini Skirt), and the `AIMessage` that issued those calls is the one missing from the end of the list.
3. Suspected: The summarization step trims or cuts the message history at a point that separates an `AIMessage` (with `tool_calls`) from its `ToolMessage` responses, leaving orphans at the start or end of the list (OpenAI requires them paired).
4. Suspected: The bug is intermittent ("sometime") because it only triggers when the cut-off boundary lands inside a tool-call/tool-response group, which parallel tool calls make more likely; the linked LangGraph discussion (#1398) may describe the same pattern.
````

### Rubric check (proposed)

| Criterion | Pt | Why |
|---|---|---|
| Symptom: what the user sees, and when | 1 | Line 1 now covers both, and links the trigger to the conversation being summarized. This is the half point v2 missed. |
| Error, precisely | 1 | Exact message and `param`. |
| Where | 1 | The summarization step and the `assistant` node. |
| Status / impact | 1 | Workaround mentioned (line 1 of the list). |
| Shape: ≤ 5 lines, known vs guessed separated | 0 | Line 1 puts a guess under **Known** (see below), and item 2 states a false fact under **Known**. The labels are what the ticket reader relies on. |
| **Total** | **4** | |

### Discernment: I checked these against the dump in `issue.md`

| Claim (v3) | Verdict | Evidence |
|---|---|---|
| Line 1 (Known): "starts when the agent issues two parallel tool calls in one turn and the conversation is then summarized" | **Guess labelled Known** | The ticket only says summarization is involved (title and temp fix). It never says parallel calls are the trigger. This should be Suspected. |
| Line 1 (Known): "a failed or broken response on a follow-up question" | **Guess** | The ticket shows a stack trace, not what the user sees. |
| Item 1: state starts with orphaned `ToolMessage`s | **True** | The first two messages in the dump are `sql_db_list_tables` and `sql_db_schema` tool messages with no `AIMessage` before them. |
| Item 2 (Known): the `AIMessage` that issued the last two tool calls "is the one missing from the end of the list" | **False** | The dump has an `AIMessage` with the two parallel calls (`call_qK4F…`, `call_yc6c…`) immediately before the last two `ToolMessage`s. Those two are paired correctly. The orphans are at the **start**. |
| Item 3: separates an `AIMessage` from its tool replies "at the start or end" | **Half true** | "Start" matches the dump. "End" is not supported. |

**What this teaches:** the "Known / Suspected" rule only works if Claude follows it honestly. When the new rule forced Claude to put a "when" on line 1, it filled the gap with a guess and marked it Known. Then it mis-read the dump in item 2. v3 is more complete but less trustworthy than v2.

**Where I made a mistake as teacher:** my suggested v3 line demanded a "when" even when the ticket doesn't give one. That pushed Claude to invent it. A better version is: `Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected.`

---

## Comparison

| | v1 lazy | v2 framed | v3 + "line 1" |
|---|---|---|---|
| Length | ~25 lines | 5 bullets | 5 lines |
| Has "when" | no | partly | yes |
| Invented facts | yes (fine-tuned model) | no | guess labelled Known + one false claim |
| Fix list | yes | no | no |
| Score (proposed) | 3 | 4.5 | 4 |

## v4: v3 with an honesty rule

**Change (one thing only, vs v3):** `If the ticket doesn't say, label it Suspected.`

**Prompt**
````
I'm developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guesst); no fixes yet.
Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected.
<paste issue.md>
````

**Response**
````
Known: Users sometimes get an error instead of a reply when the "summary conversation" feature is on; the ticket says it happens "sometime" and gives no exact trigger, and the temp workaround is to disable the feature.
Known: The OpenAI API returns a 400 `BadRequestError` ("messages with role 'tool' must be a response to a preceeding message with 'tool_calls'", param `messages.[1].role`), raised from the `assistant` node in `graph.py` while streaming via `chat.py`.
Known: The debugged `state["messages"]` begins with orphaned `ToolMessage`s (the first two, with no preceding `AIMessage` carrying `tool_calls`), and later has an `AIMessage` with two `tool_calls` followed by two `ToolMessage`s.
Suspected: The summarization step trims or replaces earlier history and cuts between an `AIMessage(tool_calls)` and its `ToolMessage`s, leaving tool responses at the start of the list; the ticket doesn't show the summary code.
Suspected: It only fails sometimes because the cut falls inside a tool-call group only when the history reaches the summarization threshold, so shorter conversations work.
````

### Rubric check (proposed)

| Criterion | Pt | Why |
|---|---|---|
| Symptom: what the user sees, and when | 1 | Error instead of a reply, "sometimes", and the "when" (only once the history reaches the summarization threshold) is stated and labelled Suspected. |
| Error, precisely | 1 | Exact message and `param`. |
| Where | 1 | `assistant` node in `graph.py`, streamed via `chat.py`, and the summarization step. |
| Status / impact | 1 | Workaround stated. |
| Shape: ≤ 5 lines, known vs guessed separated | 1 | 5 lines; every Known is backed by the ticket; guesses are labelled and it admits the summary code isn't in the ticket. |
| **Total** | **5** | |

### Discernment: checked against `issue.md` and the repo
| Claim | Verdict | Evidence |
|---|---|---|
| Line 3: first two messages are orphan `ToolMessage`s | **True** | `sql_db_list_tables` and `sql_db_schema` tool messages open the dump. |
| Line 3: later, an `AIMessage` with two `tool_calls` followed by two `ToolMessage`s | **True** | `call_qK4F…` and `call_yc6c…`, then the Gilded Prowl / Khaki Mini replies. v3 got this wrong. |
| Line 2: raised from `assistant` node in `graph.py`, streaming via `chat.py` | **True** | Traceback: `chat.py` line 64 `stream_agent_response`, `graph.py` line 53 `__call__`. |
| Line 5: fails only once the history reaches the threshold | **Matches the code** | `summarize_conversation` returns early when `len(messages) <= RECENT_MESSAGE_LIMIT + 1` (default 5). Claude didn't see the code, so this was a good guess. |
| Line 4: cuts between an `AIMessage(tool_calls)` and its `ToolMessage`s | **Still unproven** | `handle_keep_recent_messages` tries to keep these pairs together. Whether it always does is the Day 2 question. |

**Minor nit:** line 1 is labelled Known, but "an error instead of a reply" is inferred from a stack trace. It is honest about the trigger though ("gives no exact trigger"). Not worth a point.

---

## Comparison

| | v1 lazy | v2 framed | v3 + "line 1" | v4 + honesty rule |
|---|---|---|---|---|
| Length | ~25 lines | 5 | 5 | 5 |
| Has "when" | no | partly | yes (as Known, a guess) | yes (as Suspected) |
| Invented / wrong facts | yes | no | yes | **no** |
| Fix list | yes | no | no | no |
| Score (proposed) | 3 | 4.5 | 4 | **5** |

**Which change moved the score:**
1. Rules block (length cap + Known/Suspected labels): 3 → 4.5, the biggest jump.
2. "Line 1 must say what a user sees and when": 4.5 → 4, **worse**. It forced Claude to invent.
3. "If the ticket doesn't say, label it Suspected": 4 → 5. It gave Claude an honest way out.

**Rule to keep:** every time you require a field the source may not contain, say what to do when it's missing.

---

---

**Best prompt (copy to `../../notes.md`):** v4
```
I'm a developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guess); no fixes yet.
Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected.
<paste ticket>
```
**Surprise (good/bad):**
- Good: adding the Rules block cut the answer from ~25 lines to 5 and removed an invented detail.
- Bad: when I forced a "when it starts" line, Claude filled the gap with a guess labelled Known, then mis-read the dump (said an `AIMessage` was missing when it was present).
- Good: telling Claude what to do when the source is silent ("label it Suspected") fixed the invention problem without making the answer longer.
