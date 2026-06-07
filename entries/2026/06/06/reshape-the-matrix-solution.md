# File: reshape-the-matrix/solution.py

**Date:** 2026-06-06
**Time:** 18:52

## `reshape-the-matrix/solution.py`

### Purpose

This file solves [LeetCode 566 - Reshape the Matrix](https://leetcode.com/problems/reshape-the-matrix/). It owns the single responsibility of converting an m×n matrix into an r×c matrix by reading elements in row-major order, or returning the original matrix unchanged if the reshape is dimensionally impossible.

### Key Components

**`Solution.matrixReshape(mat, r, c)`** — The sole public method. Contract:

- **Input**: `mat` (non-empty 2D list of ints), `r` (target rows), `c` (target columns)
- **Output**: A new r×c matrix if `m*n == r*c`, otherwise the original `mat` reference
- **Purity**: Does not mutate `mat`. Returns a new list-of-lists on success, or the same object on failure.

### Patterns

**Flatten-then-slice**: The solution uses the classic 2D reshape idiom — flatten the matrix into a 1D list, then slice it into rows of width `c`. This is the same conceptual operation as `numpy.reshape` but implemented with pure list comprehensions.

The flatten step (`[val for row in mat for val in row]`) produces a row-major traversal. The rebuild step (`flat[i*c:(i+1)*c]`) partitions it back into chunks of size `c`.

### Dependencies

**Imports**: None beyond builtins. The solution uses only Python list operations.

**Imported by**: `reshape-the-matrix/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those ~400+ test files are unrelated problems that likely share a common test harness or conftest, not actual importers of this module's `Solution` class.

### Flow

1. Extract dimensions `m, n` from the input matrix.
2. Guard: if total element count `m*n != r*c`, return `mat` unchanged — reshape is impossible.
3. Flatten `mat` into a 1D list `flat` via nested list comprehension.
4. Slice `flat` into `r` rows of `c` elements each via list comprehension with index arithmetic.
5. Return the new 2D list.

### Invariants

- **Element conservation**: The reshape is only attempted when `m*n == r*c`, guaranteeing no elements are lost or invented.
- **Row-major ordering**: Elements are read left-to-right, top-to-bottom from the source and written in the same order to the target. This matches the problem's specification.
- **No partial results**: Either a complete r×c matrix is returned or the original matrix is returned untouched. There's no intermediate failure state.

### Error Handling

There is none beyond the dimension check. The code assumes `mat` is non-empty and rectangular (guaranteed by LeetCode constraints). If `mat` were empty or jagged, `len(mat[0])` would raise `IndexError` or produce incorrect results — but that's outside the problem's contract.

---

## Topics to Explore

- [file] `reshape-the-matrix/test_solution.py` — See what edge cases are tested (1×1 matrix, same-shape reshape, impossible reshape)
- [file] `convert-1d-array-into-2d-array/solution.py` — The inverse problem (1D→2D); likely uses similar slicing but must handle the impossibility check differently
- [file] `shift-2d-grid/solution.py` — Another matrix transformation that likely uses flatten-then-rebuild with an offset
- [file] `transpose-matrix/solution.py` — Compare with a reshape that changes element ordering (column-major vs row-major)
- [general] `flatten-slice-reshape-pattern` — This flatten→slice idiom recurs across matrix problems; compare with NumPy's `reshape(-1)` and `reshape(r,c)` for the zero-copy version

---

## Beliefs

- `reshape-returns-original-on-mismatch` — When `m*n != r*c`, `matrixReshape` returns the exact same `mat` object (identity, not a copy)
- `reshape-uses-O(mn)-space` — The flatten step allocates a full copy of all elements, so space complexity is O(m·n) beyond the output
- `reshape-preserves-row-major-order` — Elements appear in the output in the same row-major order as the input, guaranteed by the nested list comprehension iteration order
- `reshape-no-mutation` — The input matrix `mat` is never modified; the result is always a freshly constructed list-of-lists (on the success path)

