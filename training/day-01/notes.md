# Day 01: Mental model and Claude basics

## Progress
- [x] Setup: claude.ai login, desktop app, repo cloned
- [x] Git: branch, commit, push
- [x] Course: Claude 101 lessons 1 to 6 (lesson 7 is already done, and 8 to 13 plus the quiz and badge are on Day 2)
  - [x] 1 [What is Claude](https://academy.claude.com/courses/claude-101/what-is-claude)
  - [x] 2 Your first conversation with Claude
  - [x] 3 Getting better results
  - [x] 4 How you'll work with Claude on your desktop
  - [x] 5 Introduction to projects
  - [x] 6 Creating with artifacts
- [~] 3 chat tasks in [exercises/](exercises/README.md). Task 1 done (5/5), Task 2 done (5/5), Task 3 (drafting) has v1 scored 1/5 and the v2 response is pending, so it moves to Day 2.
- [x] Debrief: Learned is written. Surprises and the Task 3 prompt get added when Task 3 is done.

## Lesson 1: What is Claude
- Claude is an AI assistant for life and work, far more than a chatbot. It is steerable, collaborative, very intelligent, and available on the web, in an app and in a CLI.
- Claude is good at five things:
  1. Content creation
  2. Research and analysis
  3. Coding
  4. Problem-solving and reasoning
  5. Learning new things

### Reflection
Idea for work: a company email digest through the Gmail connector.
- Build it as a skill (`email-digest`) plus a scheduled task, so it runs two ways.
  - Automatically on every work day at 08:30 (cron `30 8 * * 1-5`), with the report in the app.
  - On demand, any time ("run my email digest").
- Source: the Gmail connector on the company mailbox. Enable the connector first (Settings → Connectors).
- Draft report format: urgent, needs reply, FYI. One line each, with sender, ask and deadline.
- Read-only. It summarizes and never sends, deletes or archives. It asks before any action.
- Build on Day 7 (skills), schedule on Day 9 (desktop scheduled task). Connector basics come on Day 8.
- Open questions: which label or inbox scope? Skip newsletters? Deliver the report in the app or by email to myself?

## Lesson 2: Your first conversation with Claude
1. Claude brings the intelligence. We bring the context and expertise that make the work good.
2. Talk to Claude like a co-worker: natural, concise, conversational.
3. Better results come from three things. Set the stage with a role, objectives and context. Define the task: write, analyze, build. Specify the rules: tone, style, examples.
4. Add context with uploads and connectors.
5. Claude personalizes through memory and skills.

## Lesson 3: Getting better results
1. A response that isn't what you expected is normal. It's a chance to refine.
2. Common problems and fixes:
   1. Too generic: add details such as role, constraints and context.
   2. Too long or too short: be explicit ("50 words", "2 paragraphs").
   3. Wrong format: show an example.
   4. Confident but wrong: ask for citations or ask it to search.
   5. Wrong tone: describe the tone in detail.
3. The first prompt rarely works alone. Treat it as a conversation, keep the first response as a starting point, then give feedback. If the conversation goes off track, reset (clear or start a new session) and restate everything with the Stage / Task / Rules framework.
4. The AI Fluency 4D framework:
   1. Delegation: understand your goals, know what AI can do, decide which work is yours, the AI's or shared.
   2. Description: communicate with the AI. Define a clear output, guide its process, specify the behavior and interaction you want.
   3. Discernment: evaluate the output, the process and the behavior for quality, accuracy and areas to improve.
   4. Diligence: use AI responsibly and ethically.
5. To evaluate Claude for your workflow, gather examples, test the prompt, compare outputs, then refine.
6. Video takeaways:
   1. Pick a specific task to delegate.
   2. Find past data where you already did that task.
   3. Work with the AI to reproduce your past process, and evaluate the results systematically.
   4. Find the gaps, refine the delegation, and test again.

### Reflection
1. The problems I meet most are responses that are too generic and too long. Next time I'll be more specific about the rules and the output format in the prompt.
2. Evaluate Claude against my own completed work.
3. The 4D framework shows that working well with Claude takes learning. I need to know its capabilities and my goals, describe the task well, evaluate the results and use AI responsibly.

## Lesson 4: How you'll work with Claude on your desktop
The Claude desktop app has three shapes of work. Knowing which one you're in makes the work go better.

### 1. Turn by turn: work with Claude
The most common and basic shape is a back-and-forth conversation: ask, answer, steer, revise. We think together with Claude.
- Use it when the answer changes what you ask next, when you want to stay in the loop, or when the task is quick.
- Good for unfamiliar topics, drafting and rephrasing emails, talking an idea through, and working with documents, brainstorming and checking.
- Product: the desktop Chat tab (like claude.ai) with quick entry, screenshots, window sharing, dictation and connectors.

### 2. Hand off: delegate a whole piece of work
Describe the outcome (a brief, a formatted deliverable, a scheduled task). Claude plans it, does it and comes back with the result. My job is to review the plan and review the output, not to do the steps myself.
- Use it when the task has several steps you'd normally do in sequence, when the output is finished files delivered where you need them, when the work spans your tools, or when it should run on a schedule or while you do something else.
- Handing off doesn't mean stepping away. Claude first asks a few questions to pin down scope and format, then shows its plan. You can watch progress and steer at any point, and it stops to ask permission before actions that matter.
- Good for querying across all your tools, a huge folder of documents, and repeated workflows or scheduled tasks.
- Product: Cowork, with local folder access, scheduled tasks, subagents, projects, browser use, computer use and plugins. A plugin bundles skills, connectors and agents for one kind of work.

### 3. Build software: Claude Code
Claude works in the codebase. It reads, writes, tests, runs commands, previews changes and tracks work through git. It's for developers.
- Local (pick a folder) or cloud (connect a GitHub repo).
- Permission modes: manually approve, accept edits, plan.
- Product: the desktop Code tab.

### Choosing the shape
| Doing | Shape | Use |
|---|---|---|
| Ask, brainstorm, draft, think. Quick and turn by turn. | Turn by turn | Chat (quick entry, dictation, screenshots) |
| A multi-step task that ends in a finished deliverable, spans tools, or runs on a schedule | Hand off | Cowork (folder access, connectors, scheduled tasks, subagents) |
| Write, test, run, ship code | Build software | Code tab (local or cloud) |

### Reflection
1. Log my daily work in detail, then pick the repeated parts to automate as hand-off tasks. First candidates are a morning inbox triage, a daily briefing and a weekly roundup.
2. Once the kit grows, bundle the skills and connectors into a plugin.

## Lesson 5: Introduction to projects
- A project is a self-contained workspace with its own memory, chat history, knowledge base and custom instructions. Each work stream gets its own environment.
- Knowledge improves Claude's understanding. Upload the relevant documents.
- Instructions guide Claude's behavior (tone, expertise level, response style) and apply to every conversation in the project.
- It scales on its own. When the knowledge base nears the context limit, Claude switches to searching it and pulls only what's relevant. Capacity grows up to 10x with the same response quality.
- Work users can collaborate in a project.

### Reflection
- A "Training Report" project: keep all my reports in one place, with the report format as the instructions.
- A big feature or a project analysis can be a project, so I reuse its resources and instructions.

## Lesson 6: Creating with artifacts
- Artifacts are the output you care about: a document, deck, design, dashboard or prototype.
- Claude's Design, Slides and Docs make common work deliverables as files you can download.
- An artifact is different. It opens and updates inside Claude and can be shared by link.
- Tips: ask for the deliverable, not just the content. Be specific about what you want. Describe the end user. Build on work you've already done. Refresh the data when you need it current.

### Reflection
- I already made an artifact for the email training-report skill.
- Question: should I make a daily project-status artifact and update it every day, given that my daily notes already live in the project repo? The answer:
  - Keep the repo (`TODO.md`, `training/day-NN/notes.md`) as the source of truth.
  - An artifact pays off only when someone else reads it, or when you want a nicer view than markdown. Regenerate it from the repo on request ("update my status page") instead of editing it by hand each day.
  - Otherwise skip it. A page nobody opens is one more thing to keep current.
  - The plan already has two artifact exercises: a PR walkthrough on Day 6 and a personal playbook, "how I work with Claude", on Day 15.

## Learned
- A prompt with rules is essential to get what you expect. The rules (a length cap, an output format) stop long, unstructured answers.
- Say what to do when information is missing. This avoids hallucination.
- To check code, ask Claude to trace it on a concrete input. This forces it to think step by step and follow the code, not just describe it.

## Prompts that worked
- Bug summary for a ticket (Task 1, v4, scored 5/5). Full log in [exercises/01-bug-summary/log.md](exercises/01-bug-summary/log.md).
  ```
  I'm a developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
  Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guess); no fixes yet.
  Line 1: what a user sees and when it starts. If the ticket doesn't say, label it Suspected.
  <paste ticket>
  ```
  It works because it has a role and purpose, a task, rules (a length cap, Known/Suspected labels, no fixes) and a fallback for missing information.
- Explain code and prove it (Task 2, v3, scored 5/5). It is the v2 prompt (a role, "explain how X and Y work together", at most 250 words, one diagram, `file:line` or "unsure", 3 self-check questions) plus this: `Then trace <function> by hand with N=5 on this input: <concrete input>. Show the returned list. Is any ToolMessage left without its AIMessage? Quote the lines that decide it.` Full prompt and log in [exercises/02-explain-concept/log.md](exercises/02-explain-concept/log.md).

## Gotchas
- A required field the source doesn't cover makes Claude invent it, and it may label the invention as fact. Always say what to do when information is missing.
- To check code, ask Claude to trace it on a concrete input instead of explaining it. An explanation repeats what the code is meant to do. A trace found the real bug in Task 2. Then confirm it by running the code in a test.
- "Known" claims can still be wrong. In Task 1 v3, Claude said an `AIMessage` was missing when the dump shows it. Check against the source.

## Kit candidates
- `email-digest` skill (Gmail connector, weekdays at 08:30 and on demand) in `ai-kit/.claude/skills/`
- A hand-off trio of morning inbox triage, daily briefing and weekly roundup, later bundled as a plugin
