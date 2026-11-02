# Lessons 1–3: Introduction, what we mean by AI, how AI gets its character

Sets up the course: a mental model of the machine, which kind of AI we talk about, and why the
assistant behaves the way it does.

## Lesson 1 — Intro to AI Capabilities and Limitations (4 min video)

- The 4D Framework teaches **you** how to work with AI. This course shows how AI is able to
  work with you. Together they are one system: human competencies on one side, machine
  properties on the other.
- Course roadmap: what we mean by AI → how AI is trained → the four properties → putting it
  together → next steps.
- Generative AI has four core properties: **Next Token Prediction, Knowledge, Working Memory,
  Steerability**.
- The material lasts because the *properties* stay stable while models improve. The
  boundaries move; the properties do not.

**Exercise: Mapping your current AI use**
1. List 4–6 tasks you really used AI for in the last two weeks (or want to). Be specific.
2. For each, note: did it work on the first try, or did you rework it?
3. Share the list with an AI and ask how each task could go wrong if you are not careful.
   If its answers do not match your experience, push back.
4. Keep the list. You will use it in every lesson.

**Reflect:**
- Which tasks felt safe to hand to AI, which felt risky, and can you say why?
- What AI behavior have you seen that you could not explain?

## Lesson 2 — What We Mean by AI (4 min video)

- Most AI in daily life (spam filters, recommendations, fraud detection) is **not**
  generative. It sorts, ranks or classifies existing content.
- This course is about **generative AI**: transformer-based text models that produce new
  content one token at a time.
- The four properties are shown on a reference card (see the [README](README.md)). Each is a
  continuum from capability to limitation. **The same mechanism gives you both.**
- **Calibrated trust** = find where your task sits on the continuum. Do not trust or distrust
  everything in one block.

**Exercise: Generative or not?**
1. List five AI features you used this week (autocomplete, photo tags, spam filter, chatbot,
   translation, recommendations...).
2. For each, decide: new content, or sorting/ranking/classifying?
3. Ask an AI to check your calls and explain any you got wrong in one sentence. Also ask which
   feature has a failure mode this course will explain.
4. Go back to the Lesson 1 task list and tag each task with the property question that fits:
   Where do answers come from? What does it know? What is it paying attention to? How much am
   I in control? These are predictions to test in the next four lessons.

**Reflect:**
- Did the generative vs. classification idea change how you see any tool?
- Did any task fit more than one property?

## Lesson 3 — How AI Gets Its Character (5 min video)

AI's politeness, helpfulness and caution are trained in. Two stages, each leaving fingerprints.

| Stage | What happens | Result |
| --- | --- | --- |
| 1. Pretraining | Model reads huge amounts of text, learns to predict what comes next | A powerful "document completer" with no idea of helping you |
| 2. Fine-tuning | Human preferences shape it into an assistant: treats input as a request, answers helpfully, declines harmful asks | Helpful, honest, harmless behavior |

**Fingerprints of human-judged training** (they show in every model):
- **Sycophancy**: a pull toward agreeing with you
- **Verbosity**: long answers by default
- **Over-caution**: sometimes hedges or refuses more than the risk needs
- **Loose confidence calibration**: how sure it sounds does not match how reliable it is

**Exercise: Fingerprints on your own work**
Pick one task from your list and run it three ways:
1. *Straight*: prompt as usual, save the output.
2. *Sycophancy test*: open with a wrong assumption ("I think this strategy is bulletproof").
   See if it agrees or pushes back. Then invite disagreement explicitly and compare.
3. *Verbosity test*: ask a question with a one-sentence answer. Then ask again with "Answer in
   one sentence." The length gap is the verbosity default.
4. Optional *caution test*: ask something at the edge of a gray area. Is the hedging
   proportionate to the real risk, or reflexive?
Then decide which fingerprint showed most, and whether naming it in advance changed how you
read it.

**Reflect:**
- Where does sycophancy cost you most? (Anywhere you want honest feedback.)
- Where does verbosity cost you most? (Anywhere you need short answers under time pressure.)
