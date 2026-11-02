# Lessons 5–7: Organizing your work and knowledge

Projects hold knowledge, artifacts hold outputs, skills hold repeatable methods.

## Lesson 5 — Introduction to projects

**Core idea:** a project is a self-contained workspace with its own chats, knowledge base,
instructions and memory. Use it for ongoing work, not one-off questions.

**Key points**
- **Project knowledge**: files Claude considers in every chat of the project, so you do not
  re-upload them. Context is not shared between chats unless it is in project knowledge.
- **Project instructions**: apply to every chat; they work alongside your user preferences.
- **Scaling (RAG)**: when knowledge nears the context limit, Claude searches the files and pulls
  only what is relevant (up to about 10x capacity). A visual indicator shows when RAG is on.
- **Collaboration** (Team and Enterprise): share with people or the whole organization.

| Permission | Can do |
| --- | --- |
| Can view | See contents, use knowledge, chat; no changes |
| Can edit | Change instructions and knowledge, manage members |
| Owner (creator) | Everything, including who can see it |

Consider a project when you have: reference material used again and again, fixed rules for how
Claude should answer, or a team that needs the same base.

**How to create one**
1. Sidebar > Projects > "+ New Project". Add a clear name and a short description (Claude does
   not see the description; it is for people). Choose private or shared.
2. Open Instructions and write: context, process, tone/style, specific requirements (e.g. "always
   end with a call to action"). Save instructions. You can also automate ("when I upload a
   transcript, make a summary with this template").
3. Add files with the "+" in the files menu (PDF, DOCX, CSV, TXT, HTML, or link Google Drive):
   reference docs, background material, examples of good work, specs.
4. Chat inside the project. Content uploaded in a single chat stays out of the knowledge base.

**Sharing:** "Share project" next to the name; add people by name/email (bulk paste works) or
share with everyone in your organization. They get an email; shared projects appear in "Shared
with me".

**Example projects:** product launch, research support, client account hub, event planning,
job description generator (also personal: finance, home renovation).

**Best practices**
- Start focused, then grow.
- Keep knowledge current (old docs give old answers).
- Write clear, specific instructions.
- Name files descriptively ("Q4-2025-Sales-Report.pdf", not "report.pdf").
- Refer to documents by name in questions.
- Note: the "Use style" menu from the video is deprecated; Skills do that job now.

**Reflect:** What ongoing work needs persistent context? What do you keep re-uploading or
re-explaining? Which projects would help a team?

## Lesson 6 — Creating with artifacts

**Core idea:** an artifact is an output that stands on its own (document, deck, design,
dashboard, prototype) shown in a window next to the chat. Say "Create this as an artifact" to be
sure. All artifacts are saved in the **Artifacts tab**: the chat is where you create, the tab is
where outputs live.

| Type | For |
| --- | --- |
| Claude Design | Landing pages, one-pagers, mockups, UI prototypes; use your design system; edit on canvas |
| Claude Slides | Presentations; edit each slide; present in Claude; export to PowerPoint, Google Slides, PDF |
| Claude Docs | Living documents; co-edit in real time; Claude explains in comments; charts from connected data (snapshot, ask to refresh); export to Google Docs or .docx |
| Other artifacts | Charts, flowcharts, interactive pages, working code; on every plan |

- You can convert between them ("turn this doc into a deck").
- Design, Slides, Docs are on every plan including Free; on Team an admin can turn them off; on
  Enterprise admins manage them in Organization settings > Artifacts.
- **Artifact vs file creation**: an artifact opens, updates and is shared by link inside Claude;
  file creation gives a downloadable Word, Excel, PowerPoint or PDF file.

**Create:** describe what you want in any conversation, or start in the Artifacts tab. Claude
uses context it already has (files, chat, project knowledge, connected tools).

**Change an artifact (mix freely)**
1. Edit directly (type, edit a slide, drag/resize).
2. Comment on the exact element; in a doc, @-mention Claude and it replies with what and why.
3. Just ask in the conversation.
Editing on the mobile app works; changing sharing needs desktop or web.

**Sharing:** private until you share. Add people (view, comment, or edit; docs: view/edit) or
share a link inside the organization. Recipients need a Claude account. Pro/Max: private or
anyone with the link. Team/Enterprise: links stay inside the organization unless an Owner turns on
External sharing. Only the artifact is shared, not your chat.

**Tips**
- Ask for the deliverable ("turn Q3 results into a one-page doc"), not just the content.
- Be specific (inputs, charts, warnings you want).
- Say who the end user is.
- Build after the conversation, when Claude understands the problem.
- Ask for a data refresh when you need current numbers.

**Reflect:** Which deliverable do you build by hand each time? What recurring work could be a
reusable interactive artifact? Who gets it, and can they view, comment or edit?

## Lesson 7 — Working with skills

**Core idea:** a skill is a folder of instructions, scripts and resources that Claude loads when
needed, to do a specialized task the same way every time. Document creation (Excel, Word,
PowerPoint, PDF) is powered by skills.

| Kind | Notes |
| --- | --- |
| Anthropic skills | Built and maintained by Anthropic; Claude uses them automatically |
| Custom skills | Yours or your organization's (brand rules, meeting-note format, analysis method) |

**Enable (web or desktop)**
1. Your name (lower left) > Settings > Capabilities > turn on **Code execution and file
   creation** (on Team/Enterprise an Owner controls this; Enterprise also needs Skills enabled).
2. Customize > Skills in the sidebar.
3. Open a skill and use its switch to turn it on or off.

**Using:** just ask ("create an Excel sheet with monthly expenses and totals", "turn these notes
into a PowerPoint"). You see the skill in Claude's reasoning; the result is a file to download or
save to Google Drive. Uploading a file creates a new version, not an edit of the original. Turn on
"Allow limited network access" if asked.

**Security:** skills can contain code. Only install from trusted sources, review outside skills
first. Your custom skills are not visible to colleagues until you share.

**Create a custom skill by chatting**
1. Tell Claude what skill you want.
2. Answer its interview questions (purpose, what good output looks like, examples).
3. Upload templates, style guides, sample work.
4. Click Save skill on the file it generates.
5. Check it under Customize; ask Claude to edit it later. If it does not appear: Customize >
   Skills > Add > Upload skill.

**Skills vs projects**

| | Projects | Skills |
| --- | --- | --- |
| Purpose | Store knowledge Claude uses | Define a process Claude runs |
| Best for | Long-term context, team sharing | Repeatable, multi-step workflows |
| Memory | Available in all project chats | Applied when the skill is invoked |

Short version: projects = the "what", skills = the "how". They work together.

**Reflect:** Which documents do you make often? Which repeated workflows could be custom skills?
