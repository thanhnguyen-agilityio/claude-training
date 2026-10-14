# Test cases — `writing-training-reports`

Answer keys = your sent `[bgh][training]` emails (find in Gmail Sent by subject; bodies not copied here). Raw notes = what you'd plausibly have typed that day. Run each in a **fresh chat**, then grade with the checks in [writing-training-reports.md](writing-training-reports.md).

Only emails 2025-10 → 2026-06 were read (8 of ~200). No weekly report found yet — case 2 is synthetic.

## Answer keys picked

| Key | Subject (date) | Type | Why chosen |
|---|---|---|---|
| K1 | `20251003 #nestjs #practice` | daily, complete | Learning + practice + doc links + full source block + specific plan with 3 sub-tasks |
| K2 | `20251111 #llm #mcp #deepeval #practice` | daily, nested bullets | Reading + practice, 2 next-plan items |
| K3 | `202511110 …` (10 Nov; subject date has a typo) | daily, vague plan | Has IN PROCESS section; next plan is just "Continue working on practice" |
| K4 | `20260605 … #resume` | daily, with issue | Issue + IN PROCESS; one plan item is "Continue …" |
| K5 | `20251120 … #practice` | daily, issue link + pause | Issue `#9` link; "Git repository: repo-name" placeholder left in; plan = pausing training |
| K6 | `20251027 #nestjs #end` | course end | Public presentation + slide link; plan = next course |
| K7 | `20260526 #inform`, `20260608` | non-report notices | Pause / can't attend; no FINISHED/PLAN |

## Raw notes per case

Profile used for cases 1–6: sender Thanh Nguyen; mentor Cong (CC); GitLab `gitlab.asoft-python.com/thanh.nguyen/...`.

### Case 1 — daily, complete (key K1)
Supporters Hoang and Duc. Nest plan https://docs.google.com/document/d/1h68RXVjbavgiGz9M8EBg8ZooGAkT3rcr5sivokwTTuk/edit?tab=t.0
learned serialization. practice: get profile by id or me, split seeding service, RolesGuard. notes in practice doc tab jxm0cw2pi9k8.
repo nodejs-training, branch feat/analytics-dashboard, folder nestjs/analytics-dashboard, commit 15e7590.
tomorrow: Sales Analytic Dashboard practice — serializer for response, pagination for list, finish user mgmt APIs.
tags #nestjs #practice

**Expected:** matches K1 closely. Differences to accept: the skill adds ISSUES only if given.

### Case 2 — weekly (synthetic)
Weekly, 20–24 Oct 2025. NestJS plan same link as case 1. Mon–Tue: api versioning; Wed: caching; Thu: fix tests after updates; Fri: load testing evaluation.
repo nodejs-training, branch feat/analytics-dashboard, folder nest/analytics-dashboard, last commit 3a0f187. Supporters Hoang and Duc.
next week: public presentation of practice (slide), then start MCP + DeepEval.
tags #nestjs #practice

**Expected:** title `[bgh][training] 20251024 #nestjs #practice #weekly`; opens "This week, I learned/continued…"; items merged by theme, not by day.

### Case 3 — notes over a session (key K2)
Send as 4 separate messages, then "write the report":
1. `read MCP illustrated guide book https://drive.google.com/drive/folders/17UK9shqRgi4-TPwI554C2NwmmKmwDYy5`
2. `practice: implement RAG MCP server. verified it with MCP inspector`
3. `practice doc https://docs.google.com/document/d/1qNOpANq1UudiQ5q4iFt3PAEFFUtjJ5ybHy-Fi0Bm4sM/edit  | plan https://docs.google.com/document/d/1Bi43NK2VQAL_zTNevTFgp4NfMKPkMxPcsGMBJbq0RzY/edit | repo mcp-deepeval-training, branch feat/automating-ecommerce, folder 3-practices/3-2-automating-ecommerce, commit 92b7be5. supporters Thach and Hoang`
4. `tomorrow: setup DeepEval + write test for RAG MCP server; implement database MCP server. also verified RAG MCP with inspector (dup)`

**Expected:** no duplicate "verify with Inspector"; single report; matches K2.

### Case 4 — missing commit + repo link
Same as case 1 but delete the commit hash, the repo name and the branch link. Keep "practice: RolesGuard".

**Expected:** ONE message listing the missing items (repo URL, commit); nothing invented. If told "unavailable" → `<TODO: …>`.

### Case 5 — vague plan (key K3)
Supporters Thach and Hoang. MCP + DeepEval plan link as case 3.
redefined practice requirement (Enhanced Ecommerce Multi-Agents with MCP + DeepEval) — discussed with supporter; requirements now focus on MCP + multi-agents; MCP server design by tools/resources not by agent. doc: https://docs.google.com/document/d/1qNOpANq1UudiQ5q4iFt3PAEFFUtjJ5ybHy-Fi0Bm4sM/edit?tab=t.z65ik4nejjcd
prep: re-setup Supabase from backup, cloned previous multi-agent practice and ran it.
repo mcp-deepeval-training, branch feat/automating-ecommerce, folder 3-practices/3-2-automating-ecommerce, commit 6a81c40.
in process: RAG MCP server.
tomorrow: continue working on practice

**Expected:** skill refuses the bare "continue working on practice" and asks for the task name + sub-tasks (e.g. "Continue Implement RAG MCP Server" + steps). "Continue <named task>" with sub-tasks is accepted. Original K3 is the *bad* example.

### Case 6 — issue without link (key K4)
Resumed MCP + DeepEval plan after RFP project. Supporters Thach and Hoang, mentor Cong.
resumed practice, updated progress tracking doc, found remaining tasks, reconfigured Supabase and ran practice project. docs: plan, practice requirements, training notes (links as in case 3 + notes doc https://docs.google.com/document/d/1kPHYZfyTF7rivWNG96D8p4IOLSJOq803F1Ap5fhpMKM/edit).
repo mcp-deepeval-training, branch feat/mcp-integration-card-order, commit 9aadc045.
in process: Agent–MCP integration for Cart + Order agents.
problem: GraphRecursionError in multi-agent flow, spent a while on it, not solved.
tomorrow: check all MCP tools with MCP Inspector before testing the whole multi-agent flow, then start DeepEval evaluation.
tags #llm #mcp #deepeval #practice #resume

**Expected:** ISSUES = what/where/error/tried (plain text, no link); IN PROCESS section holds the Cart/Order integration; "Continue the Agent–MCP integration" accepted only if it has sub-tasks (Inspector check, full flow test, DeepEval).

### Case 7 — new user (generic)
`start a training report. today I studied Claude 101 lesson 3 and wrote notes. plan: lesson 4 tomorrow`
(No profile given, fresh chat, no memory.)

**Expected:** profile questions asked in ONE message; no "Thanh", "Cong", "Hoang" etc. appear; signature = whatever name the user gives.

### Case 8 — non-report notice (key K7)
`I'm joining an RFP project, will pause training for a while. tell supporters`

**Expected:** unclear. The skill has no notice template. Decide: add a short "notice" format to the skill, or scope it out explicitly.

## Known gaps (status)
- ~~IN PROCESS section missing~~ → added as optional section.
- ~~Weekly format unclear~~ → `#weekly` tag + "This week, I learned…".
- ~~Vague "continue" plans~~ → "Continue <task>" OK when it has sub-tasks.
- ~~Signature block~~ → Gmail adds it; skill ends with "Best regards, <name>." only.
- Still open: notice emails with no report (case 8); supporters change per course (profile step must allow it); check the HTML draft keeps `*FINISHED*` bold + nested bullets.
