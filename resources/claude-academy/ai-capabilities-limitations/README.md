# AI capabilities and limitations — study notes

Personal study notes for the Claude Academy course
[AI capabilities and limitations](https://academy.claude.com/courses/ai-capabilities-and-limitations)
(13 lessons, 1 quiz, completion badge).

These are my own summaries, not a copy of the course. Open the lesson links for the videos,
transcripts, full exercise text and the interactive simulations.

## Source and license

- Course © Anthropic. The course page text I used does not state a license.
- These notes are personal summaries for non-commercial training use.

## The framework in one page

The 4D Framework (see [AI Fluency notes](../ai-fluency/README.md)) describes what **you** do:
human competencies. This course describes the machine side: **four properties** of generative
AI. The same mechanism gives each property both a capability and a limitation, so the goal is
**calibrated trust**: find where your task sits on each continuum, then verify and add context
to match. The properties stay stable as models improve; only the boundaries move.

Generative AI = transformer-based models that **produce new content** one token at a time (not
the sorting/ranking AI in spam filters or recommendations).

| Property | Guiding question | Capability zone | Limitation zone |
| --- | --- | --- | --- |
| Next Token Prediction | Where do AI answers come from? | Well-worn paths: summarize, reformat, explain common concepts | Novel territory, sparse patterns, "true vs. sounds true" |
| Knowledge | What does AI actually know? | Frequent, recent-in-training, consistent: mainstream topics, popular languages | Rare, post-cutoff, niche, local, or contested topics |
| Working Memory | What is the AI paying attention to right now? | Material fits comfortably, session is current, you supply relevant context | Very long docs or conversations, expecting cross-session continuity (the cliff) |
| Steerability | How much am I in control? | Short, concrete, verifiable instructions ("respond as a table," "under 100 words") | Long reasoning chains, abstract asks, native precision |

Training leaves fingerprints: pretraining makes a document completer; fine-tuning adds
assistant behavior but also sycophancy, verbosity, over-caution and loose confidence.

How it pairs with the 4Ds:

| 4D | Connected property |
| --- | --- |
| Delegation | Knowledge: where the model is well-stocked or thin |
| Description | Working Memory and Steerability: how to structure context and write goals |
| Discernment | Next Token Prediction, and failure diagnosis in Lesson 12 |
| Diligence | Not tied to a single property in these lessons |

Most real failures are **two properties colliding** (e.g. Next Token Prediction + Knowledge =
hallucinated specifics; Working Memory + Steerability = long-chat drift). Name the pair, then
pick the fix.

## Lessons

| # | Lesson | Notes |
| --- | --- | --- |
| 1 | [Intro to AI Capabilities and Limitations](https://academy.claude.com/courses/ai-capabilities-and-limitations/intro-to-ai-capabilities-and-limitations) | [01-introduction.md](01-introduction.md) |
| 2 | [What We Mean by AI](https://academy.claude.com/courses/ai-capabilities-and-limitations/what-we-mean-by-ai) | [01-introduction.md](01-introduction.md) |
| 3 | [How AI Gets Its Character](https://academy.claude.com/courses/ai-capabilities-and-limitations/how-ai-gets-its-character) | [01-introduction.md](01-introduction.md) |
| 4 | [Next Token Prediction](https://academy.claude.com/courses/ai-capabilities-and-limitations/next-token-prediction) | [02-next-token-prediction.md](02-next-token-prediction.md) |
| 5 | [Try It Out: Next Token Prediction](https://academy.claude.com/courses/ai-capabilities-and-limitations/try-it-out) | [02-next-token-prediction.md](02-next-token-prediction.md) |
| 6 | [Knowledge](https://academy.claude.com/courses/ai-capabilities-and-limitations/knowledge) | [03-knowledge.md](03-knowledge.md) |
| 7 | [Try It Out: Knowledge](https://academy.claude.com/courses/ai-capabilities-and-limitations/try-it-out-31vzkl2dgi907) | [03-knowledge.md](03-knowledge.md) |
| 8 | [Working Memory](https://academy.claude.com/courses/ai-capabilities-and-limitations/working-memory) | [04-working-memory.md](04-working-memory.md) |
| 9 | [Try It Out: Working Memory](https://academy.claude.com/courses/ai-capabilities-and-limitations/try-it-out-q7hdjm9twcbt) | [04-working-memory.md](04-working-memory.md) |
| 10 | [Steerability](https://academy.claude.com/courses/ai-capabilities-and-limitations/steerability) | [05-steerability.md](05-steerability.md) |
| 11 | [Try It Out: Steerability](https://academy.claude.com/courses/ai-capabilities-and-limitations/try-it-out-y02xgkpa6wa7) | [05-steerability.md](05-steerability.md) |
| 12 | [When Properties Collide](https://academy.claude.com/courses/ai-capabilities-and-limitations/when-properties-collide) | [06-putting-it-together.md](06-putting-it-together.md) |
| 13 | [Next Steps](https://academy.claude.com/courses/ai-capabilities-and-limitations/next-steps) | [06-putting-it-together.md](06-putting-it-together.md) |

Lessons 5, 7, 9 and 11 are interactive "Try It Out" simulations; my notes only summarize what
each teaches, so use the course page for the full interactive. The course quiz and completion
badge are on the course page; they are not covered here.

## Diligence statement

I wrote these notes with Claude (Opus 5.5 orchestrating, Sonnet drafting). Claude read the
course pages via Claude in Chrome and drafted summaries in its own words. I'm responsible for
checking them against the course.
