# File: valid-mountain-array/solution.py

**Date:** 2026-06-06
**Time:** 19:38

## Purpose

This file solves [LeetCode 941 — Valid Mountain Array](https://leetcode.com/problems/valid-mountain-array/). It determines whether an integer array forms a "mountain": strictly increasing to a single peak, then strictly decreasing. The file owns the core algorithm; its test file (`valid-mountain-array/test_solution.py`) validates it.

## Key Components

**`Solution.validMountainArray(arr: List[int]) -> bool`** — The only method. Given a list of integers, returns `True` if and only if the array is a valid mountain.

A valid mountain requires:
- Length >= 3
- A unique peak index `p` where `0 < p < n-1`
- `arr[0] < arr[1] < ... < arr[p]` (strictly increasing)
- `arr[p] > arr[p+1] > ... > arr[n-1]` (strictly decreasing)

## Patterns

**Two-pointer walk-inward.** Instead of a single linear scan with state tracking, the solution walks pointer `i` up from the left and pointer `j` down from the right, each following its respective slope. If the array is a valid mountain, both pointers converge on the same peak index. This is a clean alternative to the more common single-pass-with-state approach — it avoids explicit state flags for "ascending" vs "descending" phases.

## Dependencies

- **Imports:** `typing.List` — standard type annotation, no runtime behavior.
- **Imported by:** `valid-mountain-array/test_solution.py` directly. The large "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those other test files don't actually import this solution; they share the same `from typing import List` import.

## Flow

1. **Short-circuit:** If `len(arr) < 3`, return `False` immediately — a mountain needs at least three elements.
2. **Left walk:** Starting at `i = 0`, advance `i` rightward while `arr[i] < arr[i+1]`. When the loop exits, `i` sits at the first position where the array stops increasing — the candidate peak from the left.
3. **Right walk:** Starting at `j = n-1`, advance `j` leftward while `arr[j] < arr[j-1]`. When the loop exits, `j` sits at the first position where the array stops decreasing (reading right-to-left) — the candidate peak from the right.
4. **Convergence check:** Return `True` only if `i == j` (both found the same peak) **and** `i != 0` **and** `j != n-1` (the peak isn't at either endpoint, which would mean there's no ascending or descending portion).

## Invariants

- **Strict monotonicity:** Both while-loops use `<`, not `<=`. Plateaus (equal adjacent elements) halt the pointer, causing the convergence check to fail. This correctly rejects arrays like `[1, 2, 2, 1]`.
- **Peak not at boundary:** The `i != 0 and j != n-1` guards reject purely increasing (`[1,2,3]`) or purely decreasing (`[3,2,1]`) arrays, even though the pointers would converge.
- **Single peak:** Because `i` walks left-to-right and `j` walks right-to-left, they can only meet at a single index. Multi-peaked arrays (e.g., `[1,3,2,3,1]`) will have `i` and `j` land on different local maxima, so `i != j` and the check fails.

## Error Handling

None — the method assumes valid input per LeetCode's contract (a list of integers). No exceptions are raised or caught. Invalid inputs like `None` or non-list types would produce an unhandled `TypeError` at the `len()` call.

## Topics to Explore

- [file] `valid-mountain-array/test_solution.py` — See which edge cases are covered (plateaus, length-2, all-ascending, single-element peak)
- [file] `valid-mountain-array/plan.md` — Understand the planning process that led to this two-pointer approach over alternatives
- [file] `monotonic-array/solution.py` — Related problem; compare how monotonicity checking differs when there's no peak requirement
- [function] `valid-mountain-array/solution.py:validMountainArray` — Trace through with `[0,3,2,1]` vs `[3,2,1]` to internalize the boundary guards
- [general] `two-pointer-convergence` — The pattern of walking two pointers inward and checking convergence appears in several other solutions in this repo (e.g., valid palindrome, sorted-array problems)

## Beliefs

- `mountain-requires-min-length-3` — Arrays with fewer than 3 elements are always rejected before any pointer logic runs
- `plateau-rejects-mountain` — Equal adjacent elements halt pointer advancement, causing the convergence check to fail (strict `<` not `<=`)
- `peak-must-be-interior` — The `i != 0 and j != n-1` check ensures purely monotonic arrays are rejected even when both pointers converge
- `two-pointer-single-pass-linear` — The algorithm is O(n) time and O(1) space; each element is visited at most once across both pointer walks

