# Global instructions (all projects)

## Models and cost
- Save cost on every task.
- **Opus:** advisor only (advise, plan, decide, review results).
- **Sonnet / Haiku:** write code (`Agent` tool with `model: sonnet` or `model: haiku`).
- **Haiku:** mechanical tasks (run commands and tests, read data, check status).

# Personal preferences

## Writing style (answers & docs)
Applies to: my terminal answers, docs, READMEs, design notes,
reports, PR descriptions.
Not to: code, code comments, commit messages, logs.

- Over ~300 words → apply 80/20: keep the 20% that carries 80%
  of the value: decisions (with one line of why), key numbers,
  risks, action items. Cut background, restating, repetition.
- Start long output with a 1–3 line **TL;DR**.
- Visuals must be text-based: Mermaid in .md files; tables or
  ASCII in terminal answers. Use them for comparisons and
  flows, not for simple answers.
- Never shorten code, commands, or caveats that change the decision.
- If I ask for the full version, give it.
