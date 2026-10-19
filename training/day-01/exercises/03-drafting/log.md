# Task 3 — Log

Rubric: see [README.md](README.md). Scores marked *(proposed)* are the teacher's first pass. Confirm or change them.

## Scores

| Round | Change | Score /5 | What improved / what was still wrong |
|---|---|---|---|
| v1 | lazy prompt + the Task 1 v4 summary pasted | 1 *(proposed)* | It's an engineer's status report, not a Slack reply to a PM. It has no ETA, headers, jargon and about 230 words. It did not invent an ETA. |
| v2 | | | |
| v3 | | | |

---

## v1: lazy prompt

**Prompt** (the Task 1 v4 summary pasted below it, nothing else)
````
write a message to my PM about the summary bug

Known: Users sometimes get an error instead of a reply when the "summary conversation" feature is on; the ticket says it happens "sometime" and gives no exact trigger, and the temp workaround is to disable the feature.
Known: The OpenAI API returns a 400 `BadRequestError` ("messages with role 'tool' must be a response to a preceeding message with 'tool_calls'", param `messages.[1].role`), raised from the `assistant` node in `graph.py` while streaming via `chat.py`.
Known: The debugged `state["messages"]` begins with orphaned `ToolMessage`s (the first two, with no preceding `AIMessage` carrying `tool_calls`), and later has an `AIMessage` with two `tool_calls` followed by two `ToolMessage`s.
Suspected: The summarization step trims or replaces earlier history and cuts between an `AIMessage(tool_calls)` and its `ToolMessage`s, leaving tool responses at the start of the list; the ticket doesn't show the summary code.
Suspected: It only fails sometimes because the cut falls inside a tool-call group only when the history reaches the summarization threshold, so shorter conversations work.
````

**Response**
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

| Criterion | Pt | Why |
|---|---|---|
| Answers both questions (why off, when back) in the first 2 lines | 0 | The first lines say what's happening. "When is it back" is never answered. |
| No jargon | 0 | `BadRequestError`, `ToolMessage`, `AIMessage`, `graph.py`, `state["messages"]`. A PM can't read this. |
| Honest ETA: a range and what it depends on | 0 | No ETA. It didn't invent one, which is good, but a PM needs a range. It only asks you for an ETA at the end. |
| Slack-sized: ≤ 80 words, no headers, sounds like you | 0 | About 230 words with four bold headers. It reads like a ticket. |
| Ends with what the PM can expect | 0.5 | "Keep the feature disabled. Let me know if you want it handled differently." That's something, but there's no "I'll update you after X". |
| **Total** | **0.5, rounded to 1** | |

### Observations
- **Good:** it didn't invent an ETA or state the cause as fact. It kept "confirmed" and "not yet confirmed" apart, because that labelling was in the input.
- **Good:** it asked for an ETA instead of making one up.
- **Bad:** the output copies the style of the input. You pasted an engineering summary and got an engineering message back. Claude didn't know who the reader was.
- **Bad:** it committed you to a fix plan ("I'll make the trim keep each `AIMessage` together…"). You never said that.
- **Bad:** meta lines slipped through ("the ticket doesn't include the summary code", "Hi [name]").
- **Next change for v2:** Stage (the PM is non-technical, it's Slack) + Task (answer the PM's 2 questions) + Rules (word cap, no jargon, ETA as a range with its dependency, end with the next update) + the missing facts.

---

## v2: framed (Stage / Task / Rules)

_To do._

## v3: fix one gap

_To do._

---

**Final message (after your own hand edit):**
```

```
**What you changed by hand, and why:**

**Best prompt (copy to `../../notes.md`):**
```

```
**Surprise (good/bad):**
