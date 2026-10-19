# Task 2: Explain this concept

## Scenario
To fix the Task 1 bug on Day 2, you need to understand how this agent keeps its chat history short. You want an explanation pitched at your level. You know Python and APIs, and LangGraph is new to you.

## Concept
How the LangGraph agent summarizes and trims conversation history, and why tool messages make that hard.

If you already know this well, pick another concept from `sample-project/`, such as `interrupt_before=["sensitive_tools"]` or the RAG code in `server/agent/rag/`, and use the same loop.

## Input
- `sample-project/server/agent/graph.py`: `State`, `summarize_conversation`, `init_graph`
- `sample-project/server/utils/utils.py`: `handle_keep_recent_messages`

## v1: lazy prompt (send exactly this, with no code attached)
```
explain langgraph conversation summary
```
It is meant to be generic. Watch how much of the answer is about your code and how much is textbook.

## Ideas for v2 and v3 (pick a few)
- Say who you are and what you'll use the answer for (fixing a bug tomorrow).
- Attach the two files and ask it to explain this code, not LangGraph in general.
- Set the shape, for example "250 words or fewer, one ASCII diagram of the graph, one analogy".
- Ask it to quote the line for every claim, or to mark what it isn't sure about.
- Ask it to end with 3 questions you should be able to answer if you understood it.

## Rubric (1 point each, 5 max)
- [ ] It explains the graph flow: `START → summarize_conversation → assistant → tools → assistant ...`
- [ ] It explains what is kept (the summary string and the last N messages) and what is deleted (`RemoveMessage`).
- [ ] It explains the pairing rule between an `AIMessage` with `tool_calls` and its `ToolMessage`, and why trimming can break it.
- [ ] It is pitched at your level and length. You didn't skim or get lost.
- [ ] You checked 2 claims against the code yourself and logged them.

## Claim check
| Claim Claude made | File:line you checked | True, false or partly |
|---|---|---|
| | | |
| | | |

## Your log
Keep it in [log.md](log.md), with one section per round: prompt, response, score and what changed.
