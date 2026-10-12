# Day 01 — Mental model + Claude basics

## Learned
- Context window = working memory; manage with `/context` (see usage), `/compact` (summarise), `/clear` (reset per task).
- Surfaces: terminal, VS Code, Desktop, web. Permission modes: manual → auto-accept edits → auto → plan (read-only).
- Workflow: explore → plan → code → commit.
- `CLAUDE.md` = persistent project memory, loaded every session → keep it short.
- Extend: subagents (delegate, own context), MCP (external tools/data), hooks (deterministic: format, block cmds, notify).

## Prompts that worked
- Bug summary: **"Summarize in 3 sentences: what breaks, likely cause, first debug step. Then list missing info."** → right symptom + sharp missing-info list. Chat can't read repo, so cause stayed a guess.
- Explain concept: vague "in 5 lines" → 4 paragraphs. Hard format "exactly 5 bullets, max 15 words each. One analogy. One tip." → obeyed. Numeric limits beat vague ones.
- Drafting: "Slack msg, friendly, 3 lines max" → on tone/length, but generic. Add PR link, bug name, tone example, audience to get a send-ready draft.
- Improve next time: "Rank 2–3 hypotheses with how to confirm each" (answer gave only 1 cause).

## Gotchas
- Instructions in `CLAUDE.md` are advice; only hooks/permission deny rules are guaranteed.

## Kit candidates
- Prompt rule: always give a hard format (count, max words, sections) + the context chat can't see.
- Hook: auto-format after edit (→ D9 `ai-kit` settings).
