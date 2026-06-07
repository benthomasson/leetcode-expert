# File: monotonic-array/solution.py

**Date:** 2026-06-06
**Time:** 18:06

## `monotonic-array/solution.py`

### Purpose

This file solves [LeetCode 896 — Monotonic Array](https://leetcode.com/problems/monotonic-array/). It determines whether a given integer array is monotonic, meaning the sequence is entirely non-decreasing or entirely non-increasing. This is the sole module for this problem in the repo, following the project's one-solution-per-directory convention.

### Key Components

**`Solution.isMonotonic(self, nums: List[int]) -> bool`** — The single method. It takes a list of integers and returns `True` if the array is monotonically non-decreasing, monotonically non-increasing, or both (i.e., all elements equal).

The method uses two boolean flags:
- `increasing` — stays `True` as long as no pair `nums[i] > nums[i+1]` is found (non-decreasing property holds).
- `decreasing` — stays `True` as long as no pair `nums[i] < nums[i+1]` is found (non-increasing property holds).

The final return is `increasing or decreasing`. If either flag survived the full scan, the array is monotonic.

### Patterns

**Dual-flag single-pass scan.** Rather than making two passes (one checking non-decreasing, one checking non-increasing) or sorting/comparing, this tracks both properties simultaneously in O(n) time and O(1) space. Each adjacent pair can only falsify one of the two flags, so the flags are independently flipped. This is the canonical approach for this problem.

**LeetCode `Solution` class convention.** The method lives on a `Solution` class with no `__init__`, matching the LeetCode submission interface that the test harness instantiates.

### Dependencies

**Imports:** `typing.List` — used only for the type annotation on `nums`.

**Imported by:** `monotonic-array/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the repo's shared test infrastructure, not actual imports of this module — each test file imports its own `Solution` from its sibling `solution.py`.

### Flow

1. Initialize `increasing = True`, `decreasing = True`.
2. Iterate `i` from `0` to `len(nums) - 2`.
3. For each adjacent pair `(nums[i], nums[i+1])`:
   - If `nums[i] > nums[i+1]`, the sequence is not non-decreasing → set `increasing = False`.
   - If `nums[i] < nums[i+1]`, the sequence is not non-increasing → set `decreasing = False`.
4. Return `increasing or decreasing`.

For a constant array like `[3, 3, 3]`, neither condition fires, so both flags remain `True` — correctly returns `True`.

### Invariants

- The loop examines every consecutive pair exactly once. No early termination — even if both flags are `False` by index 2, the loop runs to completion. This is a minor inefficiency but keeps the code simple.
- An array of length 0 or 1 skips the loop entirely and returns `True` (vacuously monotonic), which is correct per the problem constraints.

### Error Handling

None. The method assumes valid input per the LeetCode contract (a list of integers with `1 <= len(nums) <= 10^5`). No bounds checking, no exception handling, no edge-case guards beyond the natural behavior of `range(0)` for single-element inputs.

---

## Topics to Explore

- [file] `monotonic-array/test_solution.py` — See what edge cases the tests cover (constant arrays, two-element arrays, strictly vs. non-strictly monotonic)
- [file] `monotonic-array/review.md` — The code review may note the missing early-exit optimization
- [function] `valid-mountain-array/solution.py:isValidMountainArray` — A related problem that also scans for ordering properties but requires a strict increase-then-decrease shape
- [file] `check-if-array-is-sorted-and-rotated/solution.py` — Another monotonicity-adjacent problem: detecting a sorted array that's been cyclically shifted
- [general] `single-pass-dual-flag-pattern` — This pattern of tracking two mutually-exclusive properties in one pass recurs in problems like "is sorted ascending or descending"

## Beliefs

- `monotonic-handles-constant-arrays` — A constant array (all elements equal) returns `True` because neither flag is ever set to `False`
- `monotonic-no-early-exit` — The loop always runs to completion even if both `increasing` and `decreasing` are `False` mid-scan, making worst-case and best-case both O(n)
- `monotonic-vacuous-truth-for-short-arrays` — Arrays of length 0 or 1 return `True` without entering the loop, which is correct per LeetCode constraints
- `monotonic-single-pass-constant-space` — The algorithm uses O(n) time and O(1) extra space with no auxiliary data structures

