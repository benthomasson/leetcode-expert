# File: image-smoother/solution.py

**Date:** 2026-06-06
**Time:** 17:02

## `image-smoother/solution.py`

### Purpose

This file solves [LeetCode 661 — Image Smoother](https://leetcode.com/problems/image-smoother/). It applies a 3×3 box blur filter to a grayscale image matrix: each cell is replaced by the floor of the average of itself and its valid neighbors. The file is self-contained — solution and tests in one module.

### Key Components

**`Solution.imageSmoother(img)`** — The core algorithm. Takes an `m × n` matrix of integers (0–255) and returns a new matrix of the same dimensions where each cell holds `floor(sum of neighbors / count of neighbors)`. "Neighbors" means the cell itself plus all adjacent cells within a 3×3 window, clamped to matrix bounds.

**`TestImageSmoother`** — Seven test cases covering the LeetCode examples, degenerate shapes (1×1, single row, single column), and uniform matrices (all-zero, all-255).

### Patterns

**Brute-force convolution with boundary clamping.** Rather than padding the matrix or pre-checking edge/corner cases, the inner loop uses `max(0, i-1)` and `min(m, i+2)` to define the window bounds. This idiom eliminates branch logic for borders — the window naturally shrinks from 3×3 to 2×3, 2×2, etc. at edges.

**Out-of-place computation.** A fresh `result` matrix is allocated up front, so reads from `img` are never corrupted by writes. This avoids the complexity of in-place approaches that encode old and new values in a single cell (a common LeetCode trick using bit packing).

**Inline tests.** The `unittest` suite lives in the same file with `if __name__ == "__main__": unittest.main()`, matching the repo-wide convention. A separate `test_solution.py` also exists for each problem directory.

### Dependencies

**Imports:** `typing.List` (type annotation) and `unittest` (test framework). No external packages.

**Imported by:** The "Imported By" list in the prompt is misleading — it shows hundreds of unrelated test files. These are likely artifacts of a static analysis tool matching on `from solution import Solution` across the entire repo, not actual consumers of *this* solution. The real dependent is `image-smoother/test_solution.py`.

### Flow

1. Read dimensions `m`, `n` from the input matrix.
2. Allocate a zeroed `m × n` result matrix.
3. For each cell `(i, j)`:
   - Compute the clamped row range `[max(0, i-1), min(m, i+2))` and column range `[max(0, j-1), min(n, j+2))`.
   - Sum all values in that window and count how many cells it contains.
   - Store `total // count` (integer floor division) in `result[i][j]`.
4. Return the result matrix.

The time complexity is O(m·n) — the inner 3×3 window is bounded at 9 iterations regardless of matrix size. Space is O(m·n) for the output.

### Invariants

- **Window size is always 1–9 cells**, so `count` is never zero — floor division is safe.
- **Input is never mutated** — reads always see original values because output goes to a separate matrix.
- **Floor semantics** — Python's `//` operator on non-negative integers performs floor division, which matches the problem's requirement. This holds because pixel values are 0–255 and sums of up to 9 such values stay non-negative.

### Error Handling

None. The function trusts its caller to provide a valid non-empty matrix of integers. This is standard for LeetCode solutions where input constraints are guaranteed by the judge. Passing an empty matrix would raise an `IndexError` on `len(img[0])`.

## Topics to Explore

- [file] `image-smoother/test_solution.py` — The external test file; likely mirrors or extends the inline tests
- [file] `image-smoother/plan.md` — Documents the approach considered before implementation
- [file] `image-smoother/review.md` — Post-implementation review notes on this solution
- [general] `in-place-image-smoothing` — The bit-packing variant that uses O(1) extra space by encoding old/new values in the same cell (common LeetCode follow-up)
- [function] `largest-local-values-in-a-matrix/solution.py:Solution.largestLocal` — Another 3×3 sliding-window matrix problem in this repo; compare the boundary-handling approach

## Beliefs

- `image-smoother-out-of-place` — `imageSmoother` allocates a separate result matrix and never writes to the input, so reads always reflect original pixel values
- `image-smoother-floor-division-safe` — `count` is always ≥1 because the window always includes cell `(i, j)` itself, so the `total // count` division never raises `ZeroDivisionError`
- `image-smoother-constant-work-per-cell` — The inner double loop iterates at most 9 times per cell, making the overall complexity O(m·n) not O(m·n·k²)
- `image-smoother-boundary-clamping` — Edge and corner cells are handled implicitly via `max`/`min` bounds rather than explicit conditional branches

