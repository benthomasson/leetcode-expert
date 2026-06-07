# File: check-if-array-is-sorted-and-rotated/solution.py

**Date:** 2026-06-06
**Time:** 15:38

## `check-if-array-is-sorted-and-rotated/solution.py`

### Purpose

This file solves [LeetCode 1752: Check if Array Is Sorted and Rotated](https://leetcode.com/problems/check-if-array-is-sorted-and-rotated/). It determines whether a given array could have originated from a non-decreasing sorted array that was then rotated (shifted) by some number of positions. The file is self-contained: solution class and unit tests in one module.

### Key Components

**`Solution.check(nums: List[int]) -> bool`** — The core algorithm. It counts "breaks" in the array — positions where an element is strictly greater than the next element (wrapping around circularly). A sorted-then-rotated array has at most one such break: the rotation point where the end of the original sorted array meets the beginning.

The critical line:

```python
breaks = sum(nums[i] > nums[(i + 1) % n] for i in range(n))
```

This treats the array as circular via `% n`, comparing the last element back to the first. The result `breaks <= 1` covers three cases:
- **0 breaks**: already sorted (rotation by 0 positions)
- **1 break**: exactly one rotation point
- **2+ breaks**: not a valid sorted-and-rotated array

### Patterns

**Circular array traversal via modular arithmetic** — Instead of special-casing the wrap-around comparison (`nums[-1]` vs `nums[0]`), the code uses `(i + 1) % n` uniformly across all `n` comparisons. This is a standard idiom for circular problems and eliminates edge-case branching.

**Generator expression with `sum()`** — The boolean generator `nums[i] > nums[(i + 1) % n]` is summed directly, exploiting Python's `True == 1` / `False == 0` coercion. This is a compact counting pattern common across this solution set.

### Dependencies

**Imports**: `typing.List` (type annotation), `unittest` (test framework). No project-internal dependencies.

**Imported by**: The `test_solution.py` in this same directory, plus the "Imported By" list in the prompt is misleading — those are other problems' test files that likely share a common test harness pattern, not actual importers of *this* solution's code.

### Flow

1. Compute `n = len(nums)`.
2. Iterate `i` from `0` to `n-1`, comparing each `nums[i]` to `nums[(i+1) % n]`.
3. Count how many pairs are strictly decreasing (a "break").
4. Return `True` if at most one break exists.

The entire computation is O(n) time, O(1) space.

### Invariants

- The algorithm makes exactly `n` comparisons — one for every adjacent pair in the circular view. This means the last-to-first wrap-around is always checked, which is essential: `[2, 1]` has one break (index 0→1) but the wrap `1→2` is fine, so it passes. `[3, 1, 2, 1]` has breaks at 0→1 and 2→3, so it fails.
- Duplicate values are handled correctly because the comparison is strict (`>`). `[2, 2, 1, 2]` has one break (index 1→2), and the wrap `2→2` is not a break.

### Error Handling

None — the function assumes valid input per the LeetCode contract (non-empty list of integers). No bounds checking or empty-list guard. The `% n` would raise `ZeroDivisionError` on an empty list, but that's outside the problem's constraints.

## Topics to Explore

- [file] `check-if-array-is-sorted-and-rotated/test_solution.py` — See if tests cover additional edge cases beyond the inline ones
- [function] `most-visited-sector-in-a-circular-track/solution.py:Solution` — Another circular-array problem that likely uses modular arithmetic
- [general] `circular-array-modular-idiom` — How `(i + 1) % n` is used across this solution set for wrap-around problems
- [file] `rotate-string/solution.py` — Related rotation problem that may use string concatenation instead of counting breaks

## Beliefs

- `sorted-rotated-at-most-one-break` — A non-decreasing array rotated by any number of positions has at most 1 index where `nums[i] > nums[(i+1) % n]`
- `circular-comparison-count-equals-n` — The algorithm compares exactly `n` adjacent pairs (including the last-to-first wrap), not `n-1`
- `strict-greater-handles-duplicates` — Using `>` rather than `>=` ensures duplicate-heavy arrays like `[2, 2, 2]` correctly return `True`
- `empty-input-not-guarded` — Passing an empty list would raise `ZeroDivisionError` from the `% n` operation; the solution relies on the LeetCode constraint `1 <= nums.length`

