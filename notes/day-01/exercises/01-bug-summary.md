# Task 1 — Bug summary

## Scenario
You just joined the e-commerce agent project. The lead hands you a ticket with just "Summary conversation sometime got error" and a 90-line traceback. Before you touch code, you need a summary you could paste into the ticket or say at standup.

## Input
`sample-project/assets/issue.md` (attach it or paste it). It has the traceback, the `state["messages"]` dump and a link to a LangGraph discussion.

Optional extra context for v2/v3: `sample-project/server/agent/graph.py` (`summarize_conversation`) and `sample-project/server/utils/utils.py` (`handle_keep_recent_messages`).

## v1: lazy prompt (send exactly this)
```
summarize this bug
<paste issue.md>
```

## Rubric (1 point each, 5 max)
- [ ] **Symptom:** what the user sees, and when (only on longer conversations, once summarization kicks in)
- [ ] **Error, precisely:** OpenAI 400, a `tool` message with no preceding assistant message that has `tool_calls`
- [ ] **Where:** names the summarize/trim step, not just "the OpenAI call" or "LangGraph"
- [ ] **Status/impact:** mentions the current workaround (feature disabled)
- [ ] **Shape:** short enough for a ticket (≤ 5 lines), and separates *known* from *guessed*

<details><summary>Teacher's check (open only after v3)</summary>

What a good summary should get right, from the repo:
- `summarize_conversation` runs at `START` on every turn. Once the history is longer than `RECENT_MESSAGE_LIMIT + 1` (default 5), it keeps only the last N messages and deletes the rest.
- If the cut falls between an `AIMessage(tool_calls=…)` and its `ToolMessage`, the history sent to OpenAI starts with an orphan `ToolMessage` → 400 (`param: messages.[1].role`).
- `handle_keep_recent_messages` tries to keep tool pairs together. Whether it fully does is the **Day 2** question. Don't fix it today.
- Penalize any summary that states a root cause as fact without pointing to evidence in the ticket.
</details>

## Your log
| Round | Prompt (or the change) | Score /5 | What improved / what was still wrong |
|---|---|---|---|
| v1 | `summarize this bug` | | |
| v2 | | | |
| v3 | | | |

**Best prompt (copy to notes):**
```

```
**Surprise (good/bad):**
