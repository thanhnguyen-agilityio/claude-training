# Day 4: Claude Code Desktop core

## Common workflows
Source: https://code.claude.com/docs/en/common-workflows

- Covers: prompt recipes, resume previous conversations, run parallel sessions with worktrees, plan before editing, delegate research to subagents, pipe Claude into scripts.
- Prompt recipes:
  - Understand new codebases
  - Fix bugs efficiently
  - Refactor code
  - Work with tests
  - Create pull requests
    - Back to the session with `claude --from-pr 123`
  - Handle documentation
  - Work in notes and non-code folders
  - Work with images
  - Reference files and directories
  - Run Claude on a schedule: cloud scheduled tasks, desktop scheduled tasks, GitHub Actions, `/loop`
  - Ask Claude about its capabilities
- Resume previous conversations
- Run parallel sessions with worktrees (very powerful, see below)
- Plan before editing
- Delegate research to subagents
- Pipe Claude into scripts

### Worktrees

Interactive guide: [Git Worktree Playground](https://claude.ai/artifact/WNygvExsGUkeGZ7toZfU4v): how it works · switching vs worktrees · bare clone setup · workflows · [gotchas](https://claude.ai/artifact/WNygvExsGUkeGZ7toZfU4v#gotchas)

Key concepts:

1. One worktree = one directory + one branch + one isolated workspace
   - No conflicts between worktrees
2. Two ways to create a worktree:
   - Option A: `claude --worktree feature-name` (creates it automatically)
   - Option B: `git worktree add ../path branch-name` (manual, then `cd` and run `claude`)
3. From an active Claude session, to work on another task:
   - Open a new terminal → run `claude --worktree another-task`
   - Or use the Bash tool to create the worktree manually, then open a new terminal
4. Each terminal = a separate Claude session working independently
5. Useful commands:
   - `git worktree list`: see all worktrees
   - `git worktree remove <path>`: clean up when done

Mental model: worktrees are parallel universes of your repo. Each one has its own branch and its own files, and can be edited without affecting the others.

The big benefit: work on multiple tasks at the same time without switching branches or stashing changes.

Extra gotchas:
- `claude --worktree <name>` (`-w`) puts the folder under `.claude/worktrees/<name>`; omit the name and one is generated.
- A branch can be checked out in only one worktree at a time.
- Untracked files (`.env`, `node_modules`, build output) are not copied: reinstall deps per worktree. `.worktreeinclude` lists gitignored files to copy in.
- On exit, a worktree with no changes is removed automatically; with changes, Claude asks keep or remove.
- `git worktree prune` cleans up records of worktree folders deleted by hand.
- All worktrees share one `.git`: commits show up everywhere at once, but nothing is merged until you merge.

## Practice
- [ ] Explore a new codebase: https://github.com/donnemartin/system-design-primer
- [ ] Practice with worktrees
- [ ] 
