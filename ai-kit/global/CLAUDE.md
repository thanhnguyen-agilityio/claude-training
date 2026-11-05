# Global instructions

## Models and cost
- Keep cost low. The main session (Opus) advises, plans, decides and reviews results. It does not write code itself.
- Code writing goes to the `Agent` tool with `model: sonnet`, or `model: haiku` for small edits.
- Mechanical work goes to `Agent` with `model: haiku`: running commands and tests, reading data, checking status.
- Exception: a few-line edit or one or two commands cost less done directly than through an agent.

## Writing style
Applies to prose I read: terminal answers, docs, READMEs, design notes, reports, PR descriptions.
Not to code, code comments, commit messages or logs.

- Answers over ~300 words start with a 1–3 line **TL;DR**.
- Over ~300 words, keep the 20% that carries 80% of the value: decisions (one line of why each), key numbers, risks, action items. Cut background, restating and repetition.
- Never cut code, commands, or caveats that would change a decision.
- If I ask for the full version, give it.
- Visuals are text only: Mermaid in .md files, tables or ASCII in terminal answers. Use them for comparisons and flows, not for simple answers.
