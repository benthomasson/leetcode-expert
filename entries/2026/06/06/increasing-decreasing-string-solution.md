# File: increasing-decreasing-string/solution.py

**Date:** 2026-06-06
**Time:** 17:03

## Purpose

This file solves [LeetCode 1370: Increasing Decreasing String](https://leetcode.com/problems/increasing-decreasing-string/). It implements the "sort string" algorithm that repeatedly sweeps through available characters in ascending then descending order, appending one of each to the result until all characters are consumed. The file is self-contained: solution class + unit tests in one module.

## Key Components

### `Solution.sortString(s: str) -> str`

The core algorithm. Takes a string of lowercase English letters and returns a reordered string built by alternating forward (a→z) and backward (z→a) sweeps through the character set.

**Contract**: Input must be lowercase English letters only. Output is a permutation of the input with the same character frequencies.

### `TestSortString`

Nine test cases covering: LeetCode examples, single character, uniform characters, pre-sorted/reverse-sorted inputs, and a full-alphabet input.

## Patterns

**Counting sort via fixed-size array**: Rather than using `collections.Counter` or sorting the string, the solution uses a 26-element integer array (`count`) indexed by character ordinal offset. This is the canonical approach when the alphabet is small and known — O(1) space (fixed 26), avoids hash overhead.

**Drain loop with remaining counter**: The `remaining` variable tracks total characters left. The outer `while remaining > 0` loop runs until all characters are consumed. Each inner loop (forward sweep, backward sweep) decrements both the per-character count and the global remaining counter, so the loop terminates in at most `ceil(len(s) / num_distinct_chars)` iterations of the outer loop.

**Append-to-list then join**: Standard Python idiom for string building — `result` is a list, joined at the end. Avoids O(n²) string concatenation.

## Dependencies

**Imports**: Only `unittest` from the standard library. No external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files from *other* problems that import `unittest`, not files that import this module. This solution is standalone.

## Flow

1. Build a frequency array `count[0..25]` by scanning input string once — O(n).
2. Enter drain loop:
   - **Forward sweep** (indices 0→25): for each character with `count[i] > 0`, append it and decrement.
   - **Backward sweep** (indices 25→0): same logic, reverse direction.
3. Repeat until `remaining == 0`.
4. Join the result list into a string and return.

Each full iteration of the outer loop appends at most one instance of each distinct character (once forward, once backward). For input `"aaaabbbbcccc"`, the first iteration appends `a,b,c` (forward) then `c,b,a` (backward) = `"abccba"`, then repeats for the second batch.

## Invariants

- `sum(count) == remaining` at all times — these are kept in sync by decrementing both together.
- Characters within each sweep are strictly ordered (ascending in forward, descending in backward).
- The output is always a permutation of the input (same multiset of characters).
- The algorithm terminates because each inner-loop iteration that appends a character strictly decreases `remaining`.

## Error Handling

None. The function assumes valid input (lowercase English letters). No bounds checking, no type validation. Invalid input (uppercase, non-alpha, empty string) would silently produce incorrect results or an empty string — but LeetCode constraints guarantee valid input.

## Topics to Explore

- [file] `increasing-decreasing-string/test_solution.py` — Separate test file that may contain additional edge cases beyond the inline tests
- [function] `find-common-characters/solution.py:commonChars` — Another problem using the 26-element counting array pattern for character frequency manipulation
- [general] `counting-sort-in-leetcode` — Many easy string problems in this repo likely share the fixed-size frequency array idiom; compare approaches across solutions
- [file] `increasing-decreasing-string/review.md` — Code review notes that may highlight alternative approaches or complexity analysis

## Beliefs

- `sort-string-linear-time` — `sortString` runs in O(n * 26) = O(n) time where n is the input length, since each character is appended exactly once across all sweep iterations
- `sort-string-constant-space` — The `count` array is always exactly 26 elements regardless of input size; auxiliary space is O(1) beyond the output
- `sweep-ordering-guarantee` — Characters within each forward sweep are in strictly ascending order and within each backward sweep in strictly descending order, by construction of the index iteration
- `remaining-invariant` — The `remaining` counter equals `sum(count)` at every point in execution, ensuring the drain loop terminates exactly when all characters are consumed

