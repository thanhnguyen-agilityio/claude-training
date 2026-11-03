# Day 5, Block 3: fresh vs. primed (ticket #48)

Ticket: [#48 Unit test run fail](https://github.com/thanhnguyen-agilityio/claude-training-practice/issues/48). CI collection crashes because `chromadb` loads `onnxruntime`, and the pinned wheel can't load on the Ubuntu runner.

## Setup

- Base commit for both runs: `7157b2f` (main, CLAUDE.md removed).
- **A, fresh:** worktree from `day5-A-fresh`, so no project CLAUDE.md. User-level rules (`english-rephrase.md`) and auto-memory still loaded (223 tokens of memory files).
- **B, primed:** worktree from `day5-B-primed`, which is `7157b2f` plus one commit restoring CLAUDE.md (same text as `a82f689`). It got the priming prompt first, then the same ticket prompt.
- Same model and effort in both (Opus 5.5). Each worktree is new, so neither had a `.env`.
- Not completely blind: I had already tried #48 (stash on `fix/issue-48-onnx-import`, same lazy-import idea). Neither session saw that stash.

## Comparison

| Row | A: fresh | B: primed |
|---|---|---|
| Questions Claude asked | 0 | 0 |
| Files touched | `server/agent/rag/retriever.py` (+4/−2), new `server/tests/test_import_no_onnxruntime.py` (22 lines) | `server/agent/rag/retriever.py` (+4/−2), new `server/tests/test_import_without_onnxruntime.py` (30 lines) |
| Files that shouldn't have changed | None | None |
| Wrong assumptions | None that cost anything. It read `.github/workflows/ci.yml` for the test commands and ran `uv run --with pytest python -m pytest tests` from `server/`. It ran only the server suite, plus ruff. | 1. It ran CLAUDE.md's command `uv run --env-file ../.env ...`, but the worktree had no `.env`, so the server and client suites errored. It recovered by dropping `--env-file`. It then ran all three suites and ruff, as CLAUDE.md requires. |
| Test fails before / passes after | Yes. It asserts `onnxruntime` is not in `sys.modules` after `import agent.graph`, run in a subprocess. | Yes. It blocks `onnxruntime` with a `meta_path` hook, then imports `agent.graph` in a subprocess. This reproduces the CI failure mode more closely. |
| Context `/context` start → end | ~71.0k → **83.4k** (Messages 12.4k) | ~71.5k → **80.2k after priming** → **92.6k** (Messages 8.7k priming + 12.5k ticket) |
| API tokens (summed from transcript) | output 6.1k, cache write 41.1k, cache read 971k | priming: output 2.1k, cache write 37.8k, cache read 502k. Total: output 8.1k, cache write 50.3k, cache read 1,472k |
| Cost (estimate*) | ≈ $0.89 | priming ≈ $0.54, ticket ≈ $0.72, total ≈ $1.25 |
| Quality (1–5) | **4**: correct minimal fix, real failing test, ruff clean. Only the server suite was run, and it committed without being asked. | **4**: same fix, a slightly better test, and all suites run. It hit the `.env` false start, made a new branch, and committed without being asked. |

*Estimate at assumed Opus rates: $5/M input, $6.25/M cache write, $0.50/M cache read, $25/M output. `/cost` can't be read from outside a session. Run `/cost` in each session for the exact figure.

First run (before this re-run), read from `/cost` in each session: A 52.5k → 77.3k, $0.39; B ended at 79k, $0.33. That run had B cheaper, the opposite of the estimate above, so check `/cost` before trusting the cost verdict.

Notes:
- Both runs made the same diagnosis and the same 6-line fix: move the `chromadb` and `langchain_chroma` imports inside `get_retriever()`. Both pointed out that the real root cause is the `onnxruntime==1.15.0` pin. Neither bumped it, because the rules said minimal diff and no dependency changes.
- B's ticket phase cost about the same as all of A. Priming was pure overhead: about 9k extra context and about $0.54.
- What CLAUDE.md changed: B knew about "all three suites + ruff" and "one ticket per branch". It also inherited one wrong assumption from CLAUDE.md: that `.env` exists at the repo root.

**Verdict:** For this ticket, priming wasn't worth its cost. A got to the same fix with no questions for about 30% fewer tokens. CLAUDE.md made the checks more complete (all three suites), not the fix better.
