# Lesson 3: Designing effective subagents

Four fixes for subagents that wander, run too long, or return output the main agent can't use.

## Lesson 3 — Designing effective subagents

**How the config is used**
- The **name and description** of every subagent go into the main agent's system prompt. That is how
  it picks which subagent to launch and when. To change auto-triggering, edit these two fields.
- The description has a second job: the main agent uses it as guidance when it writes the subagent's
  **input prompt**. So the description shapes *what the subagent is told*, not only *when* it runs.

**1. Descriptions that shape the input prompt**

| Description says | Main agent's input prompt becomes |
| --- | --- |
| Generic code-review text | Vague: "use git diff to find the current changes" |
| "...tell the agent precisely which files you want it to review" | Lists the exact files to review |
| Web search agent: "...return sources that can be cited" | Asks for citable sources |

**2. Output format** (called the single most important improvement)
- Gives the subagent a **natural stopping point**: done when every section is filled.
- Stops it running too long; without a format it can't tell when it has researched enough.
- Example sections for a code reviewer: Summary, Critical issues, Major issues, Minor issues,
  Recommendations, Approval status (ready to merge or needs changes).

**3. Obstacle reporting**
- Workarounds the subagent finds must appear in its summary, or the main thread rediscovers them
  and wastes time and tokens.
- Ask for them explicitly with an **"Obstacles encountered"** section: setup issues, environment
  quirks, workarounds, commands that needed special flags, dependencies or imports that broke.

**4. Limited tool access** (prevents side effects; makes each role clear)

| Subagent type | Tools |
| --- | --- |
| Research / read-only | Glob, Grep, Read |
| Code reviewer | + Bash (for `git diff`); no Edit or Write |
| Styling / code changes | Edit and Write |

**Summary:** specific description → structured output → obstacle section → only the tools needed.
Together they make a subagent focused, predictable, finished on time, and clear in what it reports.

**Gaps:** video not watched. The two "Open in Claude Code" prompt blocks are paraphrased above, not copied.
