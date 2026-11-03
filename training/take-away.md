# Take-away

## Week 1 — Fundamentals (Day 1–3)

### Day 1: Basics
- Prompt: Stage / Task / Rules

### Day 2: Analysis
- Analyze: what it asks / what's ambiguous / first step
- Claude habit: paste the stack trace and code, ask for hypotheses, verify each by running it

### Day 3: Fix
- Fix: implement, test, PR (what / why / how tested / screenshots)
- Code review checklist: correctness > tests > readability > security basics > scope

## Week 2 — Dev track core

### Day 4: Daily loop
- Loop: ticket > plan mode (fix direction here) > implement > steer diff > tests > PR
- Failing test first; a passing test doesn't prove the fix is right, check manually too
- Permission modes (Shift+Tab): default (asks each time) / acceptEdits / plan (read-only) / auto
- One topic per session; `/resume` to go back
- Verify Claude's claims about code by reading it yourself
- Repeated loop → command (`/do-issue`); grilling skill to push back on plans

### Day 5: Memory & context
- CLAUDE.md: short (~40 lines) = commands, layout, conventions, never-do; only commands checked in the repo; grow it from real corrections
- CLAUDE.md can be wrong and Claude follows it (#48: `--env-file ../.env` with no `.env`), so test its commands like code
- Fresh vs primed (#48): same fix either way; priming cost ~9k context and only made checks more complete, so skip priming for small tickets and rely on CLAUDE.md
- `/context` first: a fresh session already starts at ~34k (tools + skills + memory), so turn off unused skills/MCP before blaming the task
