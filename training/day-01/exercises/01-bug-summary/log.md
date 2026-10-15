# Task 1 — Log

Rubric: see [README.md](README.md). Scores marked *(proposed)* are the teacher's first pass. Confirm or change them.

## Scores

| Round | Change | Score /5 | What improved / what was still wrong |
|---|---|---|---|
| v1 | lazy prompt | 3 *(proposed)* | See v1 analysis below |
| v2 | | | |
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

_To do._

## v3: fix one gap

_To do._

---

**Best prompt (copy to `../../notes.md`):**
```

```
**Surprise (good/bad):**
