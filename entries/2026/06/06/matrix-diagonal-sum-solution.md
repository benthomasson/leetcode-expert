# File: matrix-diagonal-sum/solution.py

**Date:** 2026-06-06
**Time:** 17:32

## `matrix-diagonal-sum/solution.py`

### Purpose

This file solves [LeetCode 1572 — Matrix Diagonal Sum](https://leetcode.com/problems/matrix-diagonal-sum/). It computes the sum of both diagonals of an `n x n` square matrix, ensuring the center element (when `n` is odd) is counted only once.

### Key Components

**`Solution.diagonalSum(mat: List[List[int]]) -> int`** — The sole method. Takes a square matrix and returns the sum of all elements on the primary diagonal (top-left to bottom-right) and the secondary diagonal (top-right to bottom-left).

### Flow

1. **Single-pass accumulation**: Iterates `i` from `0` to `n-1`. At each step, adds two elements:
   - `mat[i][i]` — the primary diagonal element at row `i`
   - `mat[i][n - 1 - i]` — the secondary diagonal element at row `i`

2. **Center correction**: When `n` is odd, both diagonals share the center element at `(n//2, n//2)`. The loop double-counts it, so it's subtracted once after the loop.

This is an O(n) time, O(1) space solution — it touches each diagonal element exactly once (with one subtraction to fix the overlap).

### Patterns

- **Overcounting then correcting** — rather than branching inside the loop to check `if i != n - 1 - i`, the code adds both unconditionally and fixes the single overlap case afterward. This eliminates a branch per iteration at the cost of one conditional subtraction. Clean trade for readability and performance.

### Dependencies

- **Imports**: `typing.List` (type annotation only).
- **Imported by**: `matrix-diagonal-sum/test_solution.py` and hundreds of other test files that share a common test harness importing `Solution` generically.

### Invariants

- `mat` must be square (`len(mat) == len(mat[0])`). The code doesn't validate this — it relies on LeetCode's constraint guarantees.
- `n >= 1` is assumed. For `n=1`, the loop adds `mat[0][0]` twice, then the odd-length correction subtracts it once, producing the correct single-element answer.

### Error Handling

None. The function trusts its input matches the problem constraints. An empty matrix (`n=0`) would return 0 without error, which is arguably correct.

## Topics to Explore

- [file] `matrix-diagonal-sum/test_solution.py` — Verify which edge cases are covered (n=1, even vs odd dimensions)
- [file] `matrix-diagonal-sum/review.md` — See the code review notes for this solution
- [general] `diagonal-traversal-patterns` — Compare with problems like Diagonal Traverse (LC 498) or Toeplitz Matrix for related matrix-walking strategies
- [function] `check-if-matrix-is-x-matrix/solution.py:Solution.checkXMatrix` — Another problem that operates on both diagonals of a square matrix, likely uses a similar indexing scheme

## Beliefs

- `diagonal-sum-overcounting-correction` — The center element is double-counted by the loop when n is odd, and the post-loop subtraction is the sole mechanism that corrects this.
- `diagonal-sum-linear-time` — The solution runs in O(n) time with a single pass over row indices, not O(n^2) over the full matrix.
- `diagonal-sum-no-input-validation` — The function assumes `mat` is a non-empty square matrix and performs no shape or type validation.
- `diagonal-sum-n1-correctness` — For a 1x1 matrix, the loop adds the element twice and the odd-correction subtracts it once, yielding the correct result.

