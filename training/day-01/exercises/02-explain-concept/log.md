# Task 2: Log

Rubric and claim check: [README.md](README.md). Model for all rounds: Claude Sonnet 5.5, medium effort, Chat tab, new chat each time.

| Round | Change | Score /5 | Result |
|---|---|---|---|
| v1 | Lazy prompt | 1.5 | Explains what is kept and deleted. Never mentions tool calls, tool results or the pairing rule. About 600 words of textbook, and it never says it can't see the agent code. |
| v2 | Stage / Task / Rules | 4.5 | Loop, pairing rule, length all hit. Cites the issue and labels guesses. Missing the "summary string + last N" mechanic. Includes the claim check point (2 true). |
| v3 | Added a "general LangGraph" sentence on the summary mechanic | 4.5 | Mechanic explained, but about 330 words against a 250 cap, one false claim, and an unlabeled invented diagram. Same score as v2 for a different reason. |

---

## v1: lazy prompt

Prompt (nothing attached)
````
explain langgraph conversation summary
````

Response
````
"LangGraph conversation summary" usually refers to one of two things, and both come up when you're building a chat agent like the e-commerce one you're working on.

**The problem it solves**

A chat agent's state includes the full list of messages. Every turn appends to it, so the history grows until it gets expensive (more tokens per call), slow, and eventually too long for the model's context window. Conversation summarization compresses older messages into a short summary while keeping the most recent ones verbatim.

**The classic LangGraph pattern**

You keep a state with `messages` plus a `summary` string, and add a node that decides when to summarize:

```python
from langgraph.graph import MessagesState, StateGraph, START, END
from langchain_core.messages import HumanMessage, RemoveMessage

class State(MessagesState):
    summary: str

def call_model(state: State):
    summary = state.get("summary", "")
    messages = state["messages"]
    if summary:
        # Inject the summary as context ahead of the recent messages
        messages = [("system", f"Summary of earlier conversation: {summary}")] + messages
    response = model.invoke(messages)
    return {"messages": [response]}

def should_summarize(state: State):
    # Trigger once the history passes a threshold
    return "summarize" if len(state["messages"]) > 6 else END

def summarize(state: State):
    summary = state.get("summary", "")
    if summary:
        prompt = f"Current summary: {summary}\n\nExtend it with the new messages above."
    else:
        prompt = "Summarize the conversation above."
    new_summary = model.invoke(state["messages"] + [HumanMessage(content=prompt)])

    # Delete all but the last 2 messages from state
    to_delete = [RemoveMessage(id=m.id) for m in state["messages"][:-2]]
    return {"summary": new_summary.content, "messages": to_delete}

builder = StateGraph(State)
builder.add_node("agent", call_model)
builder.add_node("summarize", summarize)
builder.add_edge(START, "agent")
builder.add_conditional_edges("agent", should_summarize)
builder.add_edge("summarize", END)
```

The key mechanics:

- **`RemoveMessage`** is how you delete messages from state, because the `messages` reducer appends by default. Passing a `RemoveMessage` with a message's ID tells the reducer to drop it.
- **Rolling summary**: each time you summarize, you feed in the existing summary and ask the model to extend it, so it stays one compact block rather than a growing pile of summaries.
- **Checkpointer**: pair this with a checkpointer (e.g. `MemorySaver`, or a Postgres/SQLite saver in production) so the summary and recent messages persist per `thread_id` across turns.

**The newer helper: `SummarizationNode` (langmem)**

Rather than hand-rolling the node, the `langmem` library provides `SummarizationNode` and `summarize_messages`, which summarize based on a token budget (`max_tokens`, `max_summary_tokens`) instead of a message count. It's usually the better choice for production since token limits are what actually matter.

**Related options worth knowing**

- **`trim_messages`**: just drops older messages by token count. Simplest, but loses information.
- **Filtering**: pass only the last N messages to the model while keeping everything in state.
- **Long-term memory (Store)**: for facts that should persist across threads (like a shopper's preferences), use LangGraph's `Store` rather than summaries, which are scoped to a single conversation.

**Tradeoffs to watch**

- Summaries are lossy. Details like order IDs, SKUs, or exact quantities can get dropped, so for an e-commerce agent it's worth keeping structured data (cart, order IDs) in separate state fields rather than relying on the summary to carry them.
- Summarizing costs an extra LLM call, so triggering on a threshold rather than every turn keeps latency and cost down.

If you tell me which version of LangGraph you're on and whether you want message-count or token-based triggering, I can tailor the example.
````

Score 1.5/5: loop 0, kept and deleted 1, pairing rule 0, level and length 0.5, claim check 0.

- It knew "the e-commerce one you're working on" from chat memory with nothing attached.
- Its example deletes `messages[:-2]` by count. That is the pattern that can split a tool-call pair, but it never says so.

---

## v2: Stage, Task, Rules

Prompt
````
I'm a Python/API developer, new to LangGraph, joining an e-commerce agent project. Tomorrow I'll fix the bug in the issue below, so I need to understand how this agent keeps its chat history short.
Explain, for this case: how the agent loops (assistant, tool calls, tool results), what summarization keeps and deletes, and why tool messages make trimming break.
Rules: max 250 words; one ASCII diagram of the message list; for each claim, point to the line in the issue that supports it, or label it "general LangGraph, can't see your code"; if unsure, say so.
<paste issue-1.md>
````

Response
````
1. Loop

* The `assistant` node calls the model. If the AIMessage has `tool_calls`, a tool runs and appends a ToolMessage with the same `tool_call_id`. This repeats until an AIMessage ends with `finish_reason: 'stop'`.
* Issue: the trace says "task with name 'assistant'", and msgs [2]-[4] below show that pattern.
* The tool node and routing are general LangGraph, can't see your code.


```
[0] Tool  list_tables  id=call_O1N..  <- orphan
[1] Tool  schema       id=call_BHb..  <- orphan
[2] AI    tool_calls   id=call_qhy..
[3] Tool  query result id=call_qhy..  (pairs with [2])
[4] AI    final, finish_reason=stop

```

2. What summarization kept and deleted

* Kept: msgs [2]-[4] are an intact pair (matching `call_qhy...` ids, issue state dump).
* Deleted: the AIMessage(s) that issued `call_O1N...` and `call_BHb...` are no longer in the list. This is my inference, because the list starts with ToolMessages.
* No HumanMessage appears either (state dump).
* I can't see where the summary text is stored or how the cut point is chosen. Unsure.

3. Why it breaks

* OpenAI requires each `tool` message to follow an assistant message carrying `tool_calls` (error text, trace).
* [0] and [1] have no such parent, so the 400 comes from `messages.[1]`. The index would fit a system prompt sitting at [0], but that is a guess.
* "Sometimes" fits a cut that only occasionally lands inside a tool-call group. This is my inference. The issue says only that it's intermittent and that disabling summary avoids it.

Likely fix direction (general LangGraph, can't see your code): remove or keep AI+Tool groups together, never one without the other. Check the summarizer's cut logic tomorrow.
````

Score 4.5/5 with the claim check. Loop 1, kept and deleted 0.5, pairing rule 1, level and length 1, claim check 1.

- The cite-or-label rule made Claude mark inferences ("my inference", "a guess") instead of stating the cause as fact.
- The diagram shows the bug at a glance: two orphans at the front.
- Gap: it gave up on the summary mechanic ("can't see where the summary is stored").

---

## v3: fix one gap

One sentence added to the Task line of v2. Everything else, including "max 250 words", unchanged.
````
Also explain, in 2 sentences labelled "general LangGraph", how a typical summarize step stores a summary string and deletes older messages, and tie it to the dump above.
````

Response
````
Loop (general LangGraph, can't see your code, for the edges): assistant → tools → assistant, repeating until the assistant answers without tool calls. The dump matches this: an `AIMessage` with `tool_calls` (id `call_qhyE...`), then a `ToolMessage` with the same `tool_call_id`, then a final `AIMessage` with `finish_reason='stop'`.

```
before: [Human][AI+calls A,B][Tool A][Tool B][AI+call C][Tool C][AI final]
deleted: ^^^^^^ ^^^^^^^^^^^^^
kept   :                     [Tool A][Tool B][AI+call C][Tool C][AI final]
          ^ orphans: their AI+calls message is gone

```

Kept vs deleted (inferred from the dump, my reading, not confirmed): the state holds 5 messages. It starts with `ToolMessage`s for `call_O1...` and `call_BHb...`, whose issuing `AIMessage` is missing. So the cut fell between an `AIMessage(tool_calls)` and its results. I can't see where the summary text is stored or whether it's injected, since none appears in the dump.
Why it breaks: OpenAI requires every `role: tool` message to follow an assistant message with matching `tool_calls`. The error says exactly that, for `messages.[1]`. Index 1 plausibly means a system prompt sits at index 0 and the orphan `ToolMessage` follows it (unsure). It's intermittent because it only fails when the trim boundary lands inside a tool-call group (the issue says "does not happen every time"). Turning summaries off avoids the trim (workaround line).
General LangGraph: A typical summarize node asks the LLM for a summary string, saves it under a state key like `summary`, and returns `RemoveMessage(id=...)` for old messages, which the `add_messages` reducer deletes by id. In your dump every message has an `id`, which fits that pattern, but the cut was by count, not by tool-call boundaries.
Likely fix to check tomorrow: move the cut so the kept slice starts at a `HumanMessage`, or also remove leading `ToolMessage`s.
````

Score 4.5/5. Kept and deleted is now 1, because the general sentence covers the summary string, `RemoveMessage` and the `add_messages` reducer. Level and length dropped to 0.5.

- Cost of the fix: about 330 words against the 250 cap. Third time in Day 1 a new rule broke an old limit.
- False claim: "every message has an `id`". The `AIMessage` at issue-1.md:31 has none.
- "The cut was by count" is stated as fact. The dump doesn't show how the cut was made.
- The diagram's "before" row invents a `HumanMessage` and calls A,B without saying so, and its markers are misaligned.
- The unrequested "likely fix" line is back.
