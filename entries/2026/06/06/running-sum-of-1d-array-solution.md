# File: running-sum-of-1d-array/solution.py

**Date:** 2026-06-06
**Time:** 18:58

## Purpose

This file implements the solution to [LeetCode 1480 — Running Sum of 1d Array](https://leetcode.com/problems/running-sum-of-1d-array/). It computes the prefix sum of an integer array, where each element `result[i]` equals the sum of all elements from index `0` through `i`. It's a single-responsibility module: one class, one method, one problem.

## Key Components

### `Solution.runningSum(nums: List[int]) -> List[int]`

Computes prefix sums **in-place** by accumulating each element onto the previous one. The loop starts at index 1 (skipping index 0, which is already its own prefix sum) and overwrites `nums[i]` with `nums[i] + nums[i-1]`. Returns the mutated input list.

**Contract:** Accepts a non-empty list of integers. Returns the same list object, now containing prefix sums.

## Patterns

**In-place mutation.** Rather than allocating a new list, the solution overwrites the input array. This is a common LeetCode idiom — it's O(1) auxiliary space, but it destroys the original data. The caller's list is modified as a side effect, which matters if they hold a reference to it.

**Prefix sum via forward accumulation.** After each iteration, `nums[i]` holds the sum `nums[0] + nums[1] + ... + nums[i]` because `nums[i-1]` already contains the prefix sum up to `i-1`. This is the standard single-pass prefix sum pattern.

## Dependencies

**Imports:** `List` from `typing` — used solely for the type annotation.

**Imported by:** The `running-sum-of-1d-array/test_solution.py` file directly tests this. The massive "Imported By" list in the context is misleading — those are unrelated test files across the repo that happen to import their own `Solution` class, not this one. The only real consumer is this problem's own test file.

## Flow

1. Loop `i` from `1` to `len(nums) - 1`.
2. At each step, `nums[i] += nums[i - 1]` — the current element absorbs the running total.
3. After the loop, every position holds its prefix sum. Return `nums`.

For input `[1, 2, 3, 4]`:
- `i=1`: `nums[1] = 2 + 1 = 3` → `[1, 3, 3, 4]`
- `i=2`: `nums[2] = 3 + 3 = 6` → `[1, 3, 6, 4]`
- `i=3`: `nums[3] = 4 + 6 = 10` → `[1, 3, 6, 10]`

## Invariants

- **Loop invariant:** At the start of iteration `i`, all elements `nums[0..i-1]` are correct prefix sums.
- **Single-element lists:** The `range(1, 1)` loop body never executes, so a single-element list is returned unchanged — correct, since the prefix sum of one element is itself.
- **Empty lists:** `range(1, 0)` is empty, so an empty list passes through without error.

## Error Handling

None. The method trusts its input matches the LeetCode contract (non-empty integer list). No bounds checking, no type validation. This is appropriate for a LeetCode solution where the platform guarantees valid input.

## Topics to Explore

- [file] `running-sum-of-1d-array/test_solution.py` — See the test cases and edge cases exercised against this solution
- [file] `running-sum-of-1d-array/review.md` — Code review notes that may flag the in-place mutation tradeoff
- [function] `find-the-highest-altitude/solution.py:largestAltitude` — A closely related prefix-sum problem where max of the running sum is returned instead
- [function] `find-pivot-index/solution.py:pivotIndex` — Uses prefix sums to find where left sum equals right sum
- [general] `in-place-vs-copy-prefix-sum` — Whether in-place mutation is preferred across this repo's solutions or if some allocate a new array

## Beliefs

- `running-sum-mutates-input` — `runningSum` modifies and returns the input list rather than allocating a new one; callers lose the original data
- `running-sum-is-single-pass-linear` — The algorithm runs in O(n) time and O(1) auxiliary space via forward accumulation
- `running-sum-handles-single-element` — A single-element input is returned unchanged because the loop range `(1, 1)` is empty
- `running-sum-forward-invariant` — After processing index `i`, `nums[i]` equals `sum(original_nums[0..i])`

