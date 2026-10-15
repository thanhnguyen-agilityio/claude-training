# Day 01 — Exercises (Developer)

> Source: [dojo/schedule/day-01.md](../../../dojo/schedule/day-01.md)
> *In Claude chat, get a useful answer to three real work questions (one bug summary, one "explain this concept", one drafting task); note what prompt changes improved the answer.*

## Goal
Practice the **turn-by-turn** shape (Lesson 4) and the **Stage / Task / Rules** prompt (Lesson 2–3).
What you produce is **not** the answers. It's the record of *which prompt change made the answer better*.

## Setup (5 min)
- Use the **Chat** tab in Claude desktop, not Code or Cowork. Today is about chat only.
- Open **one new chat per task**. Don't carry context from one task to the next.
- Chat can't see this repo. Paste the code or attach the file yourself. Choosing what context to give is part of the exercise.
- Sandbox rule: only `sample-project/` content. No client code, secrets or customer data.

## The loop (same for every task)
| Round | What you do | Log |
|---|---|---|
| **v1: lazy** | Send the weak prompt given in the task file, as is | Score it against the rubric (0–5) |
| **v2: framed** | Rewrite it with Stage / Task / Rules | Score it, then note what changed and why it helped |
| **v3: fix one gap** | Look at the worst rubric miss and change **one thing** only (example, length, format, ask for evidence…) | Score it, then note the single change and its effect |

Stop at v3 even if you could keep going. The point is to see which change moved the score.

Prompt skeleton for v2:
```
[Stage]  You are … / I am a … working on … / Context: …
[Task]   I need you to … (one clear deliverable)
[Rules]  Length … · Format … · Audience … · Tone … · If unsure, say so …
```

## Tasks (~30 min each)
1. [01-bug-summary/](01-bug-summary/README.md): summarize the seeded bug in `sample-project/assets/issue.md`
2. [02-explain-concept/](02-explain-concept/README.md): explain conversation summarization / message trimming in the LangGraph agent
3. [03-drafting/](03-drafting/README.md): draft a status update about the bug for a non-technical PM

Tasks 1, 2 and 3 use the same bug, so by the end of the day you understand it well. That's your head start for Day 2 (repro + failing test).

## Debrief (15 min): write into `../notes.md`
Answer the dojo discussion question for yourself:
1. **Surprised good:** where did Claude beat what you'd have written?
2. **Surprised bad:** where was it wrong, generic or confidently off? How did you notice? (Discernment)
3. **Top 3 prompt changes** across all tasks, ranked by how much each one helped. Copy them to *Prompts that worked*.
4. **One habit** you'll keep from tomorrow on.

## Done when
- [ ] 3 task files have v1/v2/v3 logs and scores filled in
- [ ] Debrief answers are in `../notes.md` (Learned · Prompts that worked · Gotchas)
- [ ] Committed and pushed
