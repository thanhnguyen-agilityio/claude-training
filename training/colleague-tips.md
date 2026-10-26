# Tips from colleagues' training reports (Oct 16–23)

Source: sample of company training mails (14 read in full, ~50 skimmed of ~200). Hints, not the plan. Verify before relying on them. No names kept.

## Day 4–5: basics, memory
- Plan Mode is the best moment to fix direction.
- A passing test doesn't prove the fix is right.
- The folder you open Claude Code in decides which CLAUDE.md it reads.
- Rules that must happen every time → hook. CLAUDE.md is only a request.
- Check a few of Claude's claims about the code against the code (3 of 3 were right for one colleague).
- CLAUDE.md: commands, conventions, a "never do" list.
- Trigger compaction and see what survives. Make a bad edit on purpose and `/rewind`.
- Same task in a fresh session vs a primed one (already read the codebase); compare.

## Day 6: parallel
- `/loop 15m` to watch an open PR; keep a `loop.md` in the repo.
- `/rc` to steer the desktop session from a phone.
- Compare `/effort` levels incl. ultrathink on a hard bug.
- Two tickets at once in two git worktrees.

## Day 8: MCP
- Small FastMCP server + MCP Inspector.
- GitHub MCP at user scope with a fine-grained token. Playwright MCP: open page, screenshot.

## Day 9: hooks
- Build: format-on-edit, block-forbidden-command.
- Forbidden-command hook: parse commands properly (a naive version had bypasses found in review); add tests.

## Day 10: review
- `/code-review` and `/ultrareview` are complementary, not interchangeable.
- `/code-review ultra <n>` fell back to a local review for one person; `/ultrareview <n>` launched the cloud job. Verify yourself.
- Check review suggestions by reading the code (one would have dropped an error message the UI reads).
- `/security-review` reads only the diff; it misses existing code.
- Security plugin that calls a model every turn sends diffs out and costs per run; two people uninstalled it.
- Sort findings: fix / out of scope / false positive. Seed a bug on purpose to test a reviewer.

## Day 12–13: capstone
- Role per step (lead, BA, QA, dev) → child tickets, test matrix, dev questions.
- Plan first, get approval before code. One worktree session and one PR per ticket.
- Before each push: test, lint, typecheck, `/code-review`. Record a short screen video per feature.
- Playbook order: `intent.md` → plan mode → CLAUDE.md → skills → parallel sessions → evals in CI → hooks as approval gates.
