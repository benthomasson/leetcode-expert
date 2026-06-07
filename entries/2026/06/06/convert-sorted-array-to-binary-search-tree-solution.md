# File: convert-sorted-array-to-binary-search-tree/solution.py

**Date:** 2026-06-06
**Time:** 15:53

## Purpose

This file is a self-contained LeetCode solution for [problem 108: Convert Sorted Array to Binary Search Tree](https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/). It owns three things: the `TreeNode` data structure, the `sorted_array_to_bst` algorithm, and a test suite that validates correctness via structural invariants (BST property, balance, in-order reconstruction).

## Key Components

### `TreeNode`
A standard binary tree node with `val`, `left`, and `right`. Uses PEP 604 union syntax (`TreeNode | None`) enabled by `from __future__ import annotations`. This class is the shared tree node definition across the entire repo — the "Imported By" list shows hundreds of other problem test files depend on it.

### `sorted_array_to_bst(nums) -> TreeNode | None`
The main algorithm. Takes a sorted integer list and returns the root of a height-balanced BST. Delegates to a closure `helper(left, right)` that operates on index bounds rather than array slices.

### `helper(left, right) -> TreeNode | None`
The recursive workhorse. Picks the middle index `(left + right) // 2` as the root, then recurses on the left and right halves. The node construction is a single expression — `TreeNode(nums[mid], helper(left, mid - 1), helper(mid + 1, right))` — so left and right subtrees are built before the parent node's constructor returns.

### `TestSortedArrayToBST`
Tests don't assert a specific tree shape. Instead, `_assert_valid` checks three structural properties: BST ordering, height-balance (no subtree pair differs by more than 1), and in-order traversal reproducing the original sorted input. This makes the tests robust to any valid balanced BST construction (e.g., choosing upper-mid vs lower-mid).

## Patterns

**Divide-and-conquer via index bounds.** The closure captures `nums` and operates on `(left, right)` indices instead of creating sublists. This avoids O(n log n) total copying that slicing would incur, keeping space to O(log n) stack frames.

**Invariant-based testing.** Rather than hardcoding expected tree structures, tests verify the three defining properties of a correct answer. This is a pattern seen across BST-related solutions in this repo.

**Floor-division midpoint.** `(left + right) // 2` biases toward the left-middle element for even-length ranges. This produces a valid balanced BST but not the only valid one — choosing `(left + right + 1) // 2` would also be correct.

## Dependencies

**Imports:** Only `__future__.annotations` (for `X | None` syntax in Python <3.10) and `unittest`. No external dependencies.

**Imported by:** This file's `TreeNode` class is imported by ~300+ test files across the repo. It serves as the canonical tree node definition for every binary tree problem in the collection.

## Flow

1. `sorted_array_to_bst([−10, −3, 0, 5, 9])` calls `helper(0, 4)`.
2. `helper` computes `mid = 2`, picks `nums[2] = 0` as root.
3. Left subtree: `helper(0, 1)` → `mid = 0`, root `−10`, right child `helper(1, 1)` → leaf `−3`.
4. Right subtree: `helper(3, 4)` → `mid = 3`, root `5`, right child `helper(4, 4)` → leaf `9`.
5. Result: a balanced BST with root 0, depth 3.

The recursion bottoms out when `left > right`, returning `None` (empty subtree).

## Invariants

- **Input must be sorted ascending.** The algorithm doesn't verify this; it's a precondition from the problem statement. Unsorted input produces a tree that fails the BST property.
- **Output is height-balanced.** Equal partitioning around the midpoint guarantees no subtree height difference exceeds 1.
- **In-order traversal = input.** Since the sorted order maps directly to BST in-order, the algorithm preserves element order by construction.
- **Empty input → `None`.** `helper(0, -1)` immediately returns `None`.

## Error Handling

None. The function assumes valid input (a sorted list of integers). Empty lists are handled gracefully by the base case. No exceptions are raised or caught. The test suite relies on `unittest` assertions for failure reporting.

## Topics to Explore

- [file] `balanced-binary-tree/solution.py` — Uses a similar recursive height-check pattern; compare how balance is verified vs. constructed
- [file] `increasing-order-search-tree/solution.py` — Another BST construction problem that depends on this file's `TreeNode`
- [general] `midpoint-bias-in-bst-construction` — How choosing left-mid vs right-mid affects tree shape and why LeetCode accepts both
- [function] `convert-sorted-array-to-binary-search-tree/solution.py:_is_balanced` — O(n^2) balance check; could be O(n) with a combined height-and-balance pass
- [file] `closest-binary-search-tree-value/solution.py` — BST search that also uses `TreeNode`; shows the query side of BST operations

## Beliefs

- `sorted-array-bst-uses-index-bounds` — `sorted_array_to_bst` recurses on index bounds `(left, right)`, never slicing the array, giving O(n) time and O(log n) stack space
- `treenode-is-shared-canonical-definition` — `TreeNode` in this file is imported by 300+ test files across the repo, making it the de facto shared binary tree node
- `left-mid-bias-on-even-length` — For even-length ranges, `(left + right) // 2` selects the left-middle element, producing a left-leaning balanced tree
- `tests-verify-invariants-not-shape` — Tests assert BST ordering, height-balance, and in-order reconstruction rather than a specific tree structure

