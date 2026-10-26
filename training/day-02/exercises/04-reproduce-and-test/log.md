# Task 4: Log (short)

## Repro
1. Build messages: Human, AI(tool_call c1), Tool(c1), AI(answer).
2. Call `handle_keep_recent_messages(messages, recent_messages_number=2)` (`server/utils/utils.py`).

**Expected:** kept window has no ToolMessage without its AIMessage tool_call.
**Actual:** kept = [Tool(c1), AI(answer)]. Tool is orphaned. Tool-call ids are only collected from kept AIMessages, never from kept ToolMessages, so the parent AIMessage is never pulled back.
**Env:** Python via uv, real langchain_core messages, no LLM call needed.

## Failing test
- Repo: `claude-training-practice`, branch `test/keep-recent-orphan-tool-message`
- File: `server/tests/test_keep_recent.py`
- Run: `cd server && uv run --with pytest python -m pytest tests -q`
- Result: 1 failed, `AssertionError: orphan ToolMessage: its AIMessage was cut`
- First try with N=3 passed: the cut must land between the tool call and its result, so N=2.

## Fix idea (Day 3, not today)
Also collect `tool_call_id` from kept ToolMessages and re-add their AIMessage, in original order.
