<!-- Source: https://dojo.agilityio.dev/schedule/day-08.html — saved 2026-10-12. Internal training material. -->

Week 2 · Track split

# Day 08

Developer track · BA/QA track

## Developer track — Extend, automate, review

### MCP and connectors

- **Course:** [Introduction to model context protocol](../courses.md).
- Add the GitHub connector; add the Playwright MCP server.

**Exercise**

Use one MCP tool end-to-end in a session (e.g. query PRs, comment on one).

## BA/QA track — Automated testing

### Browser automation

- Playwright MCP in a session: drive the training web app by chatting (navigate, fill, assert); Claude in Chrome on a signed-in site; computer-use demo on a GUI-only tool.

**Exercise**

Automate one real user journey end-to-end from the ticket pack's criteria.

## Skills today

### Developer track

**MCP connectors (GitHub first)** — Claude reads real PR/ticket state instead of guesses.
*How to set up:*
1. Open a terminal in your repo and paste: `claude mcp add --transport http github https://api.githubcopilot.com/mcp/`
2. Restart the session and sign in when GitHub asks — PR and ticket tools now appear in the session.

**Playwright MCP (devs too)** — Drive and verify the running app from a session.
*How to set up:*
1. Install Node.js if you don't have it (nodejs.org).
2. Open a terminal in your repo and paste: `claude mcp add playwright -- npx -y @playwright/mcp@latest`
3. Restart the session; browser tools (open, click, screenshot) are now available.

### BA/QA track

**Playwright MCP browser automation** — Chat-driven end-to-end journeys from the ticket's criteria.
*How to set up:*
1. Install Node.js if you don't have it (nodejs.org).
2. Open a terminal in your repo and paste: `claude mcp add playwright -- npx -y @playwright/mcp@latest`
3. Restart the session, then ask in plain words: "run the journey in the ticket's Given/When/Then and show screenshots."

---

Related: [Course catalog](../courses.md) · [Developer track](../developer.md) · [BA/QA track](../ba-qa.md) · [Shared fundamentals](../fundamentals.md)
← [Day 07](day-07.md) · Next → [Day 09](day-09.md)
