# Day 01 — Mental model + Claude basics

## Learned
- Context window = working memory; manage with `/context` (see usage), `/compact` (summarise), `/clear` (reset per task).
- Surfaces: terminal, VS Code, Desktop, web. Permission modes: manual → auto-accept edits → auto → plan (read-only).
- Workflow: explore → plan → code → commit.
- `CLAUDE.md` = persistent project memory, loaded every session → keep it short.
- Extend: subagents (delegate, own context), MCP (external tools/data), hooks (deterministic: format, block cmds, notify).

## Prompts that worked
1. Bug summary (+ pasted `issue.md`) → right symptom, sharp missing-info list; chat can't read repo so cause stayed a guess.
   > Summarize this bug in 3 sentences: what breaks, likely cause, first debugging step. Then list what info is missing.
   - Improve: add "Rank 2–3 hypotheses and how to confirm each".
2. Explain concept. Vague → 4 paragraphs (ignored "5 lines"). Hard format → obeyed:
   > Explain a context window to a junior dev in exactly 5 lines/bullets, max 15 words each. One analogy. One practical tip.
3. Drafting → right tone/length, generic (no link/bug name):
   > Draft a short Slack message to a teammate: the login bug is reproduced, the fix is in PR review, and I need their review by tomorrow. Friendly, 3 lines max.
   - Improve: add PR link, ticket, audience, tone example.

## Gotchas
- Instructions in `CLAUDE.md` are advice; only hooks/permission deny rules are guaranteed.

## Kit candidates
- Prompt rule: always give a hard format (count, max words, sections) + the context chat can't see.
- Hook: auto-format after edit (→ D9 `ai-kit` settings).
