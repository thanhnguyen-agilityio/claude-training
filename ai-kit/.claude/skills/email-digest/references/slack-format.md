# Email digest — Slack message format

Use Slack emoji shortcodes exactly as below. The two divider lines are 85 `-` characters.

```
:mailbox_with_mail: Daily Email Digest | <Ddd, Mon D>[ (Preview)]
:clock8: <window> | <u> updates · <a> actions · <c> training reports
-------------------------------------------------------------------------------------

:dart: Needs Attention (<count>)
• [<gist>](<viewUrl>) — <sender>

:briefcase: Project Updates (<count>)
• [<gist>](<viewUrl>) — <sender>
_+<N> more_

:people_hugging: My People (<count>)
• [<gist>](<viewUrl>) — <sender>

:eyes: Training Issues (<count>)
• [<blocker, question, waiting item, or issue>](<viewUrl>) — <sender>

:bar_chart: Training Pulse | <c> Reports
Current Focus
• <theme>: <n>
Milestones
• <sender> — <milestone>
-------------------------------------------------------------------------------------
:dart: End of digest. Have a productive day!
```

- Title date: scheduled run → today (e.g. `Tue, Nov 3`). Manual run with `end` = now → the
  next weekday's date plus ` (Preview)`.
- `<window>`: `start` and `end` on the same date → `Mon, Nov 2 · 08:00–21:20`; otherwise →
  `Mon, Nov 2 08:00 – Tue, Nov 3 08:00` (Monday: `Fri, Oct 30 08:00 – Mon, Nov 2 08:00`).
- Counts: `u` = 🫂 items, `a` = 🎯 items (incl. ⏳), `c` = pulse reports. Singular for 1
  ("1 action"). Drop a part that is 0.
- 🎯 Needs Attention = approvals and admin, then the ⏳ items as plain `•` lines (no
  separate heading or prefix); 👀 Training Issues = the 🙋 + 🧩 lists (see 📊 in Step 2).
- Current Focus: the 3–5 themes, biggest first, `<theme>: <count>`. Milestones: at most 3,
  `<sender> — <milestone>`.
- No line ends with a period, except the closing line.
- Max items per section from Config, then `_+N more_`. Hide empty sections and empty
  Current Focus / Milestones lists (no "nothing today" lines).
- Every section empty → title line, window line (counts dropped), `Nothing new since <start>`,
  closing line.
