# Day 01: Mental model and Claude basics

## Progress
- [x] Setup: claude.ai login, desktop app, repo cloned
- [x] Git: branch, commit, push
- [x] Claude 101 lessons 1 to 6 (lesson 7 done earlier; 8 to 13, quiz and badge are Day 2)
- [x] 3 chat tasks in [exercises/](exercises/README.md): Task 1 5/5, Task 2 4.5/5, Task 3 4.0/5 plus a hand-edited final message
- [x] Debrief

## Lesson 1: What is Claude ([course](https://academy.claude.com/courses/claude-101/what-is-claude))
- An AI assistant for life and work, steerable and collaborative, on web, app and CLI.
- Good at content creation, research and analysis, coding, problem-solving, and learning.

Idea for work: an `email-digest` skill plus a scheduled task, weekdays 08:30 (`30 8 * * 1-5`) and on demand.
- Reads the company mailbox through the Gmail connector. Read-only, asks before any action.
- Report sections: urgent, needs reply, FYI. One line each: sender, ask, deadline.
- Skill on Day 7, connector on Day 8, schedule on Day 9.
- Open: which label scope, skip newsletters, deliver in the app or by email.

## Lesson 2: First conversation
- Claude brings the intelligence. I bring context and expertise.
- Talk to it like a co-worker.
- Better results: set the stage (role, goal, context), define the task, specify the rules (tone, style, examples).
- Add context with uploads and connectors. Memory and skills personalize it.

## Lesson 3: Getting better results
- A bad first answer is normal. Refine it.
- Too generic: add role, constraints, context. Too long or short: give a number. Wrong format: show an example. Confident but wrong: ask for citations or a search. Wrong tone: describe it.
- If the chat drifts, restart and restate with Stage / Task / Rules.
- 4D framework: Delegation (what is mine, what is Claude's), Description (clear output and behavior), Discernment (check quality and accuracy), Diligence (use it responsibly).
- To test Claude on a workflow, take a task I already did, have it reproduce my process, compare, refine.

My usual problems are answers that are too generic and too long, so I set the rules and the output format up front.

## Lesson 4: Desktop, three shapes of work
| Shape | Use when | Tool |
|---|---|---|
| Turn by turn | The answer changes the next question: quick asks, drafting, brainstorming | Chat tab |
| Hand off | Several steps, finished files, several tools, or a schedule | Cowork |
| Build software | Write, test, run, ship code. Permission modes: manual, accept edits, plan | Code tab (local or cloud) |

Plan: log my daily work, then turn the repeated parts into hand-off tasks (morning inbox triage, daily briefing, weekly roundup). Bundle them into a plugin later.

## Lesson 5: Projects
- A project is a workspace with its own memory, chat history, knowledge and instructions.
- Instructions apply to every chat in it. A large knowledge base falls back to search.
- Idea: a "Training Report" project with the report format as instructions. A big feature analysis could be another.

## Lesson 6: Artifacts
- An artifact opens and updates inside Claude and can be shared by link. Docs, Slides and Design make downloadable files.
- Tips: ask for the deliverable, be specific, describe the end user, build on earlier work, refresh the data.
- I already made one for the training-report email skill.
- A daily status artifact is not worth it. `TODO.md` and `notes.md` stay the source of truth. Make one only when someone else reads it, and regenerate it on request.
- The plan has two artifact exercises: a PR walkthrough on Day 6 and a personal playbook on Day 15.

## Learned
- Rules matter most. A length cap, Known/Suspected labels and "no fixes" took the Task 1 summary from about 20 lines with the cause stated as fact to 5 honest lines.
- Name the reader and the question. In Task 3, "the PM is not technical and asked this" took the draft from 1.5 to 4.0.
- Context fixes only what depends on it. In Task 3 the facts gave v1 a date and nothing else. Jargon, length and format needed rules.
- "Cite the line, or label it general, and say if unsure" makes Claude separate evidence from textbook (Task 2).
- When a rule needs a field the source may not have, say what to do when it's missing. Repeat the length limit whenever a rule is added.

## Prompts that worked
Ranked across the tasks:
1. A Rules block with a hard cap and a format (word limit, no bullets, Known/Suspected, one diagram). The biggest jump every time.
2. Naming the reader and the exact question, so Claude stops reformatting my notes.
3. An evidence rule: cite the line or label it general, say if unsure.

Bug summary for a ticket (Task 1 v2, 5/5, [log](exercises/01-bug-summary/log.md)):
```
I'm a developer who just joined the e-commerce agent project, and I need to paste the summary into the ticket. Summarize the bug in the ticket below.
Rules: max 5 lines; label each line Known (shown in the ticket) or Suspected (a guess); no fixes yet.
<paste ticket>
```

Explain a concept for this case (Task 2 v2, 4.5/5, [log](exercises/02-explain-concept/log.md)):
```
I'm a Python/API developer, new to LangGraph, joining an e-commerce agent project. Tomorrow I'll fix the bug in the issue below, so I need to understand how this agent keeps its chat history short.
Explain, for this case: how the agent loops, what summarization keeps and deletes, and why tool messages make trimming break.
Rules: max 250 words; one ASCII diagram of the message list; for each claim, point to the line in the issue that supports it, or label it "general LangGraph, can't see your code"; if unsure, say so.
<paste issue>
```

Reply to a non-technical PM (Task 3 v2, 4.0/5, final message in [log](exercises/03-drafting/log.md)). The shape is who I am, who the reader is, the exact question, then rules (80 words, no bullets, answer both questions first, date as a range plus what it depends on, end with what happens next), then the summary "for you only, don't copy it" and the facts.

## Gotchas
- A prompt with no rules gets a long answer: root cause as fact, an unrequested fix list, invented extras.
- A new rule breaks an old limit. Every v3 added a rule and went over the cap (preamble, 330 words vs 250, 83 vs 80). Repeat the limit.
- Claude states checkable details with confidence. It said "every message in your dump has an `id`", but the `AIMessage` at issue-1.md:31 has none. I found it only by reading the line.
- Soft wording stays. Claude kept "should be back in roughly 2 to 3 days" and never wrote "earliest". Name the exact word.
- Chat sometimes returns a draft in a card with only a note in the reply. Ask for plain text.
- Chat memory leaks context. The first Task 2 answer knew about the e-commerce project with nothing attached.

## Surprises
- Good: the rules block alone took Task 1 from 4 to 5. Role and purpose mattered less.
- Good: the cite-or-label rule made Claude mark its own guesses.
- Bad: v3 scored the same as or lower than v2 in all three tasks. Fixing one gap cost something else.
- Bad: claim checks were hard. The agent code isn't in the repo, so I could only check against the issue.

## Debrief
1. Claude beat me on the one-sentence plain cause for the PM ("cuts them in the wrong spot and the assistant fails to reply") and on the ASCII diagram showing two orphan tool messages at the front.
2. It was wrong on "every message has an id" (checked issue-1.md:31), on `messages.[1]` as a system prompt (unverifiable, Claude called it a guess), and on "the second orphaned message" in Task 1. I caught them by checking the line, not by the tone.
3. Top three prompt changes: see the ranked list above.
4. Habit to keep: end every prompt with a Rules block that includes the limit, and check one claim against the source before trusting it.

## Kit candidates
- `email-digest` skill (Gmail connector, weekdays 08:30 and on demand) in `ai-kit/.claude/skills/`
- Morning inbox triage, daily briefing and weekly roundup as hand-off tasks, later bundled as a plugin
