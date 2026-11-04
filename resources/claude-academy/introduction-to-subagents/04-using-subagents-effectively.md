# Lesson 4: Using subagents effectively

When a subagent helps, when it gets in the way, and the one question that decides it.

## Lesson 4 — Using subagents effectively

**Decision rule:** *Does the intermediate work matter to the main thread?*
- No, I only need the result → delegate to a subagent.
- Yes, I need to see and react to each step → keep it in the main thread.

Subagents fit when exploration is separate from execution: you want the answer, the digging would
clutter the context, or the task gains from fresh eyes or a custom system prompt.

**Where they help**

| Use case | Why a subagent wins | Lesson example |
| --- | --- | --- |
| Research | Dozens of file reads stay in the subagent; main thread gets a short answer | "Where is the JWT validated?" → one line naming the middleware file and the router that calls it |
| Code review | Claude reviews better when the code looks like someone else's; a fresh context has no memory of writing it | Reviewer runs `git diff`, reads changed files, applies team review rules from its system prompt |
| Custom system prompt | Claude Code's default prompt favors short, code-focused answers | **Copywriting** agent with tone, audience and voice rules; **styling** agent that reads design-system files (colors, spacing, components) before writing CSS |

**Where they hurt** (the overhead of hiding work and compressing it is only worth it if the subagent
does something the main thread can't)

| Anti-pattern | Problem |
| --- | --- |
| "Expert" personas ("you are a Python expert") | Add nothing; Claude already has that knowledge |
| Sequential pipelines (reproduce → debug → fix agents) | Each step depends on the last; details are lost at every handoff. Only fine for truly independent steps |
| Test runners | Return "tests failed" and hide the output you need; you end up writing debug scripts. In testing this did **worst** of all setups |

**Use for:** research and exploration, code reviews, tasks needing a custom system prompt.
**Avoid for:** expert personas, dependent multi-step pipelines, running tests you need to debug.

**Gaps:** video not watched. The "Course complete" page was not read.
