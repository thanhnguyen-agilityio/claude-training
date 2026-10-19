# ai-kit

Reusable Claude Code starter. Copy into any project; never overwrites existing files.

```bash
./ai-kit/install.sh /path/to/project
```

Installs: `CLAUDE.md` (from template — fill `<…>`), `.claude/settings.json`, `.claude/commands/`, `.claude/skills/`.

## Contents
| Item | What |
|---|---|
| `CLAUDE.md.template` | Project rules: commands, conventions, never-do |
| `.claude/settings.json` | Safe permissions (deny secrets, force-push) |
| `commands/analyze-ticket` | `/analyze-ticket <text>` → 3-sentence analysis + gaps + questions |
| `commands/pr` | `/pr` → PR description from current branch diff |
| `skills/review-checklist` | Review order: correctness → tests → readability → security → scope |
| `skills/repro-bug` | Reproduce-ready bug report + failing test first |
| `skills/optimize-skill` | `optimize a skill` → trims a skill's tokens without changing its output (baseline → cut → re-run → report). Needs the `unslop` skill installed |
| `skills/writing-training-reports` | Daily/weekly `[bgh][training]` report email from session notes → Gmail draft (never sends). Eval: [training/evals/](../training/evals/writing-training-reports.md) |

## Backlog (add as course reaches it)
- D5: refine CLAUDE.md template from real sample-project one
- D6: `loop.md` template
- D7: `release-checklist` skill, personal command
- D8: `.mcp.json` (GitHub, Playwright)
- D9: hooks (format-on-edit, block-forbidden-command, notify) in `settings.json`; `@claude` GitHub Action workflow
- D15: retro → personal playbook
