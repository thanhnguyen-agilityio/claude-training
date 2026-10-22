# Task 3: Log

The rubric is in [README.md](README.md).

## Scores

| Round | Change | Score /5 | What improved, and what was still wrong |
|---|---|---|---|
| v1b | Same lazy line, plus the two README facts | 1.5 | Facts moved only the date (1 point) and half the ending. Jargon, length, format and "answer first" are still 0: they come from having no audience or rules, not from missing facts. |
| v1a | Lazy prompt (+ Task 1 summary, no facts) | 0 | Reformatted the engineer summary for the PM. Jargon throughout, ~170 words, headers and bullets, no date, ends with an offer. It did not invent a date, and its chat note asked what to commit to. |
| v2 | Stage / Task / Rules | 4.0 | Named the reader and the PM's question, 80-word cap, no bullets, answer first, end with what happens next. Still a vague cause (symptom, not reason) and a date that reads as a promise ("should be back in about 2 to 3 days", no "earliest"). |
| v3 | Add a plain-language cause rule | 4.0 | Cause is now plain and in sentence 1 (+0.5). But 83 words against the 80 cap (-0.5), and the date dependency shrank to "the fix gets reviewed", with no "earliest". Same score as v2. Final message is v3 hand-edited to 78 words. |

---

## v1a: lazy prompt, no facts

Model: Claude Sonnet 5.5, medium effort (Chat tab, new chat). The draft came back in a card. The chat note only said "I've drafted the message in the card above... tell me what you want to commit to", so I asked it to paste the draft as plain text.

Prompt (the Task 1 v2 summary was pasted in full; the two facts from the README were not included in v1)
````
write a message to my PM about the summary bug.

this is my summary for the bug:

Known: In long conversations the chatbot intermittently fails and the user sees an error instead of an answer; the summary feature is currently turned off as a workaround.
Known: The failure is an OpenAI 400 BadRequestError ("messages with role 'tool' must be a response to a preceding message with 'tool_calls'"), pointing at messages.[1], raised in the 'assistant' task.
Known: The captured state["messages"] begins with two ToolMessages (sql_db_list_tables, sql_db_schema) that have no preceding AIMessage containing their tool_calls.
Suspected: The conversation history is being trimmed or summarized in a way that cuts off the AIMessage carrying the tool_calls and leaves its ToolMessage responses orphaned at the start of the list.
Suspected: Failures are intermittent because they only occur when the cut point falls between a tool_calls message and its tool responses, which depends on conversation length and tool usage.
````

Response
````
Hi, quick update on the summary bug.

Impact: In long conversations the chatbot intermittently fails, and the user sees an error instead of an answer. The summary feature is turned off for now as a workaround.

What we know:
- The failure is an OpenAI 400 BadRequestError ("messages with role 'tool' must be a response to a preceding message with 'tool_calls'"), pointing at messages[1] and raised in the 'assistant' task.
- The captured message list starts with two tool responses (sql_db_list_tables, sql_db_schema) that have no preceding AI message containing their tool_calls.

What we suspect (not yet confirmed):
- The conversation history is being trimmed or summarized in a way that cuts off the AI message carrying the tool_calls, leaving its tool responses orphaned at the start of the list.
- It's intermittent because it only happens when the cut point lands between a tool_calls message and its tool responses, which depends on conversation length and tool usage.

Happy to walk you through it if useful.
````

Score: 0/5
- [ ] Both questions in the first 2 lines: no. "Why it's off" is only in line 3 and half-answered. "When it's back" is never answered.
- [ ] No jargon: no. "OpenAI 400 BadRequestError", `tool_calls`, `messages[1]`, "tool responses", "cut point".
- [ ] Honest date: no date or range at all. It didn't invent one either.
- [ ] Slack-sized: no. About 170 words, with labels and bullets. It reads like a status report.
- [ ] Ends with what the PM can expect: no. It ends with "Happy to walk you through it".

Observations
- It answered the wrong question. The PM asked "why off, when back". It re-sent the engineering summary with a polite wrapper.
- The audience was never stated, so it kept the Known/Suspected labels from the input and wrote for an engineer.
- Good: it invented no date, and the chat note asked what to commit to.
- The input had no timeline facts, so the date items are impossible to hit until the facts are added. That led to v1b.

## v1b: lazy prompt, with the README facts

Model: Claude Sonnet 5.5, medium effort (Chat tab, new chat).

Prompt (same lazy line and the same pasted summary as v1a, plus the facts)
````
write a message to my PM about the summary bug.

this is my summary for the bug:
<Task 1 v2 summary, same as v1a>

Facts:
- The feature is disabled as a temporary fix. Long chats work, but older context isn't summarized.
- Next step: reproduce tomorrow, then fix and test. The earliest realistic date is after the fix is reviewed, in 2 to 3 days.
````

Response
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

Score: 1.5/5
- [ ] Both questions in the first 2 lines: no. The date is in the second-to-last paragraph.
- [ ] No jargon: no. "400 BadRequestError", `tool_calls`, `sql_db_list_tables`, "cut point".
- [x] Honest date: yes. A range ("2 to 3 days") with what it depends on (fix reviewed). Small slip: it dropped "earliest", so it reads more like an estimate than a floor.
- [ ] Slack-sized: no. About 190 words, with labels and bullets.
- [~] Ends with what the PM can expect: half. "Next steps" is there but not last. It ends with an offer to call.

Observations
- The facts fixed only the date item. Everything else is the missing audience and rules.
- It still pastes the engineering summary, now even longer, because it adds the facts on top of it.
- It left a `[PM name]` placeholder and wrote "I've turned the feature off", which says who did it. The facts don't say that.

## v2: Stage, Task, Rules

Model: Claude Sonnet 5.5, medium effort (Chat tab, new chat).

Prompt (as drafted in this session; I suggested adding `Say "at the earliest" for the date.` to Rules, but did not confirm whether it was in the prompt that was sent)
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
<Task 1 v2 summary, same as v1a>

Facts:
- The feature is disabled as a temporary fix. Long chats work, but older context isn't summarized.
- Next step: reproduce tomorrow, then fix and test. The earliest realistic date is after the fix is reviewed, in 2 to 3 days.
````

Response
````
Conversation summary is off because a bug was making long chats fail with an error, so we switched it off as a temporary fix. Long chats work fine now; older context just isn't summarized.

It should be back in about 2 to 3 days, depending on how quickly we can reproduce the bug, fix it, and get the fix reviewed. I'll start reproducing it tomorrow. I'll update you once I've confirmed the cause, and again when it's ready for review.
````

Score: 4.0/5
- [x] Both questions in the first 2 lines: yes. The "why" is sentence 1. The "when" opens paragraph 2.
- [~] No jargon, cause in one plain sentence: half. No jargon left, but "a bug was making long chats fail" gives the symptom, not what goes wrong.
- [~] Honest date: half. It gives a range and what it depends on. But "should be back in about 2 to 3 days" drops "earliest", so it reads as a promise.
- [x] Slack-sized: yes. Exactly 80 words, no headers or bullets, sounds like a colleague.
- [x] Ends with what the PM can expect: yes (update after the cause is confirmed, and again when ready for review).

What improved (1.5 to 4.0)
- Naming the reader ("PM, who is not technical") and giving the actual question stopped it from reformatting the engineering summary.
- The word cap, "no bullets" and "answer both questions first" rules took it from about 190 words with headers to 80 words in two paragraphs.
- "For you only, don't copy it" turned the bug summary into background instead of the draft.

Still wrong
- The cause is a symptom, not a reason.
- The date reads as a promise.

## v3: fix one gap

Model: Claude Sonnet 5.5, medium effort (Chat tab, new chat).

Change: one line added to the Rules of v2. Everything else, including the 80-word cap, unchanged.
````
- Explain the cause in one plain sentence about what goes wrong, as if to someone who has never seen code (for example, what happens to the chat when it gets long).
````

Response
````
Hi! We turned it off because, when a chat gets long, the part that condenses older messages sometimes cuts them in the wrong spot and the assistant then fails to reply. It should be back in roughly 2 to 3 days, depending on how quickly the fix gets reviewed. For now, long chats still work, but older context just isn't summarized. I'll reproduce the issue tomorrow, then fix and test it. I'll update you once it's in review and again when it's live.
````

Score: 4.0/5
- [x] Both questions in the first 2 lines: yes. Why in sentence 1, when in sentence 2.
- [x] No jargon, cause in one plain sentence: yes. "The part that condenses older messages sometimes cuts them in the wrong spot and the assistant then fails to reply" is the best cause line so far.
- [~] Honest date: half. It gives a range and a dependency, but the dependency is now only "how quickly the fix gets reviewed". Reproduce, fix and test dropped out. Still no "earliest".
- [~] Slack-sized: half. 83 words against the 80 cap. No headers or bullets, and it sounds like a person.
- [x] Ends with what the PM can expect: yes (update when it's in review and again when it's live).

What the one change did
- Fixed the target gap: the cause went from "a bug" to a plain sentence about what goes wrong (+0.5).
- Cost: 3 words over the cap (-0.5), and the date dependency got thinner. The net is the same score as v2.
- This is the third time in Day 1 that a new rule pushed against an old limit (Task 1 v3, Task 2 v3, Task 3 v3). When you add a rule, repeat the limit.
- "Earliest" is still missing even after the rule was suggested. A soft word like "roughly" or "should" is Claude's default. A hard rule has to say it (for example: start the date with "At the earliest").

## Final message (v3, hand-edited)
I took v3 and made three edits: removed "Hi!", turned the date into "At the earliest ... once the fix is tested and reviewed", and trimmed words. It is 78 words.
````
We turned it off because, when a chat gets long, the part that condenses older messages sometimes cuts them in the wrong spot and the assistant fails to reply. At the earliest it's back in 2 to 3 days, once the fix is tested and reviewed. For now, long chats work, but older context isn't summarized. I'll reproduce the issue tomorrow, then fix and test it. I'll update you when it's in review and again when it's live.
````
