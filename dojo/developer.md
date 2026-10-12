<!-- Source: https://dojo.agilityio.dev/developer.html — saved 2026-10-12. Internal training material. -->

Track 1 · Web / Game / Mobile

# Developer Track: Claude Code Desktop

Developer track · Weeks 2–3 · Days 4–11

Goal: make the **Claude Desktop app's Code tab** (Claude Code Desktop) the primary development environment for every developer, backed by the terminal CLI and the official docs at [code.claude.com/docs](https://code.claude.com/docs).

The desktop app has three tabs — **Chat**, **Cowork**, **Code** — and this track lives in **Code**. Everything below is a real, currently documented feature. Trained in [Days 4–11 of the schedule](schedule/day-04.md).

## Core environment (what to master first)

### 1. Sessions

Each conversation is a session with its own project folder and history; the sidebar runs many in parallel, each with git isolation (own worktree) so changes don't collide. Resume with `/resume`, `--continue`, `--resume`.

### 2. Panes

Drag-and-drop layout: chat, visual **diff review** (comment on hunks before applying), **browser pane** (preview your running app while Claude verifies its own changes; browse external sites), integrated **terminal** and **file editor**, and the **iOS Simulator pane** (macOS; Claude builds, runs, and taps your iOS app).

### 3. Environments

Sessions run **Local**, in the **Cloud** (keeps running after you close the app; monitor from claude.ai/code or mobile), over **SSH** (your remote machine), or in **WSL** on Windows.

### 4. Permission modes

`default`, `acceptEdits`, plan mode, `bypassPermissions`, and **auto mode** (the current default) — control how much Claude asks before acting. Use plan mode ("analyze before you edit") for anything you want to approve up front.

### 5. Side chats

Ask a side question using the session's context without derailing the main conversation; Claude can also check on and message your other sessions (cross-session messaging).

## Daily workflow: ticket → fix → PR

The unit of work stays the shared-fundamentals loop; Claude Code does the heavy lifting:

```
1. Analyze:  "Here is ticket #123 (pasted). Explore the codebase and tell me
             where this bug most likely lives and what you'd check first."
2. Plan:     plan mode → review the plan → approve.
3. Fix:      implement on a branch; watch the diff pane; comment to steer.
4. Verify:   Claude runs the tests and the app; browser pane / simulator for UI.
5. Ship:     PR with description; PR monitoring pane watches CI.
6. Review:   /code-review first pass, human review second, ultrareview when it's risky.
```

Habits that make this work (from the [best practices](https://code.claude.com/docs/en/best-practices)):

- Give context, not orders: paste the ticket, the error, the constraint.
- Steer with the diff pane — a comment on a hunk beats a paragraph of prose.
- Verify by running. Never claim "done" you haven't seen run.
- Keep sessions one-topic; start a new session per ticket.

## Memory and context

- **CLAUDE.md / AGENTS.md**: persistent project instructions (build commands, style, conventions) that every session reads. Keep it short and true; the whole team shares it.
- **Auto memory**: Claude accumulates project learnings across sessions on its own.
- **Context window**: long sessions compact automatically; `/compact` when you choose to; know what survives compaction. Side chats exist precisely to avoid polluting context.

## Extending Claude Code

- **Skills** (`SKILL.md`): reusable, shareable instructions — e.g. "how we release", "how we write migration scripts". Bundled skills include `/loop`; teams write their own and ship them in plugins.
- **Custom slash commands**: turn repeated prompts into one command.
- **Plugins** (from marketplaces, including Anthropic's): bundle skills, hooks, commands, MCP servers. Install with `/plugin`.
- **MCP servers / Connectors**: connect GitHub, Slack, Linear, and your own tools; the desktop app's Connectors flow sets up supported services with a GUI.
- **Hooks**: shell commands that fire automatically — format on edit, notify on finish, block forbidden commands. This is how team policy gets enforced without policing.

## Parallel and remote work

- **Worktrees + parallel sessions**: several tickets at once, each isolated in its own worktree; watch them all in **agent view**.
- **Subagents / agent teams / dynamic workflows**: decompose big tasks across parallel Claude agents; dynamic workflows run scripted fleets of subagents for audits and migrations.
- **Projects**: hand Claude a stream of related tasks in one conversation; it runs them as parallel cloud sessions sharing repos and memory.
- **Dispatch** (Cowork tab; Pro/Max plans): message Dispatch a task from your phone; it spawns a Code session and pushes a notification when it finishes or needs approval.
- **Remote Control**: start at your desk, continue from your phone — full local environment, files, and MCP servers stay on your machine.

## Automation

- **`/loop`** for in-session polling and PR babysitting; **Desktop scheduled tasks** for recurring local runs (morning briefing, dependency audit); **Routines** for cloud schedules and GitHub-event triggers.
- **`/goal`**: set a completion condition and Claude keeps working toward it.
- **Channels**: CI pushes failures straight into your session instead of you polling.
- **GitHub Actions**: `@claude` on a PR/issue; auto-fix failing PRs; scheduled jobs.

## Review and quality

- **`/code-review`**: local multi-agent review of your branch or a PR.
- **ultrareview** (`/code-review ultra`): deep cloud review with a fleet of agents that must reproduce every finding — use on risky or security-sensitive merges.
- **Security plugins**: `security-guidance` (Claude reviews its own changes for vulnerabilities in-session) and Claude Security (codebase scans → patches).

## Safety rails (non-negotiable)

- Permission rules in settings (`allow` / `deny` per tool), sandboxed bash for untrusted commands, plan mode for anything destructive.
- Never let Claude push straight to shared branches on client repos; PRs always.
- Client confidentiality: no client code, secrets, or customer data in cloud sessions or published artifacts unless the contract allows it. Ask the lead when unsure.

## Role notes

- **Web:** [Chrome integration](https://code.claude.com/docs/en/chrome) — Claude drives your signed-in Chrome to test web apps, read console logs, fill forms; the desktop browser pane previews the app while Claude verifies its own changes.
- **Mobile:** iOS Simulator pane (build, run, tap, screenshot from the session); computer use for Android emulators and GUI-only tooling.
- **Game:** computer use for engine editors that have no CLI (Unity/Unreal editors), Claude Code in the terminal for code, assets pipeline, and build scripts; artifacts to share build reports and level-design option boards with the team.

## Skill bar (end of track)

1. Run two parallel isolated sessions on two tickets, merge both cleanly.
2. Use plan mode for a risky change and steer it via diff comments.
3. Publish an artifact walking a teammate through your PR.
4. Start a session at your desk and continue it from your phone via Remote Control.
5. Run `/loop` that babysits a PR through CI, and a `/code-review` (or ultrareview) on a real branch.
6. Ship one team skill (e.g. release checklist) and one hook (e.g. format-on-edit).
