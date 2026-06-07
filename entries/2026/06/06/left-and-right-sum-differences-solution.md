# File: left-and-right-sum-differences/solution.py

**Date:** 2026-06-06
**Time:** 17:21

## Purpose

This file solves [LeetCode 2574 — Left and Right Sum Differences](https://leetcode.com/problems/left-and-right-sum-differences/). It computes, for each index `i`, the absolute difference between the sum of all elements to the left of `i` and the sum of all elements to the right of `i`. It's a single-function module exposing `get_answer` as the solution entry point.

## Key Components

### `get_answer(nums: list[int]) -> list[int]`

**Contract**: Given a 0-indexed integer array, returns an array of the same length where `answer[i] = |leftSum[i] - rightSum[i]|`.

- `leftSum[i]` = sum of `nums[0..i-1]` (0 for index 0)
- `rightSum[i]` = sum of `nums[i+1..n-1]` (0 for last index)

## Patterns

**Running-sum decomposition.** Rather than computing `leftSum` and `rightSum` arrays separately (two passes + O(n) extra space each), this uses a single pass with an algebraic identity:

```
rightSum[i] = total - leftSum[i] - nums[i]
```

This avoids building any prefix/suffix sum arrays. The `left` accumulator grows as we iterate, and `right` is derived from the invariant that `left + nums[i] + right = total`. This is the standard O(n) time / O(1) auxiliary space approach for prefix-suffix problems.

## Dependencies

**Imports**: None — pure Python, no external or standard library imports.

**Imported by**: The `left-and-right-sum-differences/test_solution.py` file imports this directly. The "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share a common test harness, not actual consumers of this function.

## Flow

1. Compute `total = sum(nums)` — one full pass.
2. Initialize `left = 0` (nothing to the left of index 0).
3. For each element `x` in `nums`:
   - Derive `right = total - left - x` (everything except left-side elements and current element).
   - Append `abs(left - right)` to the result.
   - Advance the left accumulator: `left += x`.
4. Return the result list.

The key subtlety is ordering: `right` is computed *before* `left` is updated with the current element, so `left` represents the sum of elements strictly before index `i`, and `right` represents the sum strictly after.

## Invariants

- At the start of each loop iteration for index `i`: `left == sum(nums[0:i])`.
- After computing `right`: `left + x + right == total` always holds.
- Output length always equals input length.

## Error Handling

None. The function assumes valid input per the LeetCode contract (non-empty list of integers). No bounds checking, no type validation. An empty list would produce an empty result (harmless). A non-list input would raise at `sum(nums)`.

## Topics to Explore

- [file] `left-and-right-sum-differences/test_solution.py` — See what edge cases are covered (empty arrays, single element, all zeros)
- [function] `find-pivot-index/solution.py:get_answer` — Same prefix-sum decomposition pattern applied to finding where leftSum equals rightSum
- [function] `find-the-highest-altitude/solution.py:get_answer` — Another prefix-sum variant worth comparing
- [general] `running-sum-patterns` — How the repo handles prefix/suffix sum problems across solutions (running-sum-of-1d-array, find-pivot-index, this file)

## Beliefs

- `left-right-single-pass` — `get_answer` computes the result in exactly one pass after an initial `sum()`, making it O(n) time and O(1) auxiliary space (beyond the output list)
- `right-derived-from-invariant` — The right sum is never independently accumulated; it is always derived as `total - left - current_element`
- `left-updated-after-right` — The left accumulator is updated *after* computing `right`, ensuring `left` represents `sum(nums[0:i])` not `sum(nums[0:i+1])` when computing the answer for index `i`
- `no-import-dependencies` — The module uses no imports; it is pure Python with no standard library or third-party dependencies

