# Issue [#2](https://github.com/thanhnguyen-agilityio/claude-training-practice/issues/2)
## Title: The old message cut off and the bot don't remember the previous conversation
## Description:

**Issue**
- When a conversation gets long, I see the message is cut off and bot not remember my previous information
- Steps (with `RECENT_MESSAGE_LIMIT=2`):
  - Send "my name is Thanh"
  - Send "Give me list categories"
  - Send "my name?"
- Actual: the bot says it doesn't remember my name. The first welcome message also disappears after the 2nd message.

**Expected**
- If possible, the conversation show on UI should not drop / cut off
- And the bot should remember my previous conversation
