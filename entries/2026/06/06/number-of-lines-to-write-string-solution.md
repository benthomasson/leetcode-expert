# File: number-of-lines-to-write-string/solution.py

**Date:** 2026-06-06
**Time:** 18:19

## Purpose

This file solves [LeetCode 806 — Number of Lines To Write String](https://leetcode.com/problems/number-of-lines-to-write-string/). It simulates writing a string character-by-character across lines that are each at most 100 pixels wide, then reports how many lines were used and how wide the last line is.

The method name `numberOfWays` is a misnomer — it should be `numberOfLines` per the LeetCode problem. This doesn't affect correctness since LeetCode matches by class/method signature, but it's misleading to readers.

## Key Components

**`Solution.numberOfWays(widths, s)`** — The single method. Takes a 26-element list mapping each letter `a`–`z` to its pixel width, plus a string `s` to write. Returns `[lines, last_line_width]`.

## Flow

1. Start with `lines = 1`, `current_width = 0`.
2. For each character in `s`:
   - Look up its width via `ord(ch) - ord('a')` as an index into `widths`.
   - If appending this character would exceed 100 pixels, start a new line (`lines += 1`) and set `current_width` to just this character's width.
   - Otherwise, accumulate the width.
3. Return the line count and final line width.

The key decision point is `current_width + w > 100` — a character that would push past the 100-pixel boundary forces a line break *before* itself. A character that lands exactly on 100 does not.

## Patterns

- **Greedy simulation**: pack as many characters as possible onto each line before moving to the next. No lookahead or backtracking.
- **Ordinal arithmetic**: `ord(ch) - ord('a')` maps lowercase letters to indices 0–25, a standard LeetCode idiom for avoiding a dictionary.

## Dependencies

- **Imports**: `typing.List` only (for type annotation).
- **Imported by**: `number-of-lines-to-write-string/test_solution.py`. The massive "Imported By" list in the prompt is noise — those are unrelated test files that import their own `solution.py`, not this one.

## Invariants

- `widths` must have exactly 26 elements (one per lowercase letter). No validation; out-of-range indexing would raise `IndexError`.
- `s` must contain only lowercase English letters. Any other character would index outside `widths`.
- Each character width is assumed to be ≤ 100. If a single character were wider than 100, the line would start with just that character and immediately exceed the limit on the *next* character — the logic still works, but the output would be semantically wrong (a character that can't fit on any line).
- `lines` is always ≥ 1, even for an empty string — but LeetCode guarantees `s` is non-empty (`1 <= s.length <= 1000`).

## Error Handling

None. The code trusts its inputs completely, which is appropriate for a LeetCode solution where constraints are guaranteed by the judge.

## Topics to Explore

- [file] `number-of-lines-to-write-string/test_solution.py` — See what edge cases the test suite covers (empty string, exact 100-pixel boundaries, single-character strings)
- [file] `number-of-lines-to-write-string/plan.md` — Check whether the plan documents the greedy approach or considered alternatives
- [general] `greedy-line-packing` — Compare with text-wrapping algorithms (e.g., Knuth-Plass) to understand what greedy sacrifices
- [function] `number-of-lines-to-write-string/solution.py:numberOfWays` — The method name doesn't match the problem; check if LeetCode's signature actually uses this name or if it's a typo in this repo

## Beliefs

- `line-break-before-overflow` — A new line is started *before* the character that would exceed 100 pixels; that character becomes the first on the new line
- `exact-100-no-break` — A character landing exactly at `current_width + w == 100` does *not* trigger a line break
- `empty-string-returns-one-line` — An empty input string returns `[1, 0]` because `lines` is initialized to 1 and never incremented
- `single-pass-linear` — The algorithm is O(n) in the length of `s` with O(1) extra space

