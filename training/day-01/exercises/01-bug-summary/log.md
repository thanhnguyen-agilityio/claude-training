# Task 1 — Log

Rubric: see [README.md](README.md). Scores marked *(proposed)* are the teacher's first pass. Confirm or change them.

## Scores

| Round | Change | Score /5 | What improved / what was still wrong |
|---|---|---|---|
| v1 | lazy prompt | 3 *(proposed)* | See v1 analysis below |
| v2 | Stage (role + purpose) / Task / Rules (≤5 lines, Known vs Suspected, no fixes) | 4.5 *(proposed)* | Length and shape fixed, no unrequested fix list, guesses labelled. Still missing: *when* it starts (only once the history is long enough to be trimmed). |
| v3 | | | |

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

_To do._

---

**Best prompt (copy to `../../notes.md`):**
```

```
**Surprise (good/bad):**
