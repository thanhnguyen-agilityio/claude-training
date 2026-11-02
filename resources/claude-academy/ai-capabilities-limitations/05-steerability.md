# Lessons 10–11: Property 4 — Steerability

Question: **How much am I in control?**

## Lesson 10 — Steerability (5 min video, 25 min lesson)

- The model follows instructions the same way it does everything else: by continuing a
  pattern. So it is very steerable, but there is always a **gap between what you meant and
  what you got**. Most interesting failures live in that gap.
- Works because fine-tuning taught instruction-following. Has limits because instructions are
  followed by pattern-matching, not understanding.
- Lesson opens with a guess: how closely do you check "write exactly 100 words"?

| Zone | Instructions |
| --- | --- |
| Capability | Short, concrete, verifiable: format specs, length limits, explicit roles |
| Limitation | Long reasoning chains, abstract or vague asks, native numerical/logical precision |

- Characteristic failures:
  - **Reasoning drift**: small errors early on grow through the chain
  - **Letter over spirit**: the instruction is followed, the intent is missed
  - **Brittle arithmetic**: math done by pattern, not calculation
- Features that help: system prompts, code execution, visible reasoning, structured outputs.
- If an instruction is followed literally but uselessly, **restate the goal**. Repeating the
  instruction louder does not close the gap.
- **4D connection:** Steerability is what makes **Description** powerful and also what limits
  it. Knowing the gap between words and intent changes how you write prompts and where you add
  checkpoints.

**Exercise: The goal rewrite**
1. Pick a multi-step or format-specific task. Write the goal in one sentence (what you want
   to achieve, not the format). Example goal: "Convince my team the timeline is realistic."
   Example format: "Three bullet points."
2. Probe 1 (tight control): give a short, checkable instruction (three-column table, exactly
   five bullets, second person). Did it hold exactly?
3. Probe 2 (reasoning drift): ask for a version with 4–5 dependent steps and review each step.
   Then ask it to stop and show step 2 before continuing. Compare with and without a
   checkpoint.
4. Probe 3 (letter vs. spirit): give an instruction that can be met literally but uselessly
   ("make this shorter" when structure is the problem). Then add your goal to the
   instruction and compare.
5. Mark where multi-step tasks need a checkpoint, and write the goal statement to add to tasks
   where you only gave a format.

**Reflect:**
- How often do you state format but not goal? What changes when you give both?
- Which recurring task will get a mid-process checkpoint this week?

## Lesson 11 — Try It Out: Steerability (5 min, interactive)

Full interactive: [try-it-out](https://academy.claude.com/courses/ai-capabilities-and-limitations/try-it-out-y02xgkpa6wa7)
Only the first screen was captured.

Title: "Letter vs. spirit."
- Three workplace scenarios with vague editing requests: "Make it shorter," "Make it more
  professional," "Add more detail." For each, you see Claude's **literal result**, the **goal
  it missed**, and an **improved version** where the goal is stated.
- Lesson: instructions are honored by pattern-matching, not understanding. There is always room
  between your words and your intent, so unstated intent gets lost. Say the goal.
