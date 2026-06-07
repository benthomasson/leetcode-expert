# File: maximum-product-difference-between-two-pairs/solution.py

**Date:** 2026-06-06
**Time:** 17:41

## Purpose

This file solves [LeetCode 1913 — Maximum Product Difference Between Two Pairs](https://leetcode.com/problems/maximum-product-difference-between-two-pairs/). Given an array of integers with at least 4 elements, it finds the maximum value of `(nums[w] * nums[x]) - (nums[y] * nums[z])` where `w`, `x`, `y`, `z` are distinct indices.

It's one of ~500+ solution modules in the `leetcode-implementations` repo, following the standard per-problem directory layout (`solution.py`, `test_solution.py`, `plan.md`, `review.md`).

## Key Components

**`max_product_difference(nums: list[int]) -> int`** — The sole function. Takes an integer list, returns the maximum product difference.

Contract: `nums` must have length >= 4 (per LeetCode constraints). All elements are positive integers (1 <= nums[i] <= 10^4 per the problem).

## Patterns

**Sort-and-pick-extremes**: Rather than brute-forcing all 4-index combinations (O(n^4)), the solution sorts the array and directly picks the two largest (`nums[-1]`, `nums[-2]`) and two smallest (`nums[0]`, `nums[1]`) values. This works because to maximize `(a*b) - (c*d)`, you maximize the first product and minimize the second — which means picking the two largest for the first pair and two smallest for the second.

**In-place mutation**: `nums.sort()` mutates the caller's list. This is a common LeetCode convention where the input is considered consumed after the call, though it's worth noting if this function were used in a larger system.

## Dependencies

**Imports**: None — pure stdlib, no external dependencies.

**Imported by**: `maximum-product-difference-between-two-pairs/test_solution.py` directly. The massive "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share a common test harness or import pattern, not actual consumers of `max_product_difference`.

## Flow

1. Sort `nums` in ascending order — O(n log n)
2. Multiply the last two elements (largest pair)
3. Multiply the first two elements (smallest pair)
4. Return the difference

Single expression, no branching.

## Invariants

- After sorting: `nums[0] <= nums[1] <= ... <= nums[-2] <= nums[-1]`
- The product `nums[-1] * nums[-2]` is the maximum possible product of any two elements
- The product `nums[0] * nums[1]` is the minimum possible product of any two elements (given the constraint that all values are positive)
- The four indices are guaranteed distinct because the array has >= 4 elements

**Important constraint**: This solution is correct only when all elements are non-negative (which the LeetCode problem guarantees: `1 <= nums[i] <= 10^4`). If negatives were allowed, the two most-negative numbers could produce a larger product than the two largest positives, breaking the greedy assumption.

## Error Handling

None. The function trusts its input matches the LeetCode constraints. No validation, no exception handling. Arrays shorter than 4 elements would cause an `IndexError` on the slice accesses.

## Topics to Explore

- [file] `maximum-product-difference-between-two-pairs/test_solution.py` — See what edge cases are tested (length-4 arrays, duplicates, etc.)
- [file] `maximum-product-difference-between-two-pairs/review.md` — Check if the review flagged the in-place mutation or the positive-only assumption
- [function] `maximum-product-of-two-elements-in-an-array/solution.py:max_product` — Closely related problem (maximize a single product); compare approaches
- [function] `maximum-product-of-three-numbers/solution.py:maximum_product` — Three-number variant where negatives matter; shows when the sort-and-pick-ends pattern needs adjustment
- [general] `sort-vs-partial-sort` — This could use O(n) selection (find top-2 and bottom-2 with a single pass) instead of O(n log n) sort; worth considering for the pattern

## Beliefs

- `sort-greedy-correctness` — The sort-based approach is correct only because all `nums[i]` are positive; negative values would invalidate the assumption that the two smallest form the minimum product
- `mutates-input` — `max_product_difference` mutates the caller's list via `nums.sort()` rather than using `sorted()`
- `linear-time-possible` — The problem can be solved in O(n) by tracking the two largest and two smallest in a single pass, but this solution uses O(n log n) sort
- `no-input-validation` — The function performs no bounds checking; arrays with fewer than 4 elements will raise `IndexError`

