# Task 1: Bug summary

## Scenario
You just joined the e-commerce agent project. The ticket says only "Summary conversation sometime got error" and a 90-line traceback. Write a summary you could paste into the ticket or say at standup.

## Input
`resources/practice/issues/issue-1.md`, pasted or attached. The source code isn't in this repo, so work from the issue alone.

## v1: lazy prompt (send exactly this)
```
summarize this bug
<paste issue-1.md>
```

## Rubric (1 point each, 5 max)
- [x] Symptom: what the user sees, and when. It only happens in long conversations, once summarization starts.
- [x] Error, exactly: an OpenAI 400, because a `tool` message has no preceding assistant message with `tool_calls`.
- [x] Where: it names the summarize or trim step, not just "the OpenAI call" or "LangGraph".
- [x] Status: it mentions the workaround (the feature is disabled).
- [x] Shape: 5 lines or fewer, known facts kept apart from guesses.

<details><summary>Teacher's check (open after v3)</summary>

- The error is an OpenAI 400 (`param: messages.[1].role`): a `tool` message has no preceding assistant message with `tool_calls`.
- The dump starts with `ToolMessage`s and no `AIMessage`, so the history was cut in the middle of a tool-call pair. That points at the summarize or trim step, but the issue never shows that code, so it is Suspected.
- The workaround is that the summary feature is off.
- Mark down any summary that states a root cause as fact without evidence from the ticket.
</details>

## Log
[log.md](log.md): one section per round with prompt, response, score and what changed.
