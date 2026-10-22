# Task 1: Bug summary

## Scenario
You just joined the e-commerce agent project. The lead hands you a ticket that says only "Summary conversation sometime got error" and a 90-line traceback. Before you touch code, you need a summary you could paste into the ticket or say at standup.

## Input
`resources/practice/issues/issue-1.md`, attached or pasted. It holds the description, the traceback and the `state["messages"]` dump. The source code is not in this repo, so work from the issue alone.

## v1: lazy prompt (send exactly this)
```
summarize this bug
<paste issue-1.md>
```

## Rubric (1 point each, 5 max)
- [x] Symptom: what the user sees, and when. It only happens on longer conversations, once summarization starts.
- [x] Error, exactly: an OpenAI 400, because a `tool` message has no preceding assistant message with `tool_calls`.
- [x] Where: it names the summarize or trim step, not just "the OpenAI call" or "LangGraph".
- [x] Status: it mentions the current workaround (the feature is disabled).
- [x] Shape: short enough for a ticket (5 lines or fewer), with known facts kept apart from guesses.

<details><summary>Teacher's check (open only after v3)</summary>

What a good summary gets right, from the issue:
- The error is an OpenAI 400 (`param: messages.[1].role`): a `tool` message has no preceding assistant message with `tool_calls`.
- The dump starts with `ToolMessage`s and no `AIMessage`, so the history was cut in the middle of a tool-call pair. This points to the summarize or trim step, but the issue never shows that code, so it is Suspected.
- The workaround is that the summary feature is turned off.
- Mark down any summary that states a root cause as fact without pointing to evidence in the ticket.
</details>

## Your log
Keep it in [log.md](log.md), with one section per round: prompt, response, score and what changed.
