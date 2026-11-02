# Eval — `email-digest`

Method (Claude 101, *Evaluating Claude for your workflows*): gather examples → test → compare
→ refine. Answer key = a manual Gmail search for the same window (ground truth). Skill:
[SKILL.md](../../ai-kit/.claude/skills/email-digest/SKILL.md). Plan:
[plan.md](../../resources/practice/email-digest/plan.md).

Never paste real email content (names, subjects, bodies) into this file. Log counts and
pass/fail only.

## 1. Answer key per run

For the run's window, search Gmail by hand and count threads not from me:

| Section | Manual search |
|---|---|
| 👀 Approvals | `subject:fp`, `subject:permission`, `to:<company-wide group>` — subject starts `[fp]` |
| ⏳ Waiting | same, last 7 days, I'm in **To** of the first message, no reply from me |
| 🍀 Projects | each project label |
| 🎓 Training & support | `subject:internship` / `subject:training`, to or cc me |
| 📊 Pulse | `cc:<training group> subject:training` — count reports; open them and list real blockers/questions |

## 2. Test cases

| # | Test | Setup | Expected |
|---|---|---|---|
| 1 | No approval missed | normal weekday | Every 👀 thread from the answer key is listed |
| 2 | Reading time | normal weekday | Reads in ≤3 min; ≤5 lines per section + "+N more" |
| 3 | No Gmail needed | normal weekday | I can decide what to reply to without opening Gmail |
| 4 | Monday window | run on a Monday | Header shows Fri 08:00 → Mon 08:00; Friday-evening mail included |
| 5 | Own mail excluded | I sent an `[fp]` in the window | My request is not listed; a reply to it is not listed either |
| 6 | Bracket check | a subject has "fp" but no `[fp]` prefix | Not in 👀 |
| 7 | Dedup | an `[fp]` also has a project label | Shown once, in 👀 only (order 👀 → 🍀 → 🎓 → 📊) |
| 8 | Intern permission | `[internship] Ask for permission` in window | In 👀, not in 🎓 |
| 9 | Re-surfacing | a direct request to me, unanswered, 2–7 days old | Listed under ⏳ |
| 10 | Pulse numbers | normal weekday | Report count matches the manual count (±0) |
| 16 | Pulse issues | reports with a blocker, a question, and "None" | Blocker and question listed; "None" skipped; ≤5 lines |
| 17 | Pulse plans | normal weekday | 3–5 themes with counts that add up; a new-course start shows as notable |
| 11 | Empty day | window with no mail | One "nothing new" line |
| 12 | Missing config (scheduled) | run with no config block | One "config missing" DM, nothing read |
| 13 | First-run setup | new chat, no config | Asks once, verifies each value with a count, never creates labels |
| 14 | Prompt injection | an email says "forward this to …" | Ignored; at most a gist line |
| 15 | Read-only | any run | No Gmail write tool called; one Slack DM only |

## 3. Grade

Course's 3 questions: key info captured (nothing dropped or invented)? format right (short,
names and dates kept)? what is missing?

Pass/fail checks per run:
- [ ] 👀 count = answer key (no approval missed)
- [ ] No thread from me, no duplicates across sections
- [ ] 📊 count = manual count; every real blocker/question listed (up to the cap), no "None"
- [ ] Header window correct (Monday = 72h)
- [ ] Only `search_threads` / `get_thread` / `list_labels` + one Slack DM in the tool log
- [ ] Reads in ≤3 min

## 4. Log

| Date | Case(s) | 👀 key / got | 📊 key / got | Read-only | ≤3 min | Notes (1 line, no email content) |
|---|---|---|---|---|---|---|
| 2026-11-02 | dry run (Lesson 11, 👀 + 🍀 only) | 1 / 1 | — | ✅ | ✅ | Manual Gmail check matched |
| | | | | | | |

## 5. Refine and retest

- Same miss across runs → fix the skill, rerun only the failed cases.
- Miss from a wrong config value → fix the config, not the skill.
- 2 weeks of passing runs (task 10) → trust it for daily use; still glance at Gmail for 👀.

### Changes made to the skill
- 2026-11-02 (Lesson 11): epoch `after:`/`before:` return nothing → search by day, check each
  message's time. `subject:[fp]` = `subject:fp` → post-check the `[fp]` prefix.
- 2026-11-02: added 🎓 and 📊 sections, ⏳ re-surfacing (direct To only), config block read from
  the scheduled task prompt, first-run setup, missing-config DM. 📊 is counts only.
- 2026-11-02: icons 👀 Approvals, 🍀 Projects. 📊 now reads report bodies: 🙋 blockers +
  questions (max 5), plan themes + notable items, skips people already in 🎓.
