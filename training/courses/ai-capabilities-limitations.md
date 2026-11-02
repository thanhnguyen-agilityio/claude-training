# AI Capabilities & Limitations — notes

Course: [Claude Academy](https://academy.claude.com/) · Optional · Progress: 4/13 · In progress

## Lesson 1: Intro to AI Capabilities & Limitations
- **2 training stages:** pre-training, then fine-tuning.
- **4 core properties of generative AI:**
  1. Next token prediction
  2. Knowledge
  3. Working memory
  4. Steerability
- How everything interconnects.

### Exercise: Mapping my current AI use
Keep this list. It comes back in every lesson.

**1. Tasks I used AI for (last two weeks)**
1. Collect and write my journal, give me the scrum note for daily work.
2. Write my project self-review notes together.
3. Rephrase a message before I send it out.
4. Improve old practice: learn the source code and raise the issues found.
5. Loop the SDLC `analysis > plan > code > review > merge` over many issues. Some need evidence that the fix works, some need review to clean up / refactor. Critical ones need my review before merge.
6. Writing-training-reports (email) skill.
7. Email digest skill.

**2. First try or rework?**
- Rephrase worked on the first try.
- Others needed rework with more context, scope, constraints, output format or examples.
- To do: name *which* of these was missing per task (each points to a different property).

**3. How each task can go wrong (asked Claude, checked against my experience)**

| # | Task | How it can go wrong |
| --- | --- | --- |
| 1 | Journal → scrum note | Fills gaps with plausible work I didn't do; blurs done vs. in progress. |
| 2 | Self-review | Too much praise, mirrors my framing (sycophancy); generic strengths. |
| 3 | Rephrase | Small tone/meaning shift ("maybe" → "will"). Read once before sending. |
| 4 | Learn old code, raise issues | Plausible issues that aren't real; misses what it never read. |
| 5 | SDLC loop | Errors pile up across steps; claims "tests pass" without running; early decisions drop out on long runs. |
| 6 | Training-email skill | Invents details I didn't give; format drifts from team style. |
| 7 | Email digest skill | Works on test data, fails on real inbox; mislabels urgent as FYI. |

My own findings (match the list):
- Analysing a bug without the source/trace leads to the wrong direction / guessing.
- A skill like the email digest won't work until it's verified with real data.

### Reflection
- **Safe vs. risky:** rephrasing and drafting the training email feel safe. Sending email or fixing a critical bug feel very risky. Rule: risk follows how hard it is to undo and how many people it reaches, not how hard the task is.
- **Behavior I couldn't explain:** when I ask for analysis, it also proposes a fix.
  - Why (Lesson 3): fine-tuning pushes it to be maximally helpful, and in training data analyses are usually followed by fixes.
  - Fix: say it directly, "Analysis only. Don't propose fixes yet." (Steerability.)

## Lesson 2: What We Mean by AI

### Exercise: Generative or not?

**1–2. Five AI features I used this week, and my call**

| Feature | My call | Check (with Claude) |
| --- | --- | --- |
| Autocomplete | Ranking | ⚠️ Depends: a phone keyboard ranks known words; Smart Compose / code completion generate new text. Same next-word idea as a chatbot, at smaller scale. |
| Spam filter | Classifying | ✅ |
| Chatbot | New content | ✅ |
| Translation | New content | ✅ Modern translation is a transformer writing a new sentence. |
| Recommendations | Ranking | ✅ |

**3. Most likely to fail in a way this course covers:** translation. The output always reads smoothly but I often can't check it ("true vs. sounds true"). Rare words, slang and company terms may also be thin in the model's knowledge (EN ↔ VI).

**4. Tag my Lesson 1 tasks with a property question** — to do.
- Where do the answers come from? (Next Token Prediction)
- What does it know? (Knowledge)
- What's it paying attention to? (Working Memory)
- How much am I in control? (Steerability)

### Reflection
- To do.

## Lesson 3:

## Lesson 4:

## Lesson 5:
