# Scheduled task — email digest (tasks 9 and 12)

Create on claude.ai (Gmail and Slack connectors are connected there). SKILL.md holds the
company defaults; the prompt carries only my project labels.

## Task settings

- **Name:** Email digest
- **Schedule:** weekdays at 08:00 (Asia/Ho_Chi_Minh)
- **Skill:** email-digest uploaded to claude.ai (Settings → Capabilities → Skills)
- **Prompt:** below

```text
Run the email-digest skill.
Project labels: "🔥 Projects/🌸 Smoliv"
```

## Task 12 — check the config is read

1. Click **Run now** on the task.
2. In the run log, check the skill used the defaults and the Smoliv label from the prompt
   (💼 and 📊 appear) and did not ask questions.
3. Remove the `Project labels` line, run again → expect a full digest with 💼 hidden.
4. Put the line back.

Result: TBD

## Values verified (2026-11-02, Gmail search)

| Value | Check | Result |
|---|---|---|
| `asoft.all@asnet.com.vn` | `to:` over 180 days | 2 threads (`asoftall@` → 0) |
| `asoft.training@asnet.com.vn` | `cc:` on Oct 30 | 62 threads (`asofttraining@` → 0) |
| `internship` | to/cc me, 14 days | 10 threads |
| `[bgh][training]` | to me, 14 days | 10 threads (supportee reports) |
| `"🔥 Projects/🌸 Smoliv"` | label search | 28 threads total |
