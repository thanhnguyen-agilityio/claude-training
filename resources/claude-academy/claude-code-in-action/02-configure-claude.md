# Lessons 2–5: Configure Claude

Write instructions Claude follows, package procedures as skills, choose permission modes, and
enforce hard rules with hooks.

## Lesson 2 — A CLAUDE.md that follows (7 min)

- A CLAUDE.md that keeps growing gets followed less. It is **guidance, not enforced config**:
  every line competes with every other line for attention. Leaner file = more of it followed.

**Is CLAUDE.md the right tool?**
- Soft conventions go in CLAUDE.md. **Hard rules** (e.g. never push to main) go in a
  **PreToolUse hook**, which runs before the action and can block it.

**Four locations, all loaded together at launch (they stack)**

| Location | For |
| --- | --- |
| Managed policy | Org rules set by the platform team; cannot be excluded |
| User | Your preferences across all projects on your machine |
| Project | Shared with the team, checked into the repo |
| Local | Git-ignored, your notes for this one repo (e.g. decisions for your refactor branch) |

**Imports**
- Split a long file with `@path/to/file.md` lines.
- Imported files are expanded inline at launch, so imports **organize but do not reduce context**.

**Phrasing rules so they stick**
- **Specific and checkable**: "put new API routes in `src/api/handlers`, one per file", not
  "follow best practices".
- **Name the replacement**: "use named exports, not default exports", not just "don't use
  default exports".
- **Emphasis is a budget**: IMPORTANT / YOU MUST only works if few rules use it. Spend it on the
  two or three rules that hurt most when broken.

**Keep revising**
- Treat each wrong action as a bug report against CLAUDE.md. You can ask Claude to add the rule.
- If you cannot justify a line, delete it.

**Recap:** hard rules to hooks, imports to organize, specific rules with replacements, small
emphasis budget, revise often.

## Lesson 3 — Verification skills (5 min)

- If you build one skill first, make it a **verification skill**. Checking Claude's work by hand
  depends on you remembering to ask; a skill removes that.
- How it works: after a change (e.g. a refactor), the work matches the skill's **description**,
  so the skill triggers by itself and runs the same steps every time:
  1. Run the test suite.
  2. Read the diff.
  3. Check that no test was weakened to make it pass.
  4. Report pass or fail with evidence.
- **"Done" = gates run and observed, results stated.** Green tests alone are not enough, since a
  test can be loosened until it always passes.
- Same shape fits any repeated procedure: release checklist, migration recipe, pre-PR check.
  Rule of thumb: typed the same multi-step instruction twice → make it a skill.

**What a skill folder can hold**
- `SKILL.md`: name, triggering description, procedure. Keep it lean.
- `reference.md` (linked from SKILL.md): detail Claude reads only when needed.
- Scripts (e.g. `check.sh` that runs all gates): Claude **executes** them instead of loading
  them into context.
- Only skill descriptions sit in context until a skill is needed, so packaging is cheap.

**Which surface owns which rule**

| Rule type | Put it in |
| --- | --- |
| Always-on conventions (naming, file locations) | CLAUDE.md |
| Task-specific procedures and reference | Skill |
| Must never be skipped | Hook (code that runs, not an instruction) |

**Recap:** build a verification skill, check it into `.claude/skills`, and the whole team gets
the same automatic checks.

## Lesson 4 — Permission modes (5 min)

- A **permission mode** sets once what Claude may run without asking, matched to the job.
- **Shift+Tab** cycles the everyday modes (manual, accept edits, plan, auto). The status bar shows
  the current mode.

**The six modes**

| Mode | Runs without asking | Use for |
| --- | --- | --- |
| Manual | Reads only | Default hands-on work |
| Accept edits | Reads, file edits, common file-system bash commands | Iterating on code you review afterwards |
| Plan | Reads; no edits. With auto available, its classifier can approve exploration commands | Research and proposals |
| Auto | Everything, but a separate **classifier model** reviews most actions first | Hands-off work |
| Don't ask | Reads in working dirs + pre-approved tools; anything that would prompt is **auto-denied** | CI, scheduled jobs, overnight batches |
| Bypass permissions | Everything, no checks (same as `--dangerously-skip-permissions`) | Only inside an isolated container or VM |

**Auto mode's classifier guards intent**
- Blocks moves that go beyond what you asked: production deploys and migrations, force push,
  piping downloaded code into a shell, sending sensitive data out, irreversibly deleting files
  that existed before the session.
- Allows everyday work: local edits, installing from the lock file, read-only requests, pushing
  to your own branch.
- It checks **intent, not correctness**. Broken auth code is not dangerous, so it passes.
- Pair auto with a **Stop hook that runs tests**: classifier guards intent before actions, the
  hook guards correctness after. The block/allow lists keep changing, so check the docs.

**Don't ask for unattended runs**
- No human to approve → nothing hangs; prompts become denials and the pipeline keeps moving.

**Recap:** auto + stop hook for hands-off work, don't ask for pipelines, bypass only in
isolated environments.

## Lesson 5 — Hooks (7 min)

- A CLAUDE.md rule is a request. A **hook** is deterministic code that runs at a fixed point in
  the loop, so the rule becomes one Claude **cannot skip**.

**Hook events worth knowing** (about 30 exist)

| Event | Fires | Typical use |
| --- | --- | --- |
| PreToolUse | Before a tool call | Enforcement: allow, deny, ask, or rewrite |
| PostToolUse | After a successful tool call | Auto-format, auto-lint |
| Stop / SubagentStop | When Claude (or a subagent) wants to end its turn | Refuse "done" until a condition holds |
| PreCompact / PostCompact | Around compaction | — |
| InstructionsLoaded | When CLAUDE.md or a rule file loads | Audit what reached context |
| SessionStart | Session start (matchers like `startup`, `compact`) | Prime the environment |

- To re-inject context after compaction, use **SessionStart with the `compact` matcher**, not
  PostCompact: only SessionStart's output gets back into the conversation.

**PreToolUse returns JSON** (print it, exit 0)
- `hookSpecificOutput.permissionDecision`: `allow`, `deny` or `ask` (plus `defer`, only for
  non-interactive `-p` runs). Add `permissionDecisionReason`.
- **`updatedInput`** rewrites the call instead of blocking. It **replaces the whole input
  object**, so echo back the fields you are not changing.

**Exit codes for simple hooks**

| Code | Meaning |
| --- | --- |
| 0 | Success. JSON on stdout is parsed. Plain text is ignored, except on SessionStart, UserPromptSubmit and UserPromptExpansion, where it is added to context |
| 2 | **Blocking error**. stderr goes back to Claude |
| Anything else (incl. **1**) | Non-blocking: stderr is logged and Claude carries on |

- Exit 1 does **not** block. Use 2.
- Exit 2 on Stop tells Claude it is not done. On PostToolUse it is too late to stop the call but
  still feeds text back. Notification and SessionStart ignore blocking.

**Patterns**
- **Redact instead of block**: a PreToolUse hook on Bash (matcher + optional `if` clause) spots
  an `sk_live_` secret and swaps in a placeholder via `updatedInput`. The command still runs
  and the secret never goes through.
- **Preserve state across a compact**: a SessionStart `compact` hook prints a short summary of
  the files in progress so Claude continues instead of starting cold.

**Recap:** guard tools with PreToolUse, gate the turn with Stop, preserve state with
SessionStart after compaction.
