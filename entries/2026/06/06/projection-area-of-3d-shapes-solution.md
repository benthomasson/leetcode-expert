# File: projection-area-of-3d-shapes/solution.py

**Date:** 2026-06-06
**Time:** 18:36

## Projection Area of 3D Shapes — `solution.py`

### Purpose

This solves [LeetCode 883: Projection Area of 3D Shapes](https://leetcode.com/problems/projection-area-of-3d-shapes/). Given an `n x n` grid where each cell value represents a stack of unit cubes, compute the total area when projecting the 3D shape onto three orthogonal planes (top/xy, front/xz, side/yz).

### Key Components

**`Solution.projectionArea(grid)`** — Single-pass O(n²) solution that computes all three projections simultaneously:

- **Top (xy) projection**: Count of cells where `grid[i][j] > 0`. Each non-empty stack casts exactly one unit square onto the floor.
- **Front (xz) projection**: Sum of the maximum height in each row. Looking from the front, each row's silhouette is determined by its tallest column.
- **Side (yz) projection**: Sum of the maximum height in each column. Looking from the side, each column's silhouette is determined by its tallest row.

The `grid[j][i]` index swap on line 23 is the key trick — it computes column maximums alongside row maximums in a single nested loop, avoiding a second pass.

**`carFleet = projectionArea`** — An alias, likely an artifact of the automated solution generation pipeline. This makes `Solution.carFleet` callable as an alias, which is irrelevant to the problem but harmless.

### Patterns

- **Single-pass multi-accumulation**: Rather than three separate traversals (one per projection), the code fuses all three computations into one double loop. The `grid[j][i]` transpose trick lets column max and row max be computed in the same iteration.
- **No auxiliary data structures**: Everything is computed with scalar accumulators (`top`, `front`, `side`, `row_max`, `col_max`). No extra arrays or dicts needed.

### Dependencies

**Imports**: Only `typing.List` for the type annotation.

**Imported by**: The `projection-area-of-3d-shapes/test_solution.py` file imports `Solution` from this module. The massive "Imported By" list in the prompt appears to be a cross-reference artifact — those test files belong to unrelated problems and don't actually import this specific solution.

### Flow

1. Get grid dimension `n`.
2. Outer loop over `i in range(n)` — iterates rows (and, via transpose, columns).
3. Inner loop over `j in range(n)`:
   - Increment `top` if `grid[i][j] > 0`.
   - Track `row_max` as `max(grid[i][j])` across columns.
   - Track `col_max` as `max(grid[j][i])` across rows — note the swapped indices.
4. After each inner loop, add `row_max` to `front` and `col_max` to `side`.
5. Return `top + front + side`.

### Invariants

- The grid is assumed to be square (`n x n`). The code uses `len(grid)` for both dimensions.
- Cell values are non-negative integers (heights). The `> 0` check for the top projection relies on this.
- The grid is non-empty (no guard for `n == 0`, consistent with LeetCode constraints: `1 <= n <= 50`).

### Error Handling

None. This follows the standard LeetCode convention where inputs are guaranteed valid by the problem constraints.

## Topics to Explore

- [file] `surface-area-of-3d-shapes/solution.py` — The companion problem (LeetCode 892) that computes surface area from the same grid representation, using a different counting strategy
- [file] `projection-area-of-3d-shapes/test_solution.py` — Test cases that verify edge cases like single-cell grids and grids with zeros
- [general] `grid-transpose-in-single-pass` — The `grid[j][i]` technique for computing row and column aggregates simultaneously without allocating a transposed copy
- [file] `projection-area-of-3d-shapes/plan.md` — The planning document showing how the approach was derived

## Beliefs

- `top-projection-counts-nonzero-cells` — The xy (top-down) projection area equals the count of cells with `grid[i][j] > 0`, not the sum of values
- `single-loop-computes-row-and-column-max` — The `grid[j][i]` index swap lets column maximums be computed in the same loop as row maximums, avoiding a second O(n²) pass
- `carfleet-alias-is-dead-code` — `carFleet = projectionArea` is a stale alias unrelated to the problem; it's never called by the test suite for this problem
- `assumes-square-grid` — The solution uses a single `n = len(grid)` for both dimensions, relying on the LeetCode constraint that the grid is always n x n

