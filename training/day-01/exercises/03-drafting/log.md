# Task 3: Log

Rubric: [README.md](README.md). Model for all rounds: Claude Sonnet 5.5, medium effort, Chat tab, new chat each time.

| Round | Change | Score /5 | Result |
|---|---|---|---|
| v1 | Lazy line, plus the Task 1 summary and the two README facts | 1.5 | Facts gave it a date (1) and half the ending. Jargon, about 190 words, bullets and "answer first" all 0. |
| v2 | Stage / Task / Rules | 4.0 | Reader named, 80 words, no bullets, answers first, ends with next steps. Cause is only a symptom, and the date reads as a promise. |
| v3 | Added a plain-language cause rule | 4.0 | Cause is plain and in sentence 1 (+0.5). But 83 words against the 80 cap (-0.5), and the date dependency shrank to review only. Final message is v3 hand-edited to 78 words. |

---

## v1: lazy line, with summary and facts

Prompt
````
write a message to my PM about the summary bug.

this is my summary for the bug:

Known: In long conversations the chatbot intermittently fails and the user sees an error instead of an answer; the summary feature is currently turned off as a workaround.
Known: The failure is an OpenAI 400 BadRequestError ("messages with role 'tool' must be a response to a preceding message with 'tool_calls'"), pointing at messages.[1], raised in the 'assistant' task.
Known: The captured state["messages"] begins with two ToolMessages (sql_db_list_tables, sql_db_schema) that have no preceding AIMessage containing their tool_calls.
Suspected: The conversation history is being trimmed or summarized in a way that cuts off the AIMessage carrying the tool_calls and leaves its ToolMessage responses orphaned at the start of the list.
Suspected: Failures are intermittent because they only occur when the cut point falls between a tool_calls message and its tool responses, which depends on conversation length and tool usage.

Facts:
- The feature is disabled as a temporary fix. Long chats work, but older context isn't summarized.
- Next step: reproduce tomorrow, then fix and test. The earliest realistic date is after the fix is reviewed, in 2 to 3 days.
````

Response (the chat reply came as a card, so I asked for plain text)
````
Hi [PM name], quick update on the summary bug.

Impact: In long conversations the chatbot intermittently fails and the user sees an error instead of an answer. To stop this, I've turned the summary feature off as a temporary workaround. Long chats work again, but older context is no longer summarized.

What we know:
- The failure is a 400 BadRequestError from OpenAI, raised in the 'assistant' task. It says a tool message must follow a message with tool_calls.
- In the captured state, the message list starts with two tool responses (sql_db_list_tables, sql_db_schema) whose originating AI message with the tool_calls is missing.

What we suspect (not yet confirmed):
- Trimming or summarizing the history cuts off the AI message that carries the tool_calls and leaves its tool responses orphaned at the start of the list.
- It's intermittent because it only happens when the cut point lands between a tool_calls message and its responses, which depends on conversation length and tool usage.

Next steps: I'll reproduce it tomorrow, then fix and test. The earliest realistic date to re-enable summaries is once the fix has been reviewed, so roughly 2 to 3 days.

Happy to jump on a call if you want more detail.
````

Score 1.5/5. Date 1, ending 0.5, the rest 0. The audience was never stated, so it wrote for an engineer: jargon, bullets, "what we suspect" sections. The "when" is in the second-to-last paragraph. It also left a `[PM name]` placeholder, wrote "I've turned the feature off" (the facts don't say who did), and dropped "earliest".

---

## v2: Stage, Task, Rules

Prompt (as drafted in this session. I also suggested `Say "at the earliest" for the date.` but did not confirm it was in the prompt that was sent.)
````
I'm a developer on an e-commerce chatbot project. Our PM, who is not technical, asked me on Slack: "Why is conversation summary turned off? When is it coming back?"

Write my reply.

Rules:
- Max 80 words, plain text, no headers or bullets, friendly colleague tone.
- First 2 lines answer both questions: why it's off (one plain sentence, no technical terms) and when it's back.
- Date as a range plus what it depends on. Don't promise a fixed date.
- End with what the PM can expect next.
- Don't invent facts beyond the ones below.

My bug summary (for you only, don't copy it):
<Task 1 v2 summary>

Facts:
- The feature is disabled as a temporary fix. Long chats work, but older context isn't summarized.
- Next step: reproduce tomorrow, then fix and test. The earliest realistic date is after the fix is reviewed, in 2 to 3 days.
````

Response
````
Conversation summary is off because a bug was making long chats fail with an error, so we switched it off as a temporary fix. Long chats work fine now; older context just isn't summarized.

It should be back in about 2 to 3 days, depending on how quickly we can reproduce the bug, fix it, and get the fix reviewed. I'll start reproducing it tomorrow. I'll update you once I've confirmed the cause, and again when it's ready for review.
````

Score 4.0/5. Both answers up front (1), no jargon but the cause is only a symptom (0.5), range plus dependency but "should be back" reads as a promise (0.5), exactly 80 words (1), ends with next steps (1).

Naming the reader and the real question stopped it from reformatting the engineering summary. The word cap, "no bullets" and "answer first" took it from about 190 words to 80.

---

## v3: fix one gap

One line added to the Rules of v2. The 80-word cap stayed.
````
- Explain the cause in one plain sentence about what goes wrong, as if to someone who has never seen code (for example, what happens to the chat when it gets long).
````

Response
````
Hi! We turned it off because, when a chat gets long, the part that condenses older messages sometimes cuts them in the wrong spot and the assistant then fails to reply. It should be back in roughly 2 to 3 days, depending on how quickly the fix gets reviewed. For now, long chats still work, but older context just isn't summarized. I'll reproduce the issue tomorrow, then fix and test it. I'll update you once it's in review and again when it's live.
````

Score 4.0/5. Both answers up front (1), plain cause (1), date half (0.5, review only, still no "earliest"), 83 words (0.5), ends with next steps (1).

- The cause line is the best so far, but the extra rule cost 3 words over the cap. Third time in Day 1 a new rule broke an old limit.
- "Earliest" is still missing. Claude defaults to soft words ("roughly", "should") unless a rule names the exact wording.

---

## Final message

v3 hand-edited: removed "Hi!", changed the date to "At the earliest ... once the fix is tested and reviewed", trimmed words. 78 words.
````
We turned it off because, when a chat gets long, the part that condenses older messages sometimes cuts them in the wrong spot and the assistant fails to reply. At the earliest it's back in 2 to 3 days, once the fix is tested and reviewed. For now, long chats work, but older context isn't summarized. I'll reproduce the issue tomorrow, then fix and test it. I'll update you when it's in review and again when it's live.
````
