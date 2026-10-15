# Task 3 — Drafting

## Scenario
The PM (not technical) asks on Slack: *"Why is conversation summary turned off? When is it coming back?"*
You reply. You understand the bug now (Tasks 1–2), but you don't have a fix or an estimate yet. Repro and the failing test are scheduled for tomorrow.

## Input
Your best summary from Task 1, plus these facts:
- The feature is disabled as a temporary fix, so long chats work, but older context isn't summarized.
- Next step: reproduce tomorrow, then fix + test. Realistic earliest ETA: after the fix is reviewed (2–3 days).

## v1: lazy prompt (send exactly this)
```
write a message to my PM about the summary bug
```

## Rubric (1 point each, 5 max)
- [ ] **Answers both questions** (why it's off, when it's back) in the first 2 lines
- [ ] **No jargon:** no "ToolMessage", "400", "LangGraph". Plain cause in one sentence.
- [ ] **Honest ETA:** gives a range and what it depends on. Doesn't over-promise.
- [ ] **Slack-sized:** ≤ 80 words, no headers, sounds like you, not a press release
- [ ] **Ends with what the PM can do / expect** (e.g. "I'll update you after repro tomorrow")

## Ideas for v3
- Paste a past Slack message of yours as a **tone example**
- Give a hard word limit
- Ask for 2 variants (short / slightly fuller) and pick one
- Tell it what *not* to say ("don't apologize three times", "no bullet list")

## Your log
| Round | Prompt (or the change) | Score /5 | What improved / what was still wrong |
|---|---|---|---|
| v1 | `write a message to my PM about the summary bug` | | |
| v2 | | | |
| v3 | | | |

**Final message (after your own hand edit):**
```

```
**What you changed by hand, and why:**

**Best prompt (copy to notes):**
```

```
