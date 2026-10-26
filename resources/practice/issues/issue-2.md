# Issue [#2](https://github.com/thanhnguyen-agilityio/claude-training-practice/issues/2)
## Title: The old message cut off and the bot don't remember the previous conversation

**Issue**
- In a long conversation, old messages disappear from the UI and the bot forgets earlier info.

**Expected**
- UI keeps showing the conversation. Bot remembers it.

**Repro** (`RECENT_MESSAGE_LIMIT=2`)
1. Send "my name is Thanh".
2. Send "Give me list categories".
3. Send "my name?".
- Actual: bot says it doesn't remember. Welcome message also disappears after the 2nd send.

**Cause (from code, not yet run)**
- Bot: `summarize_conversation` (`server/agent/graph.py`) saves `summary` but nothing reads it, so the bot never sees it.
- UI: `client/pages/agent.py` replaces the UI list with `/history` on every rerun. The server has already deleted old messages, and the welcome message is client-only, so both vanish.

**Plan**
- PR 1: feed `summary` to the assistant + test. UI fix is a follow-up. Fix before #8.
