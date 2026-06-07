# File: flood-fill/solution.py

**Date:** 2026-06-06
**Time:** 16:53

## `flood-fill/solution.py`

### Purpose

This file implements LeetCode problem 733 — Flood Fill. It owns the responsibility of recoloring a contiguous region of same-colored pixels in a 2D grid, starting from a given seed coordinate. This is the classic "paint bucket" operation.

### Key Components

**`Solution.floodFill(image, sr, sc, color)`** — The entry point. Takes a 2D grid, a starting pixel `(sr, sc)`, and a target `color`. Returns the mutated grid after filling all pixels connected to `(sr, sc)` that share the original color.

**`dfs(r, c)`** — A nested recursive helper that performs the actual traversal. It colors the current pixel and recurses into all four cardinal neighbors. It's a closure over `image`, `m`, `n`, `original`, and `color` from the enclosing scope.

### Patterns

**Recursive DFS flood fill** — The standard graph traversal approach for connected-component problems on grids. Instead of maintaining an explicit `visited` set, the algorithm uses the color mutation itself as the visited marker: once `image[r][c]` is set to `color`, it no longer equals `original`, so the bounds check `image[r][c] != original` prevents revisiting.

**In-place mutation** — The grid is modified directly rather than producing a copy. The return value is the same `image` reference that was passed in — this follows LeetCode's convention where the caller already holds the reference.

**Early exit guard** — Line `if original == color: return image` short-circuits the entire operation when the fill would be a no-op. Without this, the DFS would never terminate because coloring a pixel wouldn't distinguish it from unvisited neighbors.

### Dependencies

**Imports:** Only `typing.List` for type annotations — no algorithmic dependencies.

**Imported by:** `flood-fill/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the repo's shared test infrastructure, not actual usage of the flood-fill logic.

### Flow

1. Capture `original = image[sr][sc]`.
2. If `original == color`, return immediately (no-op guard).
3. Cache grid dimensions `m, n`.
4. Call `dfs(sr, sc)`, which:
   - Returns immediately if `(r, c)` is out of bounds or doesn't match `original`.
   - Sets `image[r][c] = color`.
   - Recurses into down, up, right, left neighbors (in that order).
5. Return the mutated `image`.

The recursion forms a depth-first spanning tree over the connected component. The call order (down/up/right/left) doesn't affect correctness, only traversal order.

### Invariants

- **Termination guarantee**: Every recursive call either returns immediately (out of bounds or wrong color) or colors a pixel before recursing. Since coloring makes the pixel fail the `!= original` check, each cell is visited at most once. Total calls are bounded by `O(m * n)`.
- **No-op safety**: When `original == color`, the function returns the grid untouched. This is load-bearing — removing it causes infinite recursion.
- **Connectivity definition**: Two pixels are "connected" if they share an edge (4-directional). Diagonal neighbors are not considered.

### Error Handling

None. The function assumes valid inputs per LeetCode constraints: `sr` and `sc` are within bounds, and `image` is non-empty. An out-of-range `sr`/`sc` would raise an `IndexError` at `image[sr][sc]` on line 1 of the method body.

## Topics to Explore

- [file] `flood-fill/test_solution.py` — Test cases reveal edge cases the solution handles (single-pixel grids, already-colored starts, full-grid fills)
- [file] `island-perimeter/solution.py` — Another grid DFS problem; compare how the traversal pattern differs when counting vs. mutating
- [file] `find-if-path-exists-in-graph/solution.py` — Graph reachability using a different representation (adjacency list vs. implicit grid)
- [general] `bfs-vs-dfs-grid-traversal` — When BFS (queue-based) is preferable to DFS for flood-fill (e.g., avoiding stack overflow on large grids)
- [file] `flood-fill/plan.md` — Design rationale and alternative approaches considered before implementation

## Beliefs

- `flood-fill-terminates-via-color-guard` — The `original == color` early return on line 14 is necessary to prevent infinite recursion; without it, the DFS visited-check (`image[r][c] != original`) would never trigger when fill color equals source color.
- `flood-fill-in-place-mutation` — `floodFill` mutates the input `image` in place and returns the same reference, not a copy.
- `flood-fill-four-directional` — Connectivity is 4-directional (up/down/left/right); diagonal pixels are never considered neighbors.
- `flood-fill-linear-time` — Each pixel is visited at most once, giving O(m*n) time and O(m*n) stack depth in the worst case (e.g., a spiral-shaped single-color region).

