# File: special-positions-in-a-binary-matrix/solution.py

**Date:** 2026-06-06
**Time:** 19:14

## Purpose

This file solves [LeetCode 1582: Special Positions in a Binary Matrix](https://leetcode.com/problems/special-positions-in-a-binary-matrix/). A position `(i, j)` is "special" if `mat[i][j] == 1` and it's the **only** 1 in its entire row and entire column. The file returns the count of such positions.

## Key Components

### `Solution.numSpecial(mat) -> int`

Takes an m×n binary matrix and returns the number of special positions. The method works in three steps:

1. **Precompute row sums** — `row_sums[i]` = total 1s in row `i`
2. **Precompute column sums** — `col_sums[j]` = total 1s in column `j`
3. **Count specials** — a cell qualifies iff `mat[i][j] == 1` AND both its row sum and column sum equal exactly 1

## Patterns

**Precomputation to avoid redundant work.** Without `row_sums`/`col_sums`, you'd scan the full row and column for every cell — O(m·n·(m+n)). With precomputed sums, the final check is O(1) per cell, giving O(m·n) total.

**Generator expression for the final count.** The `sum(1 for ...)` pattern avoids building an intermediate list — it streams the count.

## Dependencies

**Imports:** None beyond the built-in `list` type hint.

**Imported by:** `special-positions-in-a-binary-matrix/test_solution.py` (the "Imported By" list in the prompt is auto-generated from the full repo's test runner and reflects all test files, not actual imports of this module).

## Flow

```
mat → compute row_sums (list comp)
    → compute col_sums (list comp, column-major traversal)
    → iterate all (i, j), filter by three conditions, count matches
```

The column sum computation at line 14 is worth noting: `sum(mat[i][j] for i in range(m))` iterates down each column, which is a column-major access pattern across a row-major structure. For large matrices this is cache-unfriendly, but for LeetCode constraints (≤100×100) it's irrelevant.

## Invariants

- `row_sums[i] == 1` guarantees `mat[i][j]` is the sole 1 in row `i`
- `col_sums[j] == 1` guarantees `mat[i][j]` is the sole 1 in column `j`
- Combined with `mat[i][j] == 1`, these three conditions are necessary and sufficient for "special"

The `mat[i][j] == 1` check is technically redundant given `row_sums[i] == 1` (if the row sum is 1 and we're iterating all cells, we'd still need to confirm *this* cell is the 1), but it short-circuits the row/col sum lookups for the vast majority of cells (most are 0).

## Error Handling

None. The method assumes a well-formed non-empty binary matrix per LeetCode's constraints. Passing an empty matrix would raise `IndexError` at `len(mat[0])`.

## Topics to Explore

- [file] `special-positions-in-a-binary-matrix/test_solution.py` — See the edge cases tested (all-zero matrix, single-element, full row/column of 1s)
- [file] `special-positions-in-a-binary-matrix/plan.md` — Original problem decomposition and approach selection
- [function] `lucky-numbers-in-a-matrix/solution.py:Solution` — Similar row/column precomputation pattern on a matrix problem
- [general] `matrix-row-col-precomputation` — This pattern (precompute per-row and per-column aggregates, then query in O(1)) recurs across matrix problems like image-smoother and projection-area-of-3d-shapes

## Beliefs

- `special-positions-precompute-sums` — The solution precomputes row and column sums in O(m·n) to reduce per-cell special-check from O(m+n) to O(1)
- `special-positions-three-conditions` — A cell is special iff `mat[i][j] == 1`, `row_sums[i] == 1`, and `col_sums[j] == 1`; all three are checked conjunctively
- `special-positions-time-complexity` — Total time complexity is O(m·n) with O(m+n) auxiliary space for the sum arrays
- `special-positions-no-validation` — No input validation is performed; an empty matrix will crash on `len(mat[0])`

