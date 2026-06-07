# File: diameter-of-binary-tree/solution.py

**Date:** 2026-06-06
**Time:** 16:22

## Purpose

This file implements [LeetCode 543 — Diameter of Binary Tree](https://leetcode.com/problems/diameter-of-binary-tree/). It's a self-contained module: problem solution, tree node definition, and unit tests all in one file. Its role in the project is as one of hundreds of solved LeetCode problems following a uniform `solution.py` + `test_solution.py` structure.

## Key Components

**`TreeNode`** — Standard binary tree node with `val`, `left`, `right`. Uses PEP 604 union syntax (`TreeNode | None`) enabled by the `from __future__ import annotations` import.

**`diameter_of_binary_tree(root)`** — The main solver. Takes a root node, returns the diameter as an integer edge count. The diameter is the longest path between any two nodes in the tree — critically, this path does not need to pass through the root.

**`height(node)`** — Nested closure inside the solver. Computes the height of a subtree while simultaneously updating the outer `diameter` variable via `nonlocal`. Returns the height (edge count from node to deepest leaf), but the side effect — updating `diameter` — is the real point.

## Patterns

**Single-pass DFS with closure accumulator.** This is the canonical pattern for tree diameter: compute height recursively, and at each node, the candidate diameter is `left_height + right_height`. The `nonlocal diameter` / `max` accumulator avoids needing a mutable container or class-level state. This is O(n) time, O(h) stack space.

**Height returns edges, not nodes.** The base case returns `0` for `None` (not -1 for null / 0 for leaf), which means a single node has height 0 and a leaf-to-leaf path through a node is `left + right` edges. This is consistent with the problem's definition of diameter as edge count.

## Dependencies

**Imports:** Only stdlib — `annotations` for forward-reference syntax, `typing.Optional` for the type hint, `unittest` for tests. No external packages.

**Imported by:** The "Imported By" list in the prompt is misleading — those are test files across the entire repo that happen to share a common test runner or import pattern. The actual direct dependent is `diameter-of-binary-tree/test_solution.py`.

## Flow

1. `diameter_of_binary_tree` initializes `diameter = 0`.
2. Calls `height(root)`, which recurses depth-first (post-order).
3. At each node, `height` recurses left and right, getting their heights.
4. It updates `diameter = max(diameter, left + right)` — the path through this node.
5. It returns `1 + max(left, right)` — this node's height to its parent.
6. After the full traversal, `diameter` holds the global maximum.

The key insight: the diameter at any node is the sum of its children's heights. The global diameter is the max over all nodes. By computing height bottom-up, every node is visited exactly once.

## Invariants

- `height(None)` returns `0` — the empty-tree base case.
- `height(node)` always returns a non-negative integer.
- `diameter` is monotonically non-decreasing during traversal (only updated via `max`).
- The returned diameter counts **edges**, not nodes. A single-node tree returns `0`, not `1`.

## Error Handling

None. The function assumes a valid binary tree (no cycles, no invalid node types). Passing `None` as root works correctly — `height` returns 0, diameter stays 0, and `0` is returned.

## Topics to Explore

- [file] `balanced-binary-tree/solution.py` — Uses the same height-recursion pattern but returns a boolean; compare how it short-circuits vs. this solution's full traversal
- [file] `maximum-depth-of-binary-tree/solution.py` — The pure height computation without the diameter side-effect; the building block this solution extends
- [function] `binary-tree-tilt/solution.py:findTilt` — Another example of the "compute one thing, accumulate another via nonlocal" DFS pattern
- [general] `tree-diameter-vs-height` — Understanding why diameter is `left + right` (path through node) while height is `1 + max(left, right)` (longest arm down)

## Beliefs

- `diameter-returns-edges` — `diameter_of_binary_tree` returns the number of edges on the longest path, not the number of nodes; a single-node tree returns 0
- `diameter-not-necessarily-through-root` — The algorithm correctly finds diameters that don't pass through the root, as demonstrated by `test_diameter_not_through_root` (expected: 4 on a tree where the longest path is entirely in the left subtree)
- `single-pass-linear-time` — The solution visits each node exactly once via post-order DFS, making it O(n) time and O(h) space where h is tree height
- `nonlocal-accumulator-pattern` — The `diameter` variable is captured and mutated by the inner `height` closure via `nonlocal`, avoiding the need for a class instance variable or mutable container

