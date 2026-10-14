# Eval — `writing-training-reports`

Method (Claude 101, *Evaluating Claude for your workflows*): gather examples → test the prompt → compare outputs → refine. Answer keys = training report emails already sent. Skill: [SKILL.md](../../ai-kit/.claude/skills/writing-training-reports/SKILL.md).

## 1. Gather answer keys (5–10 sent reports)
Search Sent for `[bgh][training]`. Pick reports that differ: plain daily · weekly · with issues/questions · several tasks · vague next plan that needed clarifying.

Picked K1–K7 and drafted raw notes for 8 cases → [writing-training-reports-cases.md](writing-training-reports-cases.md). Cases below map to those keys.

## 2. Test cases
Each case = raw notes as typed during the day (short, out of order, links unformatted). Run in a **fresh chat**.

| # | Test | Raw notes include | Expected |
|---|---|---|---|
| 1 | Daily, complete info | everything | Matches sent email closely |
| 2 | Weekly | date range, 4–5 tasks | "This week…", title date = last working day |
| 3 | Notes over a session | 3–4 separate messages | Merged, no duplicates |
| 4 | Missing commit + link | no hash, no repo URL | One message asking; nothing invented |
| 5 | Vague plan | "tomorrow: continue #26" | Rejects it, asks for sub-tasks |
| 6 | Issue, no link | error text + what was tried | Short issue: what, where, error, tried |
| 7 | New user (generic) | no name/recipients known | Profile step runs; no example names leak |
| 8 | Saved profile | `Training report profile` block in memory, prefix `hf` | No setup questions; subject starts `[hf][training]` |
| 9 | Thin notes | "learned caching. tomorrow: continue" | Says report is thin, ≤3 specific questions; "draft as is" skips |
| 10 | Secret in notes | notes paste a `.env` line with an API key | Key left out of the report; user told why |

## 3. Grade
Course's 3 questions: key info captured (nothing dropped/invented)? tone/style right (slightly formal, concise)? what is missing?

Pass/fail checks per case:
- [ ] Title exactly `[<team>][training] YYYYMMDD #tags`
- [ ] `asoft.training@asnet.com.vn` in CC
- [ ] All links clickable (issue, branch, commit, course, references)
- [ ] Every next-plan item specific
- [ ] Empty ISSUES section omitted
- [ ] Signature = correct name
- [ ] Gmail draft created, not sent; edits update the same draft

## 4. Log
| Case | Title | CC | Links | Plan | ISSUES | Sig | Draft | Diff from original (1 line) |
|---|---|---|---|---|---|---|---|---|
| 1 | | | | | | | | |
| 2 | | | | | | | | |
| 3 | | | | | | | | |
| 4 | | | | | | | | |
| 5 | | | | | | | | |
| 6 | | | | | | | | |
| 7 | | | | | | | | |
| 8 | | | | | | | | |
| 9 | | | | | | | | |
| 10 | | | | | | | | |

## 5. Refine and retest
- Same miss across cases → fix the skill (add rule or good example), rerun **only failed cases**.
- Miss from missing input → add it to what the skill asks for.
- Pass consistently → trust for daily use, still read each draft before sending. Still failing after a few rounds → stays a manual check.

### Changes made to the skill
- 2026-10-14: merged Fields + Validation checklist into one Rules list; moved the example to `example.md`; fixed the Gmail tool lookup (uuid-prefixed names, `htmlBody`). SKILL.md 1204 → 739 words. Rerun all cases.
- 2026-10-14: setup-once profile block (team prefix, To, CC list, course, hashtags, repo); prefix no longer hard-coded to bgh. Added case 8.
- 2026-10-14: added Coaching section (flag thin reports, ask ≤3 questions). Added case 9.
- 2026-10-14: wrote for the company training group: status / learning / help; takeaways = reusable insight; issues end with the help needed; safety rule for secrets. Example updated. Added case 10.
- 2026-10-14: compacted for daily use: merged Routing/Collect/Write into Workflow, Coaching points at ★ rules (no duplicate list), dropped copy-checklist, shorter description. 1153 → ~644 words.
- 2026-10-14 (real run, My Le profile): coaching turned lesson lists into reusable takeaways ✅; empty sections omitted ✅; sender/Gmail mismatch flagged ✅. Misses: greeting "Hi Xuan Mai" (full name) → profile stores greeting name; plan drafted without sub-tasks → coaching now proposes a concrete answer "ok" accepts; repo-created item nagged for takeaways → ★ applies to learning/practice items only.
- 2026-10-14 (real run 2, setup from scratch): setup asked 7 fields + team choice in one message ✅; greeting clarified ✅; user notes shaped into reusable takeaways ✅; plan sub-tasks accepted with "ok" ✅. Misses: description truncated at " #tags" (YAML comment) → removed #; profile block left with TODO after gaps answered → output complete block once known; proposed takeaways invented from lesson titles → proposals limited to plan/ranges/links.
