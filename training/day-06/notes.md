# Day 6: Flagship + parallel (CP2)

Work in `../claude-training-practice` (the app), not this repo. CP2 = 2 parallel sessions both merged · 1 plan-mode change steered via diff comments · 1 artifact · 1 Remote Control steer · 1 `/loop` run.

## 0. Practice repo reset
- CLAUDE.md restored on main (commit):
- Test line fixed for missing `.env`:
- #48 merged (PR), CI green:
- Day 5 branches/worktrees cleaned:

## 1. Intro to subagents
Notes: [my notes](../courses/introduction-to-subagents.md) · [resources/claude-academy/](../../resources/claude-academy/) (via `/academy-course`)
- 3 take-aways:
  - Subagent = own context window + custom prompt, returns a summary → keeps main context clean.
  - Design = description (when to use) + output format (when done) + least tools.
  - Delegate only when the intermediate work doesn't matter (research, custom-instruction tasks, review); not for expert personas, pipelines, test runners.

## 2. Parallel worktree sessions
Ticket pool: existing issues in [milestone 1](https://github.com/thanhnguyen-agilityio/claude-training-practice/milestone/1) / [milestone 2](https://github.com/thanhnguyen-agilityio/claude-training-practice/milestone/2), so no new issues needed.

| | Session A (unaided, `/do-issue`) | Session B (Plan mode + diff steer) |
|---|---|---|
| Ticket | | |
| Worktree / branch | | |
| PR | | |
| Steering comments (count, what changed) | — | |
| Merged | | |

- Conflict between the two branches? How resolved:

## 3. `/loop`
- `/loop 15m` on PR: what it caught:
- `/loop 5m` health/deploy check: result:
- `loop.md` path:

## 4. Claude GitHub App vs CodeRabbit
- Install: `/install-github-app` (auth secret set by me) · workflow PR:
- Issue [#71](https://github.com/thanhnguyen-agilityio/claude-training-practice/issues/71): verified the problem and noted findings on the issue.
- Fix: switched to the OAuth approach → workflow works: [run 41855608085](https://github.com/thanhnguyen-agilityio/claude-training-practice/actions/runs/41855608085) ✅
- Verified working (3 ways):
  - `@claude` review on old PR: [#11 comment](https://github.com/thanhnguyen-agilityio/claude-training-practice/pull/11#issuecomment-6634621534)
  - `@claude` chat on an issue: [#71 comment](https://github.com/thanhnguyen-agilityio/claude-training-practice/issues/71#issuecomment-6634389999)
  - Auto code-review workflow triggered on a PR: [run 41856819885](https://github.com/thanhnguyen-agilityio/claude-training-practice/actions/runs/41856819885/job/126667588617)
- Inline comments working? (prompt change in `claude-code-review.yml`):

| | Claude GitHub App | CodeRabbit |
|---|---|---|
| Comment style (inline / summary) | | |
| Real issues found | | |
| Noise / false positives | | |
| Time to review | | |
| Cost | | |
| Can fix on request (`@claude`) | | |

Verdict (1 line):

## 5. Artifact + Remote Control
- PR walkthrough artifact link:
- `/rc` phone steer: what I asked, what it did:

## 6. ultrathink + `/effort` compare
Bug:

| | Low effort | High effort / ultrathink |
|---|---|---|
| Diagnosis correct? | | |
| Tokens / cost | | |
| Time | | |
| Fix quality (1–5) | | |

Verdict (1 line):

## 7. Cloud session (claude.ai/code)
- Task:
- Differences from local (3 lines):

## CP2 check
- [ ] 2 parallel sessions both merged
- [ ] 1 plan-mode change steered via diff comments
- [ ] 1 artifact
- [ ] 1 Remote Control steer
- [ ] 1 `/loop` run

## Take-away (copy to training/take-away.md)
-

---

# Today's plan (8h, full-time)

Order: subagents course → Day 6 → GitHub App review. If a block overruns, drop the effort compare or the cloud check first, never a CP2 item.

| Done | Time | Block | Finish line |
|---|---|---|---|
| [ ] | 0:00–0:15 | **Practice repo reset.** Switch to `main`. Revert `7157b2f` to restore CLAUDE.md and fix its Test line for a missing `.env`. Merge #48 from `fix/issue-48-onnxruntime-import`. Delete the Day 5 branches and worktrees. | main has CLAUDE.md, CI green |
| [ ] | 0:15–1:00 | **Course: Intro to subagents (45 min).** Then run `/academy-course` here. | Notes + hub card |
| [x] | 1:00–1:15 | **Pick 2 tickets from #45** that touch separate files, for example (a) whitespace-only input posts an empty bubble (client, report #22) and (b) ticket email/phone validation (server, report #10). Create them as GitHub issues. | 2 issues |
| [ ] | 1:15–3:00 | **2 parallel worktree sessions.** A: `/do-issue`, unaided. B: Plan mode, with at least 2 plan/diff comments to steer it. Both open PRs. Run `/loop 15m` on PR B, write `loop.md`, try `/loop 5m` health check. | 2 PRs, loop ran |
| [ ] | 3:00–3:15 | Break | |
| [x] | 3:15–4:15 | **Claude GitHub App (extra).** Run `/install-github-app` in a terminal `claude` session. I set the secret myself. Merge the workflow PR, ask for inline comments in `claude-code-review.yml`, then trigger reviews on PR A and PR B and compare with CodeRabbit. | Reviews + table |
| [ ] | 4:15–5:00 | **Artifact + `/rc`.** PR walkthrough artifact for PR B. Steer session A from my phone. | Link + 1 steer |
| [ ] | 5:00–5:30 | **Merge both PRs.** Fix review comments, get CI green, merge. | 2 merged |
| [ ] | 5:30–6:30 | **ultrathink + `/effort`.** Run one bug (for example report #20) at low and high effort with the same prompt. | Table |
| [ ] | 6:30–7:00 | **Cloud session** from claude.ai/code, one small read-only task. | 3-line note |
| [ ] | 7:00–8:00 | **Wrap-up.** CP2 check, tick `TODO.md`, take-aways, commit + push both remotes, daily report draft. | Report drafted |
