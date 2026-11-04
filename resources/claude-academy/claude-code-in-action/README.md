# Claude Code in action — study notes

Personal study notes for the Claude Academy course
[Claude Code in action](https://academy.claude.com/courses/claude-code-in-action)
(9 lessons, 1 quiz, completion badge).

Study guide (interactive review): [Claude Code in action Study Guide](https://claude.ai/artifact/8vZhQgrk1f9RGygkPzRsG9#overview)

These are my own summaries, not a copy of the course. Open the lesson links for the videos,
transcripts and full text.

## Source and license

- Course © Anthropic. The course page text I used does not state a license.
- These notes are personal summaries for non-commercial training use.

## The course in one page

The course takes you from single prompts to long runs you can walk away from. Scope and steer a
session, write instructions Claude follows, enforce the rules it must not skip, hand repeat work
to scheduled or headless runs, and verify the result in proportion to how little you watched.

| Area | Key tools | One-line rule |
| --- | --- | --- |
| Steer | Plan mode, `/compact <focus>`, rewind (Esc Esc), `/goal`, `/loop`, worktrees | Scope first, then steer |
| Instructions | CLAUDE.md (4 locations, `@imports`), skills | Lean file, specific rules, name the replacement |
| Permissions | Manual, accept edits, plan, auto, don't ask, bypass | Auto + Stop hook for hands-off; bypass only in a VM/container |
| Enforcement | Hooks: PreToolUse, PostToolUse, Stop, SessionStart (`compact`) | Exit 2 blocks; exit 1 does not |
| Automation | Cloud scheduled tasks, `/schedule`, `claude -p`, `--bare`, Agent SDK | Start with scheduled tasks; drop down only for more control |
| Pull requests | Managed Code Review, `claude-code-action@v1` | Review → Code Review; doing work in CI → the action |
| Verify | `/code-review`, `git diff`, test hooks, cold second review | The less you watched, the more you verify |
| Share | Plugins, marketplaces, `.claude-plugin/plugin.json` | Read before you install; package once it works |

**Simple rules to remember**
- A rule Claude must never skip belongs in a hook, not in CLAUDE.md or a skill.
- Tell `/compact` what to keep; use rewind instead of arguing Claude back on track.
- The auto-mode classifier checks intent, not correctness. Pair it with a test-running Stop hook.
- Read the diff, not the summary.
- A plugin runs with your privileges, and its hooks stack with yours.

## Lessons

| # | Lesson | Notes |
| --- | --- | --- |
| 1 | [Steering long sessions](https://academy.claude.com/courses/claude-code-in-action/steering-long-sessions) | [01-steer-the-work.md](01-steer-the-work.md) |
| 2 | [A CLAUDE.md that follows](https://academy.claude.com/courses/claude-code-in-action/a-claude-md-that-follows) | [02-configure-claude.md](02-configure-claude.md) |
| 3 | [Verification skills](https://academy.claude.com/courses/claude-code-in-action/verification-skills) | [02-configure-claude.md](02-configure-claude.md) |
| 4 | [Permission modes](https://academy.claude.com/courses/claude-code-in-action/permission-modes) | [02-configure-claude.md](02-configure-claude.md) |
| 5 | [Hooks](https://academy.claude.com/courses/claude-code-in-action/hooks) | [02-configure-claude.md](02-configure-claude.md) |
| 6 | [Scheduled tasks and headless](https://academy.claude.com/courses/claude-code-in-action/routines-and-headless) | [03-automate-repeat-work.md](03-automate-repeat-work.md) |
| 7 | [GitHub Actions and Code Review](https://academy.claude.com/courses/claude-code-in-action/github-actions-and-code-review) | [03-automate-repeat-work.md](03-automate-repeat-work.md) |
| 8 | [Trust it: Verifying unsupervised runs](https://academy.claude.com/courses/claude-code-in-action/trust-it-verifying-unsupervised-runs) | [04-verify-and-share.md](04-verify-and-share.md) |
| 9 | [Plugins](https://academy.claude.com/courses/claude-code-in-action/plugins) | [04-verify-and-share.md](04-verify-and-share.md) |

Each lesson has an embedded video; my notes come from the lesson text only, not the videos.
The [course quiz](https://academy.claude.com/courses/claude-code-in-action/course-quiz) did not
load as text, and the completion badge is not covered here.

## Diligence statement

I wrote these notes with Claude. Claude read the course pages via Claude in Chrome and drafted
summaries in its own words. I'm responsible for checking them against the course.
