# Issue [#2](https://github.com/thanhnguyen-agilityio/claude-training-practice/issues/2)
## Title: The old message cut off and the bot don't remember the previous conversation
## Description:

**Issue**
- When a conversation gets long, I see the message is cut off and bot not remember my previous information

**Expected**
- If possible, the conversation show on UI should not drop / cut off
_ And the bot should remember my previous conversation
---
## Analysis (Day 4)

**Reproduced in the app** (`RECENT_MESSAGE_LIMIT=2`): send "my name is Thanh", then "Give me list categories", then "my name?". Bot answers "I don't remember your name yet." Screenshots: `issue-2-reproduce-w-limit-2-1.png`, `-2.png` (Desktop).

Two halves, two causes:

1. **Bot forgets (reproduced; cause from code reading, not yet run).** `summarize_conversation` (`server/agent/graph.py:98`) stores `summary` in state and deletes old messages with `RemoveMessage`, but nothing reads `state["summary"]` afterwards. `Assistant` never gives it to the model. Next step: failing test that builds a State with a non-empty `summary` and asserts the model input contains it.
2. **UI drops messages (partly reproduced).** `/history` (`server/routers/history.py`) returns state messages, so pruned messages are gone, and `client/pages/agent.py:102-113` overwrites the UI list with them on every rerun. Seen: the welcome message ("It's time for shopping! ...") disappeared after the second send.
   - The welcome message is client-only (`client/utils/constants.py` `WELCOME_MESSAGE`, never sent to the server), so the overwrite removes it as soon as the server has state. Prediction: happens at any limit. Not yet checked with the default limit of 5.
   - Not yet checked: older user messages disappear from the UI after a reload.

**Related:** #8 says the bot "retains context through summarization". The repro above shows it does not, so #8's promised message would be false until half 1 is fixed. Fix #2 first.

**Plan:** PR 1 = half 1 (use the summary) + test. Half 2 (separate display history from LLM context) is a follow-up ticket; note it in the PR.
