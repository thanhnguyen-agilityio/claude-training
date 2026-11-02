# Prompt log — email digest

Prompts used with Claude (claude.ai) for this project, in order. After each use, fill in
**Result** and **Next time**. Copy a prompt to the reusable library only after it worked twice.

Patterns that keep working (candidates for claude.ai preferences):

- "When you give options, mark your recommendation and say why."
- "Stop after each task and wait for my verdict."
- "Use only what we agreed; write TBD for anything undecided."
- "Output only the changed sections."

## 1. Lesson 7 — planning kickoff

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

- **Result:** clear vision, success criteria and spec; decision to build. Claude answered in
  Vietnamese (from memory). At first it gave options without a recommendation.
- **Next time:** add "mark your recommended option" from the start.

## 2. Lesson 7 — wrap-up summary

```text
Great, let's wrap up. Fill in this plan using only what we agreed in this chat. Don't add new
ideas. If something wasn't decided, write "TBD". Output it as Markdown I can copy.

## 1. Vision and goals
- What success looks like:
- Why this matters to me:
- Out of scope:

## 2. Build vs. reuse (Platform Awareness)
- Does the Inbox triage template already cover my need?
- What can I reuse from my writing-training-reports skill?
- What it lacks for me:
- Decision: use / adapt / build — because:

## 3. Task breakdown and delegation
| # | Task | Me / Claude / together | Why |

## 4. Risks to remember for Diligence
- Company email privacy:
- Read-only access, no auto-send:
```

- **Result:** a complete plan, but the delegation column was mostly TBD and the scope was too
  big for 1h.
- **Next time:** ask for "Me / Claude / together" per task explicitly, and a "When" column.

## 3. Lesson 7 — close the gaps

```text
Let's close the gaps before I execute:
1. Fill the Me/Claude/together column for tasks 3–10, with a one-line reason each.
2. Mark which tasks fit my ~1h Lesson 11 session (one loop: tasks 4 → 6 → 8 for 1–2 sections)
   and which move to Day 7–9.
3. Test output goes to a DM to myself from day 1 — update the spec and risks.
4. Replace "since last run" with a fixed window (24h, 72h on Monday).
Output only the changed sections.
```

- **Result:** all four gaps closed; only the changed sections came back, easy to merge.
- **Next time:** keep "output only the changed sections" for every follow-up.

## 4. Scope change — make the kit shareable

```text
Mình chọn "Chỉ hướng dẫn". Thêm mấy điểm:
1. Ưu tiên search query (subject prefix, group address) thay vì bắt user tạo label/filter.
   Chỉ Projects cần label — hỏi optional "label nào chứa project của bạn?".
2. Bổ sung config còn thiếu: report subject prefix (để tìm reply cho report), giờ chạy + timezone, ngôn ngữ.
3. Config lưu ở đâu để scheduled task đọc được? Ghi là open question, test ở Day 7–9.
4. Phần shareable + first-run setup là Day 7–9, không thuộc Lesson 11 loop.
   Lesson 11 vẫn hardcode giá trị của mình, nhưng SKILL.md có sẵn section Config.
Chỉ output các section thay đổi: spec, tasks, risks.
```

- **Result:** Config table, first-run setup, tasks 11–12 and sharing risks added. Claude missed
  that Gmail search ignores brackets (caught in review).
- **Next time:** ask "what could go wrong with these search queries?" before accepting.

## 5. Lesson 11 — execution kickoff

```text
This is Lesson 11 of my AI Fluency course: executing my project with Description-Discernment
loops. The attached plan.md is my agreed plan for an "email digest" skill.

Scope for this session (~1h): tasks 4 → 6 → 8 for two sections only, 🔴 Approvals & Admin and
🔥 Projects, with my values hardcoded in a Config section. Nothing else from the plan.
My active Projects sub-labels: <list them here>

How I want us to work:
- Product: for task 4, a short table per search (query, count, verdict), no email content.
  For task 6, a SKILL.md draft with a Config section, the 2 section queries, the 24h/72h
  window, the Slack format and read-only safety rules. For task 8, the digest as a Slack DM
  to myself.
- Process: one task at a time. Use only Gmail read tools, never draft/send/label/trash. In
  task 4 test two risks first: (1) does subject:[fp] match only [fp] subjects, and does
  [training] also catch my own [<team>][training] report threads? (2) how are my nested
  Projects sub-labels (with emoji) written in search, and does label:Projects alone include
  sub-label-only mail?
- Performance: be concise. When you give options, mark your recommendation and say why. Stop
  after each task and wait for my verdict before moving on.

Start with task 4: Approvals queries first.
```

- **Result:** task 4 tests caught the bracket issue (`[training]` matched 639 threads) and
  showed the parent label doesn't include sub-label mail. Claude wrongly claimed dots matter in
  group addresses; I corrected it. SKILL.md draft followed, with 3 choices marked "recommended".
- **Next time:** give the real config values (addresses, sub-labels) up front so Claude doesn't
  guess them.

## Lesson 11 — follow-up prompts

<!-- Add prompts used during the loop here: feedback, refinements, corrections. -->

### 6. Verdict on the SKILL.md draft

```text
Verdict on the 3 choices: 1 ok, 2 ok, 3 ok (gist must keep names and dates).

Fix these in SKILL.md before task 8:
1. Group address is unverified: both to:asoft.all@ and to:asoftall@ returned 0 in 14d.
   Re-test both over 180d and keep the one that returns mail. Remove the guess in the notes.
2. Count subject:permission hits over 180d that are not real requests (Drive access,
   "permission denied", etc.). If there is noise, tighten the query or the post-check.
3. Replace the sender name in the format example with a placeholder like <Sender>.
4. Make the description neutral for sharing: no personal name, "the user" instead of a pronoun.
5. Line 8 says "since the last run" — change to the fixed 24h/72h window.

Then do task 8: dry run "up to now", posted as a Slack DM to me.
```

- **Result:** all 5 fixed. Re-testing found `asoft.all@` is correct, and that the connector
  doesn't support epoch `after:`/`before:`, so the skill now fetches by day and checks each
  message's time.
- **Next time:** ask for verification evidence (query + count) for every claim, not just a
  verdict.
