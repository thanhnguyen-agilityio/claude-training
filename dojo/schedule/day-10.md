<!-- Source: https://dojo.agilityio.dev/schedule/day-10.html — saved 2026-10-12. Internal training material. -->

Week 3 · Track split, deeper

# Day 10

Developer track · BA/QA track

## Developer track — Extend, automate, review

### Review and quality

- `/code-review` on a real branch; then **ultrareview** (`/code-review ultra`) on a seeded-buggy branch (the lead prepares one) — compare signal.
- Security plugins walkthrough (`security-guidance`, Claude Security scan).

**Exercise**

Fix what the review found; PR green; note false positives for the retro.

## BA/QA track — Automated testing

### CI and triage

- Tests run on PRs via GitHub Actions; triage one seeded red build with Claude ("regression, flaky, or environment?").
- `/loop 15m watch the run` babysitting; artifact test report (pass/fail by area, flaky list) shared to the channel.
- **BA:** release-notes drafting with Claude from the merged PRs; publish as an artifact.

## Skills today

### Developer track

**/loop** — Scheduled re-runs: watch a PR, babysit CI, morning maintenance.
*How to set up:* See [Day 6](day-06.md) for the setup steps.

**ultrathink + /effort levels** — Deep reasoning spent only where it pays (the "ultracode" ask in real form).
*How to set up:* See [Day 6](day-06.md) for the setup steps.

**/code-review → ultrareview** — Catch what tired humans miss; multi-agent cloud review for risky branches.
*How to set up:* Already built in — type `/code-review` in a Code session for a review of your changes; `/code-review ultra` escalates to the deeper multi-agent cloud review (needs a claude.ai account).

**Security plugins (security-guidance, Security scan)** — Claude reviews its own changes for security issues.
*How to set up:* Already built in — type `/security-review` before committing to scan for vulnerabilities. Extra security plugins: `/plugin` → **Discover** tab → search the name your team uses (e.g. security-guidance, Security scan) → install.

**review-checklist skill** — The Day-3 checklist becomes enforced practice.
*How to set up:* See [Day 3](day-03.md) for the setup steps.

### BA/QA track

**CI triage ("regression, flaky, or environment?")** — One sentence of root cause from a red build.
*How to set up:* Nothing to install — paste the red build's log into a Claude session and ask "regression, flaky, or environment?" One sentence of root cause comes back.

**Release notes from merged PRs (artifact)** — Client-facing value visible in minutes.
*How to set up:* Nothing extra to install — in a Code session ask: "draft release notes from the merged PRs as an artifact" (see Artifacts, [Day 06](day-06.md)).

---

Related: [Course catalog](../courses.md) · [Developer track](../developer.md) · [BA/QA track](../ba-qa.md) · [Shared fundamentals](../fundamentals.md)
← [Day 09](day-09.md) · Next → [Day 11](day-11.md)
