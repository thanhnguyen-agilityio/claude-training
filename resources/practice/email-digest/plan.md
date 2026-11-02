# Lesson 7 — Project plan: email digest

Output of the Lesson 7 planning chat with Claude (claude.ai). Only decisions agreed in the chat;
anything undecided is marked TBD.

<details>
<summary>Kickoff prompt used</summary>

```text
I'm doing the AI Fluency course project. My project is an "email digest": a Claude skill plus a
scheduled task that summarizes my company Gmail every weekday at 08:30, read-only.

claude.ai already has an "Inbox triage" template (sorts the inbox into categories and drafts
replies to urgent mail, weekdays 8:00 AM). I'm not sure whether to use it, adapt it, or build
my own. I also have my own skill, writing-training-reports, which drafts outgoing report emails
through the Gmail connector; I could reuse its structure, safety rules and evals.

Before we plan anything, ask me questions one at a time until we both have a clear picture of
what success looks like and why this matters to me. Then we'll break it into tasks.
```

</details>

## 1. Vision and goals

- **What success looks like** (after 2 weeks of real use):
  - No approval email (`[fp]` / "permission") is missed — every one appears in the digest
  - The digest takes ~3 minutes or less to read
  - I don't need to open Gmail to know the morning status — I only open it to reply

- **Why this matters to me:**
  - I receive too many company emails; labels and filters alone aren't enough to know what
    needs attention each morning
  - Day-off / WFH requests from mentees, supportees and team members need my reply right away —
    missing them blocks people
  - I want to catch up on 4 areas quickly: projects, approvals & admin, my training & support,
    and company training status

- **Out of scope:**
  - Drafting or sending replies (Gmail stays read-only)
  - Sending the digest by email or as a Gmail draft
  - Project / training "modes" — all 4 groups are always scanned
  - Old projects with no new emails

## 2. Build vs. reuse (Platform Awareness)

- **Does the Inbox triage template already cover my need?**
  No. Its prompt: triage the inbox each weekday morning, group new emails by urgency, summarize
  each in one line, and draft replies to anything needing a response today. It groups by generic
  urgency, not by my 4 groups, and drafting replies breaks the read-only requirement.

- **What can I reuse from my writing-training-reports skill?**
  - Skill structure
  - Safety rules — inverted: instead of governing how to draft mail, forbid every Gmail write tool
  - The approach to writing evals

- **What it lacks for me:**
  - Reads Gmail by my 4 groups (labels, subject prefixes, group addresses)
  - Re-surfaces unreplied approvals for up to 7 days
  - Posts to Slack instead of drafting in Gmail

- **Decision: build** — because my requirements are specific (the `Projects` label tree,
  `[fp]` / `[internship]` / `[training]` prefixes, `asoft.all@` and `asoft.training@`,
  unreplied-approval tracking) and a generic template doesn't know them. Building also shows the
  delegation and discernment process for the course.

### Agreed spec

- **Schedule:** every weekday, 08:00 (Asia/Saigon)
- **Output:** one Slack message, sent as a DM to myself from day 1 (testing and real use)
- **Language:** English only; email subjects kept as original
- **Sections** (in priority order):

  | Section | Source |
  |---|---|
  | 🔴 Approvals & Admin | Subject contains `[fp]` or "permission"; emails to `asoft.all@asnet.com.vn` |
  | 🔥 Projects | All sub-labels under the `Projects` label |
  | 🎓 My training & support | Replies to my reports; `[internship]` / `[training]` emails to/cc me |
  | 📊 Company training pulse | Emails cc'd to `asoft.training@asnet.com.vn` — shown as stats: number of trainees, topics, who has issues |

- **What counts as "new":** fixed window of the last 24h (Monday: last 72h, covering
  Fri 08:00 → Mon 08:00), plus approvals I haven't replied to, re-surfaced for up to 7 days
- **Format:** one line per item (sender · gist · Gmail link); max ~5 items per section,
  "+N more" beyond that; empty sections hidden

## 3. Task breakdown and delegation

| # | Task | Me / Claude / together | Why | When |
|---|---|---|---|---|
| 1 | Reconnect Slack connector | Me — ✅ done | Needs my account; digest goes to a DM to myself | Done |
| 2 | Review the Inbox triage template | Me — ✅ done | Only visible in my account; finding: it drafts replies, so not read-only | Done |
| 3 | Review `writing-training-reports` and identify what to reuse (structure, safety rules, evals) | Together | Claude reads the skill and proposes what to reuse; I decide, since it's my own conventions | Day 7–9 |
| 4 | Test read-only Gmail searches per section; check how search matches the `Projects` label tree (labels contain emoji) | Together | Claude runs the searches; only I can judge whether the results are the right emails | Lesson 11 (1–2 sections); rest Day 7–9 |
| 5 | Test the "unreplied approval" logic (check the thread for a message from me after the request) | Claude | Mechanical thread check; I spot-check a few results | Day 7–9 |
| 6 | Write SKILL.md: section queries, time-window logic, Slack format, safety rules | Together | Claude drafts from the agreed spec; I review against how my inbox actually works | Lesson 11 (1–2 sections + read-only safety rules); rest Day 7–9 |
| 7 | Write evals: the 3 success criteria + technical evals (pulse numbers correct, no noise, no Gmail write tools called) | Together | I provide ground truth (which emails really arrived); Claude turns it into eval cases | Day 7–9 |
| 8 | Manual dry run in chat → DM to myself → refine | Together | Claude runs it; only I can judge whether it reads in ~3 minutes | Lesson 11 (1–2 sections); full digest Day 7–9 |
| 9 | Create the weekday scheduled task | Claude | Claude creates it; I approve it and check its approval setting | Day 7–9 |
| 10 | Run for 2 weeks and measure the 3 success criteria | Me | Only I can judge reading time and whether I still needed Gmail | Starts after Day 9 (2 weeks) |

**Lesson 11 loop (~1h):** tasks 4 → 6 → 8 for **🔴 Approvals & Admin** and **🔥 Projects**.
Approvals is the top priority; Projects tests the emoji-label risk early. The unreplied-approval
logic (task 5) stays out of this loop, so Approvals uses only the fixed window for now.

## 4. Risks to remember for Diligence

- **Company email privacy:**
  - The digest contains leave / WFH requests and mentee issues, so it goes as a DM to myself
    from day 1, never to a shared channel

- **Read-only access, no auto-send:**
  - Only Gmail read tools are allowed; send, draft, label, trash and every other Gmail write tool
    is forbidden in the skill's safety rules
  - The only write action is posting the digest to the configured Slack channel
  - Evals check that no Gmail write tool is called

## Reflection

<!-- In my own words, not Claude's. -->

- What surprised me in the planning chat: Claude answered in Vietnamese, because it knows I'm
  Vietnamese from its memory.
- Hardest part of the plan: how to define the success of the plan.
- What would help me delegate better: at the beginning, Claude only gave questions and some
  options without its recommendation. I asked it to mark its recommended option so I could
  prefer it, and its picks were almost always correct.
