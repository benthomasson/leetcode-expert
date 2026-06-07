# File: determine-whether-matrix-can-be-obtained-by-rotation/solution.py

**Date:** 2026-06-06
**Time:** 16:21

## `determine-whether-matrix-can-be-obtained-by-rotation/solution.py`

### Purpose

This file solves [LeetCode 1886: Determine Whether Matrix Can Be Obtained By Rotation](https://leetcode.com/problems/determine-whether-matrix-can-be-obtained-by-rotation/). It contains both the solution and its test suite in a single module — the standard layout for this repo. The file's sole responsibility is determining whether an n×n matrix can become a target matrix through 0, 90, 180, or 270-degree clockwise rotations.

### Key Components

**`Solution.findRotation(mat, target) -> bool`** — The only public method. Takes two square matrices and returns whether any rotation of `mat` equals `target`. The method is destructive to its local binding of `mat` (reassigns it on each rotation) but does not mutate the caller's list, since each rotation creates a new nested list via the comprehension.

### Patterns

**Rotation-by-enumeration**: Rather than computing a rotation formula and checking all four analytically, the code iterates a loop 4 times, comparing then rotating. This is the idiomatic brute-force approach for small fixed rotation counts.

**In-place rotation formula**: The expression `mat[n - 1 - j][i]` is the standard 90-degree clockwise rotation of an n×n matrix. For a point at row `i`, column `j` in the rotated matrix, the source is row `n-1-j`, column `i` in the original. The outer list comprehension iterates `i` (rows of the result), the inner iterates `j` (columns of the result).

**Early return**: If any rotation matches, it returns `True` immediately without computing remaining rotations. The `False` at the end is only reached after all four rotations (0°, 90°, 180°, 270°) fail to match.

### Dependencies

**Imports**: `unittest` (stdlib) for the test harness, `List` from `typing` for type annotations.

**Imported by**: The `test_solution.py` in this same directory, plus the "Imported By" list in the prompt appears to be auto-generated cross-references from the test runner infrastructure — those are unrelated test files, likely an artifact of the repo's shared test harness (`run_tests.py`), not actual imports of this module.

### Flow

1. Capture `n = len(mat)` — the matrix dimension.
2. Loop 4 times (covering 0°, 90°, 180°, 270°):
   - Compare `mat == target` using Python's structural equality on nested lists.
   - If equal, return `True`.
   - Otherwise, rotate `mat` 90° clockwise by building a new `n×n` list where each element at `(i, j)` is sourced from `(n-1-j, i)`.
3. After all 4 checks fail, return `False`.

The rotation is applied *after* the equality check, so the first iteration checks the unrotated matrix (0°), and the last iteration's rotation result is never checked — which is correct, because a 360° rotation equals the original, already tested in iteration 0.

### Invariants

- **Square matrix**: The code assumes `mat` and `target` are both n×n. Non-square inputs would produce incorrect results or index errors.
- **Same dimensions**: `mat` and `target` must be the same size. The `==` comparison would return `False` for mismatched sizes, but the rotation logic wouldn't be meaningful.
- **Exactly 4 rotations checked**: The loop runs 4 times, covering the full rotation group Z₄. This is complete — no rotation can produce a result not covered by these four.

### Error Handling

None. The function trusts its inputs conform to the LeetCode contract (binary square matrices of equal size). No validation, no exceptions raised. Python's list equality handles the comparison, and the list comprehension handles the rotation — both would raise `IndexError` on malformed input, but that's not guarded against.

---

## Topics to Explore

- [general] `90-degree-rotation-formula` — Why `mat[n-1-j][i]` is the clockwise rotation, and how it relates to transpose-then-reverse
- [file] `check-if-array-is-sorted-and-rotated/solution.py` — Another rotation-based problem; compare the enumeration strategy
- [file] `flipping-an-image/solution.py` — Related matrix transformation problem (flip + invert), different approach
- [function] `transpose-matrix/solution.py:Solution.transpose` — The transpose operation is one half of a 90° rotation; see how it's isolated here
- [general] `matrix-rotation-group` — The algebraic structure (cyclic group of order 4) that makes exactly 4 checks sufficient

## Beliefs

- `rotation-produces-new-matrix` — Each 90° rotation creates a new nested list; the caller's original `mat` is never mutated
- `four-rotations-are-exhaustive` — Checking 0°, 90°, 180°, 270° covers all possible multiples of 90°, since 360° ≡ 0°
- `zero-degree-checked-first` — The equality check happens before the rotation, so the identity (no rotation needed) is the first case tested
- `rotation-formula-is-clockwise` — `mat[n-1-j][i]` maps source position to a 90° clockwise rotation, not counterclockwise

