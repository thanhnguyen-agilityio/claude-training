# Scheduled task — email digest (tasks 9 and 12)

Create on claude.ai (Gmail and Slack connectors are connected there). The prompt carries my
config, so each run (a fresh session) can read it. SKILL.md itself holds no personal values.

## Task settings

- **Name:** Email digest
- **Schedule:** weekdays at 08:00 (Asia/Saigon)
- **Skill:** email-digest uploaded to claude.ai (Settings → Capabilities → Skills)
- **Prompt:** below

```text
Run the email-digest skill.

Email digest config
- Approval subject words: fp, permission
- Company-wide group: asoft.all@asnet.com.vn
- Training group: asoft.training@asnet.com.vn
- Mentee subject prefixes: internship, training
- Report subject prefix: [bgh][training]
- Project labels: "🔥 Projects/🌸 Smoliv"
- Schedule: weekdays 08:00, Asia/Saigon
- Language: English
- Max items per section: 5
```

## Task 12 — check the config is read

1. Click **Run now** on the task.
2. In the run log, check the skill used the config from the prompt (the 📊 line and the Smoliv
   label appear) and did not ask questions.
3. Remove the config block, run again → expect one "config missing" DM and nothing else.
4. Put the block back.

Result: TBD

## Values verified (2026-11-02, Gmail search)

| Value | Check | Result |
|---|---|---|
| `asoft.all@asnet.com.vn` | `to:` over 180 days | 2 threads (`asoftall@` → 0) |
| `asoft.training@asnet.com.vn` | `cc:` on Oct 30 | 62 threads (`asofttraining@` → 0) |
| `internship` | to/cc me, 14 days | 10 threads |
| `[bgh][training]` | to me, 14 days | 10 threads (supportee reports) |
| `"🔥 Projects/🌸 Smoliv"` | label search | 28 threads total |
