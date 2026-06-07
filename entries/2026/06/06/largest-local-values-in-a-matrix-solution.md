# File: largest-local-values-in-a-matrix/solution.py

**Date:** 2026-06-06
**Time:** 17:14

## Purpose

This file solves [LeetCode 2373: Largest Local Values in a Matrix](https://leetcode.com/problems/largest-local-values-in-a-matrix/). Given an `n x n` grid, it produces an `(n-2) x (n-2)` matrix where each cell contains the maximum value from the corresponding 3x3 submatrix in the original grid. It's a sliding-window maximum over a 2D grid with a fixed 3x3 kernel.

## Key Components

### `largest_matrix(grid) -> list[list[int]]`

The sole exported function. Takes a square grid and returns the matrix of local maximums.

**Contract**: `grid` must be at least 3x3 (the problem guarantees `3 <= n <= 100`). Every element of the output at position `[i][j]` equals the maximum of the 9 cells in `grid[i:i+3][j:j+3]`.

## Patterns

**Nested list comprehension as a double loop.** The outer comprehension iterates row anchors `i in range(n-2)`, the inner iterates column anchors `j in range(n-2)`. The `max()` generator flattens the 3x3 block into a single iterable via a double `for` — `for r in range(i, i+3) for c in range(j, j+3)` — which yields all 9 values.

This is a brute-force O(9 * (n-2)^2) approach — effectively O(n^2). No attempt at precomputation (e.g., sparse table or monotonic deque), which is appropriate given the constraint `n <= 100`.

## Dependencies

**Imports**: None — pure Python, no standard library usage.

**Imported by**: `largest-local-values-in-a-matrix/test_solution.py` directly. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that likely share a common test harness or conftest, not actual consumers of `largest_matrix`.

## Flow

1. Read `n = len(grid)`.
2. For each valid top-left anchor `(i, j)` of a 3x3 window (both range over `0..n-3`):
   - Generate all 9 values `grid[r][c]` where `r in [i, i+3)` and `c in [j, j+3)`.
   - Take `max()` of those 9 values.
3. Collect into a nested list and return.

The entire computation is a single return statement — no intermediate state, no mutation.

## Invariants

- Output dimensions are always `(n-2) x (n-2)` for an `n x n` input.
- Each output cell is the maximum of exactly 9 input cells (the 3x3 block anchored at that position).
- The function never modifies the input grid.

## Error Handling

None. If `grid` is smaller than 3x3, `range(n-2)` produces an empty range and the function silently returns `[]`. No validation, no exceptions — the problem constraints guarantee valid input.

## Topics to Explore

- [file] `largest-local-values-in-a-matrix/test_solution.py` — See the test cases and edge conditions exercised against this solution
- [file] `largest-local-values-in-a-matrix/plan.md` — Planning notes that may explain why brute force was chosen over precomputation
- [file] `image-smoother/solution.py` — Another 2D sliding-window problem; compare the kernel operation (average vs. max)
- [general] `2d-sliding-window-optimization` — Whether monotonic deque or sparse table approaches would matter at n=100 vs. larger constraints

## Beliefs

- `output-dimensions-invariant` — `largest_matrix` always returns a matrix of dimensions `(n-2) x (n-2)` for an `n x n` input grid
- `brute-force-kernel` — Each output cell evaluates `max()` over exactly 9 elements; no precomputation or memoization is used
- `pure-function` — `largest_matrix` has no side effects and does not mutate its input
- `empty-on-undersized-input` — If `grid` has fewer than 3 rows, the function returns `[]` without error

