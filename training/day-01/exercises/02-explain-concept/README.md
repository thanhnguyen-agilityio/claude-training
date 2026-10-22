# Task 2: Explain this concept

## Scenario
To fix the Task 1 bug on Day 2, you need to understand how this agent keeps its chat history short. You want an explanation pitched at your level. You know Python and APIs, and LangGraph is new to you.

## Concept
How the LangGraph agent summarizes and trims conversation history, and why tool messages make that hard.

If you already know this well, pick another concept from `resources/practice/issues/` and use the same loop.

## Input
- `resources/practice/issues/issue-1.md`: the error trace and the `state["messages"]` dump. The agent code is not in this repo, so Claude explains from the issue and must say what it can't see.

## v1: lazy prompt (send exactly this, with no code attached)
```
explain langgraph conversation summary
```
It is meant to be generic. Watch how much of the answer is about your code and how much is textbook.

## Ideas for v2 and v3 (pick a few)
- Say who you are and what you'll use the answer for (fixing a bug tomorrow).
- Attach the issue and ask it to explain this case, not LangGraph in general.
- Set the shape, for example "250 words or fewer, one ASCII diagram of the graph, one analogy".
- Ask it to quote the line for every claim, or to mark what it isn't sure about.
- Ask it to end with 3 questions you should be able to answer if you understood it.

## Rubric (1 point each, 5 max)
- [ ] It explains the agent loop visible in the issue: assistant, tool calls, tool results, assistant ... (v2, v3)
- [ ] It explains what is kept (the summary string and the last N messages) and what is deleted. (v3 only)
- [ ] It explains the pairing rule between an `AIMessage` with `tool_calls` and its `ToolMessage`, and why trimming can break it. (v2, v3)
- [ ] It is pitched at your level and length. You didn't skim or get lost. (v2 only; v3 went over 250 words)
- [x] You checked 2 claims against the code yourself and logged them.

Final: no round hit all five. v2 and v3 both scored 4.5.

## Claim check
| Claim Claude made | File:line you checked | True, false or partly |
|---|---|---|
| v2: msgs [2]-[4] are a pair on `call_qhy...` | issue-1.md:31, 33 | True |
| v2: no HumanMessage appears in the state | issue-1.md:27-35 | True |
| v2: "the 400 comes from `messages.[1]`" | issue-1.md:18 | Partly. I was unsure. Claude's own note, a system prompt at index 0, is a guess. |
| v3: "every message in your dump has an `id`" | issue-1.md:31 | False. The `AIMessage` on line 31 has no `id` field (found with Claude). |

## Your log
Keep it in [log.md](log.md), with one section per round: prompt, response, score and what changed.
