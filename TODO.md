# TODO / Progress

Started 2026-10-12. No dates: go by day number, 80/20 only (checkpoints matter, extras optional). Tell Claude "done day N" / "update todo" to tick items.
Detail per day: [PLAN.md](PLAN.md). Notes: [training/](training/).

## Progress

| Day | Theme | Status |
|---|---|---|
| 1 | Mental model + basics | ✅ |
| 2 | Ticket analysis, repro | ✅ |
| 3 | Fix/review/merge **CP1** | ✅ |
| 4 | Install, daily loop | ⬜ |
| 5 | Memory & context | ⬜ |
| 6 | Flagship + parallel **CP2** | ⬜ |
| 7 | Skills/commands/plugins | ⬜ |
| 8 | MCP & connectors | ⬜ |
| 9 | Hooks & automation | ⬜ |
| 10 | Review & quality | ⬜ |
| 11 | Role day **CP3** | ⬜ |
| 12 | Capstone: kickoff | ⬜ |
| 13 | Capstone: build | ⬜ |
| 14 | Capstone: harden | ⬜ |
| 15 | Capstone: ship **CP4** | ⬜ |

Legend: ⬜ todo · 🟨 doing · ✅ done · ❌ checkpoint failed (redo)

## Week 1 — Fundamentals

### Day 1
- [x] Setup: claude.ai login, desktop app, repo cloned
- [x] Course: Claude 101 lessons 1–4 (What is Claude, First conversation, Getting better results, Desktop) · stretch 5–6 (Projects, Artifacts) · AI Fluency + AI capabilities (optional, short)
  - [x] Lesson 1 What is Claude — reflection noted (idea: `email-digest` skill + weekday 08:30 scheduled task, Gmail connector, also on demand)
  - [x] Lessons 2–3 First conversation, Getting better results (Stage/Task/Rules, 4D framework)
  - [x] Lesson 4 Desktop — 3 shapes: turn by turn (Chat) / hand off (Cowork) / build (Code tab)
  - [x] Stretch: lessons 5–6 Projects, Artifacts
- [x] 3 chat tasks (bug summary / explain concept / drafting); log prompt improvements in notes — Task 1 5/5, Task 2 4.5/5, Task 3 4.0/5 (final message in `training/day-01/exercises/03-drafting/log.md`)
- [x] Git: branch → commit → push (`init-setup`)
- [x] Notes: `training/day-01/notes.md` · exercises: `training/day-01/exercises/`

### Day 2
Exercises: [training/day-02/exercises/](training/day-02/exercises/README.md)

- [x] Ticket analysis (task 1 done; enough, no more tickets)
- [x] Session 1: run sample app → reproduce bug → failing test (`claude-training-practice`, branch `test/keep-recent-orphan-tool-message`)
- [x] Git block skipped (pull --rebase/log/diff done; conflict #1 practice skipped, CP1 on Day 3 has a real conflict) · [x] debrief in `training/day-02/notes.md`
- [x] Course: Claude 101 finished
- Skipped (optional): clarifying-questions task, detailed log templates. Logs = short paragraph + command + output.

### Day 3 — CP1
- [x] Fix on branch, small commits, test included (repro by unit test only; not triggered in the running app)
- [x] PR description (what/why/how tested) — PR merged
- [x] Review a PR using checklist, ≥3 actionable comments (`training/day-03/review-pr11.md`, 4 comments; follow-up fix PR merged)
- [x] Merge done · conflict skipped (already experienced)
- [x] `review-checklist` skill in `ai-kit/` (already existed; used it for the review)
- [x] **CP1 pass**: repro ✔ fix+test ✔ PR ✔ review ✔ merge ✔ (conflict waived)

## Week 2 — Dev track core

### Day 4
_Tips: [colleague-tips](training/colleague-tips.md) — Day 4–5_
- [x] Course Claude Code 101 · [ ] Claude Code in action (optional, skip unless stuck)
- [ ] Docs (optional, skim only): quickstart, common-workflows, best-practices
- [ ] Code tab on repo; sessions/resume
- [ ] Permission modes tour on throwaway change
- [ ] Ex: explain feature X, verify 2 claims
- [ ] Ex: ticket → plan → implement → diff comment → tests → PR (×2, 2nd unaided)

### Day 5
- [ ] Write `CLAUDE.md` for sample-project (<1 screen) → refine `ai-kit/CLAUDE.md.template`
- [ ] Compaction experiment; `/rewind` bad edit
- [ ] Ex: fresh vs primed session comparison

### Day 6 — CP2
_Tips: [colleague-tips](training/colleague-tips.md) — Day 6_
- [ ] Artifact: PR walkthrough
- [ ] `/loop 15m` on PR; `/loop 5m` deploy check; write `loop.md`
- [ ] Remote Control `/rc` + phone steer
- [ ] ultrathink + `/effort` compare on one bug
- [ ] 2 parallel worktree sessions on 2 tickets, both merged
- [ ] Course: Intro to subagents; cloud session check from claude.ai/code
- [ ] **CP2 pass**: 2 parallel merged ✔ plan-mode+diff steer ✔ artifact ✔ RC steer ✔ loop ✔

### Day 7
- [ ] Course: Intro to agent skills
- [ ] 1 team skill (release-checklist) + 1 personal slash command → PR `.claude/`
- [ ] Install + evaluate 1 plugin

### Day 8
_Tips: [colleague-tips](training/colleague-tips.md) — Day 8_
- [ ] Course: Intro to MCP
- [ ] GitHub connector + Playwright MCP
- [ ] 1 MCP tool e2e (query/comment on PR)

## Week 3 — Extend, automate, review

### Day 9
_Tips: [colleague-tips](training/colleague-tips.md) — Day 9_
- [ ] 1 hook shipped by PR (format-on-edit / block-forbidden / notify)
- [ ] `/goal` on bounded task
- [ ] Desktop scheduled task (morning briefing)
- [ ] Routines overview; GitHub Actions `@claude` review on a PR

### Day 10
_Tips: [colleague-tips](training/colleague-tips.md) — Day 10_
- [ ] `/code-review` on real branch
- [ ] Seed buggy branch → `/code-review ultra`; compare
- [ ] Security plugins (security-guidance, Claude Security)
- [ ] Fix findings, note false positives

### Day 11 — CP3
- [ ] Claude in Chrome tests sample Streamlit client (console, forms)
- [ ] Browser pane preview loop
- [ ] (opt) AI-native SDLC playbook course
- [ ] **CP3 pass**: skill+hook merged ✔ MCP e2e ✔ review acted on ✔ role-day ✔

## Capstone

### Day 12
- [ ] Vague feature brief (Claude plays client); ticket pack + open questions

### Day 13
- [ ] Plan mode → parallel sessions → PR per ticket

### Day 14
- [ ] Tests (+CI), `/loop` babysit, `/code-review` (ultra if auth/data), fix

### Day 15 — CP4
- [ ] Cross-review, merge, tag, deploy
- [ ] RC phone demo
- [ ] Retro → standardize into `ai-kit/`
- [ ] Personal playbook ("how I work with Claude") as artifact
- [ ] **CP4 pass**

## After
- [ ] Optional: MCP advanced · Building with the Claude API · Claude Platform 101
