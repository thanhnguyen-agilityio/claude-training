# Lesson 1: What are subagents?

How a subagent runs in its own context window and hands back only a summary.

## Lesson 1 — What are subagents?

- A **subagent** is a focused helper Claude Code delegates a task to. It works in its **own context
  window** and returns a **summary** to the main conversation.
- **Why it matters:** every tool call, file read and search result in the main chat uses up the
  context window. When it fills, Claude starts losing track of earlier parts of the session.
- **What the subagent starts with:**

| Input | Comes from |
| --- | --- |
| Custom system prompt | The subagent's configuration file (role and behavior) |
| Task description | Written by the parent agent from your request |

- The subagent then reads, searches and edits on its own. Only the summary returns; Claude Code keeps
  the full subagent conversation in a **separate transcript file**.
- **Tradeoff:** the main chat stays clean, but it can't see how the subagent reached its answer.

**Example from the lesson:** "Which service handles refunds?" in an unknown codebase. Without a
subagent, ~15 file reads and several searches land in your context. With the **Explore** subagent,
your context records only the question and the answer.

**Built-in subagents**

| Subagent | Use |
| --- | --- |
| General purpose | Multi-step tasks that need both exploring and acting |
| Explore | Fast search and navigation of a codebase |
| Plan | Research during plan mode before Claude presents a plan |

**Custom subagents:** your own system prompt and tool access, e.g. code reviewer, test writer,
documentation generator (Lesson 2).

**Three benefits**
1. Work is split into focused pieces.
2. The main context stays clean because intermediate work is isolated.
3. You get back only the information you need.

**Gaps:** the lesson video was not watched; notes come from the lesson summary text.
