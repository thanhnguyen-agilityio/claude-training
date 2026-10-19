# Task 3: Log

The rubric is in [README.md](README.md). Scores marked "proposed" are the teacher's first pass. Confirm or change them.

Status: paused after v1. The v2 prompt is ready and its response is still to come. This task continues on Day 2.

## Scores

| Round | Change | Score /5 | What improved, and what was still wrong |
|---|---|---|---|
| v1 | Lazy prompt plus the Task 1 v4 summary pasted | 1 (proposed) | It reads as an engineer's status report, not a Slack reply to a PM. It has no date, it has headers and jargon, and it runs about 230 words. It did not invent a date. |
| v2 | | | |
| v3 | | | |

---

## v1: lazy prompt

Prompt (the Task 1 v4 summary pasted below it, nothing else)
````
write a message to my PM about the summary bug

Known: Users sometimes get an error instead of a reply when the "summary conversation" feature is on; the ticket says it happens "sometime" and gives no exact trigger, and the temp workaround is to disable the feature.
Known: The OpenAI API returns a 400 `BadRequestError` ("messages with role 'tool' must be a response to a preceeding message with 'tool_calls'", param `messages.[1].role`), raised from the `assistant` node in `graph.py` while streaming via `chat.py`.
Known: The debugged `state["messages"]` begins with orphaned `ToolMessage`s (the first two, with no preceding `AIMessage` carrying `tool_calls`), and later has an `AIMessage` with two `tool_calls` followed by two `ToolMessage`s.
Suspected: The summarization step trims or replaces earlier history and cuts between an `AIMessage(tool_calls)` and its `ToolMessage`s, leaving tool responses at the start of the list; the ticket doesn't show the summary code.
Suspected: It only fails sometimes because the cut falls inside a tool-call group only when the history reaches the summarization threshold, so shorter conversations work.
````

Response
`````
Here's a Slack-style draft:

---

Hi [name], quick update on the summary bug.

**What's happening:** When the "summary conversation" feature is on, users sometimes get an error instead of a reply. For now, disabling the feature avoids it.

**What we've confirmed:** The OpenAI API rejects the request with a 400 `BadRequestError`: a `tool` message has to follow an assistant message with `tool_calls`. It's raised from the `assistant` node in `graph.py` while streaming via `chat.py`. In the failing state, `state["messages"]` starts with two orphaned `ToolMessage`s that have no preceding `AIMessage` with `tool_calls`.

**What I think is going on (not yet confirmed):** The summarization step trims or replaces earlier history and cuts through the middle of a tool-call group. That leaves the tool responses at the start of the list without the message that triggered them. It would also explain why this only happens sometimes: the cut only lands inside a tool-call group once the conversation is long enough to trigger summarization, so shorter chats are fine. The ticket doesn't include the summary code, so I haven't verified this yet.

**Next step:** I'll check the summarization logic and make the trim keep each `AIMessage(tool_calls)` together with its `ToolMessage`s, either by cutting before the group or dropping the orphans. I'll then test with a long conversation that includes tool calls.

Until then, keep the feature disabled. Let me know if you want it handled differently.

---

If you can share the summarization code or an ETA, I can tighten the next-step section.
`````

### Rubric check (proposed)

| Criterion | Points | Why |
|---|---|---|
| Answers both questions (why it's off, when it's back) in the first 2 lines | 0 | The first lines say what is happening. "When is it back" is never answered. |
| No jargon | 0 | It uses `BadRequestError`, `ToolMessage`, `AIMessage`, `graph.py` and `state["messages"]`. A PM can't read this. |
| Honest date: a range and what it depends on | 0 | There is no date. It didn't invent one, which is good, but a PM needs a range. It only asks you for a date at the end. |
| Slack-sized: 80 words or fewer, no headers, sounds like you | 0 | About 230 words with four bold headers. It reads like a ticket. |
| Ends with what the PM can expect | 0.5 | "Keep the feature disabled. Let me know if you want it handled differently." That is something, but there is no "I'll update you after X". |
| Total | 0.5, rounded to 1 | |

### Observations
- Good: it didn't invent a date or state the cause as fact. It kept "confirmed" and "not yet confirmed" apart, because that labeling was in the input.
- Good: it asked for a date instead of making one up.
- Bad: the output copies the style of the input. You pasted an engineering summary and got an engineering message back, because Claude didn't know who the reader was.
- Bad: it committed you to a fix plan ("I'll make the trim keep each `AIMessage` together..."). You never said that.
- Bad: meta lines slipped through ("the ticket doesn't include the summary code", "Hi [name]").
- For v2: say the PM is non-technical and it's Slack, ask it to answer the PM's 2 questions, add rules (a word cap, no jargon, a date range with what it depends on, end with the next update), and add the missing facts.

---

## v2: Stage, Task, Rules plus facts

Prompt (the Task 1 v4 summary pasted under it, same as v1)
````
I'm a developer. My PM is not technical and asked me on Slack: "Why is conversation summary turned off? When is it coming back?" Reply to them using the bug summary below.
Facts to use:

* The feature is turned off as a temporary fix. Long chats work, but older context is no longer summarized.
* I haven't reproduced the bug yet. I'll do that tomorrow, then fix and test it.
* Realistic earliest date: after the fix is reviewed, in 2-3 days.

Rules: max 80 words; no headers or bullets; no technical terms (no code, API or file names); answer both questions in the first two lines; give the date as a range and say what it depends on; end with when I'll next update them; don't promise a specific fix.

<paste the Task 1 v4 summary>
````

Response
`````
(paused: no response yet. Claude had an issue, so run the prompt again later and paste the response here.)
`````

---

## v3: fix one gap

To do.

---

## Final message (after your own hand edit)
```

```

What you changed by hand, and why:

## Best prompt
```

```

## Surprises
