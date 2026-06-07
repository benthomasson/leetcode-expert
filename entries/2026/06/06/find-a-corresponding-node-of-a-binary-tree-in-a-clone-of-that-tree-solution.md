# File: find-a-corresponding-node-of-a-binary-tree-in-a-clone-of-that-tree/solution.py

**Date:** 2026-06-06
**Time:** 16:32

## Purpose

This file solves [LeetCode 1379: Find a Corresponding Node of a Binary Tree in a Clone of That Tree](https://leetcode.com/problems/find-a-corresponding-node-of-a-binary-tree-in-a-clone-of-that-tree/). Given an original binary tree, a structurally identical clone, and a reference to a node in the original, it finds and returns the reference to the corresponding node in the clone.

The file is self-contained: it defines the `TreeNode` class, the solution function, and a full test suite.

## Key Components

### `TreeNode` (lines 7-10)
Standard binary tree node with `val`, `left`, `right`. Used by both the solution and tests.

### `getTargetCopy(original, cloned, target) -> TreeNode` (lines 13-27)
The core algorithm. Walks both trees in lockstep using the original tree to locate the target by **identity** (not value), then returns the corresponding node from the cloned tree.

Contract:
- `original` and `cloned` must be structurally identical trees
- `target` must be a node that exists in `original`
- Returns the node in `cloned` at the same position as `target` in `original`

### `TestGetTargetCopy` (lines 32-87)
Six test cases covering: interior node, single-node tree, right-skewed chain, root as target, leaf node, left-skewed chain.

## Patterns

**Parallel recursive traversal.** The key insight is traversing `original` and `cloned` simultaneously. The identity check (`original is target`) happens on the original tree, but the *return value* comes from the cloned tree. This avoids value-based comparison, which matters when duplicate values exist.

**Short-circuit DFS.** The left subtree result is checked before recursing right (lines 25-27). If the target is found in the left subtree, the right subtree is never visited. This is a standard optimization for "find one node" tree problems.

**`_clone` helper in tests.** Tests build the original tree by hand, then clone it with `_clone`, and verify that the result is both value-correct (`assertEqual`) and identity-correct (`assertIs`).

## Dependencies

**Imports:** `typing.Optional` (declared but unused in the function signature — the actual return type annotation uses `TreeNode` directly), `unittest`.

**Imported by:** The "Imported By" list in the prompt is misleading — it lists hundreds of unrelated test files. The only real consumer is `find-a-corresponding-node-of-a-binary-tree-in-a-clone-of-that-tree/test_solution.py`.

## Flow

1. Enter `getTargetCopy` with roots of both trees and the target reference.
2. Check `original is target` — if yes, return the corresponding `cloned` node. This is the base case that produces the result.
3. Check `original is None` — if yes, return `None`. This is the base case that prevents walking off the tree.
4. Recurse left. If the left subtree returned a non-`None` result, propagate it up immediately.
5. Otherwise, recurse right and return whatever it produces (either the found node or `None`).

The recursion is pre-order DFS. Worst case (target is the rightmost leaf) visits every node — O(n) time, O(h) stack space where h is tree height.

## Invariants

- **Identity comparison, not value comparison.** `original is target` uses `is`, not `==`. This is critical: the problem explicitly allows duplicate values. Comparing by value would return the wrong node in trees like `[1, 1, 1]`.
- **Structural congruence assumed.** The algorithm never validates that `cloned` mirrors `original`. If they diverge, behavior is undefined (likely `AttributeError` or wrong result).
- **Target must exist.** If `target` is not in `original`, the function returns `None`, which violates the stated return type but is a reasonable sentinel.

## Error Handling

None. The function trusts its inputs completely — no validation, no exceptions. A `None` return implicitly signals "target not found," but the problem guarantees the target exists, so this path shouldn't occur in valid usage.

## Topics to Explore

- [file] `find-a-corresponding-node-of-a-binary-tree-in-a-clone-of-that-tree/test_solution.py` — May contain additional edge-case tests beyond the inline ones
- [function] `subtree-of-another-tree/solution.py:isSubtree` — Another tree-identity/structure-matching problem using similar recursive traversal
- [general] `parallel-tree-traversal` — The lockstep traversal pattern appears in several tree problems (merge two binary trees, same tree, symmetric tree)
- [file] `same-tree/solution.py` — Simplest instance of the two-tree simultaneous traversal pattern
- [general] `identity-vs-equality-in-tree-problems` — When `is` vs `==` matters; this problem is the canonical example

## Beliefs

- `identity-not-equality` — `getTargetCopy` uses `is` (identity) to find the target, making it correct even when the tree contains duplicate values
- `short-circuit-left-before-right` — The left subtree result is checked before recursing into the right subtree; finding the target early avoids unnecessary traversal
- `structural-congruence-assumed` — The algorithm assumes `cloned` is structurally identical to `original` and does not validate this; divergent trees produce undefined behavior
- `optional-import-unused` — `typing.Optional` is imported but never referenced in any type annotation in this file

