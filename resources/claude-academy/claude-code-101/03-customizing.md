# Lessons 8–12: Customizing Claude Code

Five ways to shape how Claude behaves: memory (`CLAUDE.md`), subagents, skills, MCP and hooks.

## Lesson 8 — The CLAUDE.md file (10 min video)

- Without it, Claude starts fresh each session: it re-explores the code and makes assumptions.
- `CLAUDE.md` is a Markdown file in the project root. Claude reads it automatically at the start
  of every session; its content is added to your prompt. Think "onboarding script for the codebase".
- Typical content: project description and stack, commands (dev, test, lint), code style rules.
  Example from the course (shortened):

```markdown
# Project
This is a Next.js 15 app using the App Router, Tailwind, and Drizzle ORM.

# Commands
- Dev server: `pnpm dev`
- Run tests: `pnpm test`
```

Levels:

| File | Where | For |
| --- | --- | --- |
| Project-level | Project root, commit to git | The whole team |
| User-level | Your configuration folder | You, all projects (personal preferences) |

Tips:
- **Save corrections**: if you keep correcting Claude, ask it to save the rule to memory.
- **Reference docs** with `@` and a path, e.g. `@README.md`.
- **Start without one** to see where you correct the model most, so the file stays short. Then
  run `/init` to have Claude generate one.

**Recap:** good sessions come from good context; start with stack, preferences, commands, then grow.

## Lesson 9 — Subagents (6 min video)

- A subagent has its **own isolated context window** and can run in parallel with the main agent.
- Flow: Claude spawns it for a task (e.g. "explore this codebase"), it does the exploring, then
  returns only a summary. Your main context stays clean.
- Create your own: subagents are Markdown files with YAML frontmatter. Easiest way is to ask
  Claude to make one, e.g. (paraphrased) "Create a code-reviewer subagent in `.claude/agents/`
  that reviews code for bugs and readability. Make it read-only."
- Location: `.claude/agents/` = this project; `~/.claude/agents/` = all projects. If the folder
  did not exist when the session started, restart Claude Code.
- Claude writes a name, description and prompt; the description tells Claude when to use it.
- Extras: **persistent memory** across conversations; **preload skills** with a `skills` key
  (the whole skill is loaded into context here, unlike in the main conversation).
- The course has a deeper course: "Introduction to subagents".

**Recap:** use subagents for heavy lifting and get back just the answer.

## Lesson 10 — Skills (3 min video)

- A **skill** teaches Claude how to do something once; Claude applies it automatically when it
  fits. Stops you repeating team standards, review format, commit style.
- A skill is a folder of instructions, scripts and resources, with a `SKILL.md` file. The
  **description** is how Claude decides to use it: it compares your request to all skill
  descriptions and activates the matches.
- Where to store:

| Type | Location | For |
| --- | --- | --- |
| Personal | `.claude/skills` in your home directory | Your habits, all projects (commit style, doc format) |
| Project | `.claude/skills` in the repo root | Team standards; anyone who clones gets them |

- **Skills vs CLAUDE.md**: `CLAUDE.md` loads into every conversation (e.g. "always use TypeScript
  strict mode"). A skill loads **on demand**; only name and description sit in context until it
  is needed (e.g. a PR review checklist is not loaded while you debug).
- **Skills vs slash commands**: you must type a slash command; a skill applies itself.
- Good for specialized, task-specific knowledge: review standards, commit formats, brand rules.
  If you explain the same thing repeatedly, write a skill.
- Deeper course: "Introduction to agent skills".

## Lesson 11 — MCP (6 min video)

- **Model Context Protocol** = open standard to connect Claude Code to external tools and data
  (databases, productivity apps, public repos). Claude decides when to use the tools.
- Examples: a Linear MCP server for your issues; a docs server like Context7 for up-to-date docs.
- Add with `claude mcp add`. Two types:
  - **HTTP**: remote services hosted by the provider.
  - **Stdio**: local processes on your machine.
- `/mcp` in a session: see connected servers, status, and disable ones you do not need.

Scopes:

| Scope | Meaning |
| --- | --- |
| Local | Current project, only you |
| User | All your projects |
| Project | `.mcp.json` checked into git; the whole team gets the same servers |

Context cost:
- Connected servers add tool names and instructions to context even when unused. Disable unused ones.
- If a CLI exists (`gh`, `aws`), it is more context-efficient than an MCP server.
- Pair an MCP server with a skill that teaches Claude to use its tools well.
- Tool search is on by default: full tool definitions stay out of context until needed.

**Recap:** `claude mcp add`, scope with `.mcp.json`, watch context usage.

## Lesson 12 — Hooks (6 min video)

- Hooks run commands at specific points in Claude Code's lifecycle. They are **deterministic**:
  they always run. A rule in `CLAUDE.md` (like "run Prettier after edits") is usually followed,
  not always.
- Use cases: auto-format after edits, log commands for compliance, block dangerous operations,
  notify you when Claude finishes.

Setup: edit `settings.json`: choose an event, optionally a matcher (which tools), and a command.

| Event | Runs |
| --- | --- |
| `PreToolUse` | Before a tool call |
| `PostToolUse` | After a tool call completes |
| `UserPromptSubmit` | When you submit a prompt, before Claude processes it |
| `Stop` | When Claude finishes responding |
| `Notification` | When Claude sends a notification |

Many more events exist; see the hooks reference. `/hooks` shows a **read-only** list of your
hooks, to confirm a new one is loaded.

- **Auto-format example**: a `PostToolUse` hook with matcher `"Edit|Write"`; the command checks
  the file extension and runs the right formatter (Prettier, gofmt...).
- **Blocking with `PreToolUse`**: the hook gets the tool name and input as JSON on stdin.

| Exit code | Result |
| --- | --- |
| 0 | Proceed |
| 2 | Block; the stderr message goes back to Claude so it can adjust |
| Other | Non-blocking error shown to you; nothing stops |

  Use it for hard rules: block writes to a production config folder, block `rm -rf`, block
  commits to main.
- **Team sharing**: hooks in `.claude/settings.json` are project-level and can be committed. Use
  the `CLAUDE_PROJECT_DIR` environment variable to point to scripts in the project, so they work
  from any working directory.

**Recap:** if something must happen every time, do not put it in a prompt; put it in a hook.
