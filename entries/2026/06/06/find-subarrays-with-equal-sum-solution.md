# File: find-subarrays-with-equal-sum/solution.py

**Date:** 2026-06-06
**Time:** 16:42

## Purpose

This file solves [LeetCode 2395: Find Subarrays With Equal Sum](https://leetcode.com/problems/find-subarrays-with-equal-sum/). It determines whether any two distinct length-2 subarrays in an integer array share the same sum. It owns exactly one responsibility: the `equal_sum_subarrays` function, which is the solution entry point imported by the corresponding test file and (based on the `imported_by` list) referenced broadly across the test suite — likely via a shared test harness pattern.

## Key Components

### `equal_sum_subarrays(nums: list[int]) -> bool`

**Contract**: Given a list of integers with length >= 2, returns `True` if there exist two length-2 subarrays starting at different indices whose element sums are equal.

The function uses a single-pass scan with a hash set for O(n) time and O(n) space.

## Patterns

**Sliding window + seen-set**: Rather than computing all pairwise sums and comparing (O(n^2)), the code slides a width-2 window across the array, computing each sum on the fly. Each sum is checked against a `seen` set before being added — a standard duplicate-detection idiom. This is the minimal correct approach: no prefix-sum array, no sorting, just a set and one pass.

**Early return**: The function short-circuits on the first duplicate sum found, avoiding unnecessary work.

## Dependencies

**Imports**: None — pure stdlib Python, no external dependencies.

**Imported by**: The function is imported by `find-subarrays-with-equal-sum/test_solution.py` directly. The massive `imported_by` list in the prompt (300+ test files) is an artifact of the repo's test harness structure — those test files likely share a common import mechanism or test runner, not direct imports of this function.

## Flow

1. Initialize an empty set `seen`.
2. Iterate `i` from `0` to `len(nums) - 2` (inclusive).
3. Compute `s = nums[i] + nums[i + 1]` — the sum of the current length-2 subarray.
4. If `s` is already in `seen`, return `True` immediately.
5. Otherwise, add `s` to `seen` and continue.
6. If the loop completes without finding a duplicate, return `False`.

## Invariants

- **Window size is always 2**: The loop bound `range(len(nums) - 1)` guarantees `nums[i + 1]` is always in bounds.
- **Precondition**: `len(nums) >= 2` (stated in docstring, not enforced). With a single-element list, the loop body never executes and the function returns `False` — safe but semantically meaningless.
- **No index reuse**: The `seen` set accumulates sums from prior indices only. The current sum is checked *before* insertion, so a subarray is never compared against itself.

## Error Handling

None. The function trusts its caller to provide a valid list of integers. An empty list or single-element list silently returns `False`. Non-integer elements would propagate a `TypeError` from the `+` operator — no defensive handling.

## Topics to Explore

- [file] `find-subarrays-with-equal-sum/test_solution.py` — How the test harness exercises this function, including edge cases
- [file] `find-subarrays-with-equal-sum/review.md` — Code review notes that may document alternative approaches or known limitations
- [function] `contains-duplicate-ii/solution.py:containsNearbyDuplicate` — Same seen-set-with-sliding-window pattern applied to a different constraint (index distance)
- [general] `set-based-duplicate-detection` — This pattern recurs across many solutions in the repo (e.g., `two-sum`, `contains-duplicate-ii`, `first-letter-to-appear-twice`)

## Beliefs

- `equal-sum-subarrays-is-single-pass` — `equal_sum_subarrays` visits each element at most once, giving O(n) time complexity
- `equal-sum-subarrays-checks-before-insert` — The duplicate check (`if s in seen`) occurs before `seen.add(s)`, preventing a subarray from matching itself
- `equal-sum-subarrays-no-validation` — The function performs no input validation; it assumes `nums` has length >= 2 per the docstring contract
- `equal-sum-subarrays-early-return` — The function returns `True` on the first duplicate sum found, not after scanning the entire array

