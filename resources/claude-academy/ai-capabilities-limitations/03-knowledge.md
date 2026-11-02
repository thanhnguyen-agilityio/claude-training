# Lessons 6–7: Property 2 — Knowledge

Question: **What does AI actually know?**

## Lesson 6 — Knowledge (5 min video)

- The model knows only what it saw in training, and it stops at the **knowledge cutoff**.
  By default it has no live browsing and no lived experience.
- Better question than "does it know this?": **how well was this represented in what it read?**
- Lesson opens with a guess: how closely do you check an AI explanation of last week's news?

| Zone | Topics |
| --- | --- |
| Capability | Frequent, recent-in-training, consistent: mainstream topics, popular languages |
| Limitation | Rare, post-cutoff, niche, local, or contested topics |

- Characteristic failures:
  - **Staleness**: old information presented as current
  - **Uneven coverage**: deep on popular topics, thin on others
  - **Inherited bias**: what counts as "default" or "normal" comes from the training data
  - **Source amnesia**: cannot say where a piece of knowledge came from
- Features that patch the gaps: web search, retrieval (RAG, MCPs), tool use.
- **4D connection:** uneven knowledge is core to **Delegation**. It tells you when to hand
  off, when to supply context yourself, and when to go elsewhere.

**Exercise: The outsider test**
1. Pick a task. Write two mainstream, stable topics; two niche, local, recent or fast-changing
   topics; and one "default assumption" outsiders often get wrong in your field.
2. Probe 1 (coverage): ask about one mainstream and one niche topic. Compare depth, accuracy,
   and whether the confidence level changes.
3. Probe 2 (staleness): ask about something that recently changed in your field. Does it
   mention the cutoff, give stale facts as current, or decline?
4. Probe 3 (defaults): ask a question that reveals whether it assumes the outsider's view,
   without stating your assumption.
5. Annotate your task list: can you rely on the model's knowledge, or must you bring it
   (context, documents, search)?
6. Stretch: repeat the staleness probe with web search on.

**Reflect:**
- Where in your work must you supply context instead of assuming the model knows?
- Did the default-assumption probe surprise you?

## Lesson 7 — Try It Out: Knowledge (5 min, interactive)

Full interactive: [try-it-out](https://academy.claude.com/courses/ai-capabilities-and-limitations/try-it-out-31vzkl2dgi907)
Most of the text was captured, but not the interactive parts themselves.

Title: "Visualizing 1024D space". It explains **embeddings**, how retrieval finds meaning:
- Old keyword search matches strings ("car" misses "automobile"); fixes were hand-built
  synonym lists. Embeddings turn text into coordinates so **similar meaning = nearby points**.
- Step by step: place documents on a 2D map (e.g. dinosaurs vs. roller coasters), place a
  question on the same map, retrieve the nearest *k* items (similarity search). Add a third
  axis, then imagine ~1,000 axes. The math still works even though we cannot picture it.
- The axes are **emergent and unlabeled**: you cannot say "dimension 847 means dinosaurs."
  That makes the space hard to interpret.
- An embedding model turns any text (3 words or 3 paragraphs) into a fixed-length list of
  numbers (1,024 values in the example, from VoyageAI).
- Similarity is measured with **cosine similarity** (direction of vectors): -1 opposite,
  0 unrelated, 1 identical.
- Link to the lesson: this is how retrieval/RAG gives the model knowledge it was not trained on.
