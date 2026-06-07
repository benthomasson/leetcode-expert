# File: longest-harmonious-subsequence/solution.py

**Date:** 2026-06-06
**Time:** 17:26

## Purpose

This file solves [LeetCode 594 — Longest Harmonious Subsequence](https://leetcode.com/problems/longest-harmonious-subsequence/). A harmonious subsequence is one where the difference between the maximum and minimum values is exactly 1. The file owns the single function `findLHS` that computes this.

## Key Components

### `findLHS(nums: List[int]) -> int`

Takes a list of integers, returns the length of the longest harmonious subsequence, or 0 if none exists.

The key insight: because a harmonious subsequence must have max - min == 1, every element in it must be one of exactly two consecutive values — say `k` and `k+1`. The order of elements in the original list doesn't matter for subsequences (you can pick any subset), so the problem reduces to: for each pair of consecutive integers `(k, k+1)` present in `nums`, how many total elements have value `k` or `k+1`? Take the max.

## Patterns

**Frequency counting + adjacency check** — a common LeetCode idiom. Rather than examining O(n^2) pairs, it collapses the array into a frequency map and iterates over distinct keys. This is the canonical O(n) approach for this problem.

The iteration only checks `k + 1` (not `k - 1`), which avoids double-counting — every valid pair `(k, k+1)` is visited exactly once, when iterating over `k`.

## Dependencies

**Imports:** `Counter` from `collections` (does the frequency counting) and `List` from `typing` (type annotation only).

**Imported by:** `longest-harmonious-subsequence/test_solution.py` — the test file. The massive "Imported By" list in the prompt is noise from the repo's test infrastructure, not actual consumers of this function.

## Flow

1. Build a frequency map: `Counter(nums)` — O(n).
2. For each distinct value `k` in the counter, check if `k + 1` also exists.
3. If so, the harmonious subsequence using values `{k, k+1}` has length `count[k] + count[k+1]`. Track the max.
4. Return the max (0 if no adjacent pair exists).

## Invariants

- The function only considers pairs differing by exactly 1. A list of all-identical values returns 0 (not the list length), because max - min would be 0, not 1.
- The one-directional check (`k + 1 in count`) guarantees each adjacent pair is evaluated once.

## Error Handling

None. The function assumes valid input per LeetCode constraints. An empty list naturally returns 0 because the `for` loop doesn't execute.

## Topics to Explore

- [file] `longest-harmonious-subsequence/test_solution.py` — See the edge cases tested (empty list, all-same values, negative numbers)
- [file] `longest-harmonious-subsequence/plan.md` — The planning doc may show alternative approaches considered (sorting-based O(n log n), sliding window)
- [function] `degree-of-an-array/solution.py:findShortestSubArray` — Another frequency-counting problem with a similar Counter-based pattern but different objective
- [general] `counter-based-leetcode-patterns` — Many easy/medium problems (majority element, top-k frequent, etc.) share this Counter + single-pass idiom

## Beliefs

- `lhs-returns-zero-for-uniform-list` — `findLHS` returns 0 when all elements are identical, because max - min == 0, not 1
- `lhs-linear-time` — The algorithm runs in O(n) time and O(n) space via a single Counter construction and one pass over distinct keys
- `lhs-one-directional-check` — Only `k + 1` is checked (never `k - 1`), ensuring each valid pair is counted exactly once
- `lhs-subsequence-not-subarray` — The solution correctly treats the input as a subsequence problem (order-independent) by using counts rather than positional logic

