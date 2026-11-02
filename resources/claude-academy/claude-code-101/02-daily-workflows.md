# Lessons 5–7: Daily workflows

The habits for everyday work: a four-step workflow, keeping the context healthy, and reviewing
what Claude changed.

## Lesson 5 — The explore → plan → code → commit workflow (8 min video)

The course says: if you take one thing from it, take this. Jumping straight to "write code"
means more correcting later.

| Step | What to do |
| --- | --- |
| Explore + Plan | Use Plan mode (Shift + Tab until "plan mode on"). Claude reads files, may search the web, then gives a plan. Review it and ask for changes in specific parts. This is the cheapest place to course-correct because no code exists yet. |
| Code | Approve the plan. Claude works through the items; your permission mode decides how often it asks. You may need to step in. |
| Commit | Test the result yourself, run a **subagent code reviewer** (fresh eyes, no bias from the session), then ask Claude to write a commit message in your style. Repeat. |

Example plan-mode prompt (paraphrased): add WebP conversion to the image upload pipeline; find
where it should happen, whether new dependencies are needed, and how to approach it.

Tips for the Code step:
- **Define success criteria**: say what "correct" means, and put it in the plan.
- **Add tools**: e.g. the Claude in Chrome extension lets Claude test a web UI in a browser tab.
- **Include a test suite**: Claude can validate against it, and can write tests too. Make sure
  the tests are a reliable source of truth (avoid false positives).
- If Claude keeps hitting the same problem, ask it to save the solution in `CLAUDE.md`.
- You can also run the **explore subagent** without plan mode for a general summary of the
  codebase when you do not plan to change anything.

**Recap:** Explore gives context, Plan gives a way to measure success, Code is the back and
forth, Commit is review and push.

## Lesson 6 — Context management (7 min video)

- Everything uses context: each prompt, file read, tool call and tool result. Space is limited,
  so use it wisely.
- When near the limit, **automatic compaction** summarizes key details and drops unneeded tool
  results. It can lose details.

| Command | What it does | Use it when |
| --- | --- | --- |
| `/compact` | Compacts everything so far, keeps a memory of the work | Same feature, near the limit, you need to continue |
| `/clear` | Removes everything, a fresh start | Starting a new feature (old chat should not bias it) |
| `/context` | Shows context size, biggest categories, a visual breakdown | You want to see what uses the space |

- For things Claude should remember across sessions, write them in `CLAUDE.md`.

Tips to save space:
- **Be specific.** A vague prompt looks short but costs more: Claude has to explore and reason a lot.
- **Manage MCP servers.** A connected server loads only tool names and instructions by default,
  full details load when needed, but each server still takes some space. Turn off unrelated ones.
- **Use subagents.** They have a separate context window and return only a summary (e.g.
  "where are the authentication endpoints?").

**Recap:** `/compact` for long sessions, `/clear` for fresh starts, check what uses context,
delegate to subagents when you only need the answer.

## Lesson 7 — Code review (10 min, interactive)

Why: the session that wrote the code is not the best judge of it. Look at the changes yourself,
then get a second review from a clean context.

**1. Review the real changes**
- A **diff** = before/after of a change, line by line, file by file.
- `/diff` opens an interactive viewer of uncommitted changes (it can also show what each Claude
  turn changed). Up/down arrows move between files, Enter opens one.
- Always look for:
  - Changes you did not ask for (a config value edited, a helper rewritten).
  - Tests that got weaker (skipped, deleted, loosened).
  - New packages and hard-coded values (a dependency for one function, a URL or key in code).
- If the whole change is wrong: `/rewind` (or press Esc twice on an empty prompt), choose the
  prompt, then **Restore code and conversation**. Limit: files changed by shell commands
  (like a package install) are not rolled back.

**2. Get a second opinion: `/code-review`**
- Reviews the change in a clean context, reports findings, edits nothing unless you ask.
- Runs in the background (seconds to a few minutes) and counts against your usage, so use it for
  changes that matter. You can also ask in plain words, e.g. "Review the changes you just made.
  Report problems; don't fix anything yet."
- If Claude answers inline instead of starting a review, run the command yourself.

**3. Decide what to do with each finding**

| Pile | Meaning |
| --- | --- |
| Fix now | Real and important |
| Ask why | You cannot verify it or it looks wrong; a cold reviewer can be mistaken. Quote the finding back and ask Claude to check again |
| Leave it | Real but small; batch for a later session |

- When you ask for a fix, ask for evidence too (e.g. "fix it, run the tests, show me the output").
- If a fix grows into a big change, review again.
- Use both human and Claude review when the change is too big to hold in your head, touches
  something sensitive or destructive, or before handing work to a teammate. A tiny change often
  needs only a quick look at the diff.

**Exercises (interactive, paraphrased)**
- *Compare summary with diff*: a signup-form task with a true summary and 8 changed files.
  Expand the diffs and flag the 3 that deserve a second look. Lesson: a true summary can still
  hide risky changes. (From the page text, the suspicious files appear to be the test file with
  weakened tests, the config file, and the package files, but the page does not state the
  answer, so check in the exercise.)
- *Sort four findings* into fix now / ask why / leave it. My suggested answers (the page does
  not show the official ones, so check in the exercise): skipped/weakened test (fix now), "no
  trim" finding that looks wrong because line 4 already calls `trim()` (ask why), hard-coded
  localhost API URL (fix now), hex color instead of a CSS variable (leave it).

**Recap:** read the diff before trusting the summary; get a clean-context review; sort findings
and ask for evidence. If the reviewer repeats the same issue, write a rule in `CLAUDE.md` (next lesson).
