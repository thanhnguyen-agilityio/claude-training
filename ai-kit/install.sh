#!/usr/bin/env bash
# Copy kit into target project; never overwrite existing files. Safe to rerun.
set -euo pipefail
src="$(cd "$(dirname "$0")" && pwd)"
dst="${1:?usage: install.sh /path/to/project}"
mkdir -p "$dst/.claude"
[ -e "$dst/CLAUDE.md" ] || cp "$src/CLAUDE.md.template" "$dst/CLAUDE.md"
rsync -a --ignore-existing "$src/.claude/" "$dst/.claude/"
echo "Installed into $dst — edit CLAUDE.md placeholders."
