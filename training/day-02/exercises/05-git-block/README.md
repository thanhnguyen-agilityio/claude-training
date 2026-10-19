# Task 5: Git block

## Goal
Get comfortable with `pull --rebase`, reading `git log` and `git diff`, and resolve your first merge conflict. In the dojo the lead seeds a conflict. Working solo, you create one yourself.

## Part A: pull --rebase, log and diff (10 min)
1. After the Day 1 PR is merged, switch to `main` and run `git pull --rebase`.
2. Run `git log --oneline -10` and `git log --stat -3`. Explain the last three commits in your own words.
3. Run `git diff HEAD~3` on a file you know. Say what changed and why.
4. Ask Claude to explain a diff you don't follow, then check its answer against the diff.

Rule: never rebase a branch someone else is using. A rebase rewrites history.

## Part B: conflict #1 (20 min)
1. Create a practice file `training/day-02/conflict-practice.md` with three lines of text and commit it on `main`.
2. Create branch `day-02/conflict-a`. Change line 2 to your first version and commit.
3. Go back to `main`, create branch `day-02/conflict-b`, and change the same line 2 to a different version. Commit.
4. Merge `conflict-a` into `main`. It works.
5. Merge `conflict-b` into `main`. Git reports a conflict.
6. Open the file. Find the markers (`<<<<<<<`, `=======`, `>>>>>>>`). Decide what the line should say, remove the markers, and `git add` the file.
7. Finish with `git commit`. Then check `git log --graph --oneline`.
8. Delete the practice file and both branches.

Ask Claude to explain each marker before you resolve it, and ask it what could go wrong if you picked one side blindly.

## Checklist
- [ ] `pull --rebase` on `main` done
- [ ] You explained 3 commits from `git log` and one `git diff`
- [ ] Conflict #1 created and resolved by you
- [ ] The practice file and branches are removed

## Your log
Keep it in [log.md](log.md).
