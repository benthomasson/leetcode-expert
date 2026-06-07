# File: remove-one-element-to-make-the-array-strictly-increasing/solution.py

**Date:** 2026-06-06
**Time:** 18:48

## Purpose

This file solves [LeetCode 1909: Remove One Element to Make the Array Strictly Increasing](https://leetcode.com/problems/remove-one-element-to-make-the-array-strictly-increasing/). It determines whether you can remove exactly one element from an integer array to make the remaining elements strictly increasing. It's a standalone solution module in a repo of ~500+ LeetCode problems, each in its own directory.

## Key Components

### `canBeIncreasing(nums: list[int]) -> bool`

The public entry point. Scans for the first violation of strict monotonicity, then checks whether removing either of the two elements involved in the violation fixes the array.

### `is_increasing_skip(skip: int) -> bool`

A nested helper that checks whether `nums` is strictly increasing when the element at index `skip` is logically removed. Instead of building a new list, it iterates through all indices and skips the one at `skip`, comparing each non-skipped value against the previous.

## Patterns

**Early violation detection with targeted repair.** Rather than brute-forcing all n possible removals (O(n^2)), the algorithm finds the *first* pair `(i-1, i)` where `nums[i] <= nums[i-1]` and only tests removing one of those two. This works because any fix *must* address the first violation — if neither removal fixes it, no single removal can fix the array.

**Logical deletion over physical deletion.** `is_increasing_skip` doesn't slice or copy the array. It skips the target index during iteration, keeping the check O(n) with O(1) extra space.

**Sentinel initialization.** `prev` starts at `-1`, which works because LeetCode's constraints guarantee `nums[i] >= 1`. This avoids special-casing the first element comparison.

## Dependencies

**Imports:** None — pure Python, no stdlib or third-party dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo, likely an artifact of the analysis tool. The actual consumer is `remove-one-element-to-make-the-array-strictly-increasing/test_solution.py`.

## Flow

1. Iterate `i` from `1` to `len(nums) - 1`.
2. At each step, check if `nums[i] <= nums[i-1]` (violation of strict increase).
3. On the **first** violation found, return `is_increasing_skip(i) or is_increasing_skip(i-1)` — try removing the current element or the previous one.
4. If the loop completes with no violation, the array is already strictly increasing. Removing any single element preserves this, so return `True`.

The two `is_increasing_skip` calls each do a full O(n) pass, but they run at most once total, so overall complexity is O(n).

## Invariants

- The function assumes `len(nums) >= 2` (per the problem constraints). No explicit length check.
- `prev = -1` relies on all values being positive integers (`1 <= nums[i] <= 10^9`).
- Only the first violation is examined. The correctness argument: if the first violation can't be fixed by removing one of its two elements, no other removal can fix it either (the violation would persist).

## Error Handling

None. The function trusts that it receives a valid `list[int]` matching the problem constraints. No exceptions are raised or caught.

## Topics to Explore

- [file] `remove-one-element-to-make-the-array-strictly-increasing/test_solution.py` — See what edge cases are covered (e.g., violation at boundaries, all-equal arrays, length-2 input)
- [file] `remove-one-element-to-make-the-array-strictly-increasing/review.md` — Read the code review for quality notes and alternative approaches
- [function] `minimum-operations-to-make-the-array-increasing/solution.py:minOperations` — Related problem about making arrays strictly increasing, different constraint (increment instead of remove)
- [general] `first-violation-greedy-correctness` — Why testing only the first violation is sufficient — the proof that if neither removal at the first violation works, no single removal anywhere will
- [file] `check-if-array-is-sorted-and-rotated/solution.py` — Another "count violations" pattern on sorted-array problems

## Beliefs

- `canbeincreasing-linear-time` — `canBeIncreasing` runs in O(n) time and O(1) extra space; `is_increasing_skip` is called at most twice, each doing one pass
- `first-violation-sufficiency` — The algorithm only examines the first violation point because any valid single removal must resolve it; if neither candidate fixes it, no removal can
- `prev-sentinel-assumes-positive` — The `prev = -1` sentinel is correct only when all array values are >= 1, matching the LeetCode constraint `1 <= nums[i] <= 10^9`
- `already-increasing-returns-true` — When the input is already strictly increasing, the function returns `True` without calling `is_increasing_skip`, since removing any element preserves monotonicity

