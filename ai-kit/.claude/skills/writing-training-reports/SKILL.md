---
name: writing-training-reports
description: Writes daily or weekly Agility training report emails (subject [team][training] YYYYMMDD plus hashtags) from the user's notes and saves them as a Gmail draft. Use for a training report, daily or weekly report, training log, or training progress notes.
---

# Writing training reports

The report goes to supporters, and the company training group reads it. It must show **status** (done, in progress, next), **learning** others can reuse, and **issues** clear enough that readers can help.

## Setup (once per course)

Use the `Training report profile` block from memory, preferences, project instructions, or the chat. If it's missing or incomplete, ask for all gaps in one message. Once every field is known, output the complete block (no TODOs) and tell the user to save it there. Ask the team prefix as a choice (bgh / hf / other); never assume one. Ask profile fields only, not the day's work. Do the same when the user says "update my profile".

```
Training report profile
- Sender: <full name>
- Team prefix: <bgh | hf | ...>
- Supporters (To): <greeting name> <email>, ...   (greeting name as used in "Hi ...", e.g. Xuan)
- CC: asoft.training@asnet.com.vn, <others <email>>, ...
- Course: [<name>](<link>)
- Hashtags: #<tag> #<tag>
- Repo: [<repo-name>](<repo link>), folder <folder>
```

## Workflow

- **Notes**: merge them into the running report (no duplicates, key points only). Reply in 1–2 lines: what you added, plus missing fields as one numbered list. "show report" → print it.
- **"write" / "draft it"**: fill gaps (branch, commit, day tags), build from the template, check the Rules, show subject, To, CC, then the body in one code block; apply edits, then create the Gmail draft after the user confirms ("just draft it" skips confirmation).
- **Edit after drafting**: update the same draft.

**Coaching**: if content breaks a quality rule (marked ★), say plainly what is weak ("'learned caching' doesn't show what you learned") and ask at most 3 specific questions in one message. For plan sub-tasks, lesson ranges, or missing links, propose a concrete answer (e.g. "Lessons 1–4 + Notion note?") so "ok" accepts it. Never propose takeaways from titles; ask what the user learned or offer to shape their own notes. Add only what the user answers or accepts. "draft as is" → stop asking.

## Rules

- Subject: `[<team prefix>][training] YYYYMMDD #tags`, date = today. Weekly: ask the date range, use its last working day, add `#weekly`, open with "This week, I learned/continued…".
- CC always includes `asoft.training@asnet.com.vn`.
- ★ Finished learning or practice item: task, issue link if any, 2–4 takeaways a colleague can reuse (what + why/how). "Caching: TTL for lists, invalidate on write", not "Learned caching".
- ★ Include references (notes, docs, board, demo) when they exist.
- ★ Next plan: each item names a task and its sub-tasks. Reject "continue working on practice".
- ★ Issue: title + link, or what / where / error / tried, ending with the help needed.
- Every URL is a Markdown link. Build issue, branch, and commit links from the repo URL pattern; unknown host → ask.
- Omit empty sections and sub-groups.
- Never invent. Missing hash or link → ask; still missing → `<TODO: ...>` and say so.
- Never include secrets (passwords, tokens, keys, `.env` values) or customer data; drop them and tell the user.
- Tone: slightly formal, concise, clear to a reader without context. Signature: "Best regards," + sender name only. Never reuse names from the example.

## Template

```
Hi <supporter greeting names>,
Today, I continued training the [<Course>](<link>) by <one-line summary>.
Please find more detail in content below:
FINISHED

* <Finished item> ([#<id>](<issue link>))
   * <takeaway>
* For more details, please refer to the [<reference>](<url>)
* Source code:
   * Git repository: [<repo-name>](<repo link>)
   * Branch: [<branch>](<branch link>)
   * Folder: <folder>
   * Last commit: [<short hash>](<commit link>)

IN PROCESS

* <Task started, not finished>

ISSUES

* Challenges
   * <challenge>
* Questions
   * <question>
* Issues
   * [<issue title>](<url>): <detail, help needed>

NEXT PLAN

* <Specific task> ([#<id>](<issue link>))
   * <sub-task>

Best regards,
<Sender name>.
```

Worked example: [example.md](example.md).

## Gmail draft

Find the tools with ToolSearch `gmail draft`. Call `create_draft` with `to`, `cc`, `subject`, and `htmlBody` (`<a href>`, nested `<ul><li>`, `<b>` headers), with text identical to the approved report. **Never send.** If Gmail is missing or fails, give copy-ready text and one line why (connect via Settings → Connectors).
