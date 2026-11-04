# Lesson 1: Steer the work

How to scope a long Claude Code session before it starts and keep it on course while it runs.

## Lesson 1 — Steering long sessions (6 min)

- Short tasks are easy. Long ones (a multi-file refactor, a new feature) take hours, and the more
  you correct Claude along the way, the longer they take.
- Two habits fix most of it: **scope first**, then **steer while it runs**.

**Scope with plan mode**
- In **plan mode** Claude reads the code and proposes a plan without editing source files.
- Read the plan properly. Ask Claude to add what is missing. Changing a plan costs far less
  than cleaning up after a bad run.

**Steer while it works**

| Tool | What it does | Tip |
| --- | --- | --- |
| `/compact` | Replaces the conversation with a summary to free context | Add instructions after the command, e.g. `/compact Focus on the --version flag implementation`, so the summary keeps what matters |
| Rewind (Esc Esc on an empty prompt) | Goes back to a checkpoint; every prompt creates one | Use it instead of prompting your way out of a wrong path |

Rewind menu options:
- **Restore code and conversation**, **restore conversation** only, or **restore code** only.
- **Summarize from here**: compress everything after the checkpoint (e.g. a side discussion).
- **Summarize up to here**: compress a long setup phase and keep the implementation intact.

**Run more autonomously**
- **`/goal <condition>`**: Claude keeps working across turns until a fast evaluator agrees the
  condition is met. Example: all tests in `src/billing` pass and the type checker reports zero
  errors. `/goal clear` cancels it. The evaluator only reads the transcript, so the condition
  must be visible in output (e.g. test results).
- **`/loop`**: runs a prompt on a fixed or self-paced interval, e.g. to poll CI or a deploy.
  Esc stops a self-paced loop while it waits; a fixed loop runs until cancelled or 7 days pass.

**Parallel work with worktrees**
- Two sessions editing the same files cause conflicts. A **worktree** gives each session its
  own file tree; a clean worktree is removed when the session exits.
- **`.worktreeinclude`** at the repo root lists git-ignored files (e.g. env file, local config)
  to copy into each worktree.

**Recap:** scope first, direct compaction, rewind when Claude drifts, set a goal when you can
describe "done" better than the steps, and use worktrees for parallel work.
