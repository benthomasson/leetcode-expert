# File: sum-of-root-to-leaf-binary-numbers/solution.py

**Date:** 2026-06-06
**Time:** 19:23

## Purpose

This file solves [LeetCode 1022: Sum of Root To Leaf Binary Numbers](https://leetcode.com/problems/sum-of-root-to-leaf-binary-numbers/). Given a binary tree where every node holds 0 or 1, each root-to-leaf path spells out a binary number (MSB at root). The solution returns the sum of all such numbers.

It also provides the `TreeNode` class and `build_tree` helper used across the entire test suite — the "Imported By" list shows hundreds of test files depend on this module for tree construction.

## Key Components

### `TreeNode`
Standard binary tree node. Fields: `val` (0 or 1), `left`, `right`. No validation on `val` — callers are trusted to pass valid inputs.

### `build_tree(values)`
Constructs a tree from a level-order list (the format LeetCode uses). `None` entries represent missing nodes. Uses a BFS queue to attach children left-to-right, level by level. Returns `None` for an empty list.

### `Solution.sumRootToLeaf(root)`
The core algorithm. Uses a nested DFS function that threads the accumulated binary value down through the tree.

## Patterns

**Bit-shifting accumulation**: Instead of building a string and converting, each recursive step does `current = (current << 1) | node.val` — left-shift the running value and OR in the new bit. This is the standard O(1)-per-node way to build a binary number incrementally.

**Leaf detection as base case**: A node is a leaf when both children are `None`. At a leaf, the accumulated value is returned directly. At internal nodes, the function sums results from whichever children exist.

**Shared infrastructure pattern**: `TreeNode` and `build_tree` are defined here but consumed by ~400 test files. This module doubles as both a solution and a shared utility — a pattern common across this repo where the first solution to need a data structure becomes the canonical import location for it.

## Dependencies

**Imports**: `deque` (for BFS in `build_tree`), `Optional` (type hints), `annotations` (PEP 604 forward-ref support).

**Imported by**: Virtually every test file in the repository imports `TreeNode` and/or `build_tree` from here. This makes the file load-bearing infrastructure — changes to `TreeNode` or `build_tree` signatures would break hundreds of tests.

## Flow

1. `sumRootToLeaf` returns 0 immediately if `root is None`.
2. Otherwise it calls `dfs(root, 0)`, starting with a binary accumulator of 0.
3. At each node, `dfs` shifts the accumulator left by 1 and ORs in `node.val`.
4. If the node is a leaf, it returns the accumulated value — that's the binary number for this path.
5. If the node has children, it recurses into each and sums the results.

For the example tree `[1, 0, 1, 0, 1, 0, 1]`:
- Path 1→0→0 = binary `100` = 4
- Path 1→0→1 = binary `101` = 5
- Path 1→1→0 = binary `110` = 6
- Path 1→1→1 = binary `111` = 7
- Sum = 22

## Invariants

- Every node's `val` must be 0 or 1 for the result to be meaningful — not enforced, just assumed.
- `dfs` is only called on non-None nodes (the None-guard happens before recursing into children).
- `build_tree` assumes `values[0]` is non-None when the list is non-empty (the root always exists).

## Error Handling

None. Null root returns 0. No validation on node values or tree structure. A malformed `values` list (e.g., non-None child of a None parent) would silently produce a wrong tree — `build_tree` skips None entries in the queue but doesn't track structural consistency.

## Topics to Explore

- [file] `sum-of-root-to-leaf-binary-numbers/test_solution.py` — Test cases showing edge cases and expected outputs for this solution
- [function] `convert-binary-number-in-a-linked-list-to-integer/solution.py:Solution` — Same bit-shifting accumulation pattern applied to a linked list instead of a tree
- [function] `binary-tree-paths/solution.py:Solution` — Collects all root-to-leaf paths as strings, same traversal structure without the numeric accumulation
- [general] `shared-tree-infrastructure` — How `TreeNode` and `build_tree` became the repo-wide tree utilities despite living in a single solution file
- [file] `evaluate-boolean-binary-tree/solution.py` — Another recursive tree evaluation where leaf values drive the base case

## Beliefs

- `bit-shift-accumulation-correctness` — `(current << 1) | node.val` correctly builds a binary number MSB-first, equivalent to `current * 2 + node.val`
- `build-tree-is-shared-infra` — `TreeNode` and `build_tree` from this file are imported by hundreds of test files across the repository, making it critical shared infrastructure
- `dfs-never-called-on-none` — The `dfs` inner function is only ever called on non-None nodes; null checks happen at the call site before recursing
- `sumRootToLeaf-linear-time` — The algorithm visits each node exactly once, giving O(n) time and O(h) stack space where h is tree height

