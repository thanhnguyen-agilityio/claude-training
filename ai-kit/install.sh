#!/usr/bin/env bash
# Copy kit into target project; never overwrite existing files.
set -euo pipefail
src="$(cd "$(dirname "$0")" && pwd)"
dst="${1:?usage: install.sh /path/to/project}"
mkdir -p "$dst"
cp -n "$src/CLAUDE.md.template" "$dst/CLAUDE.md"
mkdir -p "$dst/.claude"
cp -Rn "$src/.claude/." "$dst/.claude/"
echo "Installed into $dst — edit CLAUDE.md placeholders."
