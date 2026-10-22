# Task 3: Drafting

## Scenario
The PM, who is not technical, asks on Slack: "Why is conversation summary turned off? When is it coming back?"

You understand the bug now (Tasks 1 and 2), but have no fix or estimate yet. The repro and the failing test are tomorrow.

## Input
Your best summary from Task 1, plus these facts:
- The feature is disabled as a temporary fix. Long chats work, but older context isn't summarized.
- Next step: reproduce tomorrow, then fix and test. The earliest realistic date is after the fix is reviewed, in 2 to 3 days.

## v1: lazy prompt (send exactly this line, plus the input)
```
write a message to my PM about the summary bug
```

## Rubric (1 point each, 5 max)
- [x] Answers both questions (why it's off, when it's back) in the first 2 lines.
- [x] No jargon. No "ToolMessage", "400" or "LangGraph", and the cause fits in one plain sentence.
- [x] Honest date: a range, plus what it depends on.
- [x] Slack-sized: 80 words or fewer, no headers, sounds like you.
- [x] Ends with what the PM can expect, for example "I'll update you after the repro tomorrow".

Ticked for the hand-edited final message in [log.md](log.md). No Claude round beat 4.0.

## Ideas for v3
- Paste a past Slack message of yours as a tone example.
- Set a hard word limit.
- Ask for two variants, short and fuller, and pick one.
- Say what not to write, such as "no bullet list" or "don't apologize three times".

## Log
[log.md](log.md): one section per round with prompt, response and score. It ends with the final message.
