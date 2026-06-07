# File: symmetric-tree/solution.py

**Date:** 2026-06-06
**Time:** 19:25

## Purpose

This file implements [LeetCode 101 — Symmetric Tree](https://leetcode.com/problems/symmetric-tree/). It determines whether a binary tree is a mirror image of itself around its center. The file is self-contained: it defines the tree node type, two solution variants (recursive and iterative), a tree builder utility, and a full test suite.

## Key Components

### `TreeNode` (lines 9–14)
Standard binary tree node with `val`, `left`, `right`. This is a local definition rather than a shared import — every solution in this repo defines its own `TreeNode`, which is why hundreds of test files list this module under "Imported By" (they import the class, not the solution logic).

### `isSymmetric(root)` (lines 17–33)
The primary recursive solution. Delegates to a nested `is_mirror` helper that walks two subtrees simultaneously, comparing mirror-position nodes:
- `left.left` against `right.right` (outer pair)
- `left.right` against `right.left` (inner pair)

Returns `True` for an empty tree (null root).

### `isSymmetricIterative(root)` (lines 36–53)
BFS variant using a `deque`. Seeds the queue with the `(root.left, root.right)` pair, then pops pairs and enqueues their mirror children. Short-circuits on the first mismatch.

### `_build_tree(vals)` (lines 59–75)
Test utility that constructs a `TreeNode` tree from a level-order list (LeetCode's standard serialization format). `None` entries represent missing nodes. Used exclusively by the test class.

### `TestSymmetricTree` (lines 78–107)
Seven test cases covering: symmetric tree, asymmetric structure, asymmetric values, single node, empty tree, deep symmetric tree, and left-only child. Every test asserts both the recursive and iterative implementations agree.

## Patterns

**Dual implementation** — Providing both recursive and iterative solutions is a common pattern in this repo's tree problems. The recursive version is cleaner; the iterative version avoids stack overflow on pathological inputs.

**Mirror-walk** — Instead of serializing the tree and comparing strings, the solution walks two pointers in opposite directions simultaneously. This is O(n) time, O(h) space (recursion depth or queue size).

**Inline tests** — Tests live in the same file alongside the solution, runnable via `python -m unittest` or `python solution.py`. A separate `test_solution.py` exists alongside this file that likely imports from here.

## Dependencies

**Imports**: `deque` from `collections` (used in both the iterative solution and `_build_tree`), `Optional` from `typing`, `annotations` from `__future__` (enables forward-reference type hints for `TreeNode`).

**Imported by**: The "Imported By" list is enormous (~400 test files) but misleading — those files import the `TreeNode` class or the tree builder, not the symmetry-check logic. This module effectively serves as a de-facto `TreeNode` definition for much of the test suite.

## Flow

**Recursive path**: `isSymmetric` → null-check root → call `is_mirror(root.left, root.right)` → base cases (both null → `True`, one null → `False`) → compare values → recurse on outer and inner children. Short-circuits via `and`: if `left.val != right.val`, the second `is_mirror` call never happens.

**Iterative path**: Seed deque with one pair → loop: pop pair → skip if both null → fail if one null or values differ → enqueue two new mirror pairs → return `True` when queue empties.

## Invariants

- `is_mirror` always receives nodes from symmetric positions in the tree — the outer call guarantees `left` comes from the left subtree and `right` from the right subtree at corresponding depths.
- The iterative version maintains the same invariant: every queued pair consists of nodes that must be equal for the tree to be symmetric.
- `_build_tree` assumes the input list follows LeetCode's level-order convention: index 0 is root, and children of the node at index `i` are at indices `2i+1` and `2i+2` (modulo `None` gaps).

## Error Handling

There is none beyond structural null checks, which is appropriate — the contract is that inputs are valid `TreeNode` trees or `None`. No exceptions are raised or caught. Invalid inputs (e.g., non-list to `_build_tree`) would raise standard Python errors.

## Topics to Explore

- [file] `symmetric-tree/test_solution.py` — The companion test file that imports from this module; may have additional edge cases or a different test structure
- [function] `same-tree/solution.py:isSameTree` — Closely related problem; symmetric tree is essentially "are these two subtrees the same under mirror reflection"
- [file] `balanced-binary-tree/solution.py` — Another recursive tree-structure check with similar dual-pointer decomposition
- [general] `tree-node-duplication` — Understanding why `TreeNode` is redefined in every solution file rather than shared, and the coupling that creates in the test suite
- [function] `invert-binary-tree/solution.py:invertTree` — Inverting a tree is the "write" version of the "read" operation this solution performs

## Beliefs

- `symmetric-tree-mirror-walk` — `is_mirror` compares `left.left` with `right.right` and `left.right` with `right.left`, never same-side children
- `symmetric-tree-dual-impl-equivalence` — `isSymmetric` and `isSymmetricIterative` produce identical results for all valid inputs; every test case asserts both
- `symmetric-tree-linear-complexity` — Both implementations visit each node at most once, giving O(n) time complexity
- `treenode-is-local-not-shared` — `TreeNode` is defined locally in this file rather than imported from a shared module, making this file a transitive dependency for hundreds of test files

