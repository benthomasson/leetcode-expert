# File: average-of-levels-in-binary-tree/solution.py

**Date:** 2026-06-06
**Time:** 15:18

## Purpose

This file is the self-contained solution + test module for [LeetCode 637: Average of Levels in Binary Tree](https://leetcode.com/problems/average-of-levels-in-binary-tree/). It owns the `TreeNode` definition, the BFS-based solver, and the full unit test suite — all in one file, matching the repo's per-problem convention.

## Key Components

### `TreeNode`
A minimal binary tree node. Fields: `val` (int), `left`, `right`. Used both by `Solution` and by the tests to construct input trees inline. This is a local definition — it doesn't import a shared `TreeNode` from elsewhere.

### `Solution.averageOfLevels`
**Contract:** Given a non-null root, returns a `List[float]` where element `i` is the arithmetic mean of all node values at depth `i`.

- Assumes `root` is never `None` (no guard). The problem guarantees at least one node.
- Returns exact Python floats — no rounding.

## Patterns

**BFS via deque with level-size snapshot.** This is the textbook iterative level-order traversal pattern:

1. Seed the queue with root.
2. At the start of each iteration, snapshot `level_size = len(queue)`.
3. Pop exactly `level_size` nodes, accumulate their values, and enqueue children.
4. Compute the average from `level_sum / level_size`.

The level-size snapshot is the key idiom — it partitions a flat FIFO into discrete levels without a sentinel or two-queue swap.

**Single-file solution + test.** Every problem directory follows the same layout (`solution.py`, `test_solution.py`, `plan.md`, `review.md`). This file bundles tests inline below the solution class rather than in the separate `test_solution.py`, which also exists in this directory.

## Dependencies

**Imports:**
- `collections.deque` — O(1) popleft for the BFS queue.
- `typing.List, Optional` — type annotations only; no runtime effect.
- `unittest` — inline test suite.

**Imported by:** The `test_solution.py` in this directory and hundreds of other `test_solution.py` files across the repo import from this module. That's the shared `TreeNode` definition being reused — other tree-problem tests construct their inputs using this class.

## Flow

```
averageOfLevels(root)
  queue = [root]
  while queue not empty:
    level_size = len(queue)          # freeze current level boundary
    level_sum = 0
    for _ in range(level_size):      # process exactly this level
      node = queue.popleft()
      level_sum += node.val
      enqueue non-null children
    result.append(level_sum / level_size)
  return result
```

Each while-loop iteration processes one complete tree level. The inner for-loop drains exactly `level_size` nodes (the ones that were in the queue at the start of this level), and any children enqueued during the loop belong to the *next* level. After the for-loop, the queue contains only next-level nodes, so `len(queue)` at the top of the next iteration correctly captures the next level's size.

**Complexity:** O(n) time, O(w) space where w is the maximum width of the tree (the largest level).

## Invariants

- **Root is non-null.** No `if not root` guard. Passing `None` would crash on `node.val` in the first iteration.
- **level_size > 0 inside the loop.** The while condition guarantees the queue is non-empty, so `level_size` is always at least 1 — no division-by-zero risk.
- **Integer sum, float division.** `level_sum` accumulates as a Python int (arbitrary precision), then `/` produces a float. For very large sums this could lose precision, but that's inherent to the float return type.

## Error Handling

None. The function assumes valid input per LeetCode constraints. No try/except, no null-root guard, no type checking. If `root` is `None`, it crashes with an `AttributeError` on the first `node.val` access.

## Topics to Explore

- [file] `average-of-levels-in-binary-tree/test_solution.py` — The separate test file; compare its coverage with the inline tests bundled here
- [function] `cousins-in-binary-tree/solution.py:Solution` — Another BFS level-order problem; compare how the level-size snapshot pattern adapts when tracking parent/depth metadata
- [file] `binary-tree-inorder-traversal/solution.py` — Contrast BFS (this file) with DFS traversal patterns used elsewhere in the repo
- [general] `TreeNode-reuse-across-repo` — This file's `TreeNode` is imported by 300+ test files; understanding that dependency fan-out explains why changing its constructor signature would be high-impact

## Beliefs

- `bfs-level-snapshot-pattern` — `averageOfLevels` partitions BFS into discrete levels by snapshotting `len(queue)` before each inner loop, not by using sentinels or multiple queues
- `root-nonnull-precondition` — `averageOfLevels` assumes root is non-null; passing `None` raises `AttributeError` with no graceful handling
- `treenode-shared-dependency` — This file's `TreeNode` class is imported by hundreds of test files across the repo, making it a de facto shared data structure definition
- `float-division-always-safe` — Division by zero in `level_sum / level_size` is impossible because the while-loop condition guarantees the queue (and therefore `level_size`) is non-empty

