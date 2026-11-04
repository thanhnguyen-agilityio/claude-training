# Introduction to subagents — study notes

Personal study notes for the Claude Academy course
[Introduction to subagents](https://academy.claude.com/courses/introduction-to-subagents)
(4 lessons, about 45 min, no completion badge).

Study guide (interactive review): [Introduction to subagents Study Guide](https://claude.ai/artifact/WNrQ3jr2XK8KKtzbUv8FLd#overview)

These are my own summaries, not a copy of the course. Open the lesson links for the videos,
transcripts, full exercise text and the interactive exercises.

## Source and license

- Course © Anthropic. The course page text I used does not state a license.
- These notes are personal summaries for non-commercial training use.

## The course in one page

A subagent is a helper Claude Code starts in its own context window. It gets a system prompt from
its config file plus a task prompt from the main agent, does the digging, and returns only a
summary. That keeps the main context clean, at the cost of not seeing how the answer was found.

| Topic | Key point | Lesson |
| --- | --- | --- |
| How it works | Own context window; inputs = config system prompt + parent's task prompt; only a summary returns, full run saved in a separate transcript | 1 |
| Built-in subagents | General purpose (explore + act), Explore (search code), Plan (plan-mode research) | 1 |
| Custom subagents | Markdown + YAML frontmatter in `.claude/agents/` (project) or `~/.claude/agents/` (user); ask Claude to write it | 2 |
| Config fields | `name`, `description` (when to delegate, one line), `tools`, `model` (alias, ID or `inherit`), `color`; body = system prompt | 2 |
| Design | Description steers both *when* it runs and *what it's told*; define an output format; add an "Obstacles encountered" section; give only needed tools | 3 |
| When to use | Research, code review, tasks needing a custom system prompt | 4 |
| When to avoid | "Expert" personas, dependent sequential pipelines, test runners | 4 |

Simple rules to remember:
- **One question:** does the intermediate work matter? No → subagent. Yes → main thread.
- **Output format** is the biggest single improvement: it tells the subagent when it's done.
- **Description = trigger + brief.** Write it to steer the main agent's input prompt.
- **Least tools:** read-only for research, + Bash for reviewers, Edit/Write only for agents that change code.
- **"proactively"** in the description makes Claude delegate without being asked; restart Claude Code if the agents folder is new.

## Lessons

| # | Lesson | Notes |
| --- | --- | --- |
| 1 | [What are subagents?](https://academy.claude.com/courses/introduction-to-subagents/what-are-subagents) | [01-what-are-subagents.md](01-what-are-subagents.md) |
| 2 | [Creating a subagent](https://academy.claude.com/courses/introduction-to-subagents/creating-a-subagent) | [02-creating-a-subagent.md](02-creating-a-subagent.md) |
| 3 | [Designing effective subagents](https://academy.claude.com/courses/introduction-to-subagents/designing-effective-subagents) | [03-designing-effective-subagents.md](03-designing-effective-subagents.md) |
| 4 | [Using subagents effectively](https://academy.claude.com/courses/introduction-to-subagents/using-subagents-effectively) | [04-using-subagents-effectively.md](04-using-subagents-effectively.md) |

Each lesson has a video and transcript; notes come from the written summary only. Lesson pages do
not show durations. The course has no quiz on its pages; the "Course complete" page had no text.

## Diligence statement

I wrote these notes with Claude. Claude read the course pages via Claude in Chrome and drafted
summaries in its own words. I'm responsible for checking them against the course.
