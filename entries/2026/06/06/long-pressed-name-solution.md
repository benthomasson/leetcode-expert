# File: long-pressed-name/solution.py

**Date:** 2026-06-06
**Time:** 17:24

## Long Pressed Name — `long-pressed-name/solution.py`

### Purpose

Solves [LeetCode 925: Long Pressed Name](https://leetcode.com/problems/long-pressed-name/). Given a `name` string and a `typed` string, determines whether `typed` could have been produced by long-pressing keys while typing `name` — meaning each character in `name` appears in `typed` in order, and any extra characters in `typed` must be duplicates of the immediately preceding character.

### Key Components

**`Solution.isLongPressedName(name, typed) -> bool`** — The core algorithm. Uses a two-pointer approach where `i` tracks position in `name` and `j` iterates over `typed`.

Three cases per character `typed[j]`:
1. **Match**: `typed[j] == name[i]` → advance `i` (consume a required character)
2. **Long-press repeat**: `typed[j] == typed[j-1]` → skip (it's a duplicate from holding the key)
3. **Mismatch**: anything else → return `False` immediately

After the loop, `i == len(name)` confirms every character in `name` was consumed.

**`TestLongPressedName`** — 11 unit tests covering the standard cases: basic long-press (`"alex"` → `"aaleex"`), identical strings, single-character edge cases, mismatched characters, shorter `typed`, empty `typed`, and trailing extra characters.

### Patterns

- **Greedy two-pointer**: `j` always advances (via `for`), `i` advances only on a match. This is the canonical approach for subsequence-with-repeats problems — greedily match as early as possible, then verify any unmatched `typed` characters are valid long-press repeats.
- **Single-file solution + test**: follows the repo-wide convention of colocating the solution class and its tests in one file, runnable via `unittest.main()`.

### Dependencies

**Imports**: `unittest` only — no project-internal dependencies.

**Imported by**: `long-pressed-name/test_solution.py` (the "Imported By" list in the prompt is the full cross-repo test suite that shares the same `unittest` import, not actual importers of this module's `Solution` class).

### Flow

```
for each character in typed (index j):
    if it matches name[i]  →  advance i (greedy consume)
    elif it matches typed[j-1]  →  skip (long-press)
    else  →  return False

return whether all of name was consumed (i == len(name))
```

The `j > 0` guard before `typed[j] == typed[j-1]` prevents an index-out-of-bounds on the first character. If `typed[0]` doesn't match `name[0]`, it falls through to `return False`.

### Invariants

- **Order preservation**: characters in `name` must appear in `typed` in the same order — the algorithm never backtracks `i`.
- **Long-press validity**: an extra character is only tolerated if it equals its predecessor in `typed`. A novel character that doesn't match `name[i]` is rejected.
- **Full consumption**: the final `i == len(name)` check ensures `typed` wasn't too short to cover all of `name`. Without it, a prefix match like `name="abc"`, `typed="ab"` would incorrectly return `True`.

### Error Handling

No explicit error handling. The method assumes valid string inputs per LeetCode constraints. Empty `typed` with non-empty `name` returns `False` naturally (the loop body never executes, so `i` stays at 0).

## Topics to Explore

- [file] `long-pressed-name/plan.md` — Planning notes for the approach chosen and alternatives considered
- [file] `long-pressed-name/review.md` — Code review feedback on this solution
- [function] `backspace-string-compare/solution.py:backspaceCompare` — Another two-pointer string comparison problem with a similar greedy structure
- [general] `greedy-two-pointer-pattern` — How the repo's solutions handle subsequence and matching problems across different LeetCode problems
- [file] `valid-word-abbreviation/solution.py` — Another two-pointer string matching problem where one string is a compressed form of the other

## Beliefs

- `long-press-greedy-order` — The algorithm never backtracks pointer `i`; each character in `name` is matched at most once, left to right
- `long-press-j0-guard` — The `j > 0` check on line 19 prevents `typed[j-1]` from wrapping to the last character when `j == 0`
- `long-press-full-consumption` — The return value `i == len(name)` rejects cases where `typed` is a valid prefix of `name` but doesn't cover all characters
- `long-press-time-complexity` — The algorithm runs in O(len(typed)) time with O(1) extra space since `i` only moves forward and the loop visits each `typed` character exactly once

