# Task 3: Drafting

## Scenario
The PM, who is not technical, asks on Slack: "Why is conversation summary turned off? When is it coming back?"

You understand the bug now (Tasks 1 and 2), but you have no fix and no estimate yet. The repro and the failing test are scheduled for tomorrow.

## Input
Your best summary from Task 1, plus these facts:
- The feature is disabled as a temporary fix. Long chats work, but older context isn't summarized.
- Next step: reproduce tomorrow, then fix and test. The earliest realistic date is after the fix is reviewed, in 2 to 3 days.

## v1: lazy prompt (send exactly this)
```
write a message to my PM about the summary bug
```

## Rubric (1 point each, 5 max)
- [ ] It answers both questions (why it's off, when it's back) in the first 2 lines.
- [ ] No jargon. No "ToolMessage", "400" or "LangGraph", and the cause fits in one plain sentence.
- [ ] Honest date: a range, plus what it depends on. No over-promising.
- [ ] Slack-sized: 80 words or fewer, no headers, and it sounds like you, not a press release.
- [ ] It ends with what the PM can expect, for example "I'll update you after the repro tomorrow".

## Ideas for v3
- Paste a past Slack message of yours as a tone example.
- Set a hard word limit.
- Ask for two variants, one short and one fuller, and pick one.
- Say what not to write, for example "no bullet list" or "don't apologize three times".

## Your log
Keep it in [log.md](log.md), with one section per round: prompt, response, score and what changed.
