# Common workflows — study notes

- **Source:** https://code.claude.com/docs/en/common-workflows (full Markdown: append `.md` to the URL)
- **Read via:** Claude in Chrome, 2026-11-03
- **Note:** these are summary notes in my own words, not a copy of the page. Check the source for exact wording.

The page is a set of short recipes for everyday Claude Code work. For higher-level prompting and context advice, it points to *Best practices*.

## Prompt recipes

Each recipe follows the same idea: start broad, then narrow down, then act, then verify. They work in any Claude Code surface.

| Task | Flow | Tips |
|---|---|---|
| **Codebase overview** | `cd` to the project root → `claude` → ask for an overview → ask about architecture, data models, auth | Ask about conventions; ask for a glossary of project terms. See *Monorepos and large repos* for big codebases. |
| **Find relevant code** | Ask which files handle a feature → how they work together → trace the flow end to end | Be specific and use the project's own terms. A code intelligence plugin adds go-to-definition and find-references. |
| **Fix bugs** | Share the error → ask for a few fix options → apply the one you pick | Give the repro command and stack trace; say whether the bug is intermittent. |
| **Refactor** | Find legacy or deprecated usage → get suggestions → refactor without changing behavior → run tests | Work in small, testable steps; keep backward compatibility where needed. |
| **Tests** | Find untested code → scaffold tests → add edge cases → run and fix | Claude copies your existing test style. Ask it for missed edge cases: errors, boundary values, odd inputs. |
| **Pull requests** | Summarize changes → "create a pr" → improve the description | Review before submitting. `claude --from-pr <n>` (or pasting the PR URL into `/resume`) finds sessions linked to a PR. Sessions get linked when Claude runs `gh pr create` / `glab mr create` or works on an existing PR. |
| **Documentation** | Find undocumented code → generate docs → add examples → check against project standards | Name the style you want (JSDoc, docstrings, …). |

### Non-code folders
Claude Code works in any directory, including notes vaults and Markdown collections. `.claude/` and `CLAUDE.md` don't conflict with other tools' config folders. Files are read fresh on every tool call, so edits made in other apps are picked up.

### Images
- Add an image by drag and drop, by pasting (Ctrl+V; Alt+V on Windows/WSL), or by giving its file path.
- Uses: describe a UI, explain an error screenshot, review a diagram or schema, generate CSS/HTML from a mockup.
- Several images can go in one conversation. Cmd/Ctrl+Click an `[Image #N]` reference to open it.

### `@` references
- `@path/to/file` puts the file's content into the conversation, up to the Read tool's limit (25k tokens by default). Text files over 256KB are skipped.
- `@dir` gives a file listing, not the contents. `@server:resource` pulls MCP resources.
- `@` references also add the `CLAUDE.md` files from that path's folder and its parent folders.
- `CLAUDE_CODE_DISABLE_FILE_MENTIONS=1` (v2.1.299+, user or managed settings only) passes paths only, so Claude reads them with its tools.
- ⚠️ **PreToolUse hooks don't run for `@` includes**, because no tool call happens. To control access, use a Read deny rule or the env var above.

### Scheduling

| Option | Runs on | Best for |
|---|---|---|
| Cloud scheduled tasks (routines) | Anthropic cloud | Runs while your machine is off; can trigger on API calls or GitHub events |
| Desktop scheduled tasks | Your machine, through the desktop app | Needs local files, tools, or uncommitted changes |
| GitHub Actions | CI | Repo events and cron schedules kept next to your workflow config |
| `/loop` | The current CLI session | Quick polling while a session is open |

Scheduled prompts run on their own and can't ask questions, so spell out what success looks like and where results should go.

### Asking Claude about itself
Claude answers questions about Claude Code from the current docs, not only from the version you have installed. `/powerup` gives interactive lessons.

## Session techniques

| Technique | Command | Key point |
|---|---|---|
| **Resume** | `claude --continue` / `claude --resume` / `/resume` | Conversations are saved locally. `--continue` picks the latest session in this directory. |
| **Parallel worktrees** | `claude --worktree <name>` | Each session gets its own checkout and branch. The repo needs at least one commit. |
| **Plan mode** | `claude --permission-mode plan` or Shift+Tab | Claude reads and proposes but makes no edits until you approve (status bar shows ⏸ plan mode on). |
| **Subagents** | "use a subagent to investigate …" | Exploration happens in a separate context; only the summary comes back. |
| **Scripts / CI** | `… \| claude -p "…"` | Non-interactive mode; stdin and stdout work like any Unix tool. |

## Next steps (linked pages)
Best practices · Manage sessions · Worktrees · Extend Claude Code (skills, hooks, MCP, subagents, plugins)
