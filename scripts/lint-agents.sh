#!/usr/bin/env bash
# Lint agent charters: every description must carry a recognized trigger phrase, because the
# description field is what drives Claude Code's auto-delegation. Mirrors the MISSING_TRIGGER
# lint from wshobson/agents. Run from the repo root: bash scripts/lint-agents.sh
set -euo pipefail

AGENTS_DIR="${1:-plugin/agents}"
trigger='use proactively|use immediately|use when|use whenever|use after|use on|use for|use before|must be used|trigger when|auto-loads'
fail=0

for f in "$AGENTS_DIR"/*.md; do
  [ -e "$f" ] || { echo "no agents found in $AGENTS_DIR"; exit 1; }
  desc=$(grep -m1 '^description:' "$f" | sed 's/^description:[[:space:]]*//')
  if [ -z "$desc" ]; then
    echo "FAIL  $(basename "$f"): missing description field"; fail=1; continue
  fi
  if ! echo "$desc" | grep -qiE "$trigger"; then
    echo "FAIL  $(basename "$f"): description has no trigger phrase (add e.g. 'Use PROACTIVELY when …')"; fail=1
  fi
done

if [ "$fail" -eq 0 ]; then
  n=$(ls -1 "$AGENTS_DIR"/*.md | wc -l | tr -d ' ')
  echo "✓ all $n agent descriptions carry a trigger phrase"
fi
exit "$fail"
