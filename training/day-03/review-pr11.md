# Review: practice PR #11 (keep-recent orphan ToolMessage fix)

Checklist: `ai-kit/.claude/skills/review-checklist` (correctness → tests → readability → security → scope).

1. **Correctness, `server/agent/graph.py:44`.** `Assistant` calls `trim_messages(..., strategy="last")` with no `start_on="human"`. It can cut between a tool call and its result and send an orphan `ToolMessage` to the LLM. This is the second suspect from Day 1 and the PR does not touch it. It may be why the bug never showed in the app. Add `start_on="human"` or a test for that path.
2. **Correctness, `server/utils/utils.py:~168`.** `recent_messages_number=0` used to return everything (`messages[-0:]`). Now it returns `[]`. Callers pass `RECENT_MESSAGE_LIMIT`, so likely harmless, but say so in the PR or guard it.
3. **Tests, `server/tests/test_keep_recent.py`.** Only one case. Add: (a) several `ToolMessage`s in a row after one `AIMessage`, (b) a clean cut where nothing widens, (c) `N` bigger than the list. The current assert only checks "no orphan"; also assert the `AIMessage` is kept and order is preserved.
4. **Readability, `server/utils/utils.py:5`.** `AIMessage` import is now unused (only in comments and docstring). Remove it.

Security: nothing. Scope: clean (Makefile went in its own PR #12).

**Verdict: fix first (small).** Items 1 and 3 matter; 2 and 4 are quick.
