# Lessons 1–4: Getting started

What Claude Code is, how it works inside, how to install it, and how to send your first prompt.
(The course sidebar groups these four lessons under two small headings; I put them in one file.)

## Lesson 1 — What is Claude Code? (5 min video)

- Claude Code is an **agentic coding tool**. It understands your codebase, edits files, runs
  commands and connects to your developer tools.
- Where to use it: terminal, VS Code, JetBrains IDEs, Claude Desktop app, and the web.
- Difference from Claude.ai: it has direct access to your files and terminal. You do not copy
  and paste code back and forth; it does the work itself.
- It works as an **AI agent**: software that acts on its environment to reach a goal. At the
  core, a large language model runs in a loop, and it can use tools, services or other agents.

What it can do:

| Ability | Example |
| --- | --- |
| Read the codebase | Explain a feature, trace a bug |
| Edit many files | Refactor a function and update every caller |
| Run terminal commands | Build, run tests, install packages, then use the output to decide the next step |
| Search the web | Look up docs or the latest API reference |

Three ideas to keep in mind:
- **Context window** = Claude's working memory. It cannot hold everything, so Claude searches
  smartly instead of loading the whole codebase.
- **You control permissions.** Ask before each action, or use auto mode (a background safety
  check screens most actions).
- **It can make mistakes.** It may misread your intent, add a bug or over-engineer. Stay in the loop.

**Recap:** an agentic tool that reads, edits, runs commands and connects to external tools.

## Lesson 2 — How Claude Code works (5 min video)

**The agentic loop**
1. You enter a prompt.
2. Claude gathers the context it needs (the model returns text or a tool call).
3. It takes action (edit a file, run a command).
4. It verifies the result against your goal.
5. Done: it waits for the next prompt. Not done: it loops back and tries again.

You can add context, interrupt or steer at any point in the loop.

**Three building blocks (plus the loop)**

| Block | Meaning |
| --- | --- |
| Context | Conversation, file contents and command output it can remember. At the limit, Claude Code **compacts** (summarizes/removes) automatically. |
| Tools | Let Claude run code and actions (read files, web search...). Claude decides when to call a tool and uses the output. Most chat assistants only do text in, text out. |
| Permissions | Four modes, see below. Set in the settings file. |

**Permission modes**

| Mode | Behavior |
| --- | --- |
| Manual | Asks before every file edit or shell command |
| Auto-accept | File edits and common filesystem commands (`mkdir`, `mv`, `rm`) run without asking; other commands still ask |
| Plan mode | Reads files and runs shell commands to explore, does not edit source files, makes a plan first |
| Auto mode | No routine prompts; a background classifier blocks irreversible, destructive or out-of-environment actions. If blocked, Claude finds a safer way or asks you |

- The starting mode of a new session depends on your version and settings.
- Be careful when skipping permissions: a mistake is harder to catch before it happens.

**Recap:** agentic loop + managed context + tools + configurable permissions.

## Lesson 3 — Installing Claude Code (6 min video)

The page text shows the install commands only in the video/screenshots, so I do not copy them
here. Check the course page or the official docs for the exact commands.

| Where | Key points |
| --- | --- |
| Terminal (macOS, Linux, WSL) | One `curl` install command, or Homebrew (`brew install`, no auto-update by default) |
| Terminal (Windows) | PowerShell (`Invoke-RestMethod`), CMD (`curl`), or `winget` (no auto-update by default) |
| VS Code | Extensions panel, search "Claude Code", pick the one by Anthropic with the blue check. Restart if needed. Command palette (Ctrl/Cmd+Shift+P): "Claude Code Open in New Tab" |
| JetBrains | Install the plugin from the JetBrains Marketplace, restart the IDE, click the Claude logo for a terminal-style pane |
| Desktop | Sign in to Claude Desktop, use the "Code" tab. Pick a folder, change permissions, can run in a cloud environment |
| Web | claude.ai/code, or the "Code" label in the chat sidebar. GitHub repositories only |

First run in the terminal:
- Go to your project folder and run `claude`. If the command is missing, restart the terminal.
- Setup: pick a color theme, then sign in (Pro, Max, Team or Enterprise account) or use an API key.
  If your organization has Enterprise, choose that option.
- Claude can access the folder you started it in and all its subfolders.

Which one to use:
- Terminal: new features arrive here first.
- IDE: almost the same experience, closer to your editor.
- Desktop: good for letting Claude work in the background.
- Web: remote work on a GitHub repository.

## Lesson 4 — Your first prompt (6 min video)

- **Shift + Tab** cycles the permission modes (Manual, Auto-accept, Auto, and Plan mode).
  No right answer; choose what you feel comfortable with.
- **Plan mode**: Claude reads files and runs shell commands to study the code and your idea,
  asks clarifying questions, then gives a detailed plan. It does not edit source files. Good for
  multi-step features and for a safe code review.

**Walk-through: add a dark mode toggle**
1. Open your project root and run `claude`.
2. Press Shift + Tab until the status bar shows plan mode on.
3. Prompt (paraphrased): add dark mode across the app, a toggle switch in the header, and pick
   good contrast colors based on the existing light theme.
4. Review the plan; if good, accept it and let Claude work. Depending on your mode it may check
   in with you. At the end you can see what it did and why.

**Recap:** be descriptive in your prompt; stay in the loop if you want; use Plan mode to dig
into details before any code is written.
