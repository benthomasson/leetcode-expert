# File: delete-characters-to-make-fancy-string/solution.py

**Date:** 2026-06-06
**Time:** 16:14

## Purpose

This file solves [LeetCode 1957 — Delete Characters to Make Fancy String](https://leetcode.com/problems/delete-characters-to-make-fancy-string/). A "fancy string" is one where no three consecutive characters are the same. The solution removes the minimum number of characters to achieve this property.

It follows the repo's standard layout: each problem gets a directory with `solution.py`, `test_solution.py`, `plan.md`, and `review.md`.

## Key Components

### `Solution.makeFancyString(self, s: str) -> str`

The single method. Contract:

- **Input**: a string `s` of lowercase English letters (per LeetCode constraints)
- **Output**: the longest subsequence of `s` (preserving order) where no character appears 3+ times consecutively
- **Guarantee**: removes the minimum number of characters — it only skips a character when forced (i.e., when the last two characters in the result are both equal to the current one)

## Patterns

**Greedy single-pass with output stack.** The `result` list acts as a stack where only the tail matters. Each character is either appended or skipped based on the two most recent entries. This is idiomatic for problems where a local decision (keep/skip) depends on a bounded window of prior output.

The `continue`-to-skip / default-to-append structure avoids an `else` branch — the append always runs unless the `continue` fires. This is a common Python idiom for filter-style loops.

## Dependencies

**Imports**: None — pure standard library, no external dependencies.

**Imported by**: `delete-characters-to-make-fancy-string/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those 400+ test files are likely an artifact of the repo's test infrastructure importing a shared test runner or `Solution` base, not this specific file.

## Flow

1. Initialize empty list `result`
2. Iterate through each character `c` in `s`
3. Check: if `result` has at least 2 elements AND both `result[-1]` and `result[-2]` equal `c` → skip (this would create a triple)
4. Otherwise → append `c`
5. Join and return

The `len(result) >= 2` guard prevents index errors on the first two characters, which are always safe to append.

## Invariants

- **At every iteration**, `result` contains no run of 3+ identical consecutive characters. This is the loop invariant maintained by the skip condition.
- **Order preservation**: characters appear in `result` in the same relative order as in `s` — it's a subsequence, not a rearrangement.
- **Minimality**: every skipped character is strictly necessary. A character is only skipped when keeping it would violate the fancy property. No valid character is ever removed.

## Error Handling

None. The function assumes valid input per LeetCode constraints. An empty string produces an empty result naturally (the loop body never executes). A single-character or two-character string passes through unchanged since the `len(result) >= 2` guard prevents the skip condition from ever firing.

## Topics to Explore

- [file] `delete-characters-to-make-fancy-string/test_solution.py` — See which edge cases the test suite covers (empty string, all-same characters, already-fancy input)
- [file] `delete-characters-to-make-fancy-string/review.md` — The code review may note alternative approaches (e.g., `itertools.groupby` capping each group at length 2)
- [file] `consecutive-characters/solution.py` — Related problem that also reasons about consecutive runs, but counts max run length instead of capping it
- [file] `remove-all-adjacent-duplicates-in-string/solution.py` — Similar stack-based string filtering pattern but with a different removal rule (pairs instead of triples)
- [general] `greedy-output-stack-pattern` — The broader pattern of building output character-by-character with a stack and a lookback window appears across many string problems in this repo

## Beliefs

- `fancy-string-linear-time` — `makeFancyString` runs in O(n) time and O(n) space where n is the length of the input string
- `fancy-string-lookback-two` — The skip decision depends only on the last two characters of the result, making this a fixed-window greedy algorithm
- `fancy-string-max-run-two` — The output is guaranteed to contain no run of 3 or more identical consecutive characters, but runs of exactly 2 are permitted
- `fancy-string-preserves-order` — The output is a subsequence of the input — characters are never reordered or inserted, only removed

