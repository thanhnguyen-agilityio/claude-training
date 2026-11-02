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

## Files

| File | Lesson | Status |
| --- | --- | --- |
| [plan.md](plan.md) | 7: vision, task breakdown, delegation | done |
| [prompts.md](prompts.md) | all: prompts used, result, what to change | ongoing |
| `spec.md` | 11: built with the describe → check → refine loop | not started |
| `diligence.md` | 12: diligence statement | not started |
