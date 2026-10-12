# Plan — Dev track (Claude Code Desktop)

Source: https://dojo.agilityio.dev/ (crawled 2026-10-12; site verified 2026-10-07). 15 days, ~6h/day.
Track: **Developer**. Skipped: BA/QA-only items. Solo adaptation: Claude plays partner/reviewer/"client"; lead-only items noted in TODO.

Practice repo: `sample-project/` (Python: LangGraph agent + FastAPI/LangServe server + Streamlit client). Seeded bug ticket: `sample-project/assets/issue.md`.

## Map

| Day | Theme | Key output |
|---|---|---|
| 1 | Mental model + Claude basics | 3 real chat tasks; git clone/branch/commit/push |
| 2 | Ticket analysis, reproduce | 3-sentence analysis x5; repro + failing test; conflict #1 |
| 3 | Fix, review, merge — **CP1** | PR w/ good description; review (3 comments); merge w/ conflict |
| 4 | Install, daily loop | Full ticket loop in Code tab x2 |
| 5 | Memory & context | CLAUDE.md, compaction, `/rewind` |
| 6 | Flagship + parallel — **CP2** | artifact, `/loop`, `/rc`, ultrathink, 2 worktree sessions |
| 7 | Skills, commands, plugins | 1 skill + 1 command via PR; 1 plugin |
| 8 | MCP & connectors | GitHub + Playwright MCP used e2e |
| 9 | Hooks & automation | 1 hook PR; `/goal`; scheduled task; `@claude` Action |
| 10 | Review & quality | `/code-review` + ultra; security plugins |
| 11 | Role day — **CP3** | Chrome/Playwright verify app; checkpoint |
| 12–15 | Capstone — **CP4** | Feature for sample app: plan → build → harden → ship/demo |

## Checkpoints (pass/fail)

- **CP1 (D3):** repro bug in ticket · fix on branch + test · self-contained PR · peer review w/ 3 actionable comments · merge w/ conflict resolved.
- **CP2 (D6):** 2 parallel sessions both merged · 1 plan-mode change steered via diff comments · 1 artifact · 1 Remote Control steer · 1 `/loop` run.
- **CP3 (D11):** 1 skill + 1 hook merged · 1 MCP tool e2e · 1 `/code-review` or ultrareview acted on · role-day exercise.
- **CP4 (D15):** capstone shipped e2e · all checkpoints green · personal "how I work with Claude" playbook.

## Day detail
Actionable checklist per day: [TODO.md](TODO.md). Full source page: `https://dojo.agilityio.dev/schedule/day-NN.html`.

## Course list (devs)
Claude 101 (D1–2) · Claude Code 101 (D4) · Claude Code in action (D4) · Intro to subagents (D6) · Intro to agent skills (D7) · Intro to MCP (D8) · AI-native SDLC playbook (D11–12, lead/senior) · Optional after: MCP advanced, Building with Claude API, Claude Platform 101, human-agent teams (beta).
Docs: code.claude.com/docs/en/{quickstart, desktop-quickstart, common-workflows, best-practices, prompt-library, whats-new/index}.
Academy: academy.claude.com.

## Rules from plan
- Sandbox repo only; never client code/secrets/customer data in AI tools.
- AI output = proposal until run. Never merge what you can't explain.
- PRs always; never push to shared branches directly.
