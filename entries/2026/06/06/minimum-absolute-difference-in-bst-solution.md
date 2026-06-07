# File: minimum-absolute-difference-in-bst/solution.py

**Date:** 2026-06-06
**Time:** 17:51

## Purpose

This file is a self-contained LeetCode solution for [LeetCode 530: Minimum Absolute Difference in BST](https://leetcode.com/problems/minimum-absolute-difference-in-bst/). It owns three responsibilities: the `TreeNode` definition, the `Solution` class with the algorithm, and inline unit tests. It follows the same `solution.py` + `test_solution.py` convention used across the ~400+ problem directories in this repo, though here the tests are bundled into the solution file rather than separated.

## Key Components

### `TreeNode`
Standard binary tree node with `val`, `left`, `right`. Used as the input structure — matches the LeetCode definition.

### `Solution.getMinimumDifference(root) -> int`
The core algorithm. Finds the minimum absolute difference between any two node values in a BST. Exploits the BST property: an inorder traversal visits nodes in ascending order, so the minimum difference must occur between consecutive elements in that traversal.

**Contract**: `root` has at least 2 nodes and forms a valid BST. Returns a non-negative integer.

### `build_tree(values) -> TreeNode | None`
Test helper that constructs a binary tree from a level-order list (BFS layout), where `None` entries represent missing children. Standard LeetCode tree serialization format.

### `TestMinAbsDiff`
Six test cases covering: LeetCode examples, two-node edge case, right-skewed tree, mixed large/small gaps, and consecutive values.

## Patterns

**Inorder traversal with running state** — The solution uses instance variables (`self.prev`, `self.min_diff`) as mutable state shared across recursive calls rather than passing accumulators through parameters or using a nonlocal closure. This is a common LeetCode idiom for BST problems where you need to compare consecutive inorder elements.

**Implicit sorted-sequence reduction** — Instead of materializing the full sorted list then scanning for min-diff (O(n) space), this computes the answer during traversal by only tracking the previous value (O(h) stack space, where h is tree height).

## Dependencies

**Imports**: `typing.Optional` for type hints, `unittest` for tests. No external libraries.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files from *other* problems that likely import from their own `solution.py`, not from this file. The actual dependent is `minimum-absolute-difference-in-bst/test_solution.py`.

## Flow

1. `getMinimumDifference` initializes `self.prev = None` and `self.min_diff = inf`
2. `inorder(node)` recurses left, processes current node, recurses right
3. On each node visit: if `self.prev` is set, compute `node.val - self.prev` (guaranteed non-negative because inorder on a BST yields ascending order) and update `self.min_diff` if smaller
4. Set `self.prev = node.val` for the next comparison
5. Return `int(self.min_diff)` — the `int()` cast converts from `float('inf')` type to int (though with ≥2 nodes, `min_diff` will always have been updated)

## Invariants

- **BST property assumed, not verified** — The subtraction `node.val - self.prev` relies on inorder values being non-decreasing. On a non-BST input, this could produce negative differences and return a wrong answer.
- **At least 2 nodes required** — If the tree has only one node, `self.prev` is never set before any comparison, so `min_diff` stays at `inf` and `int(float('inf'))` raises `OverflowError` in some Python versions (returns a large int in CPython 3.x via `__int__`). The problem guarantees ≥2 nodes.
- **No duplicate handling** — BSTs typically don't have duplicate values. If duplicates exist, `node.val - self.prev` would be 0, which is correctly the minimum.

## Error Handling

None. The code trusts its input matches the LeetCode contract. No null-root guard beyond the recursive base case (`if not node: return`). The `int()` cast is the only defensive measure, converting the float sentinel to an integer return type.

## Topics to Explore

- [file] `minimum-distance-between-bst-nodes/solution.py` — Identical problem (LeetCode 783 is the same as 530); compare whether the solution is duplicated or shared
- [function] `convert-sorted-array-to-binary-search-tree/solution.py:sortedArrayToBST` — The inverse operation: building a BST from sorted data, which pairs conceptually with extracting sorted data via inorder
- [file] `closest-binary-search-tree-value/solution.py` — Another BST problem that exploits the sorted-order property via targeted traversal
- [general] `inorder-state-pattern` — How other BST solutions in this repo (find-mode, two-sum-iv, increasing-order) handle running state during inorder traversal

## Beliefs

- `bst-min-diff-is-between-inorder-neighbors` — The minimum absolute difference in a BST always occurs between two values adjacent in the inorder (sorted) sequence; non-adjacent pairs are guaranteed to have equal or larger gaps
- `inorder-uses-instance-vars-not-closure` — State is shared via `self.prev` and `self.min_diff` rather than nonlocal variables or return-value threading
- `no-materialized-list` — The solution computes the answer in O(h) space (recursion stack only) without collecting all node values into a list first
- `subtraction-order-assumes-bst` — `node.val - self.prev` (not `abs(...)`) is correct only because inorder on a valid BST visits values in non-decreasing order

