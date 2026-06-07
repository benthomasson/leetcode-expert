# File: positions-of-large-groups/solution.py

**Date:** 2026-06-06
**Time:** 18:33

## Purpose

This file solves [LeetCode 830 — Positions of Large Groups](https://leetcode.com/problems/positions-of-large-groups/). It identifies contiguous runs of the same character in a string where the run length is 3 or more, returning the `[start, end]` index pair for each such group.

It's one solution module among hundreds in the `leetcode-implementations` repo, following the standard `solution.py` + `test_solution.py` + `plan.md` + `review.md` structure.

## Key Components

**`Solution.largeGroupPositions(self, s: str) -> List[List[int]]`** — the single method. Takes a lowercase string, returns a list of `[start, end]` intervals (inclusive on both ends) for every group of 3+ consecutive identical characters.

## Patterns

**Single-pass group detection** — the algorithm tracks the `start` of the current run and advances `i` until the character changes (or the string ends). When a boundary is hit, it checks whether the group is "large" (length >= 3) and records it. This is the idiomatic way to find consecutive runs in O(n) time and O(1) extra space (excluding the result list).

**Sentinel-style loop bound** — the loop runs to `len(s) + 1` (not `len(s)`), and the condition `i == len(s)` acts as a virtual sentinel to flush the final group. This avoids duplicating the "emit group" logic after the loop — a common pattern in run-length problems.

## Dependencies

**Imports**: `List` from `typing` — used only for the return type annotation.

**Imported by**: `positions-of-large-groups/test_solution.py` imports the `Solution` class. The large "Imported By" list in the prompt is noise from the repo-wide import graph of `typing.List`, not actual dependents of this module.

## Flow

1. Initialize `result = []` and `start = 0` (beginning of the first group).
2. Iterate `i` from 1 through `len(s)` inclusive.
3. At each `i`, if `i` is past the end or `s[i]` differs from `s[start]`, the current group `[start, i-1]` has ended.
4. If the group length `i - start >= 3`, append `[start, i - 1]` to `result`.
5. Reset `start = i` to begin the next group.
6. Return `result`.

For input `"aaa"`: `i=1` same, `i=2` same, `i=3` triggers `i == len(s)`, group length 3 >= 3, emits `[0, 2]`.

## Invariants

- **Group boundaries are inclusive**: both `start` and `end` indices point to characters inside the group.
- **Threshold is 3**: groups of length 1 or 2 are silently skipped.
- **Output ordering**: groups appear left-to-right because the single left-to-right pass emits them in order.
- **Input assumed valid**: no empty-string guard, but the loop naturally returns `[]` for `s = ""` since `range(1, 1)` is empty.

## Error Handling

None. The method assumes a valid lowercase string per the LeetCode contract. An empty string produces an empty result without error.

## Topics to Explore

- [file] `positions-of-large-groups/test_solution.py` — See the edge cases and expected outputs this solution is validated against
- [file] `positions-of-large-groups/plan.md` — The planning rationale behind the chosen approach
- [file] `consecutive-characters/solution.py` — Similar single-pass consecutive-run pattern, finds the longest run instead of all large runs
- [file] `count-binary-substrings/solution.py` — Another run-grouping problem that builds on the same consecutive-character decomposition
- [general] `sentinel-loop-pattern` — The `i == len(s)` trick to flush the last group without post-loop duplication, used across many run-based solutions in this repo

## Beliefs

- `large-group-threshold-is-3` — A group is "large" if and only if it contains 3 or more consecutive identical characters; groups of length 1 or 2 are excluded from the result.
- `single-pass-linear-time` — The algorithm makes exactly one pass over the string with O(n) time complexity and O(1) auxiliary space (beyond the output list).
- `inclusive-interval-output` — Each returned interval `[start, end]` is inclusive on both ends, matching LeetCode's expected format.
- `sentinel-boundary-flush` — The loop iterates to `len(s)` (one past the last index) so the final character group is flushed without special-case code after the loop.

