# File: surface-area-of-3d-shapes/solution.py

**Date:** 2026-06-06
**Time:** 19:24

## Purpose

This file implements LeetCode 892: **Surface Area of 3D Shapes**. It solves the problem of computing the total exposed surface area of a 3D structure formed by stacking unit cubes on an `n x n` grid, where `grid[i][j]` specifies the height (number of cubes) at position `(i, j)`. The file is self-contained — solution class and test suite in one module.

## Key Components

### `Solution.surfaceArea(grid: List[List[int]]) -> int`

The core algorithm. It computes exposed surface area by:

1. **Adding** the full surface of each column of cubes in isolation: `2 + 4 * v` (2 for top/bottom caps, 4 sides per cube in the column).
2. **Subtracting** hidden faces between adjacent columns. For each pair of neighbors, `2 * min(v, neighbor)` faces are mutually occluded (one face on each side of the contact).

The subtraction only checks the **right** and **down** neighbors (`i+1`, `j+1`), avoiding double-counting — each adjacency is visited exactly once.

### `TestSurfaceArea`

Eight test cases covering the three LeetCode examples, edge cases (single cell with 0, 1, and 5 cubes), an all-zero grid, and a uniform-height grid. The uniform-height test includes a manual verification comment: 9 cells × 6 faces = 54, minus 24 shared faces (12 adjacencies × 2) = 30.

## Patterns

- **Additive-then-subtractive counting**: Start with the maximum possible surface area (all columns isolated), then subtract occluded faces. This avoids explicitly checking all 4 neighbors per cell and prevents double-counting by only looking forward (right and down).
- **Single-pass grid traversal**: O(n²) time, O(1) extra space.
- **Collocated test**: Solution and tests live in the same file, runnable via `python -m unittest` or `__main__`.

## Dependencies

**Imports**: `typing.List` (type annotation), `unittest` (test framework). No project-internal dependencies.

**Imported by**: The `test_solution.py` file in this same directory, plus the "Imported By" list in the prompt is misleading — that list appears to be a cross-repo artifact from test scaffolding that imports a shared base, not direct imports of this specific solution.

## Flow

For a grid like `[[1, 2], [3, 4]]`:

1. Cell `(0,0)`, v=1: add `2 + 4 = 6`. Right neighbor is 2 → subtract `2*min(1,2) = 2`. Down neighbor is 3 → subtract `2*min(1,3) = 2`. Running: 2.
2. Cell `(0,1)`, v=2: add `2 + 8 = 10`. No right neighbor. Down neighbor is 4 → subtract `2*min(2,4) = 4`. Running: 8.
3. Cell `(1,0)`, v=3: add `2 + 12 = 14`. Right neighbor is 4 → subtract `2*min(3,4) = 6`. No down neighbor. Running: 16.
4. Cell `(1,1)`, v=4: add `2 + 16 = 18`. No neighbors to subtract. Final: **34**.

## Invariants

- **`v > 0` guard on the `+2`**: The top and bottom caps are only added when cubes actually exist. Without this, empty cells would contribute a phantom 2 to the area.
- **Forward-only neighbor check**: Each adjacent pair `(i,j)-(i+1,j)` and `(i,j)-(i,j+1)` is processed exactly once, preventing double-subtraction.
- **`min(v, neighbor)` for occlusion**: The shorter column determines how many faces are hidden — the taller column's excess faces remain exposed.

## Error Handling

None. The function assumes a valid `n x n` grid with non-negative integers, consistent with LeetCode's constraints. No bounds checking or input validation.

## Topics to Explore

- [file] `projection-area-of-3d-shapes/solution.py` — A closely related LeetCode problem (883) that computes projection areas of the same grid-of-cubes model, using different counting logic
- [file] `island-perimeter/solution.py` — Uses the same additive-then-subtractive pattern on a 2D grid to count exposed edges
- [general] `neighbor-subtraction-pattern` — The "add full, subtract shared" idiom appears across several grid geometry problems in this repo and is worth recognizing as a reusable template
- [function] `surface-area-of-3d-shapes/solution.py:surfaceArea` — Verify the `2 + 4*v` formula by working through a single tall column (e.g., v=5 → 22 = 2 caps + 20 side faces)
- [file] `surface-area-of-3d-shapes/plan.md` — The planning document may capture alternative approaches considered (e.g., per-face enumeration vs. subtraction)

## Beliefs

- `surface-area-forward-neighbor-no-double-count` — The algorithm only checks right (`j+1`) and down (`i+1`) neighbors, so each adjacent pair is subtracted exactly once
- `surface-area-zero-height-no-caps` — Cells with `grid[i][j] == 0` contribute nothing: the `if v > 0` guard prevents adding 2 phantom cap faces for empty cells
- `surface-area-occlusion-uses-min` — Hidden faces between adjacent columns equal `2 * min(height_a, height_b)`, which correctly models partial occlusion when columns differ in height
- `surface-area-linear-time-constant-space` — The algorithm runs in O(n²) time (single pass over all cells) with O(1) auxiliary space

