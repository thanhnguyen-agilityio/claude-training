# Lessons 1–4: Meet Claude

What Claude is, how to talk to it, how to fix weak answers, and how the desktop app is organized.

## Lesson 1 — What is Claude? (5 min)

- Claude is an AI assistant for life and work, trained with **Constitutional AI**: principles that
  help it avoid harmful or unethical output and behave in a safe, transparent way.
- It is more than a chatbot: a **thinking partner** for summarizing, searching, writing, Q&A,
  coding, analysis and more.
- It is **steerable**: you can direct its personality, tone and behavior.
- Access: apps on all plans (Free, Pro, Max, Team, Enterprise). Chats, projects, memory and
  preferences sync across web, desktop and mobile.

| Capability | What it means |
| --- | --- |
| Writing and content | Emails, posts, reports; iterate on tone and structure |
| Research and analysis | Upload documents; context window 200K+ tokens (about 500 pages), up to 1M on some paid plans and models |
| Coding | Write, debug, explain code in many languages |
| Problem-solving | Math, strategy; **Thinking** lets Claude reason step by step first |
| Learning | **Learning mode** guides your reasoning instead of giving answers |

Ways to access Claude (the course focuses on Claude.ai):

| Tool | What it is |
| --- | --- |
| Claude.ai + mobile/desktop apps | Main place: chat, writing, research, analysis, file creation |
| Claude Code | Agentic coding tool; edits files, runs commands, makes commits |
| Claude Tag | Claude inside Slack (tag it in threads) |
| Claude Design | Turns ideas or sketches into interactive prototypes |
| Claude for Microsoft 365 | Sidebar in Excel, PowerPoint, Word, Outlook |

**Exercise (interactive):** sort six real requests into "search box could do this" or "needs a
thinking partner". Lesson: the wording can hide which one a request really is.

**Reflect:** Which tasks in your calendar could use Claude as a thinking partner?

## Lesson 2 — Your first conversation with Claude (15 min)

**Core idea:** Claude brings the intelligence; you bring the context and expertise. Talk to it
like a coworker: natural, short, conversational.

**Good prompt = 3 parts**

| Part | Question to answer |
| --- | --- |
| Set the stage | What is my role and goal? What context should Claude know? |
| Define the task | What action: write, analyze, build? |
| Specify the rules | Style, tone, format, length, examples? |

Course example: a marketing lead asks for market research for a Series A pitch deck, with web
research and citations, as a report of up to 5 pages with named sections.

**Add context**
- Upload files: PDF, DOCX, CSV, TXT, PNG, JPEG. Claude reads text and visuals (charts, images).
  Use cases: summarize a document, describe an image, find trends in a spreadsheet, explain code.
- In the search and tools menu, turn on web search or connected sources (e.g. Google Drive).
- Choose a model (changing it starts a new chat):
  - **Opus**: most complex tasks (e.g. multi-step financial analysis).
  - **Sonnet**: recommended everyday default, good balance of quality and cost.
- **Extended thinking**: helps with hard problems but is slower; leave it off for simple tasks.
- Tip: Settings > Account > "Instructions for Claude" sets preferences for every chat.
- Note: the "Use style" menu in the video is now deprecated.

**Iterate** (the real power is the back-and-forth)
- Ask follow-ups ("expand point two", "make it shorter").
- Give feedback ("good, but too formal").
- Redirect, or restart in a new chat if it went wrong.
- Pencil icon on your message: edit and resend it.

**Personalizing**
- **Memory**: saves role, preferences, decisions across chats. Manage in Settings > Memory.
  On by default on Free/Pro/Max; off by default on Team/Enterprise (Owner must allow).
- **Skills**: reusable instructions for specific tasks (see Lesson 7).
- The prompt framework comes from the 4D Framework for AI Fluency (see the
  [AI Fluency notes](../ai-fluency/README.md)).

**Exercise:** try a real question or task; use the use-case gallery if you need ideas.

## Lesson 3 — Getting better results (about 15 min)

**Common problems and fixes**

| Problem | Why | Fix |
| --- | --- | --- |
| Too generic | Not enough context | Add audience, role, constraints |
| Too long or short | Claude guesses length | State the length ("under 100 words") |
| Wrong format | It knows what, not how | Show an example or describe the structure |
| Confident but wrong facts | Plausible-sounding errors, esp. niche facts | Verify key facts; ask for sources or confidence; use web search |
| Wrong tone | Default is helpful and professional | Describe tone in plain words; give a sample |

**Iteration mindset**
- The first draft is a starting point, not the final answer.
- Give specific feedback ("cut the first two paragraphs"), not only "shorter".
- If the chat is off track, start a new chat with a clearer prompt.

**AI Fluency (4D):** Delegation (what to give AI), Description (communicate clearly),
Discernment (judge outputs), Diligence (use AI responsibly). The 3-part prompt is Description;
the troubleshooting is Discernment and Diligence. Free AI Fluency course covers it in depth.

**Evals (simple tests for your own work)**
1. Collect 5–10 examples of a task you do often.
2. Write prompts that should produce similar outputs, with the context you would normally have.
3. Compare Claude's output with your own: key info captured? tone right? what is missing?
4. Refine prompts, add examples, or decide that human review is needed.

**Video example (the "delegation-diligence loop"):** a program director re-runs last quarter's
analysis with AI on data he already understands, checks each answer against his known results,
and notes gaps (AI missed a program-type effect until he asked; it needs enrollment dates for
cohort analysis). If AI can match known results, trust it for similar future work; if not after
several tries, do not delegate that task. Validation builds confidence but you stay accountable
and should be open about AI's role. Not good at data? Ask AI to help design the solution
(formulas, cleanup) and keep asking for explanations.

**Exercise:** take a dataset you analyzed by hand, ask Claude to redo it, compare, refine.

**Reflect:** Which problems have you hit? Where would an eval help? How does 4D apply?

## Lesson 4 — Claude on your desktop: Chat, Cowork, Code (about 10 min)

**Core idea:** work comes in three shapes. Know which one you are in before you start.

| Shape | What happens | Where (desktop app) |
| --- | --- | --- |
| Turn by turn | You and Claude go back and forth; thinking happens in the exchange | **Chat** |
| Hand off | You describe an outcome; Claude plans, works, returns a result; you review plan and output | **Cowork** |
| Build software | Claude works in a codebase: reads, writes, tests, runs commands | **Code** tab |

Note: in the new Claude experience there is no separate Chat or Cowork; both kinds of work
happen in any conversation.

**Use turn-by-turn when:** the answer changes your next question; you want to stay hands-on
(draft, edit, think aloud); or the task is quick. Examples: screenshot a dashboard and ask what
it means; outline a presentation by voice; gather scattered notes and work on the gaps.
Chat extras on desktop: quick entry (double-tap Option on Mac), screenshots/window sharing,
dictation (Mac), desktop connectors.

**Use hand-off when:** many steps in order; output should be finished files saved in your folder;
work spans several tools; or it should run on a schedule. You still stay in control: Claude may
ask scoping questions, shows a plan, you can steer, and it asks approval for actions like
sending email. Cowork features:
- Local folder access (reads and saves back to the folder)
- Scheduled tasks (run remotely; keep the app open if they need your local files)
- Subagents (parallel background workers, one final deliverable)
- Projects, browser use (Claude in Chrome), computer use (research preview, Pro/Max), plugins
  (role bundles of skills, connectors, agents; Customize > Plugins)
- Available on Pro, Max, Team, Enterprise.

**Code tab:** local (a folder on your machine) or cloud (GitHub repo; sessions continue when the
app is closed). Permission modes: manually approve, accept edits, plan. Details are in the
Claude Code in Action course; not needed for non-developers.

**Reflect:** Which of your requests this week were really whole tasks you fed in one question at
a time? For the task you most want off your plate, write the *outcome* you would give Claude.
