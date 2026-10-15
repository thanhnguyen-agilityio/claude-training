# Task 2 — Explain this concept

## Scenario
To fix the Task 1 bug on Day 2, you need to understand how this agent keeps its chat history short. You want an explanation pitched at your level: you know Python and APIs, but LangGraph is new to you.

## Concept
**How the LangGraph agent summarizes and trims conversation history, and why tool messages make that tricky.**

(If you already know this well, pick another concept from `sample-project/`, e.g. `interrupt_before=["sensitive_tools"]`, or RAG in `server/agent/rag/`. Use the same loop.)

## Input
- `sample-project/server/agent/graph.py`: `State`, `summarize_conversation`, `init_graph`
- `sample-project/server/utils/utils.py`: `handle_keep_recent_messages`

## v1: lazy prompt (send exactly this, with **no** code attached)
```
explain langgraph conversation summary
```
(It's meant to be generic. Watch how much is about *your* code and how much is textbook.)

## Ideas for v2/v3 (pick, don't use all)
- Say who you are and what you'll use it for (fixing a bug tomorrow)
- Attach the two files and ask it to explain **this** code, not LangGraph in general
- Set the shape: e.g. "≤ 250 words + one ASCII diagram of the graph + one analogy"
- Ask it to **quote the line** for every claim, or to mark what it's unsure about
- Ask it to end with 3 questions you should be able to answer if you understood it

## Rubric (1 point each, 5 max)
- [ ] Explains the graph flow: `START → summarize_conversation → assistant → tools → assistant …`
- [ ] Explains what is kept (summary string + last N messages) and what is deleted (`RemoveMessage`)
- [ ] Explains the AI-`tool_calls` ↔ `ToolMessage` pairing rule and why trimming can break it
- [ ] Pitched at your level and length. You didn't skim or get lost.
- [ ] **Verified:** you checked **2 claims** against the code yourself (log them below)

## Claim check (Discernment)
| Claim Claude made | File:line you checked | True / false / partly |
|---|---|---|
| | | |
| | | |

## Your log
Keep it in [log.md](log.md): one section per round (prompt, response, score, what changed).
