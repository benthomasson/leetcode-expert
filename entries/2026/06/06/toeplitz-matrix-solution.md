# File: toeplitz-matrix/solution.py

**Date:** 2026-06-06
**Time:** 19:30

## `toeplitz-matrix/solution.py`

### Purpose

This file solves [LeetCode 766 — Toeplitz Matrix](https://leetcode.com/problems/toeplitz-matrix/). It determines whether a given matrix is a Toeplitz matrix, meaning every diagonal from top-left to bottom-right contains the same element. It's a single-responsibility module: one class, one method, one problem.

### Key Components

**`Solution.isToeplitzMatrix(matrix) -> bool`** — The only method. Takes an m×n matrix and returns `True` if every element equals the element diagonally above-left of it (`matrix[i][j] == matrix[i-1][j-1]`). Returns `False` on the first violation found.

### Patterns

The solution uses the **pairwise neighbor comparison** idiom rather than explicitly enumerating diagonals. Instead of iterating over each diagonal start point and walking down-right, it checks a local invariant at every interior cell: "does this cell match its diagonal predecessor?" This is equivalent because if every adjacent pair on a diagonal agrees, transitivity guarantees the entire diagonal is uniform.

The iteration starts at row 1 and column 1 (skipping the top row and left column), since those cells have no diagonal predecessor to compare against.

### Dependencies

- **Imports**: `typing.List` — used only for the type annotation.
- **Imported by**: `toeplitz-matrix/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of `List` being re-exported or resolved repo-wide — those test files import `List` from `typing`, not this module.

### Flow

1. Outer loop: rows `i` from 1 to `m-1`.
2. Inner loop: columns `j` from 1 to `n-1`.
3. Compare `matrix[i][j]` with `matrix[i-1][j-1]`.
4. First mismatch → return `False` (short-circuit).
5. All cells pass → return `True`.

Total comparisons: at most `(m-1) * (n-1)`. Time complexity is O(m·n), space is O(1).

### Invariants

- The matrix must have at least 1 row and 1 column (guaranteed by problem constraints: 1 ≤ m, n ≤ 20).
- A 1×n or m×1 matrix is trivially Toeplitz — the loops don't execute and `True` is returned, which is correct since every diagonal has exactly one element.

### Error Handling

None. The method trusts the caller to provide a well-formed rectangular matrix per the LeetCode contract. No bounds checking, no empty-matrix guard. This is appropriate — the problem guarantees valid input.

---

## Topics to Explore

- [file] `toeplitz-matrix/test_solution.py` — See what edge cases (single row/column, 1×1, all-same) are covered
- [file] `toeplitz-matrix/review.md` — Any recorded observations about alternative approaches or complexity analysis
- [general] `diagonal-enumeration-vs-neighbor-check` — Compare explicit diagonal iteration (start from row 0 and column 0 edges, walk down-right) against this pairwise approach in terms of code simplicity and constant factors
- [file] `image-smoother/solution.py` — Another matrix-neighbor problem; compare how it handles boundary cells versus skipping them
- [general] `toeplitz-follow-ups` — LeetCode's follow-up asks how to handle a matrix too large to fit in memory (load one row at a time, compare with previous row shifted by one)

## Beliefs

- `toeplitz-single-pass-o1-space` — The solution uses O(1) auxiliary space and a single pass over interior cells; it never allocates additional data structures.
- `toeplitz-short-circuits-on-first-mismatch` — The method returns `False` immediately upon finding the first cell that differs from its diagonal predecessor, without examining remaining cells.
- `toeplitz-trivially-true-for-single-row-or-column` — A matrix with one row or one column always returns `True` because the loop ranges are empty (range(1, 1) for the skipped dimension).
- `toeplitz-neighbor-equivalence` — Checking `matrix[i][j] == matrix[i-1][j-1]` for all interior cells is equivalent to verifying that every top-left-to-bottom-right diagonal contains identical elements, by transitivity of equality.

