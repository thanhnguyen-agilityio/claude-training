<!-- Source: https://dojo.agilityio.dev/ba-qa.html — saved 2026-10-12. Internal training material. -->

Track 2 · BA / QA

# BA/QA Track: Ticket Planning and Automated Testing

BA / QA · Weeks 2–3 · Days 4–11

Goal: BAs plan and specify tickets in Claude Desktop (Chat + Cowork tabs); QAs design tests and run real automated testing — from ticket to test suite to CI — with Claude doing the typing.

BA/QA keep everything they learned in the [shared track](fundamentals.md): git, PRs, and the verify-before-trust mindset still apply. Trained in [Days 4–11 of the schedule](schedule/day-04.md).

## Where each tab fits

| Tab | BA uses it for | QA uses it for |
| --- | --- | --- |
| **Chat** | Daily thinking partner: summarize, extract, draft tickets & docs; Projects to organize per-client work; artifacts for shareable specs | Test design, bug analysis, drafting test cases from acceptance criteria |
| **Cowork** | Multi-step work: research with browser tasks, document/spreadsheet production, task loops; **Dispatch** to kick off work from the phone | Coordinating longer test-prep work; Dispatch-spawned sessions |
| **Code** | (Optional) reading the repo to check a spec against reality | **Automation engine**: run test suites, author Playwright tests, triage CI |

## BA: ticket planning that devs can implement

The BA's product is a ticket a developer can start on without a meeting.

1. **Capture.** Rough request comes in (email, call, client chat). Paste it into a **Project** (per client, so context persists) and ask Claude to extract: actors, goal, constraints, open questions.
2. **Investigate.** In Cowork, run research tasks: competitor behavior, regulations, library docs — Claude browses, reads, and returns a document you edit.
3. **Specify.** Draft the ticket with Claude: user story, acceptance criteria (Given/When/Then), scope/non-scope, design sketches where relevant. Edit the draft; you own the words. Publish the spec as an **artifact** so devs and the client open one link, always-current.
4. **Connect.** Add the repo/tracker connector (GitHub, Jira-class tools via MCP connectors) so Claude can read real state instead of guesses: "which tickets mention the checkout flow?" without leaving the chat.
5. **Triage.** Morning routine: Claude summarizes what changed across the tracker and flags blockers, stale tickets, and criteria gaps.

### Habits

- One Project per client; never mix client data across threads (confidentiality rule).
- Every ticket leaves your desk with testable acceptance criteria — QA converts them directly into cases (below).
- Let Claude write the first draft of everything; never let it write the last one unedited.

## QA: test planning

1. **From ticket to cases.** Paste the ticket; ask for a test matrix: happy paths, edge cases, negative tests, permission/data variations. Delete the nonsense, add what you know breaks. That matrix is the checklist for both manual and automated coverage.
2. **Test plan per feature.** Scope, environments, data setup, risks, what's NOT tested. Draft with Claude in a Project thread; share as an artifact.
3. **Bug reports that reproduce.** Template: steps, expected, actual, environment, evidence. Feed Claude your rough notes/screenshots and get the report back in the template; paste the repro into the ticket — the dev's shared-fundamentals skill (reproduce → fix) starts from your report.

## QA: automated testing with Claude

You already learned git/PRs in the shared track; now use them for test code.

1. **Author.** In the desktop app's **Code** tab on the product repo: "write Playwright tests for the acceptance criteria of ticket #123." Review the generated spec like any PR — you can read a test even if you don't write test code from scratch.
2. **Run & iterate.** Claude runs the suite, reads failures, fixes selectors/waits, and re-runs. You watch the browser pane (web) or simulator (iOS) to see what actually happened.
3. **MCP tooling.** Add the Playwright MCP server for browser automation from chat; use **Claude in Chrome** to drive sites you're signed into; use **computer use** for GUI-only tools (native apps, game builds) where there's no API.
4. **CI.** Tests run in GitHub Actions on every PR. When red, paste the failing job into a session: "triage this failure — real regression, flaky test, or environment?" `/loop 15m watch the run and tell me when it's green` while you do something else.
5. **Report.** Ask the session for an **artifact**: a test-run dashboard (pass/fail by area, flaky list, coverage vs the ticket's acceptance criteria) that pulls fresh data through connectors when opened.
6. **Own it.** Test code lives in the repo, reviewed and merged like any other PR — your name is on the suite's quality, not Claude's.

## Phone work (both roles)

- **Dispatch** in Cowork (Pro/Max): kick off "prep the regression notes for release 2.4" from your phone; get a push notification when the session finishes.
- **Remote Control**: keep a long QA session alive on your machine and steer it from the mobile app between meetings.

## Skill bar (end of track)

**BA**

1. Produce a ticket pack (story + Given/When/Then criteria + open questions + artifact spec) from a raw client request, inside 90 minutes.
2. Run a Cowork research task and turn it into a decision document.
3. Answer "what changed in the tracker this week?" from a connector-backed summary.

**QA**

1. Turn any ticket's acceptance criteria into a reviewed test matrix.
2. Ship an automated Playwright spec, authored with Claude, merged through a PR, running green in CI.
3. Produce an artifact test report for a full regression run and triage one CI failure with Claude to a root-cause sentence.
