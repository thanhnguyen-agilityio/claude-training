<!-- Source: https://dojo.agilityio.dev/schedule/day-05.html — saved 2026-10-12. Internal training material. -->

Week 2 · Track split

# Day 05

Developer track · BA/QA track

## Developer track — Claude Code Desktop core

### Memory, context, sessions

- Write the repo's `CLAUDE.md` as a team: build/run commands, conventions, "never do" list. Keep it under one screen.
- Auto memory + compaction: run a long session, compact, observe what survives.
- Checkpointing / `/rewind`: make a bad edit, rewind it.

**Exercise**

Prove context matters — same task in a fresh session vs. one that has read the codebase; compare quality and token sense.

## BA/QA track — Claude Desktop for planning

### Ticket planning

- **Workshop:** turn 3 rough requests into ticket packs — user story, Given/When/Then acceptance criteria, scope/non-scope, open questions, spec artifact.
- Add the training repo's GitHub connector; ask Claude which tickets touch area X.

**Exercise**

A dev (from the dev track) implements one of your ticket packs with no questions asked; if they had questions, the ticket wasn't done. Fix it.

## Skills today

### Developer track

**CLAUDE.md + auto memory** — Repo rules and commands persist across every session.
*How to set up:* Already built in — create a `CLAUDE.md` file in the repo root and write your team rules in plain text; Claude loads it at the start of every session. Auto memory is on by default: open `/memory` in a session to see or edit what Claude has remembered.

**/rewind checkpointing** — Bad edit? Rewind it — removes the fear of letting Claude edit freely.
*How to set up:* Already built in — press **Esc Esc** (with an empty prompt) to open the rewind menu and restore code and conversation to an earlier point.

**One-topic-per-session + resume** — Clean context, cheap sessions, sharp assistant.
*How to set up:* See [Day 4](day-04.md) for the setup steps.

### BA/QA track

**Artifacts for specs/briefs** — Requirements become living shareable pages.
*How to set up:* See [Day 4](day-04.md) for the setup steps.

**Ticket-pack writing (story + Given/When/Then + open questions)** — Core BA skill; the zero-questions test makes quality measurable.
*How to set up:* Nothing to install — it's how you write the ticket: user story, Given/When/Then acceptance criteria, open questions, judged by the zero-questions test.

**Tracker connector (GitHub/Jira-class via MCP)** — "What changed this week?" answered from real state.
*How to set up:*
1. At claude.ai, open **Customize → Connectors** (or click the **+** next to Connectors).
2. Pick **GitHub** from the list and sign in to authorize.
3. Private repos: your GitHub org admin may need to approve access once.

**ticket-pack-writer (BA)** — Zero-question tickets as template, not talent.
*How to set up:* Nothing to install beforehand — created by the team during Day 7+, then available in every session automatically.

---

Related: [Course catalog](../courses.md) · [Developer track](../developer.md) · [BA/QA track](../ba-qa.md) · [Shared fundamentals](../fundamentals.md)
← [Day 04](day-04.md) · Next → [Day 06](day-06.md)
