# Day 5: Memory & context

## AI Fluency (15 lessons)
Progress: 9/15 at start of day → _/15

| Lesson | 3-line note |
|---|---|
| 10 | |
| 11 | |
| 12 | |
| 13 | |
| 14 | |
| 15 | |

## 1. CLAUDE.md (ecommerce-agent)
- Baseline `/context` (Sonnet 5.5, 1M window): 93.7k/1M (9%) in a long session. Fixed overhead ~32k = system prompt 2.8k + system tools 16.2k + MCP instructions 1.1k + memory files 1.6k (4 files) + skills 10k (139 skills). Messages 62k (this session, not baseline). Autocompact buffer 33k.
- Lines in final file: 
- Sections kept: commands / conventions / never-do
- What I cut from Claude's draft, and why: 
- Template change in `ai-kit/CLAUDE.md.template`: 

## 2. Compaction and /rewind
- Task used: 
- Context before `/compact`: → after: 
- Survived: 
- Lost: 
- Bad edit made: 
- `/rewind` restored (code / conversation): 
- `/memory` auto-saved entries: 

## 3. Fresh vs primed
Ticket: issue-

| | A: fresh | B: primed (CLAUDE.md + read code) |
|---|---|---|
| Questions Claude asked | | |
| Files touched / correct? | | |
| Wrong assumptions | | |
| Tokens / cost | | |
| Quality (1–5) | | |

Verdict (1 line): 

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
| [ ] | 1:55–2:45 | **Compaction and `/rewind` (50 min).** Long session on a real task → `/compact` → ask what it remembers, list what was lost. Make a deliberately bad edit → Esc Esc to rewind. Read `/memory`. | 5-line note: survived / died / restored |
| [ ] | 2:45–3:45 | **Fresh vs primed (60 min).** One ticket, same prompt. A: fresh, no CLAUDE.md, no reading. B: CLAUDE.md + codebase read. Compare quality, questions, tokens (`/context`, `/cost`). | Table filled + 1-line verdict |
| [ ] | 3:45–4:00 | **Wrap-up (15 min).** Tick Day 5 in `TODO.md`, add Day 5 lines to `training/take-away.md`, commit to `main`, push. | Pushed |
