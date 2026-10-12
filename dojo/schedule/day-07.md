<!-- Source: https://dojo.agilityio.dev/schedule/day-07.html — saved 2026-10-12. Internal training material. -->

Week 2 · Track split

# Day 07

Developer track · BA/QA track

## Developer track — Extend, automate, review

### Skills, commands, plugins

- **Course:** [Introduction to agent skills](../courses.md).
- Write one team skill (e.g. `release-checklist`, `how-we-write-migrations`) and one personal custom slash command; ship them via a PR to the repo's `.claude/`.
- Browse a plugin marketplace, install one useful plugin (e.g. code-intelligence/LSP) and evaluate it honestly.

## BA/QA track — Automated testing

### QA enters the Code tab

- **Course:** [Claude Code 101](../courses.md) (QA pass — concepts, not mastery).
- With a dev buddy: run the training repo's test suite in a Code-tab session; read a failure; ask Claude to explain and fix a deliberately broken test; watch the loop.

**Exercise**

Run the suite, break a selector, let Claude repair it, re-run green.

## Skills today

### Developer track

**release-checklist** — Release process encoded once, followed every time.
*How to set up:* Nothing to install beforehand — created by the team during Day 7+, then available in every session automatically.

**how-we-write-migrations** — The scariest change class made boring.
*How to set up:* Nothing to install beforehand — created by the team during Day 7+, then available in every session automatically.

**Plugins (/plugin)** — One install bundles skills + hooks + commands.
*How to set up:*
1. In a Claude Code session, type `/plugin`.
2. Open the **Discover** tab — Anthropic's official marketplace is already added.
3. Pick a plugin and install; its skills, hooks, and commands arrive in one step.

### BA/QA track

**QA in the Code tab (run suite, read failure, repair test)** — QA that steers the automated suite multiplies the team.
*How to set up:*
1. Install the Claude Desktop app from claude.ai/download.
2. Launch it, sign in, and click the **Code** tab.
3. Open your repo folder (accept the trust prompt) and ask Claude to run the suite and explain the failure.

**ticket-pack-writer (BA)** — Zero-question tickets as template, not talent.
*How to set up:* See [Day 5](day-05.md) for the setup steps.

---

Related: [Course catalog](../courses.md) · [Developer track](../developer.md) · [BA/QA track](../ba-qa.md) · [Shared fundamentals](../fundamentals.md)
← [Day 06](day-06.md) · Next → [Day 08](day-08.md)
