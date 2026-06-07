# File: cousins-in-binary-tree/solution.py

**Date:** 2026-06-06
**Time:** 16:08

## Purpose

This file solves [LeetCode 993: Cousins in Binary Tree](https://leetcode.com/problems/cousins-in-binary-tree/). It determines whether two nodes in a binary tree are "cousins" — meaning they sit at the same depth but have different parents. The file is self-contained: it defines the tree node structure, the solution, a tree-building helper, and unit tests.

## Key Components

### `TreeNode` (line ~9)
Standard binary tree node with `val`, `left`, `right`. Used as the shared tree representation across this repo's binary tree problems.

### `Solution.isCousins(root, x, y) -> bool` (line ~16)
The core algorithm. Takes a tree root and two node values, returns whether they're cousins. Contract: `x` and `y` are guaranteed to exist in the tree and be distinct (per LeetCode constraints). Returns `False` for `None` root.

### `_build_tree(vals) -> Optional[TreeNode]` (line ~53)
Test utility that constructs a binary tree from a level-order list, where `None` represents missing nodes. This is the standard LeetCode serialization format (e.g., `[1, 2, 3, None, 4]`).

### `TestCousins` (line ~72)
Six test cases covering: different depths, actual cousins, siblings (same parent), root-child pair, and deep cousins.

## Patterns

**BFS with parent tracking.** The queue stores `(node, parent)` tuples. Processing happens level-by-level using the `level_size = len(queue)` idiom — this is the standard way to do level-order traversal when you need to know when a level boundary is crossed.

**Early termination within a level.** After processing a full level, the code checks:
- Both `x_parent` and `y_parent` found → they're at the same depth, return whether parents differ.
- Only one found → they're at different depths, return `False` immediately without traversing deeper levels.

This avoids unnecessary work once the answer is determined.

## Dependencies

**Imports:** `collections.deque` for BFS queue, `typing.Optional` for type hints, `unittest` for tests. No project-internal imports.

**Imported by:** The `test_solution.py` files listed in the "Imported By" section don't actually import *this* file — that list appears to be an artifact of the repo-wide cross-reference. The `cousins-in-binary-tree/test_solution.py` is the only true consumer, and the tests are already inline in this file.

## Flow

1. Seed the BFS queue with `(root, None)` — root has no parent.
2. For each level, iterate exactly `level_size` times (snapshot of queue length at level start).
3. For each dequeued node, check if its value matches `x` or `y`, recording the parent if so.
4. Enqueue children with `node` as their parent.
5. After the level completes, apply the early-termination logic described above.
6. If the loop exhausts the tree without finding both, return `False`.

## Invariants

- **Level isolation:** `x_parent` and `y_parent` are reset to `None` at the start of each level. This ensures the cousin check only compares nodes found at the same depth.
- **Parent identity comparison:** `x_parent != y_parent` compares object identity (since `TreeNode` doesn't override `__eq__`), which is correct — two distinct `TreeNode` objects with the same value are still different parents.
- **Single-level decision:** The algorithm never needs information across levels. Once both targets are found (or one is found alone), the answer is determined from that single level.

## Error Handling

Minimal — the `None` root check on line 30 is the only guard. No exceptions are raised. The algorithm trusts that `x` and `y` exist in the tree (matching LeetCode's guarantees). If they don't exist, it returns `False` after exhausting the tree.

## Topics to Explore

- [file] `cousins-in-binary-tree/test_solution.py` — May contain additional edge-case tests beyond the inline ones
- [function] `average-of-levels-in-binary-tree/solution.py:averageOfLevels` — Another BFS level-order traversal; compare how the same `level_size` idiom is used for a different purpose
- [general] `bfs-vs-dfs-cousin-detection` — An alternative DFS approach tracks `(depth, parent)` per target with a single recursive pass, trading queue memory for call stack
- [file] `balanced-binary-tree/solution.py` — Contrasts BFS here with DFS for a different tree-depth problem
- [function] `cousins-in-binary-tree/solution.py:_build_tree` — The level-order tree builder is reused conceptually across many tree problem test files; worth understanding its `None`-gap handling

## Beliefs

- `cousins-bfs-level-isolation` — `x_parent` and `y_parent` are reset per level, so the algorithm never falsely compares nodes found at different depths
- `cousins-early-exit-on-single-find` — If only one of `x` or `y` is found at a level, the method returns `False` immediately without visiting deeper levels
- `cousins-parent-identity-not-value` — Parent comparison uses object identity (`!=`), not value equality, which is correct because `TreeNode` has no `__eq__` override
- `cousins-time-complexity-linear` — The algorithm visits each node at most once, giving O(n) time and O(w) space where w is the maximum level width

