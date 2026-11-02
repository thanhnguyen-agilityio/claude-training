# Email digest — setup and scheduling

## Setup (chat only, never in a scheduled run)

All checks are read-only. Never create labels or filters.

1. Run `list_labels` and ask "Which project labels should I follow?" Also ask if any default
   in SKILL.md Config should change (most users keep them all).
2. Verify each project label, and any changed value, with a search over the last 14 days and
   show the count, e.g. "`label:"<label>"` → 28 threads, correct?". 0 results → say so and ask
   again.
3. No project labels → 💼 Project Updates stays hidden.
4. Show the scheduled task prompt to paste (below).

## Scheduling

The scheduled task prompt carries only the project labels and any changed default (each run
is a fresh session):

```
Run the email-digest skill.
Project labels: "<Parent/Child>", "<Parent/Child>"
```

Schedule: weekdays 08:00, Asia/Ho_Chi_Minh unless changed. Never create the task without
asking.
