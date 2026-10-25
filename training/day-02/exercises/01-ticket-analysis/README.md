# Task 1: Ticket analysis

## Scenario
Five tickets are in the backlog. For each one, you write a three-sentence analysis before touching code. Then you ask Claude to find the gaps.

## The analysis format
Three sentences, one for each:
1. What the ticket asks for.
2. What is ambiguous or missing.
3. The first step you would take.

## The five tickets
The tickets are real issues from the practice repo, saved in [resources/practice/issues/](../../../../resources/practice/issues/). Two are bugs, one is a UI bug with a dev note, one explains another ticket, and one is a feature request.

| # | Issue | Title | Source |
|---|---|---|---|
| 1 | #1 | Chatbot shows error in long conversations (plus trace and state dump) | [issue-1.md](../../../../resources/practice/issues/issue-1.md) |
| 2 | #2 | The old message cut off and the bot don't remember the previous conversation | [issue-2.md](../../../../resources/practice/issues/issue-2.md) |
| 3 | #6 | Conversation freezes after clicking Yes/No approval buttons | [issue-6.md](../../../../resources/practice/issues/issue-6.md) |
| 4 | #8 | Chat messages disappear without warning or explanation | [issue-8.md](../../../../resources/practice/issues/issue-8.md) |
| 5 | #3 | Remove Thread ID input and add share/save conversation feature | [issue-3.md](../../../../resources/practice/issues/issue-3.md) |

The first version of this task used five made-up tickets. That work is kept in the v1 section of the log.

## How to run it
1. Write your own three-sentence analysis for all five. Do it before you ask Claude.
2. Ask Claude for its analysis of each ticket, using the ticket text only. Give it the format and a length cap.
3. Compare. Where did Claude see a gap you missed? Where did it invent a fact the ticket doesn't state?
4. Ask Claude to list the gaps for each ticket and rank them by how much they block the first step.

## Checklist
- [ ] Five analyses of three sentences each, written by you first
- [ ] Claude's version compared with yours, with differences noted
- [ ] At least one gap Claude found that you missed
- [ ] At least one place where Claude stated a fact the ticket doesn't contain

<details><summary>Teacher's check (open after you finish)</summary>

What a good analysis notices:
- #1: "sometimes" and "long" give no trigger or length. The first step is to read the state dump: the first two messages are `ToolMessage`s whose `AIMessage` is gone. Don't guess the cause before that.
- #2: it asks for two different things, a UI that keeps every message and a bot that remembers. Treat them separately. "Remember" can mean three things, so check whether the summary is ever put into the prompt. On Day 1 you found it isn't (`prompt.py:26-33`).
- #6: the dev note says the backend works and the UI ignores the response. That is a claim to check, not a fact. The first step is to watch the network calls when you click Yes or No.
- #8: the dev note says the bot "still remembers everything" through the summary. That conflicts with your Day 1 finding for #2. "5-6 messages" and "about 1000 tokens" are two different triggers, and both need checking against config.
- #3: a feature request that bundles three changes: remove the input, make sessions page-scoped, and add share links. It doesn't say who can open a shared link, how long it lasts, or what happens to existing thread IDs. Expect the most questions here.
</details>

## Your log
Keep it in [log.md](log.md).
