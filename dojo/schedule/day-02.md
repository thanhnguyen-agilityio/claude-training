<!-- Source: https://dojo.agilityio.dev/schedule/day-02.html — saved 2026-10-12. Internal training material. -->

Week 1 · Shared fundamentals

# Day 02 — Ticket analysis, reproduce and understand

Everyone

**Morning — ticket analysis:**

- **Workshop:** take 5 real tickets from the training backlog. For each, write the three-sentence analysis: what it asks, what's ambiguous, first step. Use Claude to find gaps and draft clarifying questions; compare with a partner's analysis.

**Exercise**

Write the questions you'd ask the reporter; role-play reporter/dev in pairs.

**Afternoon — reproduce and understand:**

- **Workshop:** each pair takes one seeded bug ticket. Get the app running locally from scratch; reproduce the bug; write exact repro steps into the ticket.
- **Claude habit:** paste the stack trace / relevant code into chat; ask for hypotheses; verify each by running, not by trusting.

**Exercise**

Express the bug as a failing test if possible (devs write it; BA/QA describe the assertion it should make and pair with a dev to see it written).

- **Git block:** `pull --rebase`, reading `git log` / `git diff`, merge conflict #1 (lead seeds a conflict deliberately).
- **Course:** finish [Claude 101](../courses.md) (devs) / continue (BA/QA).

## Skills today

### Reproduce-ready bug reports
Devs reproduce from the report alone.

*How to set up:* Nothing to install — it's a writing practice. Structure every report as *steps to reproduce, expected vs actual, environment*; devs should never need to ask for more.

---

Related: [Course catalog](../courses.md) · [Developer track](../developer.md) · [BA/QA track](../ba-qa.md) · [Shared fundamentals](../fundamentals.md)
← [Day 01](day-01.md) · Next → [Day 03 — Fix, review, merge — Checkpoint 1](day-03.md)
