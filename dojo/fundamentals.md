<!-- Source: https://dojo.agilityio.dev/fundamentals.html — saved 2026-10-12. Internal training material. -->

Track 0 · Everyone

# Shared Fundamentals

All staff · Week 1 · Days 1–3

Goal: after this track, every person in the company — dev, BA, QA, lead — can take a ticket from **read → reproduce → fix/develop → PR → review → merge** without friction, using git properly and using Claude as the everyday working tool rather than a toy.

This is the skill list the whole company is measured against. The Developer and BA/QA tracks build on it; nobody skips it. Trained in [Week 1 of the schedule](schedule.md).

## The fundamental skill list

### 1. Analyze a ticket

- Read a ticket and extract: what is broken/wanted, for whom, and how we'll know it's done.
- Spot the missing information **before** starting: environment, steps, expected vs actual, attachments, related tickets.
- Use Claude (chat) to summarize long tickets, cross-reference the codebase, and draft the questions to ask. Habit: paste the ticket + your questions, ask Claude to list assumptions and gaps.

**Skill bar:** Given any ticket from the backlog, you can state in three sentences what it asks for, what's ambiguous, and your first step.

### 2. Reproduce and understand the issue

- Run the project locally from a clean clone; get the failing case to happen on your machine.
- Tell a config problem from a code problem from a data problem.
- Write the failing case down as a **reproduction**: exact steps, expected, actual. If it's a bug and you can express it as a failing automated test first, do that.
- Use Claude to read unfamiliar code and error output ("explain this stack trace", "walk me through what this module does"). You still verify by running it yourself.

**Skill bar:** You can reproduce a reported bug and point at the layer where it lives.

### 3. Fix / develop

- Work on a branch, one ticket per branch, small commits with honest messages.
- Make the change plus its test; keep the diff as small as the ticket allows.
- With Claude (chat now, Claude Code later): describe the ticket, review the suggested change, run it, iterate. Never merge output you can't explain.

**Skill bar:** Your fix works, has a test, and the diff survives review without rework.

### 4. Submit a PR

- Open a PR with a description that stands alone: what, why, how tested, screenshots for UI.
- Link the ticket; let CI run; keep the PR green before requesting review.

**Skill bar:** A reviewer who knows nothing about the ticket can review from the PR alone.

### 5. Review and merge at ease

- Review for: correctness, tests, readability, security basics (input handling, secrets, permissions), and scope creep — in that order of importance.
- Give actionable comments ("this returns null when X; guard it like Y") not verdicts.
- Respond to review comments; update; re-request; squash/merge and clean up the branch.
- Resolve a merge conflict without fear.
- Use Claude as a first-pass reviewer on your own PR before a human sees it.

**Skill bar:** You review one PR and merge one PR (including a conflict) unaided.

### 6. Shared tooling habits

- **Git:** clone, branch, add/commit/push, pull --rebase, PR, review, merge, conflict resolution, reading `git log` / `git diff`. Everyone, not just devs.
- **Claude everyday:** keep a personal chat thread per topic; paste errors with context; ask for options with trade-offs, not just answers; never paste client secrets or customer data into any AI tool (consulting-company rule, apply it seriously).
- **Writing with Claude:** tickets, PR descriptions, test cases, release notes — draft with Claude, edit the result, own the output.
- **Verification mindset:** AI output is a proposal until you've run it. Trust runs, tests, and logs — not fluency.

## Supporting habits for leads

- Keep a "definition of done" for tickets that includes tests and PR description quality.
- Review the AI-assisted PRs the same as human PRs; the standard never drops because Claude wrote the first draft.
- Track the same checkpoints from the [day-by-day schedule](schedule.md): Day 3 (everyone ships + reviews a PR), Day 6/11 (track checkpoints), Day 15 (capstone).

## What "done" looks like for this track

**Done** — Every participant, regardless of role

1. Reproduces an assigned bug and writes the repro in the ticket.
2. Fixes (or specs, for BA/QA — see the [BA/QA track](ba-qa.md)) on a branch with a test.
3. Opens a PR with a self-contained description.
4. Reviews a peer's PR with at least three actionable comments.
5. Merges a PR and resolves one merge conflict.
