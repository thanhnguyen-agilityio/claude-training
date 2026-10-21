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
````
(paste your prompt here)
````

## Claude's analyses
````
(paste the response here)
````

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
