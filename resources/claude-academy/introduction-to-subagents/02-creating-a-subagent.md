# Lesson 2: Creating a subagent

How to make a custom subagent: scope, tools, model, color, and the config file.

## Lesson 2 — Creating a subagent

- A **custom subagent** is a Markdown file with **YAML frontmatter**. The frontmatter says *when*
  Claude should use it; the body says *how* it behaves.
- **Easiest way:** ask Claude to write the file. Say what it should do, where to save it, and your
  choices for scope, tools, model and color.
- Note from the lesson: the video shows the `/agents` wizard, which was **removed in Claude Code
  v2.1.198**. The file format and fields did not change.

**Scope**

| Scope | Folder | Available in |
| --- | --- | --- |
| Project-level | `.claude/agents/` | This project only |
| User-level | `~/.claude/agents/` | All projects on your machine |

**Tools:** categories are read-only, edit, execution, MCP and other. Give only what the job needs.
A code reviewer should not get edit tools, but execution tools can help it find pending changes
(e.g. run `git diff`).

**Model**

| Choice | Best for |
| --- | --- |
| Haiku | Fast, lightweight tasks |
| Sonnet | Middle ground of speed and depth |
| Opus | Complex analysis |
| Inherit | Same model as the main conversation |

**Color:** shown in the UI so you can tell which subagent is running.

**Config file** (project scope: `.claude/agents/<name>.md`)

```markdown
---
name: code-quality-reviewer
description: Use this agent when you need to review recently written or modified code for quality, security, and best practice compliance.
tools: Bash, Glob, Grep, Read, WebFetch, WebSearch
model: sonnet
color: purple
---

You are an expert code reviewer ... (system prompt)
```

| Field | Meaning |
| --- | --- |
| `name` | Unique ID. Call it by asking Claude or with `@agent-<name>` |
| `description` | Decides **when** Claude delegates. One line (use `\n` for breaks); can hold example conversations |
| `tools` | Tools the subagent may use; edit any time |
| `model` | Alias (`sonnet`, `opus`, `haiku`, `fable`), full model ID, or `inherit` |
| `color` | UI color |

- **System prompt** = the body below the frontmatter: what to focus on, how to analyze, how to
  report back. Be specific about what to look for and the output structure.
- **Automatic use:** put the word **"proactively"** in the description, and add concrete example
  scenarios.
- **Testing:** make a code change and ask for a review. If the agents folder didn't exist when the
  session started, **restart Claude Code** first. Not triggering? Improve the description with more
  specific examples and triggers.

**Gaps:** video and the wizard screenshots not read (the wizard no longer exists).
