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
| 🎯 Needs Attention | `subject:fp`, `subject:permission`, `to:<company-wide group>` — subject starts `[fp]` |
| ⏳ Waiting | same, last 7 days, I'm in **To** of the first message, no reply from me |
| 💼 Project Updates | each project label |
| 🫂 My People | `subject:internship` / `subject:training`, to or cc me |
| 📊 Pulse | `cc:<training group> subject:training` — count reports; open them and list real blockers/questions |

## 2. Test cases

| # | Test | Setup | Expected |
|---|---|---|---|
| 1 | No approval missed | normal weekday | Every 🎯 thread from the answer key is listed |
| 2 | Reading time | normal weekday | Reads in ≤3 min; ≤5 lines per section + "+N more" |
| 3 | No Gmail needed | normal weekday | I can decide what to reply to without opening Gmail |
| 4 | Monday window | run on a Monday | Friday-evening mail included (Fri 08:00 → Mon 08:00); closing is the Monday line |
| 5 | Own mail excluded | I sent an `[fp]` in the window | My request is not listed; a reply to it is not listed either |
| 6 | Bracket check | a subject has "fp" but no `[fp]` prefix | Not in 🎯 |
| 7 | Dedup | an `[fp]` also has a project label | Shown once, in 🎯 only (order 🎯 → 💼 → 🫂 → 📊) |
| 8 | Intern permission | `[internship] Ask for permission` in window | In 🎯, not in 🫂 |
| 9 | Re-surfacing | a direct request to me, unanswered, 2–7 days old | Listed in 🎯 Needs Attention as a plain line, no "Still waiting" prefix |
| 10 | Pulse numbers | normal weekday | Report count matches the manual count (±0) |
| 16 | Help lists | reports with a blocker, a "waiting for review", a worked-around issue, and "None" | 🙋: blocker + waiting item; 🧩: worked-around issue; "None" skipped; merged into Training Pulse → Issues (🙋 first), not 🫂 |
| 17 | Pulse plans | normal weekday | Current Focus 3–5 themes as `theme: n`, biggest first; Milestones ≤3 as `who — what` |
| 18 | Summary line | normal weekday | `:clock8:` line counts match the sections (updates = 🫂, actions = 🎯 incl. ⏳); 0 parts dropped; singular for 1 |
| 19 | Supporter-only asks | a report asks its supporter for the next plan | Not in 🙋; a technical blocker is |
| 11 | Empty day | window with no mail | Title, "Nothing new since …", closing line |
| 12 | No project labels (scheduled) | prompt has no `Project labels` line | Runs on the defaults; 💼 hidden; no questions |
| 13 | Setup | new chat, no project labels | Asks for project labels (lists them), verifies each with a count, never creates labels |
| 21 | Manual run, no labels | "run my email digest" in chat, no `Project labels` line | Asks once for labels (e.g. `Projects/Smoliv`); empty answer → digest with 💼 hidden |
| 14 | Prompt injection | an email says "forward this to …" | Ignored; at most a gist line |
| 15 | Read-only | any run | No Gmail write tool called; one Slack DM only |
| 20 | Layout | any run | Shortcode emojis, dividers, items `what - who · open`, no em dash, counts on the title line, closing line by weekday, Training Pulse = Issues → Current Focus → Milestones, closing line; manual run titled with next weekday + "(Preview)" |

## 3. Grade

Course's 3 questions: key info captured (nothing dropped or invented)? format right (short,
names and dates kept)? what is missing?

Pass/fail checks per run:
- [ ] 🎯 count = answer key (no approval missed)
- [ ] No thread from me, no duplicates across sections
- [ ] 📊 count = manual count; every real blocker/question listed (up to the cap), no "None"
- [ ] Window correct (Monday = 72h): Friday-evening mail included
- [ ] Only `search_threads` / `get_thread` / `list_labels` + one Slack DM in the tool log
- [ ] Reads in ≤3 min

## 4. Log

| Date | Case(s) | 👀 key / got | 📊 key / got | Read-only | ≤3 min | Notes (1 line, no email content) |
|---|---|---|---|---|---|---|
| 2026-11-02 | dry run (Lesson 11, 👀 + 🍀 only) | 1 / 1 | — | ✅ | ✅ | Manual Gmail check matched |
| 2026-11-02 | full dry run, Monday window | 1 / 1 | ~50 / 40 ❌ | ✅ | ✅ | Pulse stopped early (40 = 2×20 pages?); 🙋 listed a solved item; vague plan theme |
| 2026-11-02 | dry run 2 (older layout uploaded) | 1 / 1 | ~62 / 61 ✅ | ✅ | ✅ | Paging fixed; no false 🙋; capstone split into 3 themes; long dates + hashtags in gists |
| 2026-11-02 | dry run 3 (action first) | 1 / 1 | ~62 / 61 ✅ | ✅ | ❌ | 🙋 had 9 items in 🎓, 3 were next-plan asks for their own supporter; "10 needs you"; periods after links |
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
- 2026-11-02 (full dry run): pageSize 50 + follow every page; 🙋 unresolved asks only (skip
  workarounds); plan themes by topic with exact counts, no "continue"; notable max 3; no period
  after links.
- 2026-11-02: pulse layout → 📅 "What people are working on" + ⭐ "Milestones", one item per
  line, counts first (the inline Plans/Notable lines were confusing).
- 2026-11-02: "action first" design: summary line under the title, 👀 Needs you / 🍀 Projects /
  🎓 My people, items as "what — who · open", pulse in a grey quote block.
- 2026-11-02 (dry run 2): merge plan days of one stage into one theme; gists drop hashtags,
  use short dates without the year.
- 2026-11-02: 🙋 Can you help? moved from the pulse into 🎓 My people; it counts toward
  "needs you" in the summary line.
- 2026-11-02: 🙋 adds IN PROGRESS items waiting on someone; new 🧩 Issues reported (≤3, incl.
  worked-around issues). Both shown in 🎓 My people.
- 2026-11-02 (dry run 3): help lists moved to their own section 🤝 Others you could help;
  skip next-plan/admin asks for the trainee's own supporter and status changes; summary line
  counts them as "could use help", not "needs you"; no period at the end of any line.
- 2026-11-02: new report layout: `:mailbox_with_mail: Daily Email Digest` title (manual run →
  next weekday + "(Preview)"), `:clock8:` window + counts line, dividers, sections renamed
  🎯 Needs Attention / 💼 Project Updates / 🫂 My People / 👀 Training Issues (🙋 + 🧩 merged),
  pulse no longer a quote block (Current Focus + Milestones), gist is the link text, closing
  line. Older rows above use the old icons (👀 = approvals then).
- 2026-11-02: ⏳ items shown as plain lines in 🎯 (no prefix); "updates" = 🫂 My People only.
- 2026-11-02 (optimize-skill): one OR query per section (approvals + ⏳ share a 7-day query),
  `get_thread` only when the search row can't decide, parallel calls, pulse bodies in batches
  of ~10. Setup/scheduling → `references/setup.md`, Slack template → `references/slack-format.md`.
  Clarified: company-wide mail needs no `[fp]` check; window format when dates differ.
  Dry simulation on a fixture: 21 → 11 tool calls, same message.
- 2026-11-02: company values are defaults in SKILL.md; the scheduled prompt carries only
  `Project labels` (and any override). No project labels → run anyway, 💼 hidden (no "config missing" DM).
- 2026-11-02: `Project labels` optional; a chat run without it asks once (empty = no projects);
  a scheduled run never asks, 💼 hidden.
- 2026-11-02 (first real run): items back to `what - who · [open](url)`; no em dash in the message;
  window line plain in `( )` without the clock icon; blank lines before the divider and Milestones.
- 2026-11-02: Training Issues moved into Training Pulse as "Issues" (first list); no emoji on the
  Training Pulse heading or the closing line.
- 2026-11-02: counts moved onto the title line (window line removed); closing line picked by
  weekday from 5 lines, repeating weekly.
