# Cheatsheet (revise in 5 min)

Add to it as the plan goes on. Sources: `day-01/notes.md`, `day-02/notes.md`, `colleague-tips.md`.

## Prompting (Claude 101)
- **Stage / Task / Rules.** Stage = role, goal, context. Task = the exact question. Rules = tone, format, hard cap.
- **Rules block is the biggest win.** Word/line cap, format, Known vs Suspected, "no fixes yet". Repeat the cap whenever a rule is added.
- **Name the reader and the question** ("PM, not technical, asked this").
- **Evidence rule:** cite the line, or label "general", and say if unsure.
- Missing field? Say what to do when it's missing.
- **4D:** Delegation (mine vs Claude's) · Description (clear output) · Discernment (check it) · Diligence (use responsibly).
- Bad first answer is normal: refine, or restart with Stage/Task/Rules.

## Where to work (Desktop)
| Shape | Use when | Tool |
|---|---|---|
| Turn by turn | Answer changes next question | Chat |
| Hand off | Many steps, files, tools, schedule | Cowork |
| Build software | Write, test, run, ship code | Code tab |

- **Project** stores knowledge + instructions. **Skill** performs a task. They work together.
- **Artifact:** deliverable that updates in Claude and shares by link. Only when someone else reads it.

## Trust but verify
- Claude states checkable details confidently and gets some wrong. Check one claim against the source line.
- A hypothesis counts only after you ran something that confirms or kills it.
- Read the PR body before ticking "PR description": a merged PR can still have a stub body. Self-contained = what / why / how tested / scope.
- A passing test doesn't prove the fix is right. A repro test must cut exactly at the bug boundary.
- Soft wording sticks ("roughly 2–3 days"): name the exact word to remove.

## Claude Code (Day 4+; fill from Claude Code 101)
- Loop: ticket → plan → implement → diff comment → tests → PR.
- Permission modes: manual · accept edits · plan. Plan Mode = best moment to fix direction.
- CLAUDE.md = request (commands, conventions, never-do). Hook = must happen every time.
- The folder you open decides which CLAUDE.md loads.
- TODO (my words): 3–5 takeaways from Claude Code 101.

## Course 8–13 (Connecting tools … What's next)
- TODO (my words): 3–5 takeaways.

## This repo
- Bug: `handle_keep_recent_messages` left an orphan ToolMessage; fixed by widening the window back to a non-Tool start. Related risk: `trim_messages` without `start_on`.
- Git: `PRE_COMMIT_ALLOW_NO_CONFIG=1` for commits in the practice repo; `uv run --with pytest` for tests.
