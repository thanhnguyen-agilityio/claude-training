# Email digest: Slack message format

Use Slack emoji shortcodes exactly as below. The two divider lines are 85 `-` characters.

```
:mailbox_with_mail: Daily Email Digest | <Ddd, Mon D>[ (Preview)]
(<window> | <u> updates · <a> actions · <c> training reports)

-------------------------------------------------------------------------------------

:dart: Needs Attention (<count>)
• <gist> - <sender> · [open](<viewUrl>)

:briefcase: Project Updates (<count>)
• <gist> - <sender> · [open](<viewUrl>)
_+<N> more_

:people_hugging: My People (<count>)
• <gist> - <sender> · [open](<viewUrl>)

Training Pulse | <c> Reports

Issues (<count>)
• <blocker, question, waiting item, or issue> - <sender> · [open](<viewUrl>)

Current Focus
• <theme>: <n>

Milestones
• <sender> - <milestone>
-------------------------------------------------------------------------------------
End of digest. Have a productive day!
```

- Window line: plain text in `( )`, no emoji, no bold.
- Never use an em dash (`—`) anywhere in the message; use ` - ` between what and who.
- `[open](<viewUrl>)` is the last thing on an item line.
- Title date: scheduled run → today (e.g. `Tue, Nov 3`). Manual run with `end` = now → the
  next weekday's date plus ` (Preview)`.
- `<window>`: `start` and `end` on the same date → `Mon, Nov 2 · 08:00–21:20`; otherwise →
  `Mon, Nov 2 08:00 – Tue, Nov 3 08:00` (Monday: `Fri, Oct 30 08:00 – Mon, Nov 2 08:00`).
- Counts: `u` = 🫂 items, `a` = 🎯 items (incl. ⏳), `c` = pulse reports. Singular for 1
  ("1 action"). Drop a part that is 0.
- 🎯 Needs Attention = approvals and admin, then the ⏳ items as plain `•` lines (no
  separate heading or prefix). Training Pulse holds three lists, in order: Issues (the 🙋 + 🧩
  lists, see 📊 in Step 2), Current Focus, Milestones.
- Current Focus: the 3–5 themes, biggest first, `<theme>: <count>`. Milestones: at most 3,
  `<sender> - <milestone>`.
- No line ends with a period, except the closing line.
- Max items per section from Config, then `_+N more_`. Hide empty sections and empty
  Issues / Current Focus / Milestones lists (no "nothing today" lines).
- Every section empty → title line, window line (counts dropped), `Nothing new since <start>`,
  closing line.
