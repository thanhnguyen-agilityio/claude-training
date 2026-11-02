# Lessons 8–10: Expanding Claude's reach

Bring your tools, your company knowledge and the web into the conversation.

## Lesson 8 — Connecting your tools

**Core idea:** connectors let Claude reach the tools where your work lives, so you ask about the
real file or thread instead of pasting copies. Claude can search, read and (if allowed) act.

**Key points**
- Powered by **MCP (Model Context Protocol)**, an open standard, "like USB-C for AI".
- Two kinds:

| Kind | Runs | Examples | Use for |
| --- | --- | --- | --- |
| Web connector | Cloud services | Google Drive, Gmail, Slack, Notion, Asana, Linear, Stripe | Hosted services |
| Desktop extension | Locally via the Desktop app | Local files, browser control, native apps | Things on your computer |

- The directory lists connectors, not single apps (the Atlassian Rovo connector covers Jira and
  Confluence). No entry? Add a custom connector.

**Set up a web connector**
1. Customize > Connectors, or "+" in a chat > Connectors.
2. Click Connect (on Team/Enterprise an Owner must add it for the organization first).
3. Sign in to the service.
4. Review and grant permissions.
5. Test: "Can you access my [tool]?"

**Desktop extension:** install the Desktop app > Settings > Extensions > Install > follow steps.

**Example requests:** "What are my top tasks this week?" (project tools); "Find the email thread
about the vendor contract" (Slack/Gmail); "Search our brand voice guidelines" (Notion/Drive/
Confluence); "Show revenue trends last quarter" (Stripe, HubSpot).

**Security**
- Scoped permissions; you can toggle each one.
- Claude only sees what *you* can see.
- Disconnect any time (Customize > Connectors or the service's security settings).
- Install custom connectors only from trusted sources.

**Exercise (interactive):** toggle cloud storage, email and team chat on and off. A connection
gives you more places to point a request; it does not make Claude search by itself.

**Reflect:** Which tool is most valuable to connect? What copy-pasting could go away? Which
workflows combine several sources?

## Lesson 9 — Enterprise search

**Plan:** Team and Enterprise only; an admin must enable it. Others can skip.

**Core idea:** a dedicated "Ask {Your Org}" item in the sidebar: like a ready-made project for
the whole company, built for finding and combining knowledge across tools. It has custom
instructions set by Anthropic and is made for information gathering (unlike a normal chat with
connectors).

**Good questions:** catch up after time away; policies and processes (remote work, expenses, time
off); research across sources (why customers pick competitors); onboarding (who to ask, how a
system works); tracking decisions and contributions.

Claude searches connected tools (SharePoint, Slack, Gmail, Google Drive...) and gives one
answer **with cited sources**.

**Setup**
- *Admin (Owner):* "Ask Your Org" > "Set up for your org" (or Disable) > connect tools (a Documents
  connector and a Chat connector required; Email optional) > "+ Add more" > name the project >
  add description > "Finish set up".
- *User:* open the starred project > follow guided onboarding > sign in to each service > ask.
  More connectors = better results; add later via "Connect" in the project's Instructions.

**Safety:** you only see what you already have permission to see in the source tool; chats stay
private; connected data is not indexed or stored separately.

**Reflect:** Which questions do you often ask colleagues? Where would it help onboarding? Which
sources matter most for your role?

## Lesson 10 — Research mode for deep dives

**Plan:** paid plans (Pro, Max, Team, Enterprise).

**Core idea:** Research turns Claude into a systematic investigator: many searches that build on
each other, across the web and your connected integrations, ending in a cited report. It takes
minutes, not seconds, and uses Thinking to plan first.

**How it works**
1. Plans: breaks the request into parts.
2. Searches many times, choosing the next step from what it finds.
3. Synthesizes web plus connected sources (Gmail, Calendar, Drive).
4. Cites every claim so you can check it.

**Pick the right tool**

| Need | Use |
| --- | --- |
| Multi-source report, comparison, verifiable citations | **Research** |
| One quick fact, one or two sources | Web search |
| Deep reasoning without outside info (math, debugging, logic) | **Thinking** |
| Answers from your company's own knowledge | **Enterprise search** |

**Use it:** "+" at bottom left > Research (it highlights) > enter prompt > Claude works in the
background with progress indicators. Web search must be on (in the new Claude experience there is
no toggle; Claude searches when it helps).

**Good Research prompts**
- Be specific about the goal (not "tell me about EVs").
- Name the structure/sections you want.
- Add constraints (budget, time, region).
- Ask Claude to help you improve the prompt first.
- With integrations, steer: "pull context from my Google Drive", "include my recent emails".

**Exercise (interactive):** route five sample questions to the right tool; then compare two
Research prompts and pick the stronger one.

**Reflect:** Which tasks need many sources? What complex question have you postponed because
research is slow?
