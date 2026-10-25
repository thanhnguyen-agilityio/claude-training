# Task 1: Log

## v2: practice issues (#1, #2, #6, #8, #3)
Tickets from [resources/practice/issues/](../../../../resources/practice/issues/). Reuse the best prompt from v1.

### My analyses (before asking Claude)

#### #1 Chatbot shows error in long conversations
1. Asks: fix issue on error on long conversations.
2. Ambiguous: user/thread detail to trace, error details, how many messages are there, could user continue to chat even see the error.
3. First step: try to reproduce the issue. understand when how cut of on summary.

#### #2 Old message cut off, bot doesn't remember
1. Asks: bot should remember the overall information even the conversation long.
2. Ambiguous: what is the user/thread got the issue to trace, what is the messsage bot not remember.
3. First step: try to reproduce the issue. understand how the summarize content send to model after the summarize action happens.

#### #6 Conversation freezes after Yes/No approval
1. Asks: User should receive follow up message that they response for HITL is received and on process.
2. Ambiguous: what is the user/thread got the issue to trace.
3. First step: try to reproduce the issue. understanding the HITL for both case approve/reject action.

#### #8 Chat messages disappear without warning
1. Asks: the UI history message should not cut off even behind the scene the summarize happens.
2. Ambiguous: how to know when the summarization happens?
3. First step: try to reproduce the issue. define the solution/UX for the case.

#### #3 Remove Thread ID input, add share/save
1. Asks: replace input thread id with a button to share/save the conversation.
2. Ambiguous: N/A
3. First step: checkout where the input of thread id stand in the app and how to generate a share url link.

### Prompt to Claude
````
I'm new AI developer who working on e-commerce chat agent build with LangChain/LangGraph. I need to analysis ticket of issues/improvement.

**Analysis format:**
Three sentences, one for each:
1. What the ticket asks for.
2. What is ambiguous or missing.
3. The first step you would take.

**Rules:**
- Write in concise, max 20 words each.
- No fixes.
- Only use what ticket have. If not, say suspected.

<issue-content>
````

### Claude's analyses

#### #1
`````
1. The ticket asks that the chatbot answer reliably in long conversations, and that the summary feature can be re-enabled without errors.
2. Unclear which summary logic trims messages, what triggers the failure, and how often; the OpenAI 400 error suggests orphaned ToolMessages (suspected).
3. First, reproduce the error with a long conversation and inspect the message list sent to OpenAI just before the 400.
`````

#### #2
`````
1. The ticket asks that long chats keep all messages visible in the UI and that the bot remembers earlier conversation details.
2. Missing: what "long" means, which messages get cut, whether cutoff is UI or bot, reproduction steps, and whether memory should persist across sessions (suspected: token-limit truncation).
3. Reproduce the issue with a long conversation, then check whether the UI, the stored history, or the model input drops messages.
`````

#### #6
`````
The ticket asks that Yes/No approval clicks continue the conversation with visible feedback, instead of freezing the chat.

1. Missing: which UI framework and streaming method is used, whether the graph resumes after approval, and failure behavior.
2. First, reproduce the bug in the browser, watching network responses and console logs after clicking Yes or No.
`````

#### #8
`````
1. The ticket asks to notify users clearly when older messages are summarized, optionally letting them view the summary.
2. Unclear: summarization trigger (5-6 messages or ~1000 tokens?), summary-viewing scope, whether Issue #2 overlaps, and which UI shows notices.
3. Reproduce the issue, then inspect the LangGraph summarization and trimming node to confirm where messages get removed.
`````

#### #3
`````
1. The ticket asks to remove the Thread ID input, default to session-based chats, and add a shareable-link feature to reopen conversations.
2. Missing: link storage, expiry, privacy or access control, what "session-based" means technically, and whether shared links are view-only or editable.
3. I would first trace how Thread ID currently flows from frontend input through the LangGraph checkpointer, to confirm what it controls.
`````

### Comparison
| Issue | A gap Claude found that I missed | A fact Claude invented | Which analysis was better |
|---|---|---|---|
| #1 | | | |
| #2 | | | |
| #6 | | | |
| #8 | | | |
| #3 | | | |

### Gaps ranked by how much they block the first step

### Surprises

---

## v1: first ticket set (retired 2026-10-25)
The first run used five made-up tickets. They were replaced by the practice repo issues. Kept here for the prompt experiment on ticket 1.

### My analyses (before asking Claude)

#### Ticket 1
1. Asks: fix summary conversation feature not work
2. Ambiguous: sometimes mean when? specific cases? trace back said 2 tools call and message cut off. If it not error, does the summary feature work?
3. First step: understand the summary conversation feature, then reproduce the issue.

#### Ticket 2
1. Asks: why the old message disappear. the issue of bot forget the conversation.
2. Ambiguous: old messages mean how many messages lost? and the bot forget is it halluciation or the summary never come to it. Is it happen on all conversation or just conversation long enough?
3. First step: check all context send to bot: system prompt, messages when do the summary on long conversation.

#### Ticket 3
1. Asks: history limit config not work. the message always missing 1
2. Ambiguous: where config, do you mean the const variable of app config? 4 message kept include summary message or not?
3. First step: checkout the message list send to bot, on conversation short/long with summarization.

#### Ticket 4
1. Asks: fix error on long chat show up related tool.
2. Ambiguous: what is the error? which tool? long chat mean how many messages? is it happen on all conversation or just conversation long enough?
3. First step: receive the error, try reproduce it with same conversation, check the tool call and message list.

#### Ticket 5
1. Asks: ask about the order status feature.
2. Ambiguous: which message customer send to bot? did they have any order?
3. First step: ask the customer to provide the order number and check the order status feature with that order number.

#### Teacher's feedback on my analyses
(filled in after the review)

### Prompt to Claude
I sent one ticket per prompt. The template is below. For ticket 1, the ticket text and the contents of `issue.md` (traceback, state dump and notes) went in place of the last line. I gave no format beyond the three questions, no "three sentences" and no "do not guess" rule.
````
Do analysis this ticket, answer 3 question:

1. What the ticket asks for.
2. What is ambiguous or missing.
3. The first step you would take.

Rules: short/concise.

<ticket title/source>
````

### Claude's analyses

#### Ticket 1
`````
**1. What the ticket asks for**
Fix the intermittent 400 error in the "summary conversation" feature, where OpenAI rejects the request. Until then, the temp fix is to disable the feature.

**2. What is ambiguous or missing**
- **Trigger:** "Sometime" is vague. The state dump shows it likely happens after a few turns, once the history is long enough to be summarized or trimmed.
- **Where summarization runs:** The ticket doesn't say whether it is a custom node, `trim_messages`, or `RemoveMessage`. The traceback shows no summary code. It only shows the `assistant` node failing.
- **Root cause (not stated, but visible in the state):** `state["messages"]` starts with `ToolMessage`s. The AIMessage with `tool_calls` that precedes them was cut off, so OpenAI sees orphaned `tool` messages (`messages.[1].role`). Trimming or summarizing is slicing the history in the middle of a tool-call group. It also looks like the two parallel `ToolMessage`s (and their AIMessage) can get separated.
- **Missing:** a reliable repro, the summarization code and its threshold (message count or tokens), the expected behavior for the summary, and a decision on whether the temp fix should stay in place while the fix is built.

**3. First step**
Find the summarization/trim code in `server/agent/graph.py` (or wherever history is cut) and reproduce it locally with a short script. Feed it a history that contains an AIMessage with parallel `tool_calls` and its ToolMessages, lower the threshold so the cut lands inside that group, and confirm the same 400. Once reproduced, fix it by making the cut land only at safe boundaries: never start the kept history with a `ToolMessage`, and keep each AIMessage with its ToolMessages together. Either drop leading orphan ToolMessages or move the cut back to the preceding HumanMessage. In LangChain, `trim_messages(start_on="human")` does this.
`````

#### Ticket 1 again, with three rules added
The one change: `Rules: three sentences per answer; use only what the ticket says, and write "not stated" for anything it doesn't say; no fixes.`
`````
**1. What the ticket asks for.**
The ticket reports that the "summary conversation" feature sometimes errors, and it records a temporary fix of disabling that feature. The error is an OpenAI 400 BadRequestError saying a message with role 'tool' must respond to a preceding message with 'tool_calls', pointing at `messages.[1].role`. The ticket does not state an explicit request such as "investigate" or "resolve"; that is not stated.

**2. What is ambiguous or missing.**
Not stated: what "summary conversation" does or when it triggers, what "sometime" means (frequency or conditions), and what outcome is expected beyond the temporary fix. The state dump shows two ToolMessages from parallel tool calls with the AIMessage holding their `tool_calls` missing before them, but the ticket does not say how that message was lost or whether summarization causes it. The ticket also does not say whether the feature is already disabled, who owns it, or its priority, and it links a LangGraph discussion without saying what it concludes.

**3. The first step I would take.**
I would reproduce the failure in a conversation where the agent makes parallel tool calls, as in the "Compare Gilded Prowl Skirt with Khaki Mini Skirt" request. At the point of the error I would inspect `state["messages"]` and check whether the summary step removed or trimmed the AIMessage carrying the two `tool_calls`. The ticket does not state the summary logic or where it lives, so I would first locate that code before changing anything.
`````

#### Ticket 1: first run against the run with rules

| | First run (no rules) | With the three rules |
|---|---|---|
| Words | about 270 | about 225 |
| Proposes a fix | yes (`trim_messages(start_on="human")`) | no |
| Says the root cause is visible in the dump | yes, stated | no, left open |
| Gap: whether the temporary fix stays | yes | partly ("whether the feature is already disabled") |
| Generic gaps (owner, priority) | no | yes |
| Reads the dump correctly | partly | no |

What the rules fixed: the fix is gone, the structure follows the three questions, and the guesses are gone from section 2.

What they didn't fix, and what they added:
- **A false claim in section 2.** It says the `AIMessage` holding the two parallel `tool_calls` is "missing before them". In the dump, that `AIMessage` is there, right before the last two `ToolMessage`s (`call_qK4F...` and `call_yc6c...`). The orphans are the first two messages in the list. This is the same misreading as Task 1 v3 on Day 1. The "not stated" rule made Claude more careful about the ticket's text and no more careful about the dump.
- **It sent the first step to the wrong place.** Step 3 says to check whether the summary step removed the `AIMessage` with the two `tool_calls`. That one was never removed. Inspecting `state["messages"]` would still show the real orphans, but the hypothesis is wrong.
- **The rule was applied too literally.** "The ticket does not state an explicit request such as investigate or resolve; that is not stated" adds nothing, and "who owns it, or its priority" is generic and could go on any ticket.

Tickets 2 to 5: add your prompt and Claude's response here, in the same format.

### Comparison
| Ticket | A gap Claude found that I missed | A fact Claude invented | Which analysis was better |
|---|---|---|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |
| 5 | | | |

### Best prompt
```

```

### Surprises
