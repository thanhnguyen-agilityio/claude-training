<!-- Source: https://dojo.agilityio.dev/schedule/day-09.html — saved 2026-10-12. Internal training material. -->

Week 3 · Track split, deeper

# Day 09

Developer track · BA/QA track

## Developer track — Extend, automate, review

### Hooks and automation

- Hooks: format-on-edit, block-forbidden-command, notify-on-finish — ship one as a PR.
- Automation ladder: `/goal` on a bounded task; Desktop scheduled task (morning briefing); Routines overview (cloud); GitHub Actions `@claude` on the training repo.

**Exercise**

`@claude` review fires on your next PR; evaluate its comments.

## BA/QA track — Automated testing

### Author a suite

**Exercise**

"Write Playwright tests for the acceptance criteria of ticket #N" — review the spec like a PR (readability, assertions, no hardcoded waits), iterate, merge it.

- **BA parallel:** requirements regression — re-check all Week-2 ticket packs against the built features; file gaps as tickets (planning quality measured).

## Skills today

### Developer track

**Hooks (format-on-edit, block-forbidden-command, notify-on-finish)** — Team rules enforced automatically.
*How to set up:* Already built in — type `/hooks` to open the hooks browser, or simply ask Claude "add a hook that formats every file you edit" and it writes the config itself.

**Automation ladder (/goal, scheduled tasks, Routines, @claude in GitHub Actions)** — From "watch this task" to "review every PR automatically".
*How to set up:*
1. `/goal` in a session — built in; keeps Claude working toward a condition.
2. Desktop scheduled task: in the Code tab, click **Routines** in the sidebar (or the sidebar's More menu) → **New routine** → choose **Local**.
3. Cloud routine: claude.ai/code/routines — runs even with your computer off.
4. `@claude` on GitHub: run `/install-github-app` in the repo and follow the prompts.

### BA/QA track

**Author a real spec suite** — QA-written tests devs review like code.
*How to set up:* Nothing new to install — uses the Code tab you set up on Day 7 (Desktop app → Code tab → open repo). QA writes the tests; devs review them like code.

**test-spec-writer (QA)** — Acceptance criteria → reviewed test code, standardized.
*How to set up:* Nothing to install beforehand — created by the team during Day 7+, then available in every session automatically.

---

Related: [Course catalog](../courses.md) · [Developer track](../developer.md) · [BA/QA track](../ba-qa.md) · [Shared fundamentals](../fundamentals.md)
← [Day 08](day-08.md) · Next → [Day 10](day-10.md)
