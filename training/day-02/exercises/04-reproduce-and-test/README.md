# Task 4: Reproduce and write a failing test

## Scenario
This is the main exercise of the day. You take the seeded bug from `sample-project/assets/issue.md`, reproduce it in the running app, write exact repro steps, and turn it into a failing test. You do not fix it today.

You already have a strong hypothesis from Day 1 Task 2: `handle_keep_recent_messages` (`sample-project/server/utils/utils.py:156-185`) can leave a `ToolMessage` without the `AIMessage` that called it. Treat it as a hypothesis until you have run it.

## Part A: hypotheses (20 min)
1. Paste the stack trace from `issue.md` and the code for `summarize_conversation`, `handle_keep_recent_messages` and `Assistant` into a chat.
2. Ask Claude for a ranked list of hypotheses. For each one, ask what you would run to confirm or kill it.
3. Write the list in your log. Mark each one confirmed, killed or untested after you run it.

The Day 1 candidates are: the helper collects ids from the wrong messages, and `trim_messages` has no `start_on`.

## Part B: reproduce in the app (45 min)
1. Run the app (Task 3) with `RECENT_MESSAGE_LIMIT=3`.
2. Use one `thread_id` for the whole conversation.
3. Send a question that triggers two parallel tool calls, such as `Compare "Gilded Prowl Skirt" with "Khaki Mini Skirt"`. Then keep chatting for a few more turns.
4. Watch the server log. When it fails, note the exact message count and the question that triggered it.
5. Try twice more. Note whether it fails every time, or only sometimes, and what decides it.

## Part C: the repro report (20 min)
Write it so that someone else can reproduce the bug from the report alone. The `repro-bug` skill in `ai-kit/` has the same structure.
- Steps: exact and numbered, including the config value.
- Expected and actual.
- Environment: versions, config, model.
- Evidence: the trace and the state dump.

## Part D: the failing test (45 min)
Write a test that fails today because of the bug, and that will pass once it is fixed.

Setup:
1. `cd sample-project`, then `uv add --dev pytest`. The project has no tests folder yet.
2. Create `sample-project/server/tests/test_keep_recent_messages.py`.
3. Run it from `sample-project/server` with `uv run python -m pytest tests -q`. Use `python -m pytest` so the `utils` package is importable.

Starter. Fill in the history and the assertion yourself.
```python
from langchain_core.messages import AIMessage, HumanMessage, ToolMessage

from utils.utils import handle_keep_recent_messages


def history():
    # TODO: build the list from the failing case in your repro.
    # Hint: an AIMessage can carry several tool_calls, and each ToolMessage
    # points back to one of them through tool_call_id.
    return []


def test_no_orphan_tool_messages():
    kept = handle_keep_recent_messages(history(), recent_messages_number=5)
    # TODO: assert that no ToolMessage in `kept` is missing its AIMessage
```

Rules for a good failing test:
- It fails for the right reason. Read the failure message and check that it names the bug.
- It is small and has no network call. This one needs no OpenAI key.
- It would pass once the bug is fixed, and it would not pass for an unrelated reason.
- Commit it on its own branch, for example `day-02/failing-test`, with the failure output in the commit message or the log.

<details><summary>Teacher's check (open after you finish)</summary>

I ran a version of this test against the project's pinned versions (`langchain-core` 0.3.34 and `langgraph` 0.2.70) with real message classes. It failed with `orphan ToolMessages: ['call_b']`. So the test design is sound for the helper.

What this does not prove:
- That the helper is the cause in the running app. Part B is the evidence for that.
- That fixing the helper is enough. `trim_messages` in `Assistant` can also leave a `ToolMessage` first, and the end-to-end repro tells you whether it matters.

If your test passes on the first run, it is not testing the bug. Check that the cut really falls between the `AIMessage` and its `ToolMessage` (the last N must start after the `AIMessage`).
</details>

## Checklist
- [ ] Hypotheses listed, each marked confirmed, killed or untested
- [ ] The bug reproduced in the running app, with the message count and trigger noted
- [ ] A repro report with steps, expected and actual, environment and evidence
- [ ] A test that fails today for the right reason, committed on its own branch

## Your log
Keep it in [log.md](log.md).
