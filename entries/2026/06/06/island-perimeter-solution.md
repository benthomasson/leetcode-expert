# File: island-perimeter/solution.py

**Date:** 2026-06-06
**Time:** 17:08

## Purpose

This file solves [LeetCode 463 — Island Perimeter](https://leetcode.com/problems/island-perimeter/). Given a 2D grid where `1` represents land and `0` represents water, it computes the perimeter of the single island. The problem guarantees exactly one island with no lakes (no water enclosed by land).

## Key Components

**`Solution.islandPerimeter(grid: List[List[int]]) -> int`** — The sole method. Scans every cell in the grid and accumulates the perimeter using an additive-then-subtract approach.

## Patterns

**Neighbor-subtraction counting.** Rather than checking all four neighbors to count exposed edges, this solution uses a well-known optimization:

1. Each land cell starts contributing 4 edges.
2. For each shared edge with an already-visited land neighbor, subtract 2 (one edge from each cell is internal).

Only the **up** and **left** neighbors are checked (lines 17–20), not all four directions. This works because the scan goes top-to-bottom, left-to-right — so by the time we visit cell `(r, c)`, cells `(r-1, c)` and `(r, c-1)` have already been processed. Each adjacency is counted exactly once, and each adjacency eliminates 2 perimeter edges (one from each of the two adjacent cells).

## Dependencies

**Imports:** `typing.List` — used only for the type annotation on `grid`.

**Imported by:** `island-perimeter/test_solution.py` consumes this directly. The massive "Imported By" list in the prompt is an artifact of all test files importing `List` from `typing`, not importing this module.

## Flow

```
for each cell (r, c) in row-major order:
    if land:
        perimeter += 4
        if cell above is land:  perimeter -= 2
        if cell to left is land: perimeter -= 2
return perimeter
```

No recursion, no BFS/DFS, no visited set. A single O(rows × cols) pass.

## Invariants

- The grid is non-empty (`len(grid) > 0`, `len(grid[0]) > 0`) — guaranteed by the problem constraints.
- Boundary checks (`r > 0`, `c > 0`) prevent index-out-of-range; the bottom/right neighbors are never checked because they haven't been visited yet.
- The subtraction of 2 per shared edge is correct only because each adjacency is visited exactly once (up and left, never down and right).

## Error Handling

None. The method trusts its input matches the LeetCode contract — a rectangular grid of 0s and 1s with exactly one island. No validation, no exceptions.

## Topics to Explore

- [file] `island-perimeter/test_solution.py` — See what grid configurations are tested (single cell, L-shapes, full rows, etc.)
- [file] `island-perimeter/plan.md` — Check if alternative approaches (DFS, BFS, 4-neighbor check) were considered
- [file] `flood-fill/solution.py` — Contrast with a grid problem that does require BFS/DFS traversal
- [general] `grid-perimeter-techniques` — Compare the subtract-shared-edges approach vs. counting exposed edges per cell vs. counting edge contributions per row/column
- [file] `surface-area-of-3d-shapes/solution.py` — Extension of the same neighbor-subtraction pattern to 3D

## Beliefs

- `island-perimeter-single-pass` — The algorithm computes the perimeter in a single row-major scan with no auxiliary data structures, running in O(rows × cols) time and O(1) extra space.
- `island-perimeter-subtract-two` — Each shared edge between two land cells removes exactly 2 from the perimeter total (one from each cell), and checking only up/left neighbors guarantees each adjacency is counted once.
- `island-perimeter-no-traversal` — Unlike flood-fill or connected-component problems, this solution does not use DFS, BFS, or a visited set — it relies on the guarantee of a single island.
- `island-perimeter-boundary-guard` — The `r > 0` and `c > 0` guards are the only bounds checks needed because only up and left neighbors are examined.

