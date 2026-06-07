# File: find-the-distance-value-between-two-arrays/solution.py

**Date:** 2026-06-06
**Time:** 16:45

## Purpose

This file solves [LeetCode 1385: Find the Distance Value Between Two Arrays](https://leetcode.com/problems/find-the-distance-value-between-two-arrays/). It counts how many elements in `arr1` have **no** element in `arr2` within absolute distance `d`. It's one of ~400+ solution files in the `leetcode-implementations` repo, each following the same structure: a `Solution` class with a single method matching the LeetCode signature.

## Key Components

### `Solution.findTheDistanceValue`

**Contract**: Given two integer arrays and a distance threshold `d`, return the count of elements `arr1[i]` such that `|arr1[i] - arr2[j]| > d` for **all** `j`.

**Signature**: `(arr1: List[int], arr2: List[int], d: int) -> int`

**Side effect**: Mutates `arr2` in-place via `.sort()`. This is typical for LeetCode solutions but worth noting — the caller's copy of `arr2` is reordered.

## Patterns

**Sort + binary search** instead of brute-force nested loop. The naive O(n*m) approach checks every pair. This solution sorts `arr2` (O(m log m)) then uses `bisect_left` to find the insertion point for each `arr1` element, reducing the inner check to O(log m). Total: O(m log m + n log m).

The binary search narrows the "is anything within distance `d`?" question to checking exactly two candidates: the element at the insertion point (the smallest value >= `val`) and the one just before it (the largest value < `val`). These are the only two elements that could be closest to `val` in a sorted array.

## Dependencies

**Imports**:
- `bisect.bisect_left` — stdlib binary search returning the leftmost insertion index
- `typing.List` — type annotation (could use `list` on Python 3.9+, but LeetCode convention)

**Imported by**: `find-the-distance-value-between-two-arrays/test_solution.py` (the "Imported By" list in the prompt is a red herring — those are all test files that import their *own* `solution.py`, not this one)

## Flow

1. Sort `arr2` in ascending order.
2. For each `val` in `arr1`:
   - `bisect_left(arr2, val)` returns `pos`, the index where `val` would be inserted to keep order.
   - Check `arr2[pos]` (if it exists): this is the smallest element >= `val`. If `|arr2[pos] - val| <= d`, something is too close.
   - Check `arr2[pos-1]` (if `pos > 0`): this is the largest element < `val`. Same distance check.
   - If neither neighbor is within `d`, increment `count`.
3. Return `count`.

## Invariants

- After sorting, `arr2[pos-1] < val <= arr2[pos]` (when both exist). This means `arr2[pos-1]` and `arr2[pos]` are the two tightest bounds on `val`, so checking only these two is sufficient — every other element is farther away.
- The boundary checks (`pos < len(arr2)` and `pos > 0`) prevent index-out-of-range when `val` is beyond the extremes of `arr2`.

## Error Handling

None — the function assumes valid inputs per the LeetCode contract (non-empty arrays, integer values). No validation, no exceptions. If `arr2` is empty, `bisect_left` returns 0, both boundary checks fail, and every element counts — which is correct.

## Topics to Explore

- [file] `find-the-distance-value-between-two-arrays/test_solution.py` — See what edge cases the tests cover (empty arrays, all-within-distance, negative values)
- [function] `find-smallest-letter-greater-than-target/solution.py:Solution.nextGreatestLetter` — Another solution using `bisect_left` on a sorted array, same pattern
- [general] `bisect-vs-two-pointer` — Several solutions in this repo choose between binary search and two-pointer approaches for sorted-array problems; comparing when each wins
- [file] `find-the-distance-value-between-two-arrays/plan.md` — The planning doc may explain why sort+bisect was chosen over brute force or two-pointer

## Beliefs

- `sort-plus-bisect-sufficiency` — Checking only `arr2[pos]` and `arr2[pos-1]` after `bisect_left` is sufficient to determine if any element in sorted `arr2` is within distance `d` of `val`
- `arr2-mutated-in-place` — The method mutates the input `arr2` via `.sort()` rather than using `sorted()`, so the caller's list is reordered as a side effect
- `empty-arr2-correct` — When `arr2` is empty, the function correctly returns `len(arr1)` because both boundary guards fail and no element is marked `too_close`
- `time-complexity-nlogm` — The algorithm runs in O(m log m + n log m) where n = len(arr1) and m = len(arr2), versus O(n*m) for brute force

