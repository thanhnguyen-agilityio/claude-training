# Day 01 exercises (developer)

Source: [dojo/schedule/day-01.md](../../../resources/dojo/schedule/day-01.md). Get a useful answer in Claude chat to three work questions (bug summary, explain a concept, drafting) and note which prompt changes improved each answer.

The output is the record of which change made each answer better, not the answers.

## Setup
- Chat tab in Claude desktop, a new chat per task. Chat can't see this repo, so paste or attach the file yourself.
- Use only `resources/practice/` content. No client code, secrets or customer data.

## The loop (each task)
| Round | What you do | What you log |
|---|---|---|
| v1, lazy | Send the weak prompt from the task file | Score 0 to 5 against the rubric |
| v2, framed | Rewrite with Stage / Task / Rules | Score, and what changed and why |
| v3, fix one gap | Change one thing aimed at the worst rubric miss | Score, and the effect of that change |

v2 skeleton:
```
[Stage]  You are ... / I am a ... working on ... / Context: ...
[Task]   I need you to ... (one clear deliverable)
[Rules]  Length ... / Format ... / Audience ... / Tone ... / If unsure, say so ...
```

## Tasks (all use the bug in `resources/practice/issues/issue-1.md`)
1. [01-bug-summary/](01-bug-summary/README.md): summarize the bug for a ticket.
2. [02-explain-concept/](02-explain-concept/README.md): explain how the agent summarizes and trims history.
3. [03-drafting/](03-drafting/README.md): draft a status update for a non-technical PM.

## Debrief
Answer in `../notes.md`:
1. Where did Claude beat what you would have written?
2. Where was it wrong or generic, and how did you notice?
3. Which three prompt changes helped most, ranked?
4. Which one habit will you keep?

## Done when
- [x] The three logs have v1, v2 and v3 with scores, and Task 3 has the final message
- [x] Debrief answers are in `../notes.md`
- [ ] Everything is committed and pushed
