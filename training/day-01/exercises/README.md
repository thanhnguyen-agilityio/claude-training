# Day 01 exercises (developer)

Source: [dojo/schedule/day-01.md](../../../resources/dojo/schedule/day-01.md). The dojo exercise reads: "In Claude chat, get a useful answer to three real work questions (one bug summary, one 'explain this concept', one drafting task); note what prompt changes improved the answer."

## Goal
Practice the turn-by-turn shape (lesson 4) and the Stage / Task / Rules prompt (lessons 2 and 3). The output is not the answers. It is a record of which prompt change made each answer better.

## Setup (5 min)
- Use the Chat tab in Claude desktop. Today is chat only, not Code or Cowork.
- Open a new chat for each task so context doesn't carry over.
- Chat can't see this repo. Paste the code or attach the file yourself. Choosing what context to give is part of the exercise.
- Use only `resources/practice/` content. No client code, secrets or customer data.

## The loop (same for every task)
| Round | What you do | What you log |
|---|---|---|
| v1, lazy | Send the weak prompt from the task file as written | Score it against the rubric (0 to 5) |
| v2, framed | Rewrite it with Stage / Task / Rules | Score it, then note what changed and why it helped |
| v3, fix one gap | Find the worst rubric miss and change one thing (an example, a length, a format, a request for evidence) | Score it, then note the single change and its effect |

Stop at v3. The point is to see which change moved the score.

Prompt skeleton for v2:
```
[Stage]  You are ... / I am a ... working on ... / Context: ...
[Task]   I need you to ... (one clear deliverable)
[Rules]  Length ... / Format ... / Audience ... / Tone ... / If unsure, say so ...
```

## Tasks (about 30 min each)
1. [01-bug-summary/](01-bug-summary/README.md): summarize the bug in `resources/practice/issues/issue-1.md`.
2. [02-explain-concept/](02-explain-concept/README.md): explain conversation summarization and message trimming in a LangGraph agent, from the issue.
3. [03-drafting/](03-drafting/README.md): draft a status update about the bug for a non-technical PM.

All three tasks use the same bug, so by the end of the day you understand it well. That gives you a head start on Day 2 (repro and failing test).

## Debrief (15 min)
Write the answers in `../notes.md`, under Learned, Prompts that worked, Gotchas and Surprises. They answer the dojo discussion question.
1. Where did Claude beat what you would have written?
2. Where was it wrong, generic or confidently off, and how did you notice? This is the Discernment step.
3. Which three prompt changes helped most, ranked? Copy them to Prompts that worked.
4. Which one habit will you keep from tomorrow on?

## Done when
- [ ] The three task logs have v1, v2 and v3 with scores, and Task 3 has the final message
- [ ] Debrief answers are in `../notes.md` (Learned, Prompts that worked, Gotchas, Surprises)
- [ ] Everything is committed and pushed
