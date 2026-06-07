# File: cells-with-odd-values-in-a-matrix/solution.py

**Date:** 2026-06-06
**Time:** 15:33

## Purpose

This file is the solution and test suite for [LeetCode 1252: Cells with Odd Values in a Matrix](https://leetcode.com/problems/cells-with-odd-values-in-a-matrix/). It owns a single responsibility: given an `m x n` matrix initialized to zeros and a list of `[row, col]` index pairs, count how many cells end up with odd values after incrementing every cell in the specified row and every cell in the specified column for each pair.

## Key Components

### `Solution.oddCells(m, n, indices) -> int`

The core algorithm. Rather than simulating the full matrix (O(m*n) per operation), it exploits the fact that each cell's final value is `row_count[r] + col_count[c]` — the number of times its row was hit plus the number of times its column was hit. A cell is odd when exactly one of those two counts is odd (odd + even = odd, even + odd = odd).

This leads to the closed-form return on line 23:

```python
odd_rows * (n - odd_cols) + (m - odd_rows) * odd_cols
```

- `odd_rows * (n - odd_cols)`: cells where the row count is odd and the column count is even.
- `(m - odd_rows) * odd_cols`: cells where the row count is even and the column count is odd.

### `TestOddCells`

Nine test cases covering: LeetCode examples, single-cell matrices, single-row/column, all rows and columns hit, repeated indices, and a stress test (100 identical operations on a 50x50 matrix).

## Patterns

- **Counting instead of simulation**: The solution avoids materializing the matrix entirely. It counts row/column hit frequencies, then uses combinatorics. This is a common LeetCode pattern for matrix problems where per-cell values depend only on aggregate row/column properties.
- **Parity decomposition**: The odd/even split lets the final answer be computed in O(m + n) after a single O(|indices|) pass, rather than O(m * n).
- **Self-contained file**: Solution class + test class in one file, consistent with every other problem in this repo.

## Dependencies

**Imports**: `unittest` (stdlib), `typing.List` (type annotation only — not needed at runtime in modern Python).

**Imported by**: The `test_solution.py` files listed in the prompt don't actually import *this* file — the "Imported By" section appears to be a repo-wide cross-reference artifact. The real consumer is `cells-with-odd-values-in-a-matrix/test_solution.py`.

## Flow

1. Initialize `row_count[0..m-1]` and `col_count[0..n-1]` to zero.
2. For each `[r, c]` in `indices`, increment `row_count[r]` and `col_count[c]`.
3. Count how many row counts are odd (`odd_rows`) and how many column counts are odd (`odd_cols`).
4. Return the number of (row, col) pairs where exactly one of `row_count[row]` and `col_count[col]` is odd.

## Invariants

- A cell `(r, c)` is odd **if and only if** exactly one of `row_count[r]` and `col_count[c]` is odd. This is the XOR parity property of addition.
- The formula double-counts nothing: the two terms in the return expression are disjoint (odd-row/even-col vs even-row/odd-col), and together they cover all odd cells exactly once.

## Error Handling

None. The function trusts its inputs match LeetCode constraints (valid indices within bounds, m/n >= 1). No bounds checking or exception handling — appropriate for a competitive programming context.

## Complexity

- **Time**: O(|indices| + m + n) — one pass to count, one pass to compute parities.
- **Space**: O(m + n) for the two count arrays, versus O(m * n) for a brute-force simulation.

## Topics to Explore

- [file] `cells-with-odd-values-in-a-matrix/plan.md` — How the approach was designed before implementation
- [file] `cells-with-odd-values-in-a-matrix/review.md` — Post-implementation review notes and alternative approaches considered
- [general] `parity-decomposition-pattern` — Other solutions in this repo that exploit parity/counting to avoid simulation (e.g., `flipping-an-image`, `xor-operation-in-an-array`)
- [function] `cells-with-odd-values-in-a-matrix/test_solution.py:TestOddCells` — Whether the external test file adds coverage beyond what's inline here
- [general] `row-col-frequency-counting` — Related matrix problems that decompose cell values into independent row and column contributions

## Beliefs

- `odd-cells-no-matrix-materialization` — `oddCells` never allocates an m-by-n matrix; it uses O(m+n) space via row/column frequency arrays
- `odd-cells-xor-parity-correctness` — A cell (r,c) has an odd value iff exactly one of row_count[r] and col_count[c] is odd, which the return formula computes via inclusion-exclusion
- `odd-cells-linear-time` — The algorithm runs in O(|indices| + m + n) time, independent of the matrix area m*n
- `odd-cells-formula-disjoint-terms` — The two terms `odd_rows * (n - odd_cols)` and `(m - odd_rows) * odd_cols` partition all odd-valued cells with no overlap

