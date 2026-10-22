# Task 2: Explain this concept

## Scenario
To fix the Task 1 bug tomorrow, you need to understand how the agent keeps its chat history short. You know Python and APIs. LangGraph is new to you.

## Concept
How the LangGraph agent summarizes and trims conversation history, and why tool messages make that hard. (If you already know it, pick another concept from `resources/practice/issues/`.)

## Input
`resources/practice/issues/issue-1.md`: the error trace and the `state["messages"]` dump. The agent code isn't in this repo, so Claude explains from the issue and must say what it can't see.

## v1: lazy prompt (send exactly this, nothing attached)
```
explain langgraph conversation summary
```
Watch how much of the answer is about your code and how much is textbook.

## Ideas for v2 and v3
- Say who you are and what you'll use the answer for.
- Attach the issue and ask for this case, not LangGraph in general.
- Set the shape: "250 words or fewer, one ASCII diagram, one analogy".
- Ask for the line behind every claim, or for what it isn't sure about.
- Ask for 3 questions you should be able to answer if you understood it.

## Rubric (1 point each, 5 max)
- [ ] Explains the agent loop in the issue: assistant, tool calls, tool results, assistant. (v2, v3)
- [ ] Explains what is kept (the summary string and the last N messages) and what is deleted. (v3 only)
- [ ] Explains the pairing rule between an `AIMessage` with `tool_calls` and its `ToolMessage`, and why trimming can break it. (v2, v3)
- [ ] Pitched at your level and length. (v2 only; v3 went over 250 words)
- [x] You checked 2 claims against the code yourself and logged them.

No round hit all five. v2 and v3 both scored 4.5.

## Claim check
| Claim Claude made | File:line | True, false or partly |
|---|---|---|
| v2: msgs [2]-[4] are a pair on `call_qhy...` | issue-1.md:31, 33 | True |
| v2: no HumanMessage in the state | issue-1.md:27-35 | True |
| v2: "the 400 comes from `messages.[1]`" | issue-1.md:18 | Partly. I wasn't sure. Claude's own note, a system prompt at index 0, is a guess. |
| v3: "every message in your dump has an `id`" | issue-1.md:31 | False. The `AIMessage` on line 31 has no `id` field. |

## Log
[log.md](log.md): one section per round with prompt, response, score and what changed.
