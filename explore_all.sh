#!/usr/bin/env bash
set -euo pipefail

REPO="/Users/ben/git/leetcode-implementations"
DONE=0
SKIP=0
ERR=0

for dir in "$REPO"/*/; do
  [ -f "$dir/solution.py" ] || continue
  name=$(basename "$dir")

  # Skip if already explored (entry exists)
  if ls entries/2026/*/*/"${name}-solution"* >/dev/null 2>&1; then
    SKIP=$((SKIP + 1))
    printf "S"
    continue
  fi

  if code-expert explain file "$dir/solution.py" >/dev/null 2>&1; then
    DONE=$((DONE + 1))
    printf "."
  else
    ERR=$((ERR + 1))
    printf "E"
    echo "  ERROR: $name" >&2
  fi

  count=$((DONE + ERR + SKIP))
  [ $((count % 80)) -eq 0 ] && [ $count -gt 0 ] && echo
done

echo
echo "Done: $DONE explored, $SKIP skipped, $ERR errors"
