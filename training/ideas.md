# Ideas / backlog

One line each. Tag: `[kit]` reusable · `[sample]` for sample-project · `[work]` real projects.

- [sample] Bug in `sample-project/assets/issue.md` (OpenAI 400: tool message w/o preceding tool_calls on conversation summary) — use as Day 2–3 ticket.
- [work][kit] `email-digest` skill + scheduled task: summarize company Gmail every work day 08:30 (`30 8 * * 1-5`) or on demand; Gmail connector, read-only. Build Day 7–9.
- [work][kit] `report-email` skill: draft recurring email reports from a fixed template (e.g. weekly training report for this course) — fill from `TODO.md` + `training/day-XX/notes.md`, output a Gmail draft (never auto-send). Reuse for other weekly/status reports. Skill written as `writing-training-reports` → `ai-kit/.claude/skills/`; eval plan in `training/evals/`.
- [sample] Capstone idea: add feature to sample agent (e.g. order-status tool / history export).
- [work][kit] Hand-off trio (Cowork scheduled tasks): **morning inbox triage** (= `email-digest`), **daily briefing** (calendar + tasks + inbox), **weekly roundup** (week's work from notes/git/email). Step 1: log daily work in detail to find repeat tasks. Later bundle into a plugin. Build Day 7–9.
