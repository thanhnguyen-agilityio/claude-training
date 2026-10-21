# Task 3: Run the app from scratch

## Scenario
You can't reproduce a bug in an app you can't run. Get `sample-project/` running on your own machine from a clean checkout, and write down every step that wasn't obvious. Those notes become the "environment" part of your bug report.

## Before you start
- Install `uv`, `make` and `pre-commit`. You need Python 3.11 or newer.
- Have an OpenAI API key with credit.
- Do this on your own machine. The cloud session can't hold your key and doesn't have the project's dependencies installed.

## Steps
1. `cd sample-project`
2. `uv sync`
3. `cp .env.example .env`, then fill in `OPENAI_API_KEY`. Leave the SerpAPI key empty. Set `LANGCHAIN_TRACING_V2=false` if you have no LangSmith key. Add `RECENT_MESSAGE_LIMIT=3` so summarization starts after a few messages. The default is 5.
4. `make load_env`
5. `make create_knowledge_base` (once)
6. `make run_server`. It serves on port 8080. Open `http://127.0.0.1:8080/docs` to check.
7. In a second terminal, `make run_client`, which starts the Streamlit client.
8. Send a message such as "hello" and confirm you get a reply.

`sample-project/assets/debug.md` lists a faster check: the playground at `http://localhost:8080/chat/playground/` with the body `{"message": "hello", "thread_id": "<any uuid>"}`.

## When something breaks
Paste the exact error and the command you ran into chat, and ask for hypotheses. Then run each fix, one at a time. Write down the one that worked.

## Checklist
- [ ] The server starts and `/docs` loads
- [ ] The client starts and "hello" gets a reply
- [ ] You have a list of every step that wasn't in the README, or an empty list
- [ ] `.env` is not committed (check `git status`)

## Your log
Keep it in [log.md](log.md).
