# Task 3: Log

The rubric is in [README.md](README.md). Scores marked "proposed" are the teacher's first pass. Confirm or change them.

Status: v1 and v2 are done. v3 and the hand-edited final message are still to do. This task continues on Day 2.

## Scores

| Round | Change | Score /5 | What improved, and what was still wrong |
|---|---|---|---|
| v1 | Lazy prompt plus the Task 1 v4 summary pasted | 1 (proposed) | It reads as an engineer's status report, not a Slack reply to a PM. It has no date, it has headers and jargon, and it runs about 230 words. It did not invent a date. |
| v2 | Added the PM's question, three facts and eight rules (80 words, no jargon, a date range, an update time) | 4 (proposed) | It fits Slack at 68 words with no jargon, a date range with its dependency, and an update promise. It never says why the feature was turned off (the errors), and it invents "afternoon". |
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
Conversation summary is off as a temporary fix: long chats still work, but older context just isn't summarized anymore. I can't give a firm return date yet, since I haven't reproduced the bug. I'll do that tomorrow, then fix and test it. Realistic earliest is 2-3 days from now (Oct 23-24), depending on the fix passing review without surprises. I'll update you tomorrow afternoon once I've reproduced it.
`````

### Rubric check (proposed)

| Criterion | Points | Why |
|---|---|---|
| Answers both questions (why it's off, when it's back) in the first 2 lines | 0.5 | "When" gets an honest answer in line 2 ("no firm return date yet"). "Why" only says "a temporary fix". It never says the feature caused errors, which is what the PM asked. |
| No jargon | 1 | No code, API or file names. "Reproduced" is the only technical word, and a PM can follow it. |
| Honest date: a range and what it depends on | 1 | "2-3 days from now (Oct 23-24), depending on the fix passing review". The dates match the facts (the day this was run was Oct 21). |
| Slack-sized: 80 words or fewer, no headers, sounds like you | 1 | 68 words, no headers or bullets. |
| Ends with what the PM can expect | 1 | "I'll update you tomorrow afternoon once I've reproduced it." |
| Total | 4.5, rounded down to 4 | The missing "why" matters most to this reader, so I rounded down. |

### Observations
- Good: it followed every rule, and the date range matches your facts.
- Good: it didn't promise a fix, and it said it can't give a firm date.
- Bad: the PM asked "why is it turned off", and the answer never mentions the errors. A PM reading this can't tell whether summary was switched off for cost, for a decision or for a bug.
- Bad: "tomorrow afternoon" is invented. Your facts said "tomorrow". You can't promise an afternoon update unless you mean it. Fix this in your hand edit.
- Good: the facts did the work. The v1 response had no date because the facts were missing, and v2 has one because you supplied them. This is the Task 1 lesson in a new place.
- For v3: add the missing "why" as a fact, for example "Why it's off: in some long chats the assistant crashed with an error instead of replying". That is one change, and it is the biggest remaining gap. Fix "afternoon" by hand.

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
