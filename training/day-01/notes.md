# Day 01 — Mental model + Claude basics

## Progress
- [x] Setup: claude.ai login, desktop app, repo cloned
- [x] Git: branch → commit → push
- [~] Course: Claude 101 (13 lessons; rest on Day 2: 7–13 + quiz + badge)
  - [x] 1 [What is Claude](https://academy.claude.com/courses/claude-101/what-is-claude)
  - [x] 2 Your first conversation with Claude
  - [x] 3 Getting better results (do before the 3 chat tasks)
  - [x] 4 How you'll work with Claude on your desktop
  - [x] 5 Introduction to projects
  - [x] 6 Creating with artifacts
- [ ] 3 chat tasks (bug summary / explain concept / drafting) → [exercises/](exercises/README.md)

## Lesson 1 notes — What is Claude
- Claude is an AI assistant for life and work, far more than a chatbot. Designed to be steerable and collaborative, very intelligent, and available in many places: web, app, CLI.
- Claude excels at:
  1. Content creation
  2. Research and analysis
  3. Coding
  4. Problem-solving and reasoning
  5. Learning new things

### Reflection
Work idea to build: **company email digest** via Gmail connector.
- Make it a skill (`email-digest`) + a scheduled task, so it runs two ways:
  - **Auto:** every work day 08:30 (cron `30 8 * * 1-5`) → report in app.
  - **On demand:** run the skill/task manually any time ("run my email digest").
- Source: Gmail connector (company mailbox). Enable connector first (Settings → Connectors).
- Report format (draft): urgent / needs reply / FYI, one line each, sender + ask + deadline.
- Read-only: summarize only, never send/delete/archive. Ask before any action.
- Build when: Day 7 (skills) → schedule on Day 9 (desktop scheduled task); MCP/connector basics Day 8.
- Open Qs: which label/inbox scope? skip newsletters? where to deliver report (in-app vs email-to-self)?

## Lesson 2 notes — Your first conversation with Claude
1. Claude brings the intelligence; we bring the context and expertise that make the work good.
2. Talk to Claude like a co-worker: natural, concise, conversational.
3. Better results = (a) **set the stage**: role, objectives, context · (b) **define the task**: write, analyze, build… · (c) **specify the rules**: tone, style, examples.
4. Add context via uploads and connectors.
5. Claude personalizes through memory and skills.

## Lesson 3 notes — Getting better results
1. A Claude response that isn't what you expected is normal. It's a chance to refine.
2. Common challenges and fixes:
   1. Too generic → add details: role, constraints, context.
   2. Too long/short → be explicit: "50 words", "2 paragraphs".
   3. Doesn't follow the format → show an example.
   4. Confident but wrong → ask for citations or to search.
   5. Tone not right → describe the tone in detail.
3. Iteration mindset: the first prompt rarely works on its own; it's a conversation. Keep the 1st response as a starting point, then give feedback. If the conversation goes off track, reset (clear / new session) and restate all your ideas using the Stage / Task / Rules framework.
4. AI Fluency, the 4D framework:
   1. **Delegation** — understand your goals, know what AI can do, decide which work is yours, AI's, or shared.
   2. **Description** — communicate with AI effectively: define a clear output, guide the AI's process, specify the desired behavior and interaction.
   3. **Discernment** — evaluate the output, the process and the behavior: quality, accuracy, areas to improve.
   4. **Diligence** — use AI responsibly and ethically.
5. Evaluating Claude for your workflow, simple approach: (1) gather examples (2) test the prompt (3) compare outputs (4) refine your approach.
6. Video key takeaways:
   1. Identify a specific task you want to delegate.
   2. Find past data where you already completed that task.
   3. Work with AI to reproduce your past work process; evaluate the results systematically.
   4. Identify gaps, refine your delegation, and test again.

### Reflection
1. The challenges I meet most are responses that are too generic and too long. Next time I'll be more specific in the prompt's rules and output format.
2. Evaluate Claude against my own completed work.
3. The 4D framework shows that collaborating well with Claude takes learning: know its capabilities, know my goals, describe the task well, evaluate the results, and use AI responsibly.

## Lesson 4 notes — How you'll work with Claude on your desktop
Claude desktop app has **3 shapes of work**. Know which one you're in to use it well.

### 1. Turn by turn: work *with* Claude
The most common and basic shape: a back-and-forth conversation. Ask → answer → steer → revise. We think together with Claude.
- **Reach for it when:** the answer changes what you ask next · you want to stay in the loop · it's quick.
- **Try it for:** unfamiliar topics · drafting emails, rephrasing, talking an idea through · working with documents, brainstorming, checking.
- **Product:** desktop **Chat** tab (like claude.ai) + quick entry, screenshots, window sharing, dictation, connectors.

### 2. Hand off: delegate a whole piece of work
Describe the **outcome** (a brief, a formatted deliverable, a scheduled task). Claude plans it, does it, and comes back with the result. My job: **(1) review the plan, (2) review the output**, not do the steps myself.
- **Reach for it when:** the task has several steps you'd normally do in sequence · the output is finished files, delivered where you need them · the work spans your tools · it should run on a schedule or while you do something else.
- Hand-off ≠ stepping away: Claude first asks a few questions to pin down scope and format, then shows the plan. You can watch progress and steer at any point; it stops to ask permission before actions that matter.
- **Try it for:** querying across all your tools · a huge folder of documents · repeated workflows / scheduled tasks.
- **Product:** **Cowork**: local folder access · scheduled tasks · subagents · projects · browser use · computer use · plugins (bundles of skills + connectors + agents for one kind of work).

### 3. Build software: Claude Code
Claude works in the codebase: reads, writes, tests, runs commands, previews changes, tracks via git. For developers.
- **Where:** Local (pick a folder) or Cloud (connect a GitHub repo).
- **Permission modes:** Manually approve · Accept edits · Plan.
- **Product:** desktop **Code** tab.

### Choosing the shape
| Doing | Shape | Use |
|---|---|---|
| Ask, brainstorm, draft, think; quick, turn by turn | Turn by turn | Chat (quick entry, dictation, screenshots) |
| Multi-step task ending in a finished deliverable; spans tools; runs on a schedule | Hand off | Cowork (folder access, connectors, scheduled tasks, subagents) |
| Write, test, run, ship code | Build software | Code tab (local / cloud) |

### Reflection
1. Log my daily work in detail, then pick repeated work to automate as hand-off tasks. First candidates: **morning inbox triage**, **daily briefing**, **weekly roundup**.
2. Once the kit grows, bundle the skills + connectors into a **plugin**.

## Lesson 5 notes — Introduction to projects
- A project is a self-contained workspace with its own memory, chat history, knowledge base and custom instructions. One dedicated environment per work stream.
- **Knowledge** improves Claude's understanding: upload the relevant documents.
- **Instructions** guide Claude's behavior (tone, expertise level, response style) and apply to every conversation in the project.
- **Scales automatically:** when the knowledge base nears the context limit, Claude switches to searching it and pulls only what's relevant. Capacity grows up to 10x with the same response quality.
- Work users can collaborate in a project.

### Reflection
- A **"Training Report" project**: keep all my reports in one place, with the report format as instructions.
- A big feature or **project analysis** can be a project, so I reuse its resources and instructions.

## Lesson 6 notes — Creating with artifacts
- Artifacts are the output you care about: a document, deck, design, dashboard or prototype.
- Claude's Design, Slides and Docs make common work deliverables as files you can download.
- An artifact is different: it opens and updates inside Claude and can be shared by link.
- **Tips:** ask for the deliverable, not just the content · be specific about what you want · describe the end user · build on work you've already done · refresh the data when you need it current.

### Reflection
- I already made an artifact for the email training-report skill.
- Question: should I make a daily project-status artifact and update it every day? My daily notes already live in the project repo. See the answer below.
  - **Keep the repo as the source of truth** (`TODO.md`, `training/day-NN/notes.md`).
  - An artifact is worth it only if someone else reads it, or if you want a view that's nicer than markdown. Then regenerate it from the repo on demand ("update my status page"), not by hand each day.
  - Otherwise skip it. A page nobody opens is one more thing to keep current.
  - The plan already has two artifact exercises: Day 6 (PR walkthrough) and Day 15 (personal playbook "how I work with Claude").

## Learned
-

## Prompts that worked
- **Bug summary → ticket (Task 1, v4, scored 5/5):** full log in [exercises/01-bug-summary/log.md](exercises/01-bug-summary/log.md)
  ```
  I'm a developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
  Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guess); no fixes yet.
  Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected.
  <paste ticket>
  ```
  Why it works: Stage (role + purpose) · Task · Rules (length cap, Known/Suspected labels, no fixes) · a fallback for missing info.
- **Explain code + prove it (Task 2, v3, 4/5):** v2 prompt (role, "explain how X and Y work together", ≤250 words, one diagram, `file:line` or "unsure", 3 self-check questions) **plus** `Then trace <function> by hand with N=5 on this input: <concrete input>. Show the returned list. Is any ToolMessage left without its AIMessage? Quote the lines that decide it.` Full prompt and log: [exercises/02-explain-concept/log.md](exercises/02-explain-concept/log.md).

## Gotchas
- A required field the source doesn't cover makes Claude invent it, and it may mark the invention as fact. Always say what to do when info is missing.
- To check code, ask Claude to trace it on a concrete input, not just explain it. Explanations repeat what the code is meant to do; a trace found the real bug (Task 2). Then confirm with real execution (a test).
- "Known" claims can still be wrong (v3 said an `AIMessage` was missing when the dump shows it). Check against the source.

## Kit candidates
- `email-digest` skill (Gmail connector, weekday 08:30 + on demand) → `ai-kit/.claude/skills/`
- Hand-off trio: morning inbox triage · daily briefing · weekly roundup → later a plugin
