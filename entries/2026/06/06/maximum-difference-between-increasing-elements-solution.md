# File: maximum-difference-between-increasing-elements/solution.py

**Date:** 2026-06-06
**Time:** 17:36

## Purpose

This file implements [LeetCode 2016: Maximum Difference Between Increasing Elements](https://leetcode.com/problems/maximum-difference-between-increasing-elements/). It owns the single function that solves the problem: given an array, find the maximum value of `nums[j] - nums[i]` where `i < j` and `nums[i] < nums[j]`, or return `-1` if no such pair exists.

## Key Components

### `maximum_difference_between_increasing_elements(nums: list[int]) -> int`

**Contract**: Accepts a list of at least 2 integers. Returns the maximum positive difference between a later element and an earlier, strictly smaller element — or `-1` if every element is less than or equal to all preceding elements (i.e., the array is non-increasing).

## Patterns

This uses the **running minimum** pattern — a single-pass O(n) technique common in "best time to buy/sell stock"-style problems. Instead of checking all O(n^2) pairs, it tracks the smallest value seen so far and computes the difference against each subsequent element.

This is structurally identical to the `best-time-to-buy-and-sell-stock` solution in this repo, with one difference: it returns `-1` instead of `0` when no valid pair exists (since the problem requires strict inequality `nums[i] < nums[j]`).

## Dependencies

**Imports**: None — pure standard library types only (`list[int]`).

**Imported by**: The `test_solution.py` in the same directory. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a test harness pattern, not actual importers of this function.

## Flow

1. Initialize `min_val` to `nums[0]` and `max_diff` to `-1` (the sentinel for "no valid pair").
2. Iterate `j` from index 1 through `len(nums) - 1`:
   - If `nums[j] > min_val` (strict inequality), update `max_diff` to the larger of itself and `nums[j] - min_val`.
   - Update `min_val` to the smaller of itself and `nums[j]`.
3. Return `max_diff`.

The order within the loop body matters: the difference is computed **before** `min_val` is updated with the current element. This ensures `i < j` — we never compute a difference of an element against itself.

## Invariants

- **Strict inequality**: The `if nums[j] > min_val` guard ensures equal elements don't produce a difference of 0. A non-increasing array returns `-1`.
- **Ordering constraint**: By updating `min_val` after computing the difference, the algorithm guarantees the minimum always comes from an earlier index than the current `j`.
- **Single pass**: O(n) time, O(1) space.

## Error Handling

None. The function trusts its input matches the LeetCode constraint (`2 <= n <= 1000`). An empty list would raise `IndexError` at `nums[0]`; a single-element list would return `-1` (the loop body never executes).

## Topics to Explore

- [file] `best-time-to-buy-and-sell-stock/solution.py` — Nearly identical algorithm; comparing the two clarifies when running-minimum returns 0 vs -1
- [file] `maximum-difference-between-increasing-elements/test_solution.py` — Edge cases tested, especially non-increasing arrays and equal-element arrays
- [general] `running-minimum-pattern` — This pattern recurs across multiple solutions in the repo (stock problems, max subarray variants); understanding it once covers many problems
- [file] `maximum-ascending-subarray-sum/solution.py` — Another single-pass problem with an ordering constraint, but accumulates sums instead of differences

## Beliefs

- `running-min-before-diff` — `min_val` is updated after the difference check, guaranteeing the minimum always originates from an index strictly less than `j`
- `strict-inequality-guard` — The `nums[j] > min_val` check (not `>=`) means equal-valued pairs never contribute a difference, and a flat or descending array returns `-1`
- `single-pass-linear` — The algorithm is O(n) time and O(1) space with exactly one traversal of the input
- `structural-twin-of-stock-problem` — This solution is algorithmically identical to "Best Time to Buy and Sell Stock" except for the `-1` sentinel instead of `0`

