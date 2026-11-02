# Lessons 4–5: Property 1 — Next Token Prediction

Question: **Where do AI answers come from?**

## Lesson 4 — Next Token Prediction (4 min video)

- Generative AI is closer to a very powerful **autocomplete** than a search engine. It writes
  word by word (token by token) based on what tends to follow what.
- That one property gives you both the **fluency** and the **hallucination**.
- Lesson opens with a quick guess: how closely must you check an AI summary of a long report?
  (Pick on a 5-step scale: trust it, spot-check, check details, verify carefully, high risk.)

| Zone | Tasks |
| --- | --- |
| Capability | Patterns seen many times: summarize, reformat, explain common concepts |
| Limitation | Novel or sparse territory; anywhere you must tell "true" from "sounds true" |

- Fabrication concentrates in **specifics**: names, dates, statistics, citations, URLs, quotes.
  The more precise the claim, the more you should verify.
- Product features that push the limit outward: citations, uncertainty signaling, constrained
  generation, generator-verifier loops.
- **4D connection:** this is the base of **Discernment**. Knowing the output was *generated*
  tells you what kind of scrutiny to apply.

**Exercise: The verification test**
1. Pick the task where you are the domain expert. Write five checkable facts you know are
   true (job title, date, statistic, spec, quote, URL).
2. Probe 1 (capability zone): ask AI to explain a well-known concept. Notice the smooth,
   confident, mostly right answer.
3. Probe 2 (specificity): ask for five checkable specifics (three sources, an author, exact
   figures, a URL). Check each and score out of five. Note how confident it sounded when wrong.
4. Probe 3 (sampling): repeat Probe 2 in a fresh chat. What stayed the same, what changed?
   The variation is sampling at work.
5. Stretch: repeat Probe 2 with citations on (e.g. Research mode). Does the score change?

**Reflect:**
- Would you catch fabrications in a field you do not know well?
- Which of your tasks sit in the capability zone, and which need verification of specifics?

## Lesson 5 — Try It Out: Next Token Prediction (5 min, interactive)

The full interactive is on the course page:
[try-it-out](https://academy.claude.com/courses/ai-capabilities-and-limitations/try-it-out).
Only the first screen was captured, so this is a short summary of what it teaches.

- You build a tiny **Markov chain** text predictor, like phone autocomplete: tally which word
  follows which in a few messages (a frequency table), turn rows into probabilities, then
  **sample** the next word.
- You see "scale it up" (more messages, bigger table) and the **knobs** for choosing words:
  always pick the top word, pick by probability, boost likely words (temperature), cut off low
  probabilities (top-p), or keep only the top N (top-k).
- The bridge to LLMs: same idea (read context → get probability distribution → sample), but
  an LLM reads the whole conversation and computes the distribution with a large neural
  network, not a table lookup. Sampling is the same; training is very different.
- History note: Markov idea 1906, n-gram phone prediction around 2010, neural networks from
  about 2015, transformers 2017.
