# File: shift-2d-grid/solution.py

**Date:** 2026-06-06
**Time:** 19:04

## Purpose

This file solves [LeetCode 1260: Shift 2D Grid](https://leetcode.com/problems/shift-2d-grid/). It owns the transformation logic for shifting every element in an `m x n` grid `k` positions to the right, where "right" wraps from the end of a row to the start of the next row, and from the bottom-right corner back to the top-left.

## Key Components

### `Solution.shiftGrid`

**Contract:** Given a 2D grid of integers and a shift count `k`, return a new grid where every element has moved `k` positions forward in row-major order, wrapping around.

**Parameters:**
- `grid`: `List[List[int]]` — guaranteed non-empty `m x n` matrix
- `k`: `int` — non-negative shift count

**Returns:** `List[List[int]]` — the shifted grid (or the original grid object if `k` is a no-op)

## Patterns

**Flatten-rotate-reshape.** This is the canonical idiom for 2D cyclic shifts: linearize the grid into 1D, perform a simple list rotation, then re-partition into rows. It reduces a 2D problem to a 1D one, avoiding messy index arithmetic for row/column wraparound.

**Modular reduction.** `k %= total` normalizes arbitrarily large shift counts to `[0, total)` before doing any work — standard for cyclic operations.

**Early exit.** If the effective shift is zero, the method returns the original grid immediately, skipping the flatten/reshape.

## Dependencies

**Imports:** Only `typing.List` — no external libraries.

**Imported by:** `shift-2d-grid/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are test files across the repo that happen to share a common test harness import, not files that import this solution.

## Flow

1. Extract dimensions `m`, `n` from the grid.
2. Compute `total = m * n`, reduce `k` modulo `total`.
3. If `k == 0`, short-circuit and return the input grid.
4. Flatten the grid to a 1D list in row-major order via list comprehension.
5. Rotate: take the last `k` elements and prepend them before the remaining `total - k` elements. This is Python's idiomatic `flat[-k:] + flat[:-k]` slice rotation.
6. Reshape: partition the rotated 1D list back into `m` rows of `n` elements each.

The slice rotation on line 20 (`flat[-k:] + flat[:-k]`) is a right-rotation: the last `k` elements wrap to the front, which is equivalent to every element moving `k` positions forward with wraparound.

## Invariants

- **`k` is always reduced modulo `total` before use**, so the rotation is never larger than the grid size.
- **The returned grid has identical dimensions** to the input (`m` rows, `n` columns).
- **When `k == 0`, the original grid object is returned** (not a copy). This means mutations to the returned grid alias the input — acceptable for LeetCode's calling convention but worth noting.

## Error Handling

None. The solution assumes valid LeetCode inputs: non-empty grid, non-negative `k`, rectangular rows. No defensive checks for empty grids or ragged rows.

## Topics to Explore

- [file] `shift-2d-grid/test_solution.py` — See what edge cases are covered (k > total, single row/column, k = 0)
- [file] `perform-string-shifts/solution.py` — Similar shift-based problem; compare the flatten-rotate approach
- [file] `convert-1d-array-into-2d-array/solution.py` — The reshape step in isolation (1D to 2D partitioning)
- [general] `cyclic-rotation-patterns` — How other solutions in this repo handle modular wraparound (e.g., `rotate-string`, `most-visited-sector-in-a-circular-track`)
- [function] `reshape-the-matrix/solution.py:matrixReshape` — Another flatten-reshape transformation on 2D grids

## Beliefs

- `shift-grid-flatten-rotate` — The solution flattens the grid to 1D, rotates via slicing, and reshapes back to 2D — O(m*n) time and space regardless of k.
- `shift-grid-k-mod-optimization` — k is reduced modulo (m*n) before any list operations, making runtime independent of the magnitude of k.
- `shift-grid-zero-shift-aliases-input` — When k % total == 0, the method returns the original grid object, not a deep copy.
- `shift-grid-no-in-place-mutation` — The solution allocates new lists for both the flattened array and the result grid; the input grid is never mutated.

