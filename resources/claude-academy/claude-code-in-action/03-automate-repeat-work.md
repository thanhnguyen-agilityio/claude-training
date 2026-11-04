# Lessons 6–7: Automate repeat work

Hand recurring prompts to cloud scheduled tasks or headless runs, and wire Claude into pull
requests.

## Lesson 6 — Scheduled tasks and headless (7 min)

- Once you trust a task, stop starting it by hand. Options form a spectrum from "build nothing"
  (cloud scheduled tasks on Anthropic's infrastructure) to "full control" (headless mode and the
  Agent SDK in your own code).

**Cloud scheduled tasks** (formerly "routines")
- A saved bundle of **prompt + repository + connectors + trigger**, run in the cloud. No machine
  of yours stays on, no workflow file to maintain.
- Triggers: a **cron schedule**, an **HTTP POST** to its endpoint, or a **GitHub event** (e.g. a
  new PR).
- Good fits: morning dependency audit, PR triager, daily scan of Sentry issues.
- Create one at claude.ai/code/routines, or from the terminal with `/schedule <plain-language
  description>`, e.g. `/schedule daily dependency audit at 9am`.

Limits to know:
- **Research preview**: behavior and limits will change.
- Recurring schedules run **at most hourly**.
- Runs start from a fresh clone of the default branch and push to a **`claude/` branch** unless
  the prompt names another. A PR-event run starts from the PR head commit (first repo only).
  Restrict pushes with GitHub branch protection or rulesets; a rule your connected access can
  bypass won't stop the push.

**Headless (non-interactive) mode**
- `claude -p "<prompt>"` (`--print`): one-shot, no UI, reads stdin, writes stdout, pipes like any
  shell tool.
- `-p` alone still loads hooks, skills, plugins, MCP servers and CLAUDE.md.
- **Structured output**: `--output-format json --json-schema '<schema>'`; the matching object is
  in `structured_output` (extract with `jq '.structured_output...'`).
- **Multi-step**: save `session_id` from the JSON output and continue later with
  `claude --resume <id>` (e.g. plan in one script, execute in another).
- **`--bare`** for CI: skips auto-discovery of hooks, skills, plugins, MCP and CLAUDE.md; you get
  Bash, read and edit tools plus whatever you pass (`--settings`, `--mcp-config`). Same setup on
  every machine, faster start. Needs `ANTHROPIC_API_KEY` (no subscription login).

**Agent SDK**
- Library for TypeScript and Python: a `query` function with the CLI's primitives. Pass a
  prompt plus options (`allowedTools`, system prompt, permission mode) and iterate over
  streamed messages.

**Which to use**

| Need | Choose |
| --- | --- |
| Repeat work, nothing to host | Cloud scheduled task (default) |
| Job needs your pipeline, pipe data through a script | `claude -p` |
| CI needs identical setup on every machine | `claude -p --bare` |
| Work belongs inside your own product | Agent SDK |

**Recap:** start with cloud scheduled tasks; move down the spectrum only when you need more
control.

## Lesson 7 — GitHub Actions and Code Review (6 min)

- The pull request is the best handoff point. Two options: a **managed service** you switch on
  (Code Review) or a **GitHub Action** you wire up yourself.

**Managed path: Code Review**
- Anthropic-hosted; reviews PRs through the Claude GitHub app and posts **inline comments**.
- Setup: an Owner of the Claude org turns on **Allow code review** in Claude Code admin settings,
  installs the GitHub app (a GitHub org owner may need to install and link it first), picks repos
  and timing:
  - once when a PR opens,
  - on every push,
  - only on a `@claude review` comment.
- Review agents analyze the diff **against the whole codebase**, then post findings tagged by
  severity, deduplicated and ranked, plus a summary table in the check run.
- Limits: it **never approves or blocks** a PR and **never pushes fixes**. Team and Enterprise
  plans only.
- You fix and push. To check locally first, run `/code-review` in your terminal; `--fix` applies
  its findings to the working tree.

**DIY path: `anthropics/claude-code-action@v1`**
- For custom CI beyond review: implement from a comment, scheduled reports, any GitHub event.
- Setup: `/install-github-app` in Claude Code (needs repo admin); it installs the app and sets
  the API key secret.

| Input | Purpose |
| --- | --- |
| `anthropic_api_key` | Needed for Claude API runs, unless using `claude_code_oauth_token` or workload identity federation |
| `github_token` | Optional; default is the installed Claude GitHub app |
| `trigger_phrase` | Comment phrase to listen for (default `@claude`) |
| `use_bedrock` / `use_vertex` / `use_foundry` | Route through a cloud provider with your cloud sign-in |
| `prompt` | Run on the event without waiting for a mention |
| `claude_args` | CLI arguments passed to Claude Code |

- **Mention workflow** (`.github/workflows/claude.yaml`): listens for `@claude` on PR and issue
  comments; grant `id-token: write`. Claude pushes commits and comments on what it did.
- **Scheduled workflow**: cron trigger (e.g. 09:00 UTC) runs a prompt; read the output in the run
  log (no comment posted). Add `workflow_dispatch` to run it manually.
- Tune with `claude_args`: `--max-turns` caps the loop, a non-prompting permission mode for
  unattended jobs, and only the tools needed (read-only for a report).

**Recap:** use Code Review for PR reviews; use the action when Claude has to *do* something in
CI.
