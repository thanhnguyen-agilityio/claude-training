# Task 1: Log

## My analyses (before asking Claude)

### Ticket 1
1. Asks: fix summary conversation feature not work
2. Ambiguous: sometimes mean when? specific cases? trace back said 2 tools call and message cut off. If it not error, does the summary feature work?
3. First step: understand the summary conversation feature, then reproduce the issue.

### Ticket 2
1. Asks: why the old message disappear. the issue of bot forget the conversation.
2. Ambiguous: old messages mean how many messages lost? and the bot forget is it halluciation or the summary never come to it. Is it happen on all conversation or just conversation long enough?
3. First step: check all context send to bot: system prompt, messages when do the summary on long conversation.

### Ticket 3
1. Asks: history limit config not work. the message always missing 1
2. Ambiguous: where config, do you mean the const variable of app config? 4 message kept include summary message or not?
3. First step: checkout the message list send to bot, on conversation short/long with summarization.

### Ticket 4
1. Asks: fix error on long chat show up related tool.
2. Ambiguous: what is the error? which tool? long chat mean how many messages? is it happen on all conversation or just conversation long enough?
3. First step: receive the error, try reproduce it with same conversation, check the tool call and message list.

### Ticket 5
1. Asks: ask about the order status feature.
2. Ambiguous: which message customer send to bot? did they have any order?
3. First step: ask the customer to provide the order number and check the order status feature with that order number.

### Teacher's feedback on my analyses
(filled in after the review)

## Prompt to Claude
I sent one ticket per prompt. The template is below. For ticket 1, the ticket text and the contents of `issue.md` (traceback, state dump and notes) went in place of the last line. I gave no format beyond the three questions, no "three sentences" and no "do not guess" rule.
````
Do analysis this ticket, answer 3 question:

1. What the ticket asks for.
2. What is ambiguous or missing.
3. The first step you would take.

Rules: short/concise.

<ticket title/source>
````

## Claude's analyses

### Ticket 1
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

Ticket 2 to 5: add your prompt and Claude's response here, in the same format.

## Comparison
| Ticket | A gap Claude found that I missed | A fact Claude invented | Which analysis was better |
|---|---|---|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |
| 5 | | | |

## Best prompt
```

```

## Surprises
