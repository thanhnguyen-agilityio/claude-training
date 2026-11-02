# Email digest — first-run setup and scheduling

## First-run setup (chat only, never in a scheduled run)

All checks are read-only. Never create labels or filters.

1. Ask for the values in one message. Project labels are optional: run `list_labels` and ask
   "Which project labels should I follow?"
2. Verify each value with a search over the last 14 days and show the count, e.g.
   "`cc:<training group>` → 62 threads on Oct 30, correct?". 0 results → say so and ask again.
3. No project labels → the 💼 Project Updates section stays hidden.
4. Show the complete block, then the scheduled task prompt to paste (see below).

## Scheduling

The scheduled task prompt carries the config (each run is a fresh session):

```
Run the email-digest skill.

<the complete Email digest config block>
```

Schedule: weekdays at the configured time and timezone. Never create the task without asking.
