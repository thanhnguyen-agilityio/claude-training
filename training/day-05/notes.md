# Day 5: Memory & context

## AI Fluency (15 lessons)
Progress: 9/15 at start of day → 10/15. Full notes for lessons 1–10: [ai-fluency.md](../courses/ai-fluency.md)

| Lesson | 3-line note |
|---|---|
| 10 | Discernment = product (output quality) · process (how AI approached it) · performance (how it behaved in the session). Mirrors Description: describe all 3 up front, check all 3 after. |
| 11 | |
| 12 | |
| 13 | |
| 14 | |
| 15 | |

## 1. CLAUDE.md (ecommerce-agent)
- Baseline `/context` (Sonnet 5.5, 1M window): 93.7k/1M (9%) in a long session. Fixed overhead ~32k = system prompt 2.8k + system tools 16.2k + MCP instructions 1.1k + memory files 1.6k (4 files) + skills 10k (139 skills). Messages 62k (this session, not baseline). Autocompact buffer 33k.
- Fresh session baseline: 34.2k/1M (3%). System prompt 2.8k, system tools 15.6k, MCP tools 0.6k, MCP instructions 1.1k, memory 1.6k, skills 10k, messages 2.6k. Use ~34k as the start line for fresh vs primed.
- Lines in final file: 33
- Sections kept: commands / layout / conventions / never-do
- What I cut from Claude's draft, and why: 
- Template change in `ai-kit/CLAUDE.md.template`: setup-step and run-from-dir hints on commands, optional E2E/data/evals slot, `in/` and `out/` layout lines, style-rule example, a closing "under ~40 lines, only checked commands" reminder.

## 2. Compaction and /rewind
- Task used: 
- Context before `/compact`: → after: 
- Survived: 
- Lost: 
- Bad edit made: 
- `/rewind` restored (code / conversation): 
- `/memory` auto-saved entries: 

## 3. Fresh vs primed
Ticket: [#48 Unit test run fail](https://github.com/thanhnguyen-agilityio/claude-training-practice/issues/48) (onnxruntime import crashes CI collection). Full report: [fresh-vs-primed.md](fresh-vs-primed.md)

| | A: fresh | B: primed (CLAUDE.md + read code) |
|---|---|---|
| Questions Claude asked | 0 | 0 |
| Files touched / correct? | `retriever.py` (+4/−2) + new test; correct | Same fix + a closer-to-CI test; correct |
| Wrong assumptions | None that cost anything (read test commands from `ci.yml`); ran server suite only | Used CLAUDE.md's `--env-file ../.env` with no `.env` → suites errored, then recovered; ran all 3 suites + ruff |
| Tokens / cost | 71.0k → 83.4k · ≈ $0.89 (est.) | 71.5k → 80.2k primed → 92.6k · ≈ $1.25 (est., priming ≈ $0.54) |
| Quality (1–5) | 4 | 4 |

First run, from `/cost`: A $0.39, B $0.33 (B cheaper). The re-run estimate says the opposite, so the cost row needs real `/cost` numbers before trusting it.

Verdict (1 line): Same fix either way; priming cost ~9k context and only made the checks more complete (all 3 suites), not the fix better.

## Take-away (copy to training/take-away.md)
- 
- 
- 

---

# Today's plan (4h, Day 5 + AI Fluency)

Phone away, Slack closed. One topic per session: new session per block. Write the note right after each block. If a block overruns, cut extras, not checkpoint items. Stuck >10 min → ask, don't grind.

| Done | Time | Block | Finish line |
|---|---|---|---|
| [x] | 0:00–0:10 | **Setup.** Open `ecommerce-agent` clone (not the training repo). Run `/context` for baseline. | Baseline context size noted |
| [ ] | 0:10–0:55 | **AI Fluency lessons 10–15 (45 min).** 3 lines of notes per lesson. | 15/15, or ≥3 lessons with notes |
| [ ] | 0:55–1:45 | **Write `CLAUDE.md` for the app (50 min).** Commands (build/run/test), conventions, "never do" list. Let Claude draft from the code, then you cut. Refine `ai-kit/CLAUDE.md.template`. | File under ~40 lines, template updated |
| [ ] | 1:45–1:55 | **Break.** Away from screen. | |
| [x] | 1:55–2:45 | **Compaction and `/rewind` (50 min).** Long session on a real task → `/compact` → ask what it remembers, list what was lost. Make a deliberately bad edit → Esc Esc to rewind. Read `/memory`. | 5-line note: survived / died / restored |
| [x] | 2:45–3:45 | **Fresh vs primed (60 min).** One ticket, same prompt. A: fresh, no CLAUDE.md, no reading. B: CLAUDE.md + codebase read. Compare quality, questions, tokens (`/context`, `/cost`). | Table filled + 1-line verdict |
| [ ] | 3:45–4:00 | **Wrap-up (15 min).** Tick Day 5 in `TODO.md`, add Day 5 lines to `training/take-away.md`, commit to `main`, push. | Pushed |
