<!-- Source: https://dojo.agilityio.dev/schedule/day-06.html — saved 2026-10-12. Internal training material. -->

Week 2 · Track split

# Day 06

Developer track · BA/QA track · Checkpoint

## Developer track — Claude Code Desktop core

### Flagship features + parallel work — and Developer Checkpoint 2

- **[Artifacts](https://code.claude.com/docs/en/artifacts):** from a session, publish a PR walkthrough artifact; share with a peer.
- **`/loop`:** `/loop 15m` on your open PR (built-in maintenance prompt), then a custom `/loop 5m check the deploy`; write a `loop.md` for the repo.
- **Remote Control:** start a session at your desk (`/rc`), connect from your phone via claude.ai/code, send a steer from the phone.
- **"Ultracode" family:** `ultrathink` keyword on a gnarly bug; `/effort` levels on the same bug, compare; note plan-tier availability.

**Exercise**

One artifact + one loop run + one phone steer, screenshotted to the channel.

- Parallel isolated sessions on two tickets (git worktrees); watch both in agent view.
- Subagents intro (course: [Introduction to subagents](../courses.md)); cloud session for a long task; close the laptop and check on it from claude.ai/code.

### Checkpoint 2 — Developer track

- Two parallel sessions both merged.
- One plan-mode change steered via diff comments.
- One artifact.
- One Remote Control steer.
- One `/loop` run.

## BA/QA track — Claude Desktop for planning

### BA deep work / QA test design + Dispatch — and BA/QA Checkpoint 2

- **BA:** competitor/regulation research in Cowork; spreadsheet of findings; decision doc.
- **QA:** test matrices from the Day-5 ticket packs — happy paths, edge/negative cases, data variations; test plan artifact per feature.

**Exercise**

(QA) Draft 2 bug reports in the reproduce-ready template from seeded bugs; devs confirm they can reproduce from the report alone.

- Dispatch from Cowork (if plan allows): kick a task from the mobile app, get the push notification. Otherwise: Remote Control tour with a dev buddy.

### Checkpoint 2 · BA

- One 90-minute ticket pack from a raw request (story + criteria + questions + artifact) judged by a dev for implementability.

### Checkpoint 2 · QA

- One reviewed test matrix + 2 reproduce-ready bug reports.

## Skills today

### Developer track

**Artifacts** — Live shareable PR walkthroughs / investigation timelines.
*How to set up:* Already built in — in a Code session, ask Claude to publish the walkthrough or timeline as an artifact; it gets its own page and share link. Self-contained output can also become one on its own.

**/loop** — Scheduled re-runs: watch a PR, babysit CI, morning maintenance.
*How to set up:* Already built in — type `/loop 5m check the deploy` (interval + task) in a Code session. It re-runs while the session is open; press **Esc** to stop it.

**Remote Control (/rc)** — Steer a session from your phone.
*How to set up:* Already built in — type `/rc` in a Code session and accept the one-time confirmation, then steer it from the Claude phone app or at claude.ai/code. Requires a Pro, Max, Team, or Enterprise login (API keys not supported).

**ultrathink + /effort levels** — Deep reasoning spent only where it pays (the "ultracode" ask in real form).
*How to set up:* Already built in — put `ultrathink` in your prompt for one-off deep reasoning, or type `/effort` to pick an effort level (confirm the cache warning if one appears).

**Git worktrees + parallel sessions** — Two tickets in flight, two isolated agents, zero crosstalk.
*How to set up:* Already built in — run `claude --worktree ticket-123` in the repo; run it again with a different name in a second terminal for a second isolated session. The repo needs at least one commit.

**Subagents** — Delegate bounded investigation while the main session codes.
*How to set up:* Already built in — Claude delegates bounded research on its own to built-in agents (Explore, Plan); you'll see them appear under the prompt. No install; custom ones later live in `.claude/agents/`.

### BA/QA track

**Test-matrix design** — Systematic coverage before automation.
*How to set up:* Nothing to install — a testing practice: pick the dimensions (inputs, state, environment), enumerate the combinations, drop the impossible ones. A doc or spreadsheet is all you need.

**Reproduce-ready bug reports** — Devs reproduce from the report alone.
*How to set up:* See [Day 2](day-02.md) for the setup steps.

**repro-template bug skill** — Reproduce-ready format, automated.
*How to set up:* Nothing to install beforehand — the team authors this skill during Day 7+; until then, follow the Day-2 report structure by hand.

**Dispatch (phone-kicked Code sessions, push alerts; Pro/Max only)** — Hand a task over while commuting.
*How to set up:*
1. Install the Claude app on your phone (iOS or Android) — in a Code session, `/mobile` shows a QR link.
2. Keep the Claude Desktop app open and signed in on your computer.
3. In the phone app, message **Dispatch** your task — it becomes a Code session on your machine and pushes an alert when it finishes or needs you. Pro or Max plan required.

---

Related: [Course catalog](../courses.md) · [Developer track](../developer.md) · [BA/QA track](../ba-qa.md) · [Shared fundamentals](../fundamentals.md)
← [Day 05](day-05.md) · Next → [Day 07](day-07.md)
