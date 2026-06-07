# File: largest-positive-integer-that-exists-with-its-negative/solution.py

**Date:** 2026-06-06
**Time:** 17:16

## Purpose

This file solves [LeetCode 2441: Largest Positive Integer That Exists With Its Negative](https://leetcode.com/problems/largest-positive-integer-that-exists-with-its-negative/). It exports a single function `find_K` that finds the largest positive integer `k` in an array where `-k` is also present. It's one of hundreds of problem solutions in the `leetcode-implementations` repo, each living in its own directory alongside tests and review artifacts.

## Key Components

**`find_K(nums: list[int]) -> int`** — The sole public function. Contract: given a list of non-zero integers, return the largest positive `k` where both `k` and `-k` exist, or `-1` if no such pair exists.

## Patterns

The solution follows a **set-lookup** idiom: convert the input to a set for O(1) membership testing, then iterate over positive values checking for their negation. This is the standard approach for "does a complement exist?" problems (same family as Two Sum with a set).

The iteration is over `num_set` rather than `nums` — this avoids redundant checks when duplicates are present, though it doesn't change the asymptotic complexity.

## Dependencies

**Imports:** None — pure stdlib Python using only built-in `set` and `max`.

**Imported by:** The corresponding `test_solution.py` in the same directory, plus (based on the metadata) hundreds of other test files across the repo. That's almost certainly an artifact of the "Imported By" analysis picking up a shared test harness or runner, not actual imports of `find_K` from unrelated problem directories.

## Flow

1. Build `num_set` from `nums` — O(n) time, O(n) space.
2. Initialize `result = -1` (the sentinel for "no pair found").
3. Iterate over each unique value in the set. For each positive value, check if its negation exists in the set. If so, update `result` via `max`.
4. Return `result`.

Total: O(n) time, O(n) space.

## Invariants

- The function assumes `nums` contains no zeros (per the problem constraints). If zeros were present, `0 > 0` is false, so zero would never be a candidate — the code is accidentally correct for that case but doesn't rely on it.
- `result` is initialized to `-1`, which is safe because the function only considers `num > 0`, so any valid answer is `>= 1` and will always beat `-1` in the `max` call.
- The return type is always `int` — either a positive integer or `-1`.

## Error Handling

None. The function trusts that inputs conform to the problem constraints (non-zero integers, list length 1–1000). No validation, no exceptions. This is typical for LeetCode solutions where the caller guarantees valid input.

## Topics to Explore

- [file] `largest-positive-integer-that-exists-with-its-negative/test_solution.py` — See the test cases and how edge cases (all positives, all negatives, single element) are covered
- [file] `largest-positive-integer-that-exists-with-its-negative/review.md` — The code review artifact may capture alternative approaches or complexity analysis
- [function] `two-sum/solution.py:twoSum` — Same set-lookup-for-complement pattern applied to a different problem
- [general] `set-complement-pattern` — The broader family of problems (Two Sum, pair detection, k/-k) that use hash-set complement lookups

## Beliefs

- `find-k-returns-negative-one-on-no-match` — `find_K` returns `-1` when no positive/negative pair exists, not `None` or an exception
- `find-k-linear-time` — The algorithm runs in O(n) time and O(n) space due to set construction and single-pass iteration
- `find-k-iterates-unique-values` — The loop iterates over the deduplicated `num_set`, not the original `nums` list, avoiding redundant comparisons
- `find-k-no-input-validation` — The function performs no bounds checking or type validation; it trusts LeetCode's input guarantees

