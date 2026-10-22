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
- [x] 3 chat tasks in [exercises/](exercises/README.md), on `resources/practice/issues/issue-1.md`. Task 1: v2 5/5. Task 2: v2 and v3 4.5/5. Task 3: v2 and v3 4.0/5, plus a hand-edited final message.
- [x] Debrief: Learned, Prompts that worked, Gotchas and Surprises are written.

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
- A prompt with rules is essential to get what you expect. The rules (a length cap, Known/Suspected labels, no fixes) took the bug summary from about 20 lines with a root cause stated as fact to 5 honest lines.
- When you add a required field, say what to do when the source doesn't cover it. Also repeat the format limit, because a new rule can push Claude to explain itself.
- Name the reader and the question. In Task 3, "the PM is not technical, and asked this" took the draft from 1.5 to 4.0, mostly through audience and length, not through facts.
- Context fixes only what depends on it. Adding the facts in Task 3 moved just the date item. Jargon, length and format came from missing rules.
- "Cite the line, or label it general, and say if unsure" (Task 2) makes Claude separate evidence from textbook, so you know what to check.

## Prompts that worked
- Bug summary for a ticket (Task 1, v2, scored 5/5). Full log in [exercises/01-bug-summary/log.md](exercises/01-bug-summary/log.md).
  ```
  I'm a developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
  Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guess); no fixes yet.
  <paste ticket>
  ```
  It works because it has a role and purpose, a task, and rules (a length cap, Known/Suspected labels, no fixes).
- Explain a concept for this case (Task 2, v2, 4.5/5). Full log in [exercises/02-explain-concept/log.md](exercises/02-explain-concept/log.md).
  ```
  I'm a Python/API developer, new to LangGraph, joining an e-commerce agent project. Tomorrow I'll fix the bug in the issue below, so I need to understand how this agent keeps its chat history short.
  Explain, for this case: how the agent loops, what summarization keeps and deletes, and why tool messages make trimming break.
  Rules: max 250 words; one ASCII diagram of the message list; for each claim, point to the line in the issue that supports it, or label it "general LangGraph, can't see your code"; if unsure, say so.
  <paste issue>
  ```
- Reply to a non-technical PM (Task 3, v2, 4.0/5, final message in [exercises/03-drafting/log.md](exercises/03-drafting/log.md)). The shape: who I am, who the reader is, the exact question, then rules (80 words, no bullets, answer both questions first, date as a range plus what it depends on, end with what happens next), then the summary "for you only, don't copy it" and the facts.

Ranked, the three changes that helped most across the tasks:
1. A Rules block with a hard cap and a format (word limit, no bullets, Known/Suspected, one diagram). Biggest jump every time.
2. Naming the reader and the real question, so Claude stops reformatting my notes and answers what was asked.
3. An evidence rule ("cite the line or label it general, say if unsure"), which makes the guesses visible.

## Gotchas
- A prompt with no rules gets a long answer: root cause stated as fact, an unrequested fix list and invented extras (v1).
- Claude can pick a concrete detail it can't check, like "the second orphaned message" for `messages.[1]`. Check such details against the source.
- A new rule can break an old one. The line 1 rule in Task 1 v3 added a preamble, so the reply was six lines (4.5, lower than v2). It happened again in Task 2 v3 (330 words against a 250 cap) and Task 3 v3 (83 words against 80). Repeat the limit whenever you add a rule.
- Claude states checkable details with confidence and gets some wrong. In Task 2 v3 it said "every message in your dump has an `id`", but the `AIMessage` at issue-1.md:31 has none. I only caught it by reading the line.
- Soft words win over a vague rule. Claude kept "should be back in roughly 2 to 3 days" and never wrote "earliest" until a hard rule says to. Say the exact word.
- Claude Chat sometimes returns a draft in a card, and its note only describes it. Ask it to paste the draft as plain text.
- Chat memory leaks context. The first answer in Task 2 knew about the "e-commerce one you're working on" with nothing attached.

## Surprises
- Good: the rules block alone took Task 1 from 4 to 5. The role and purpose mattered less.
- Good: the cite-or-label rule made Claude mark its own guesses ("my inference", "a guess").
- Bad: v3 scored the same as or lower than v2 in all three tasks, because the fix for one gap costs something elsewhere.
- Bad: the claim check was the hardest part. The agent code isn't in the repo, so I could only check Claude against the issue.

## Debrief answers
1. Where Claude beat me: the one-sentence plain cause for the PM ("cuts them in the wrong spot and the assistant fails to reply"), and the ASCII diagram that shows two orphan tool messages at the front.
2. Where it was wrong or confidently off, and how I noticed: the invented "every message has an id" claim (checked issue-1.md:31); the `messages.[1]` index explained as a system prompt (I couldn't verify it, Claude called it a guess); the "second orphaned message" detail in Task 1. I noticed by checking the line, not by the tone.
3. Three prompt changes that helped most: see the ranked list above.
4. Habit to keep: end every prompt with a Rules block that includes the limit, and check at least one claim against the source before I trust it.

## Kit candidates
- `email-digest` skill (Gmail connector, weekdays at 08:30 and on demand) in `ai-kit/.claude/skills/`
- A hand-off trio of morning inbox triage, daily briefing and weekly roundup, later bundled as a plugin
