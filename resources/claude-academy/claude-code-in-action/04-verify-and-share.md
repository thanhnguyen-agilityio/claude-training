# Lessons 8–9: Verify and share

Check work you did not watch, then package a setup you trust as a plugin for the team.

## Lesson 8 — Trust it: Verifying unsupervised runs (5 min)

- Core rule: **verify in proportion to how little you watched.** A short session you followed
  needs a glance; an unattended or CI run needs a real check, because nobody saw it happen.

**Keep unattended runs in auto mode**
- Use auto, not bypass permissions, so the classifier still screens dangerous actions.
- The classifier never judges correctness, so it does not lower your verification bar.

**Start with the diff, not the summary**
- Run `/code-review`, then read `git diff` yourself.
- Trap: a tidy summary while the diff touched a file you did not expect. Read the planned files
  first, then look for anything outside the plan.

**Make tests a gate, not a promise**

| Hook | Does |
| --- | --- |
| Stop hook | Runs tests; refuses to end the turn on failure |
| PostToolUse hook | Lints and type-checks after every edit |

- **Exit 2** feeds the failure back to Claude, which fixes it unprompted, on every run.

**Cold second opinion**
- A fresh session or subagent reviews the changed code with no memory of how it was built, so
  it catches what the original run talked itself past.

**Checklist**
1. Read the diff yourself.
2. Gate the turn on tests with a hook.
3. Check headless runs by their JSON result and exit code.
4. Get a cold second review for anything that matters.

## Lesson 9 — Plugins (7 min)

- Copying a `.claude` folder between machines does not stay in sync. A **plugin** packages a
  setup as **one installable, versioned unit**: skills, subagents, hooks, MCP configs, plus LSP
  servers, background monitors, themes and a small slice of settings.

**Using plugins**
- Install by name in a session: `/plugin install github@claude-plugins-official`. It shows the
  details first so you can review and pick a scope, then installs and reloads. If the reload
  warns it would re-read the whole conversation, `/reload-plugins --force` activates it anyway.
- For a team, add a private **marketplace** once: `/plugin marketplace add your-org/claude-plugins`.
  Installs then resolve through it, with central discovery, versions and updates. Browse in the
  **Discover** tab.

**Read before you install**
- A plugin runs code **with your privileges**. Install it for its skills and you also get its
  PreToolUse and Stop hooks (e.g. a Stop hook that calls a network endpoint every turn).
- The details view shows what will be installed, an estimated context cost, and a warning that
  Anthropic does not control third-party plugin contents.
- Community marketplace = submitted by authors; official marketplace = curated separately.
  **Listed is not trusted.** Use only sources you trust and check what it does first.

**Components run alongside yours**
- **Hooks stack**: plugin hooks and yours both fire; neither replaces the other.
- Skills, agents and commands are **namespaced** under the plugin name, so no clashes.
- A plugin `settings.json` only honors two keys: `agent` and the subagent status line. The
  `agent` key promotes a plugin subagent to the main thread (its prompt, tools, model), which
  can change Claude Code's default behavior.
- The plugin panel shows what a plugin added and lets you manage or uninstall it.

**Packaging your own**
- Same shape as `.claude`: one folder per skill, one markdown file per subagent under `agents/`,
  `hooks/hooks.json` and `.mcp.json` at the plugin root. Components are found by convention.
- Optional manifest `.claude-plugin/plugin.json` with name, version, description, author.
  **Name is the only required field** and namespaces skills as `/plugin-name:skill-name`.
  Version it like any dependency.

**Recap:** read before you install; package your `.claude` once it works.
