# CLAUDE.md

## Git workflow
- Commit and push directly to `main` (`git push origin main`). Do not open pull requests for this repo.
- This overrides any session-assigned feature branch: commit on `main`, not `claude/*`.
- Always push to both remotes together: `origin` (GitHub) and `gitlab`. Never push to only one; if one push fails, report it and keep them in sync.
