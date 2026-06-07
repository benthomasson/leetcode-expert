# File: matrix-cells-in-distance-order/solution.py

**Date:** 2026-06-06
**Time:** 17:31

## Purpose

This file solves [LeetCode 1030 — Matrix Cells in Distance Order](https://leetcode.com/problems/matrix-cells-in-distance-order/). Given an `rows x cols` matrix and a center cell `(rCenter, cCenter)`, it returns every cell coordinate sorted by ascending Manhattan distance from the center.

## Key Components

### `Solution.allCellsDistOrder`

**Contract**: Given matrix dimensions and a center point, returns `list[list[int]]` of all `[row, col]` pairs ordered by Manhattan distance from `(rCenter, cCenter)`. Ties in distance are broken by BFS discovery order (which is stable but not unique — any tie-breaking is valid per the problem spec).

## Patterns

**BFS as implicit sort.** Rather than generating all cells and sorting by distance (O(n log n)), this uses breadth-first search from the center cell. BFS naturally visits nodes in order of hop count, and since each hop moves exactly one step in a cardinal direction, hop count equals Manhattan distance. This turns a sorting problem into a graph traversal.

The pattern is standard grid BFS:
- `deque` for O(1) popleft
- `visited` matrix to avoid revisiting cells
- 4-directional expansion `((1,0), (-1,0), (0,1), (0,-1))`

## Dependencies

**Imports**: `collections.deque` — used for the BFS queue.

**Imported by**: The `test_solution.py` in the same directory. The long "Imported By" list in the prompt is an artifact of the test harness structure — those are unrelated test files, not actual consumers of this module.

## Flow

1. Initialize an empty `result` list, a `visited` grid (all `False`), and seed the BFS queue with `(rCenter, cCenter)`.
2. Mark the center as visited.
3. While the queue is non-empty:
   - Dequeue cell `(r, c)`, append `[r, c]` to `result`.
   - For each of 4 cardinal neighbors: if in-bounds and unvisited, mark visited and enqueue.
4. Return `result`.

Every cell is enqueued and dequeued exactly once, so the loop terminates after `rows * cols` iterations.

## Invariants

- **Visit-before-enqueue**: A cell is marked `visited` when it enters the queue, not when it's dequeued. This prevents duplicate enqueues — without it, a cell reachable from two already-queued cells would be enqueued twice.
- **Complete coverage**: Every cell in the matrix appears exactly once in the output. BFS from any cell in a connected grid visits all cells, and the grid is trivially connected under 4-directional adjacency.
- **Distance ordering**: Cells at Manhattan distance `d` are all dequeued before any cell at distance `d+1`, because BFS explores layer by layer and each edge has uniform weight (1).

## Error Handling

None. The function assumes valid inputs per LeetCode constraints (`0 <= rCenter < rows`, `0 <= cCenter < cols`, both positive). No bounds checking on the center coordinate or defensive handling for empty matrices.

## Complexity

- **Time**: O(rows × cols) — each cell visited once, constant work per cell.
- **Space**: O(rows × cols) — the `visited` matrix and the queue together hold at most all cells.

This is optimal since the output itself is O(rows × cols).

## Topics to Explore

- [file] `matrix-cells-in-distance-order/test_solution.py` — Test cases reveal edge cases and expected tie-breaking behavior
- [general] `bfs-vs-sort-approach` — An alternative O(n log n) approach generates all cells then sorts by `abs(r-rCenter) + abs(c-cCenter)`; compare tradeoffs in constant factors and code simplicity
- [general] `bucket-sort-approach` — Since max Manhattan distance is bounded by `rows + cols - 2`, bucket sort achieves O(n) without BFS overhead or a visited matrix
- [file] `flood-fill/solution.py` — Another grid BFS solution in this repo; compare structural similarities

## Beliefs

- `bfs-guarantees-manhattan-order` — BFS from the center on a grid with 4-directional edges produces cells in non-decreasing Manhattan distance order, because every edge has weight 1
- `visit-before-enqueue-prevents-duplicates` — Marking `visited[nr][nc] = True` at enqueue time (not dequeue time) ensures each cell enters the queue at most once
- `output-size-equals-grid-size` — The returned list always contains exactly `rows * cols` elements, one per cell
- `linear-time-and-space` — Both time and space complexity are O(rows × cols), which is optimal for this problem since the output has that many elements

