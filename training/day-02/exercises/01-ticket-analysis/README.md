# Task 1: Ticket analysis

## Scenario
Five tickets are in the backlog. For each one, you write a three-sentence analysis before touching code. Then you ask Claude to find the gaps.

## The analysis format
Three sentences, one for each:
1. What the ticket asks for.
2. What is ambiguous or missing.
3. The first step you would take.

## The five tickets
The text below is how a reporter might write each ticket. Ticket 1 is a real file in the repo. Tickets 2 to 4 come from your Day 1 findings. Ticket 5 is deliberately vague.

| # | Ticket | Source |
|---|---|---|
| 1 | "Summary conversation sometime got error. Temp fix: disable feature." plus the traceback | `sample-project/assets/issue.md` |
| 2 | "Old messages disappear after a while and the bot forgets what we said earlier." | Day 1 Task 2: the saved summary never reaches the prompt (`prompt.py:26-33`) |
| 3 | "I set the history limit to 5 but I only ever see 4 messages kept." | Day 1 Task 2: the throwaway summary message counts as one of the N (`graph.py:117,121-124`) |
| 4 | "Long chats sometimes start with a tool result and the model errors out." | Day 1 Task 2: `trim_messages` in `Assistant` has no `start_on` (`graph.py:44-50`) |
| 5 | "Customers keep asking where their order is. Can the agent tell them?" | `training/ideas.md`, the order-status idea |

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
- Ticket 1: "sometime" gives no trigger, and it never says how long the chat was. The first step is to read the state dump, not to guess the cause.
- Ticket 2: "forgets" can mean three different things. The first step is to check whether the summary is ever put into the prompt. It isn't, so this ticket describes a real gap.
- Ticket 3: it asks for a limit of 5 and sees 4. The ticket doesn't say how it counted. The first step is to count the messages in the state.
- Ticket 4: this one is a symptom of ticket 1, and it may have a different cause. Don't assume they are the same bug.
- Ticket 5: it asks for a feature, but it doesn't say which orders, which data source, or whether the agent may change anything. Expect the most questions here.
</details>

## Your log
Keep it in [log.md](log.md).
