# Claude Code 101 — study notes

Personal study notes for the Claude Academy course
[Claude Code 101](https://academy.claude.com/courses/claude-code-101)
(12 lessons, 1 quiz, completion badge).

Study guide (interactive review): [Claude Code 101 Study Guide](https://claude.ai/artifact/DMm3h57Kha8uBPhb294Ngg#overview)

These are my own summaries, not a copy of the course. Open the lesson links for the videos,
transcripts, full exercise text and the interactive parts.

## Source and license

- Course © Anthropic. The course page text I used does not state a license.
- These notes are personal summaries for non-commercial training use.

## Cheat sheet in one page

**The agentic loop:** prompt → gather context → take action (tools) → verify → done, or loop
again. You can add context, interrupt or steer at any time.

**Workflow: Explore → Plan → Code → Commit**
1. Explore + Plan in Plan mode (Shift + Tab). Fix the plan before any code exists.
2. Code: approve the plan; give success criteria, tools and a reliable test suite.
3. Commit: test yourself, check `/diff`, get a clean-context `/code-review`, then ask Claude for
   a commit message.

**Permission modes** (Shift + Tab): Manual, Auto-accept, Plan, Auto.

**Context management**

| Command / habit | Use |
| --- | --- |
| `/context` | See what fills the window |
| `/compact` | Summarize, keep working on the same feature |
| `/clear` | Start fresh for a new feature |
| `/diff`, `/rewind` | Review changes; undo (Esc twice on an empty prompt) |
| Specific prompts | Vague prompts cost more context |
| Subagents | Heavy exploring in a separate context, only a summary comes back |
| `/mcp` | Turn off unused servers |
| `CLAUDE.md` | Memory that survives `/clear` and new sessions |

**Customization compared**

| Tool | What it is | When to use | Deterministic? |
| --- | --- | --- | --- |
| `CLAUDE.md` | Markdown memory file read at the start of every session | Stack, commands, code style, rules for every task | No (Claude follows it, usually) |
| Subagent | Markdown + YAML agent in `.claude/agents/`, own context window, returns a summary | Heavy exploring, independent review, keep main context clean | No |
| Skill | Folder with `SKILL.md`; only name/description loaded until relevant | Repeated task-specific know-how (review checklist, commit format) | No (loaded when description matches) |
| MCP | Open standard to connect external tools and data (`claude mcp add`, `.mcp.json`) | Data or actions outside the codebase (issues, docs, databases) | No (Claude decides when to call tools) |
| Hook | Command run on a lifecycle event, set in `settings.json` | Rules that must happen every time: format, log, block | **Yes**, always runs |

Rule of thumb from the course: if something must happen every time, use a hook, not a prompt.

## Lessons

Section names follow the course sidebar. The sidebar shows two small headings before "Daily
workflows"; I treat lessons 1–4 as one "getting started" group.

| # | Lesson | Notes |
| --- | --- | --- |
| 1 | [What is Claude Code?](https://academy.claude.com/courses/claude-code-101/what-is-claude-code) | [01-getting-started.md](01-getting-started.md) |
| 2 | [How Claude Code works](https://academy.claude.com/courses/claude-code-101/how-claude-code-works) | [01-getting-started.md](01-getting-started.md) |
| 3 | [Installing Claude Code](https://academy.claude.com/courses/claude-code-101/installing-claude-code) | [01-getting-started.md](01-getting-started.md) |
| 4 | [Your first prompt](https://academy.claude.com/courses/claude-code-101/your-first-prompt) | [01-getting-started.md](01-getting-started.md) |
| 5 | [The explore → plan → code → commit workflow](https://academy.claude.com/courses/claude-code-101/the-explore-plan-code-commit-workflow) | [02-daily-workflows.md](02-daily-workflows.md) |
| 6 | [Context management](https://academy.claude.com/courses/claude-code-101/context-management) | [02-daily-workflows.md](02-daily-workflows.md) |
| 7 | [Code review](https://academy.claude.com/courses/claude-code-101/code-review) | [02-daily-workflows.md](02-daily-workflows.md) |
| 8 | [The CLAUDE.md file](https://academy.claude.com/courses/claude-code-101/the-claude-md-file) | [03-customizing.md](03-customizing.md) |
| 9 | [Subagents](https://academy.claude.com/courses/claude-code-101/subagents) | [03-customizing.md](03-customizing.md) |
| 10 | [Skills](https://academy.claude.com/courses/claude-code-101/skills) | [03-customizing.md](03-customizing.md) |
| 11 | [MCP](https://academy.claude.com/courses/claude-code-101/mcp) | [03-customizing.md](03-customizing.md) |
| 12 | [Hooks](https://academy.claude.com/courses/claude-code-101/hooks) | [03-customizing.md](03-customizing.md) |

Lesson 7 has interactive exercises; my notes only summarize them. The course quiz and
completion badge are on the course page; they are not covered here.

## Diligence statement

I wrote these notes with Claude (Opus 5.5 orchestrating, Sonnet drafting). Claude read the
course pages via Claude in Chrome and drafted summaries in its own words. I'm responsible for
checking them against the course.
