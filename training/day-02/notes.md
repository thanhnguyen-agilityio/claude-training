# Day 02 — Ticket analysis, reproduce & understand

## Progress
- [ ] Exercises: [exercises/](exercises/README.md) (ticket analysis, clarifying questions, run the app, reproduce and failing test, git block)
- [ ] Carried over from Day 1: Task 3 drafting v2 and v3
- [~] Course: finish Claude 101 (lessons 7–13 + quiz + badge)
  - [x] 7 Working with skills (done early, on Day 1)
  - [ ] 8–13 Connecting tools, Enterprise search, Research, Use-cases by role, Other ways, What's next · quiz · badge

## Lesson 7 notes — Working with skills
- A skill is a folder of instructions, scripts and resources that Claude loads dynamically to do better on a specialized task.
- Two types: **Anthropic skills** and **custom skills**.
- Turn them on in the desktop app under Settings.
- Claude loads and uses a skill automatically, based on your prompt.
- Best results: **create the skill with Claude**.
- **Skills vs projects:** a project stores knowledge; a skill performs a task.

### Reflection
- I already made many custom skills at work: write training report, optimize skill, PR description, and others. These can go into `ai-kit/`.
- Link to lesson 5: `writing-training-reports` is the skill (does the task); a "Training Report" project would hold the knowledge (past reports). They work together.
- Link to Day 7 of the plan: skills get built properly there (team skill + personal command, PR into `.claude/`). The kit already has `writing-training-reports`, `optimize-skill`, `review-checklist`, `repro-bug`.

## Carried over from Day 1
- Task 1 and Task 2 point at the same bug: `handle_keep_recent_messages` (`utils.py:156-185`) collects tool-call ids from the recent `AIMessage`s instead of the recent `ToolMessage`s, so a cut can leave an orphan `ToolMessage`. Second suspect: `trim_messages` in `Assistant` has no `start_on`. **Day 2 job:** reproduce with real LangChain and write the failing test.

## Learned
-

## Prompts that worked
-

## Gotchas
-

## Kit candidates
-
