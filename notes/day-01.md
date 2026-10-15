# Day 01 — Mental model + Claude basics

## Progress
- [x] Setup: claude.ai login, desktop app, repo cloned
- [x] Git: branch → commit → push
- [~] Course: Claude 101 (13 lessons; rest on Day 2: 7–13 + quiz + badge)
  - [x] 1 [What is Claude](https://academy.claude.com/courses/claude-101/what-is-claude)
  - [x] 2 Your first conversation with Claude
  - [x] 3 Getting better results (do before the 3 chat tasks)
  - [x] 4 How you'll work with Claude on your desktop
  - [ ] stretch: 5 Introduction to projects · 6 Creating with artifacts
- [ ] 3 chat tasks (bug summary / explain concept / drafting)

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

## Learned
-

## Prompts that worked
-

## Gotchas
-

## Kit candidates
- `email-digest` skill (Gmail connector, weekday 08:30 + on demand) → `ai-kit/.claude/skills/`
- Hand-off trio: morning inbox triage · daily briefing · weekly roundup → later a plugin
