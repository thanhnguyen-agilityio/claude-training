---
name: writing-training-reports
description: Writes daily or weekly Agility training report emails ([bgh][training] YYYYMMDD #tags) from notes gathered during a session, then creates a Gmail draft. Use for a training report, daily report, weekly report, or training log.
---

# Writing training reports

A trainee at Agility sends a training report email to their supporters for an official training course. Notes may arrive over a whole session; the report is written at the end.

## Routing

- User starts a report or sends progress notes → **Collect workflow**
- User says "write", "finish", or "draft it" → **Write workflow**
- User asks to change a draft already created → edit the report, then `Gmail:update_draft`

## Profile (ask once per conversation)

Before the first report in a conversation, get the user's profile. Check the conversation, memory, and user preferences first; ask only for what is missing, in one message:

- **Sender name** for the signature (e.g. "An Tran")
- **Supporters** (To) and **mentor** (CC), with emails and first names for the greeting
- **Course** name + link, and the default **hashtags**

Suggest once that the user saves these to memory or preferences so future reports skip this step.

## Fields

| Field | Rule |
|---|---|
| Report type | `daily` or `weekly`. Weekly: ask the date range; title date = last working day; ALWAYS add the `#weekly` tag. |
| Course | Name + link, e.g. [Claude Training](https://dojo.agilityio.dev/) |
| Title | `[bgh][training] YYYYMMDD #tag1 #tag2`. Date defaults to today. Tags e.g. `#ai-tools #claude`; weekly reports add `#weekly`. |
| To | Supporters. Greeting uses their first names ("Hi An and Binh,"). Unclear → ask. |
| CC | Mentor if given, plus `asoft.training@asnet.com.vn` (ALWAYS included). |
| Source code | Repo name + link, branch, folder, last commit (short hash). |
| Finished items | Task/session, issue link if any, 2–4 sub-bullets of key takeaways. |
| References | Links for details (board, requirements, notes). |
| In process | Optional. Work started but not finished. Omit if empty. |
| Issues | Optional. Challenges, questions, or issues. An issue is a title + link, or a short description: what, where, error, what was tried. |
| Next plan | Concrete tasks with named sub-tasks. "Continue <named in-process task>" is fine when followed by its sub-tasks. |

Course, To, CC, and Source code usually stay the same between reports. Reuse the last values from the conversation and confirm them in one line instead of re-asking.

## Collect workflow

1. Add the user's notes to the running report. Merge duplicates, shorten to key notes.
2. Reply in one or two lines: what was added, plus the missing fields as one numbered list. Never ask one question per message.
3. When the user asks "show report", print the current report in template form.

## Write workflow

Copy and track this checklist:

```
Report progress:
- [ ] 1. Fill profile and all required fields (ask once for anything missing)
- [ ] 2. Build the report from the template
- [ ] 3. Validate against the checklist below; fix and re-validate
- [ ] 4. Show title, To, CC, and body to the user; apply edits
- [ ] 5. Create the Gmail draft
```

Step 5 runs only after step 3 passes and the user confirms (skip confirmation only if the user already said "just draft it").

### Validation checklist

- [ ] Title matches `[bgh][training] YYYYMMDD #tag ...` exactly
- [ ] CC contains `asoft.training@asnet.com.vn`
- [ ] Signature uses the user's own name, never a name from the example
- [ ] Every URL is a Markdown link: course, issues `[#12](url)`, branch, commit, references
- [ ] Every next-plan item names a specific task AND has details (sub-tasks). "Continue <task name>" is fine with sub-tasks. Reject bare items such as "continue in progress" or "continue working on practice"; ask for the task name and sub-tasks.
- [ ] Weekly: title has `#weekly` and the opening says "This week, I learned/continued…"
- [ ] Each finished item has short key takeaways, not paragraphs
- [ ] IN PROCESS and ISSUES sections omitted if empty; empty sub-groups omitted
- [ ] Nothing invented. Missing hash or link → ask; if the user is unavailable, use `<TODO: ...>` and say so.

## Template

ALWAYS use this exact structure. Daily opens with "Today, I continued"; weekly with "This week, I learned" (or "This week, I continued").

```
Hi <names>,
Today, I continued training the [<Course>](<course link>) by <one-line summary>.
Please find more detail in content below:
FINISHED

* <Finished item> ([#<id>](<issue link>))
   * <key takeaway>
   * <key takeaway>
* For more details, please refer to the [<reference>](<url>), [<reference>](<url>)
* Source code:
   * Git repository: [<repo-name>](<repo link>)
   * Branch: [<branch>](<branch link>)
   * Folder: <folder>
   * Last commit: [<hash>](<commit link>)

IN PROCESS

* <Task started, not finished>

ISSUES

* Challenges
   * <challenge>
* Questions
   * <question>
* Issues
   * [<issue title>](<url>): <short detail>

NEXT PLAN

* <Specific task> ([#<id>](<issue link>))
   * <sub-task>
   * <sub-task>

Best regards,
<Sender name>.
```

Signature: end with "Best regards, <Sender name>." only. Do not add phone, company, or title; Gmail adds the signature block.

Tone: natural, slightly formal (the whole company reads it). Short, concise, key notes only.

## Example

Names and links below are illustrative. Always use the user's own profile.

**Notes from the user during the session:**

> Supporters An and Binh. Plan: MCP training plan https://docs.google.com/document/d/EXAMPLE. Repo https://gitlab.asoft-python.com/an.tran/mcp-training. Worked on issue #12 Implement Database MCP Server: init server, resources database://connection, database://schema; sql tools list_database_tables, execute_sql_query. Branch feat/ecommerce, folder 3-practices/3-2-ecommerce, commit b69e476. Stuck: SQLite connection closes between tool calls, tried a connection pool, still failing. Tomorrow: cart and order tools.

**Output body:**

```
Hi An and Binh,
Today, I continued training the [MCP training plan](https://docs.google.com/document/d/EXAMPLE) by working on practice.
Please find more detail in content below:
FINISHED

* Implement Database MCP Server ([#12](https://gitlab.asoft-python.com/an.tran/mcp-training/-/issues/12))
   * Init MCP server
   * Implement resources: database://connection, database://schema
   * Implement SQL tools: list_database_tables, execute_sql_query
* For more details, please refer to the [board](https://gitlab.asoft-python.com/an.tran/mcp-training/-/boards)
* Source code:
   * Git repository: [mcp-training](https://gitlab.asoft-python.com/an.tran/mcp-training)
   * Branch: [feat/ecommerce](https://gitlab.asoft-python.com/an.tran/mcp-training/-/commits/feat/ecommerce)
   * Folder: 3-practices/3-2-ecommerce
   * Last commit: [b69e476](https://gitlab.asoft-python.com/an.tran/mcp-training/-/commit/b69e476)

ISSUES

* Issues
   * SQLite connection closes between tool calls; tried a connection pool, still failing.

NEXT PLAN

* Continue task Implement Database MCP Server ([#12](https://gitlab.asoft-python.com/an.tran/mcp-training/-/issues/12))
   * Implement cart tools
   * Implement order tools

Best regards,
<Sender name>.
```

The user gave only "#12" and the branch name; the issue, branch, and commit links follow the repo's GitLab URL pattern. When the host or URL pattern is unknown, ask.

## Gmail draft

1. Load the tool if needed: ToolSearch `select:mcp__Gmail__create_draft,mcp__Gmail__update_draft`.
2. Call `Gmail:create_draft` with to, cc, subject = title, and an HTML body: `<a href>` for links, nested `<ul><li>` for bullets, `<b>` for FINISHED / ISSUES / NEXT PLAN. Text identical to the approved report.
3. NEVER send. Only create the draft, then tell the user it is in Gmail Drafts.
4. Later edits: `Gmail:update_draft` on the same draft, not a new one.
5. Gmail not connected or the call fails → give the report as copy-ready text and say why in one line. If not connected, mention the user can connect Gmail in Settings > Connectors.
