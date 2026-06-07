# File: search-in-a-binary-search-tree/solution.py

**Date:** 2026-06-06
**Time:** 18:59

## Purpose

This file implements [LeetCode 700 — Search in a Binary Search Tree](https://leetcode.com/problems/search-in-a-binary-search-tree/). It owns the `TreeNode` definition, the `searchBST` function, and a self-contained test suite. Like every other problem directory in this repo, it follows the pattern of a single `solution.py` that is both the solution module and the test runner.

## Key Components

### `TreeNode` (lines 8–12)

A standard binary tree node with `val`, `left`, and `right`. Uses `Optional[TreeNode]` typing with `from __future__ import annotations` to allow the forward reference in the type hint (the class references itself before it's fully defined).

### `searchBST(root, val) -> Optional[TreeNode]` (lines 15–28)

The core algorithm. Takes a BST root and a target value, returns the subtree rooted at the matching node (or `None`).

**Contract**: Assumes `root` is a valid BST (left children < parent < right children). If this invariant is violated, the function may miss nodes that exist in the tree.

### `TestSearchBST` (lines 31–77)

Seven test cases covering: found in subtree, not found, root match, single-node trees, leaf nodes, and null root. Includes two private helpers:

- `_build(vals)` — constructs a tree from a level-order list (like LeetCode's serialization format). `None` entries represent missing children.
- `_to_list(root)` — serializes a tree back to level-order for assertion comparison. Only emits non-null nodes (no trailing `None`s), so it produces a compact list.

## Patterns

**Iterative BST traversal** — The solution uses a `while` loop instead of recursion. This is the idiomatic choice for BST search: O(1) space, no risk of stack overflow on deep trees, and the BST property means you only ever go one direction at each node (no need to backtrack).

**Self-contained test file** — The `TreeNode` class is defined in the same file as the solution rather than imported from a shared module. This matches the repo-wide convention where each problem directory is independent.

**Level-order serialization** — Both `_build` and `_to_list` use BFS (queue-based) traversal, mirroring LeetCode's own tree serialization format.

## Dependencies

**Imports**: `annotations` (PEP 604 forward refs), `unittest` (test framework), `Optional` from `typing`.

**Imported by**: The "Imported By" list in the prompt is misleadingly large — those are *other* test files across the repo, not files that import from *this* module. Each problem's `test_solution.py` imports from its own `solution.py`. The actual downstream dependency is just `search-in-a-binary-search-tree/test_solution.py`.

## Flow

1. `searchBST` sets `node = root`.
2. At each iteration, it compares `val` to `node.val`:
   - **Equal**: return this node (and its entire subtree, by reference).
   - **Less**: descend left.
   - **Greater**: descend right.
3. If `node` becomes `None`, the value doesn't exist — return `None`.

The key insight: returning the node returns the whole subtree because the tree is linked via object references. No copying happens.

## Invariants

- **BST ordering**: The algorithm relies on `left.val < node.val < right.val` holding at every node. It never verifies this.
- **Single match**: In a valid BST, each value appears at most once (or if duplicates exist, they're consistently placed). The function returns the *first* match encountered on the root-to-leaf path.
- **No mutation**: The function is read-only — it never modifies the tree.

## Error Handling

There is none beyond the `None` return for "not found." A `None` root is handled gracefully (the `while` loop body never executes). No exceptions are raised or caught. Invalid inputs (e.g., non-BST trees, non-integer values) would produce silent wrong answers, not errors.

## Topics to Explore

- [file] `closest-binary-search-tree-value/solution.py` — A related BST traversal problem that must track a "closest so far" instead of an exact match
- [file] `range-sum-of-bst/solution.py` — Extends BST search to a range query, showing how the same left/right pruning logic generalizes
- [function] `convert-sorted-array-to-binary-search-tree/solution.py:sortedArrayToBST` — The inverse operation: constructing the BST that this function searches
- [general] `iterative-vs-recursive-bst-traversal` — When recursion is preferable (e.g., problems needing backtracking or post-order results) vs. iteration
- [file] `increasing-order-search-tree/solution.py` — A BST problem that requires in-order traversal and tree mutation, contrasting with the read-only search here

## Beliefs

- `searchbst-iterative-o1-space` — `searchBST` uses O(1) auxiliary space; it traverses the tree iteratively without a stack or queue
- `searchbst-returns-subtree-by-reference` — The returned `TreeNode` is the original node in the tree, not a copy; modifying it would mutate the input tree
- `searchbst-assumes-valid-bst` — The function never validates BST ordering; it will silently return wrong results on a non-BST input
- `searchbst-none-safe` — Passing `root=None` is handled correctly, returning `None` without error

