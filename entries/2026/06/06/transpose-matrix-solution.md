# File: transpose-matrix/solution.py

**Date:** 2026-06-06
**Time:** 19:31

## `transpose-matrix/solution.py`

### Purpose

This file solves [LeetCode 867 — Transpose Matrix](https://leetcode.com/problems/transpose-matrix/). It owns the single responsibility of flipping a matrix over its main diagonal: rows become columns, columns become rows. Given an `m x n` input, it produces an `n x m` output where `result[j][i] == matrix[i][j]`.

### Key Components

**`Solution.transpose(self, matrix: List[List[int]]) -> List[List[int]]`** — The sole public method. It takes a 2D list of integers and returns a new 2D list representing the transpose.

- Extracts dimensions `m` (rows) and `n` (columns) from the input.
- Builds the result via a nested list comprehension: the outer loop iterates over columns (`j in range(n)`), the inner loop over rows (`i in range(m)`), yielding `matrix[i][j]` at each position.

### Patterns

**Single list-comprehension solution** — The entire transformation is expressed as one nested comprehension with no intermediate state. This is idiomatic Python for matrix operations where the mapping from input to output indices is a simple permutation.

**Loop order encodes the transpose** — The key insight is that the outer loop is `j` (column index of the input) and the inner loop is `i` (row index of the input). This naturally produces `n` rows of `m` elements each, which is exactly the transposed shape. Swapping which index is outer vs. inner is what makes this a transpose rather than a copy.

### Dependencies

**Imports:** `typing.List` — used only for type annotations.

**Imported by:** The `test_solution.py` in this same directory. The large "Imported By" list in the prompt is an artifact of the test harness structure — those are unrelated test files, not actual consumers of this module.

### Flow

1. `m, n = len(matrix), len(matrix[0])` — read dimensions. O(1).
2. The comprehension iterates `n * m` times, performing one index lookup per iteration. Total work: O(m * n) time, O(m * n) space for the new matrix.
3. Returns the new matrix. The original is not mutated.

### Invariants

- **Input must be non-empty**: `len(matrix[0])` will raise `IndexError` on an empty matrix. LeetCode's constraints guarantee `m >= 1` and `n >= 1`, so this is safe within the problem's domain.
- **Input must be rectangular**: the code reads `n` from row 0 and assumes all rows have the same length. Jagged input would silently produce wrong results (or `IndexError`) rather than being detected.
- **Output dimensions are swapped**: the result always has exactly `n` rows and `m` columns, which is the defining property of a transpose.

### Error Handling

None. The function trusts its input conforms to the LeetCode contract. No validation, no try/except. This is appropriate for a competitive-programming solution operating within guaranteed constraints.

---

## Topics to Explore

- [file] `transpose-matrix/test_solution.py` — See what edge cases the tests cover (single row, single column, square vs rectangular)
- [file] `reshape-the-matrix/solution.py` — Another matrix shape-transformation problem; compare how dimensions are remapped
- [file] `flipping-an-image/solution.py` — A related matrix manipulation (horizontal flip + invert); contrasts in-place mutation vs new-matrix approaches
- [general] `numpy-transpose-comparison` — How `numpy.ndarray.T` achieves the same result via a stride view (zero-copy) versus this O(mn) copy
- [file] `determine-whether-matrix-can-be-obtained-by-rotation/solution.py` — Matrix rotation uses transpose + reverse; shows transpose as a building block

## Beliefs

- `transpose-output-shape` — `transpose` always returns a matrix with dimensions `n x m` when given an `m x n` input, never in-place
- `transpose-index-identity` — For every valid `(i, j)`, the output satisfies `result[j][i] == matrix[i][j]`
- `transpose-no-mutation` — The input matrix is never modified; a fresh list-of-lists is constructed and returned
- `transpose-empty-unsafe` — Calling `transpose([])` raises `IndexError` because the code unconditionally accesses `matrix[0]`

