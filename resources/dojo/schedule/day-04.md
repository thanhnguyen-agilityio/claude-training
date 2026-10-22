<!-- Source: https://dojo.agilityio.dev/schedule/day-04.html — saved 2026-10-12. Internal training material. -->

Week 2 · Track split

# Day 04

Developer track · BA/QA track

## Developer track — Claude Code Desktop core

### Install, tour, first session — and the daily loop

- **Course:** [Claude Code 101](../courses.md); docs: [quickstart](https://code.claude.com/docs/en/quickstart) + [desktop get-started](https://code.claude.com/docs/en/desktop-quickstart).
- Install/verify the desktop app's Code tab on the training repo; session basics: sidebar, resume, one-topic-per-session habit.
- Permission modes tour: `default` / `acceptEdits` / plan mode / auto mode — feel the difference on a throwaway change.
- **Docs:** [common workflows](https://code.claude.com/docs/en/common-workflows) + [best practices](https://code.claude.com/docs/en/best-practices).

**Exercise**

"Explore this codebase and explain how feature X works" — then verify two of its claims by reading the code yourself.

**Exercise**

Take a bug ticket through the full loop in the Code tab: paste ticket → plan mode → approve plan → implement → watch diff pane, steer with a hunk comment → run tests → PR. Repeat with a second ticket, no help.

- **Course:** [Claude Code in action](../courses.md).

## BA/QA track — Claude Desktop for planning

### Chat, projects, artifacts + Cowork

- **Course:** [Claude 101](../courses.md) deep pass (projects, artifacts, connected tools).
- Set up one Project per training "client"; move all BA/QA work into it.

**Exercise**

Summarize a messy feature request into a structured brief in the Project; publish the brief as an artifact.

- **Course:** [Introduction to Claude Cowork](../courses.md).
- Workspaces, giving context, task loops; research + document + browser tasks.

**Exercise**

Run a Cowork research task (e.g. "compare these three auth approaches for our training app, return a decision doc"); edit its output into your own doc.

## Skills today

### Developer track

**Plan mode** — Approve the plan before any code is written — the biggest lever for trusting agentic work on real tickets.
*How to set up:* Already built in — press **Shift+Tab** in a Claude Code session until the mode indicator shows *plan*. On Windows terminals where Shift+Tab doesn't work, use **Alt+M**.

**One-topic-per-session + resume** — Clean context, cheap sessions, sharp assistant.
*How to set up:* Already built in — it's a habit, not an install: start a fresh session per topic, and reopen an earlier one with `/resume` inside a session, or run `claude --resume` in your terminal to pick from a list.

### BA/QA track

**Projects (one per client)** — All context stays in one place per client.
*How to set up:*
1. Sign in at claude.ai and click **Projects** in the left sidebar (or go straight to claude.ai/projects).
2. Click **+ New Project** in the upper right and name it after the client.
3. Recommended: click **Set project instructions** and store the client's standing context once — every chat in the project uses it.

**Artifacts for specs/briefs** — Requirements become living shareable pages.
*How to set up:*
1. In claude.ai, open **Settings → Capabilities** and make sure *Cloud code execution* and *File creation* are enabled. On Team/Enterprise plans an admin does this under **Organization settings → Capabilities**.
2. Nothing else to install — ask Claude to write the spec as a document; self-contained output becomes a shareable artifact automatically.

**Cowork workspaces + task loops** — Research/document/browser tasks run unattended.
*How to set up:*
1. Sign in at claude.ai or open the Claude Desktop app.
2. Click the message box at the bottom and switch the picker from **Chat** to **Cowork**.
3. Describe the task (research, document, browser) and send — it runs on its own and reports back. On newer accounts the Chat/Cowork picker is gone: just describe the task; Claude decides whether it's a quick answer or a running task.

---

Related: [Course catalog](../courses.md) · [Developer track](../developer.md) · [BA/QA track](../ba-qa.md) · [Shared fundamentals](../fundamentals.md)
← [Day 03](day-03.md) · Next → [Day 05](day-05.md)
