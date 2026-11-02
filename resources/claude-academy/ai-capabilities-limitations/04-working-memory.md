# Lessons 8–9: Property 3 — Working Memory

Question: **What is the AI paying attention to right now?**

## Lesson 8 — Working Memory (6 min video, 25 min lesson)

- Everything the AI attends to sits in a fixed-size workspace: the **context window**. It
  cannot attend to anything outside it.
- Unlike the other properties, this one has a **cliff**, not a slow slope: it works until it
  does not. Failure can be **silent truncation**, with no warning.
- The model does **not learn from your corrections**. It only responds to what is in context
  now.
- Lesson opens with a guess: how closely do you check an AI review of a 50-page contract?

| Zone | Situation |
| --- | --- |
| Capability | Material fits comfortably, session is current, you supply relevant context |
| Limitation | Very long documents or chats, expecting memory across sessions, key info buried in the middle |

- Context-as-leverage habits: **front-load** important material, **chunk** long work,
  **re-supply** critical context, start fresh when needed.
- Features that push the cliff out: memory, compaction, projects/workspaces, larger windows,
  multi-agent workflows.
- **4D connection:** Working Memory is what **Description** acts on. Knowing how the window
  works shows how to structure context.

**Exercise: The before-and-after**
1. Pick a task that needs context only you hold (style guide, past good example, constraints).
   Write 2–3 lines on what "good" looks like, clear enough for a stranger to judge.
2. Probe 1 (cold vs. context): run the bare request, then a fresh chat with your context up
   front. Compare both to your "good" definition.
3. Probe 2 (lost in the middle): bury one key instruction in the middle of a long text, ask a
   question that depends on it. Then move it to the top and ask again.
4. Probe 3 (blank slate): teach or correct the AI in one chat, then ask in a brand-new chat as
   if it remembered.
5. Annotate your task list: which tasks need standing context (project, saved instructions,
   uploaded docs), and which work cold?
6. Stretch: set up a memory/project feature with the Probe 1 context and re-run.

**Reflect:**
- How much did front-loading context change quality? Bigger gap than expected?
- What standing context will you set up this week so you stop re-explaining?

## Lesson 9 — Try It Out: Working Memory (10 min, interactive)

Full interactive: [try-it-out](https://academy.claude.com/courses/ai-capabilities-and-limitations/try-it-out-q7hdjm9twcbt)

Title: "Context degradation: when more context makes things worse."
- A memory test: you see 15 words, one at a time, then type what you remember. A chart shows
  recall by position.
- Result is the **serial position effect**, a U-shaped curve: you remember the start
  (primacy) and the end (recency), and lose the **middle**.
- LLMs show the same pattern. A 2023 Stanford study found accuracy was best when a key fact
  was at the start or end and dropped by more than 30% when buried in the middle. Attention
  in transformers weights the edges of the window more.
- Practical rules:
  - Put the most important instruction at the **beginning and end** of the context.
  - If a constraint must be followed, state it early and **repeat it near the end**.
  - "More context" is not always better: each item you add pushes others into the middle.
    Curate, place on purpose, repeat what matters.
