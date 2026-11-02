# Email digest — AI Fluency course project

Hands-on project for the
[AI Fluency](../../claude-academy/ai-fluency/README.md) course: plan it in Lesson 7, build it in
Lesson 11, add a diligence statement in Lesson 12.

Backlog source: `training/ideas.md` → `[work][kit] email-digest`.

## Idea

A skill plus a scheduled task that summarizes my company Gmail every weekday at 08:00
(Asia/Saigon) and posts the digest to Slack. It uses the Gmail connector with **read-only**
access. Agreed spec and decision (build) are in [plan.md](plan.md).

## Starting point: the claude.ai "Inbox triage" template

claude.ai already has a scheduled-task template called **Inbox triage**: it sorts the inbox
into categories and drafts replies to urgent mail, on weekdays at 8:00 AM.

| | Inbox triage (template) | Email digest (my idea) |
| --- | --- | --- |
| Main output | Inbox sorted by category + reply drafts | A short summary to read before standup |
| Writes to Gmail | Yes (drafts) | No (read-only) |
| Customization | Generic | My categories, my format, my senders |
| Effort | Ready to use | Build a skill + evals |

Open question for Lesson 7: **use the template, adapt it, or build my own?**
Answering it is the Platform Awareness part of Delegation.

## Related: `writing-training-reports` skill

My own email skill at
[ai-kit/.claude/skills/writing-training-reports](../../../ai-kit/.claude/skills/writing-training-reports/SKILL.md).
Same toolkit, opposite direction: it writes outgoing drafts, the digest reads incoming mail.

| | writing-training-reports | email-digest |
| --- | --- | --- |
| Direction | Outgoing: notes → report | Incoming: inbox → summary |
| Gmail access | Creates drafts, never sends | Read-only |
| Trigger | On request | Weekdays 08:30 or on request |

What I can reuse:

- **Skill shape**: a profile block saved to memory (for the digest: key senders, categories,
  what counts as urgent), plus workflow, rules, and a fallback when Gmail isn't connected.
- **Safety rules**: "never send" becomes "never write"; never include secrets or customer data.
- **Evals**: copy the format of `training/evals/writing-training-reports*.md` and test with
  sample emails.
- **Gmail connector**: already set up and working.

Later (out of scope): the digest flags replies from training supporters to feed the next report.

## Lesson 11 — execution

Loop run: tasks 4 → 6 → 8 for 🔴 Approvals & Admin and 🔥 Projects. Dry run posted to my Slack
DM; completeness checked against a manual Gmail search for the same window.

Changes from the plan, found by testing on real mail:

- **Time window:** the connector ignores epoch `after:`/`before:`, so the skill searches by day
  and checks each message's time.
- **`[fp]` prefix:** Gmail ignores brackets, so the query is `subject:fp` plus a check that the
  subject starts with `[fp]`.
- **Projects labels:** the parent label doesn't include sub-label mail; each sub-label is
  queried by its full quoted display name, emoji included.
- **New decisions:** intern `[internship] Ask for permission` mail goes to Approvals; company
  notifications (`asoft.all@`) join Approvals as back-office mail; my own sent mail is excluded
  (`-from:me`).

Reflection (my own words):

- **Descriptions that worked best:** the ones with a clear vision, goals, scope, task breakdown
  with delegation, and risks.
- **Description or Discernment, which took more effort:** Discernment. I had to understand the
  descriptions (after many rounds of Q&A and the final doc), check each task against real data
  in Gmail, and make my own evaluation.
- **What changed from the plan:** from the test results — the time window, the prefix filter
  (`fp` instead of `[fp]`), the nested label syntax, and new decisions on intern permission
  mail, company emails and excluding my own sent mail.

## Files

| File | Lesson | Status |
| --- | --- | --- |
| [plan.md](plan.md) | 7: vision, task breakdown, delegation | done |
| [prompts.md](prompts.md) | all: prompts used, result, what to change | ongoing |
| [SKILL.md](../../../ai-kit/.claude/skills/email-digest/SKILL.md) | 11: built with the describe → check → refine loop | Lesson 11 done: Approvals + Projects, dry run passed |
| [diligence.md](diligence.md) | 12: diligence statement | done |
