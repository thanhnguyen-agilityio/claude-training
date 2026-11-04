# Introduction to subagents — notes

Course: [Claude Academy](https://academy.claude.com/courses/introduction-to-subagents) · Day 6 · Full study notes: [resources/claude-academy/introduction-to-subagents](../../resources/claude-academy/introduction-to-subagents/README.md)

## Lesson 1: What are subagents?
- Subagents are specialised assistants that Claude Code can hand a task to.
- Each one runs in its own conversation/context window, with a custom system prompt that you define.
- It returns a summary to the main thread, not all of its intermediate work.
- Benefit: keeps the main context window small and clean.
- Claude Code ships with built-in subagents (e.g. Explore, Plan, general-purpose).

## Lesson 2: Creating a subagent
- Let Claude write it for you (`/agents` → generate with Claude). It does this better than writing one by hand.

## Lesson 3: Designing effective subagents
- **Description**: when to use it. It also shapes the task prompt the main agent writes for it.
- **Output format**: what to return and when it's done. This is the biggest single improvement.
- **Allowed tools**: give the fewest it needs (read-only for research, add Bash for review, Edit/Write only if it changes code).

## Lesson 4: Using subagents effectively
- Pattern 1: research and investigation
- Pattern 2: tasks that need custom instructions
- Pattern 3: code review
- Avoid: "expert" persona claims, multi-step pipelines, test runners

**Key question:** does the intermediate work matter to the main thread?
- No, I only need the result → subagent.
- Yes, I need to see and react to each step → keep it in the main thread.

## Take-away
- Subagent = separate context, returns a summary. Use it to protect the main context.
- Get Claude to generate it, then tighten the description, output format and tools.
- Delegate when only the result matters. Keep the work in the main thread when I need the steps.
