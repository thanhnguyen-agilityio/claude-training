# Day 02 exercises (developer)

Source: [dojo/schedule/day-02.md](../../../resources/dojo/schedule/day-02.md). The dojo day has two halves. In the morning you analyze tickets. In the afternoon you reproduce a seeded bug, write exact repro steps, and turn the bug into a failing test.

## Goal
Turn a vague ticket into a reproduce-ready report and a failing test. The Claude habit for the day is to paste the trace and the code, ask for hypotheses, and verify each one by running it, not by trusting it.

## Before you start
- Task 3 from Day 1 is done. Write your hand-edited final message in [03-drafting](../../day-01/exercises/03-drafting/log.md) if you haven't.
- Use only `sample-project/` content. No client code, secrets or customer data.
- Keep the OpenAI key in `.env` only. Never paste it into a chat.

## Tasks
| # | Task | Time | Output |
|---|---|---|---|
| 1 | [Ticket analysis](01-ticket-analysis/README.md) | 45 min | Three-sentence analysis for 5 tickets |
| 2 | [Clarifying questions](02-clarifying-questions/README.md) | 30 min | Questions to the reporter, with Claude playing the reporter |
| 3 | [Run the app from scratch](03-run-the-app/README.md) | 30 to 45 min | A working local app and your setup notes |
| 4 | [Reproduce and write a failing test](04-reproduce-and-test/README.md) | about 2 hours | A repro report and a test that fails today |
| 5 | [Git block](05-git-block/README.md) | 30 min | `pull --rebase`, `log`, `diff` and conflict #1 resolved |
| 6 | Course: Claude 101 lessons 8 to 13, quiz, badge | about 1.5 hours | Notes in `../notes.md` |

Do task 3 early. A broken setup is the most likely thing to block the afternoon.

## Rules for the day
- Each task has a `log.md`. Write what you did, what Claude said, and what you verified yourself.
- A hypothesis from Claude counts only after you ran something that confirms or kills it.
- Do not fix the bug today. The fix is Day 3.

## Done when
- [ ] Tasks 1 to 5 have their logs filled in
- [ ] The failing test is committed on its own branch
- [ ] Lessons 8 to 13, the quiz and the badge are done, with notes
- [ ] Debrief written in `../notes.md` (Learned, Prompts that worked, Gotchas)
- [ ] Everything is committed and pushed
