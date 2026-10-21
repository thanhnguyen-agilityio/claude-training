# Task 1: Bug summary

## Scenario
You just joined the e-commerce agent project. The lead hands you a ticket that says only "Summary conversation sometime got error" and a 90-line traceback. Before you touch code, you need a summary you could paste into the ticket or say at standup.

## Input
`sample-project/assets/issue.md`, attached or pasted. It holds the traceback, the `state["messages"]` dump and a link to a LangGraph discussion.

For v2 and v3 you can add `sample-project/server/agent/graph.py` (`summarize_conversation`) and `sample-project/server/utils/utils.py` (`handle_keep_recent_messages`).

## v1: lazy prompt (send exactly this)
```
summarize this bug
<paste issue.md>
```

## Rubric (1 point each, 5 max)
- [ ] Symptom: what the user sees, and when. It only happens on longer conversations, once summarization starts.
- [ ] Error, exactly: an OpenAI 400, because a `tool` message has no preceding assistant message with `tool_calls`.
- [ ] Where: it names the summarize or trim step, not just "the OpenAI call" or "LangGraph".
- [ ] Status: it mentions the current workaround (the feature is disabled).
- [ ] Shape: short enough for a ticket (5 lines or fewer), with known facts kept apart from guesses.

<details><summary>Teacher's check (open only after v3)</summary>

What a good summary gets right, from the repo:
- `summarize_conversation` runs at `START` on every turn. Once the history is longer than `RECENT_MESSAGE_LIMIT + 1` (default 5), it keeps only the last N messages and deletes the rest.
- If the cut falls between an `AIMessage(tool_calls=...)` and its `ToolMessage`, the history sent to OpenAI starts with an orphan `ToolMessage`, which gives the 400 (`param: messages.[1].role`).
- `handle_keep_recent_messages` tries to keep tool pairs together. Whether it does is the Day 2 question. Task 2 traces it and finds a likely bug. Day 2 confirms it in the running app. Don't fix it on Day 1.
- Mark down any summary that states a root cause as fact without pointing to evidence in the ticket.
</details>

## Your log
Keep it in [log.md](log.md), with one section per round: prompt, response, score and what changed.
