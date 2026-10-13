# Day 01 — Mental model + Claude basics

## Progress
- [x] Setup: claude.ai login, desktop app, repo cloned
- [x] Git: branch → commit → push
- [~] Course: Claude 101 (13 lessons; rest on Day 2: 7–13 + quiz + badge)
  - [x] 1 [What is Claude](https://academy.claude.com/courses/claude-101/what-is-claude)
  - [ ] 2 Your first conversation with Claude
  - [ ] 3 Getting better results (do before the 3 chat tasks)
  - [ ] 4 How you'll work with Claude on your desktop
  - [ ] stretch: 5 Introduction to projects · 6 Creating with artifacts
- [ ] 3 chat tasks (bug summary / explain concept / drafting)

## Lesson 1 reflection — What is Claude
Work idea to build: **company email digest** via Gmail connector.
- Make it a skill (`email-digest`) + a scheduled task, so it runs two ways:
  - **Auto:** every work day 08:30 (cron `30 8 * * 1-5`) → report in app.
  - **On demand:** run the skill/task manually any time ("run my email digest").
- Source: Gmail connector (company mailbox). Enable connector first (Settings → Connectors).
- Report format (draft): urgent / needs reply / FYI, one line each, sender + ask + deadline.
- Read-only: summarize only, never send/delete/archive. Ask before any action.
- Build when: Day 7 (skills) → schedule on Day 9 (desktop scheduled task); MCP/connector basics Day 8.
- Open Qs: which label/inbox scope? skip newsletters? where to deliver report (in-app vs email-to-self)?

## Learned
-

## Prompts that worked
-

## Gotchas
-

## Kit candidates
- `email-digest` skill (Gmail connector, weekday 08:30 + on demand) → `ai-kit/.claude/skills/`
