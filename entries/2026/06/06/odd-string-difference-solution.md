# File: odd-string-difference/solution.py

**Date:** 2026-06-06
**Time:** 18:26

## Purpose

This file solves [LeetCode 2451 — Odd String Difference](https://leetcode.com/problems/odd-string-difference/). Given a list of equal-length strings, it finds the one string whose "difference array" (consecutive character ordinal differences) is unique among the group. Every other string shares the same difference array.

## Key Components

### `stringWithDifferentDifference(words)`
The main solver. Takes a list of equal-length lowercase strings and returns the one whose difference array is unique.

### `diff(w)` (inner function)
Computes the difference array for a string as a tuple of integers. For a string of length `n`, it produces `n-1` values where each value is `ord(w[i+1]) - ord(w[i])`. Returns a tuple so it's hashable and usable as a `Counter` key.

## Patterns

**Counter-based outlier detection**: Rather than comparing pairs or using a majority-vote loop, the solution hashes every difference array and counts occurrences. The outlier is the one with count == 1. This is the idiomatic "find the unique element" pattern — the same approach you'd use for "single number" problems, generalized to tuples.

**Tuple as hashable signature**: The difference array is stored as a tuple (not a list) specifically so it can serve as a dictionary key in the `Counter`.

## Dependencies

- **Imports**: `collections.Counter` — used for frequency counting of difference tuples.
- **Imported by**: `odd-string-difference/test_solution.py` and hundreds of other test files across the repo (the "Imported By" list in the prompt is a repo-wide cross-reference artifact, not real imports of this file).

## Flow

1. Compute `diff(w)` for every word, producing a list of tuples.
2. Feed all tuples into a `Counter` to get frequencies.
3. Iterate through `(word, diff_tuple)` pairs; return the first word whose diff tuple has a count of 1.
4. Fall through to `return ""` if no unique diff is found (unreachable given valid problem inputs).

## Invariants

- All strings in `words` have equal length (problem constraint). If violated, `diff` would still run but produce tuples of different lengths, which would break the counting logic in a subtle way — they'd never match, so multiple strings could have count 1.
- Exactly one string has a unique difference array. If more than one were unique, the function returns only the first one found.
- The difference values can be negative (e.g., "ba" → `(-1,)`).

## Error Handling

None. The function trusts its inputs match the problem constraints. The trailing `return ""` is a defensive fallback that can't trigger under valid inputs — it exists to satisfy the return-type contract.

## Topics to Explore

- [file] `odd-string-difference/test_solution.py` — See the test cases to understand edge cases the solution handles
- [file] `odd-string-difference/plan.md` — Read the planning doc for alternative approaches considered
- [general] `counter-outlier-pattern` — How Counter-based frequency analysis is used across this repo to find unique/majority elements (cf. `majority-element`, `single-number` style problems)
- [function] `odd-string-difference/solution.py:diff` — Consider whether precomputing all diffs is necessary or whether an early-exit comparing the first three words would be faster for large inputs

## Beliefs

- `diff-tuple-is-hashable` — The difference array is returned as a tuple (not list) specifically to serve as a Counter/dict key
- `exactly-one-outlier-assumed` — The algorithm assumes exactly one word has a unique difference array; if zero or multiple are unique, behavior is undefined by the problem but the code returns the first match or empty string
- `linear-time-complexity` — The solution runs in O(n * m) time where n is the number of words and m is word length, with a single pass to build diffs and a single pass to find the outlier
- `counter-avoids-pairwise-comparison` — Using Counter reduces the problem from O(n^2) pairwise diff comparison to O(n) frequency lookup

