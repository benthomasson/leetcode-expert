# File: second-minimum-node-in-a-binary-tree/solution.py

**Date:** 2026-06-06
**Time:** 19:01

## Purpose

This file solves [LeetCode 671: Second Minimum Node In a Binary Tree](https://leetcode.com/problems/second-minimum-node-in-a-binary-tree/). It implements a DFS-based search over a "special" binary tree where every node's value equals the minimum of its subtree. The goal is to find the second-smallest distinct value in the tree, or `-1` if no such value exists.

## Key Components

### `TreeNode`
Standard binary tree node with `val`, `left`, `right`. This is the shared tree node definition used across many solutions in this repo (the "Imported By" list confirms it's reused extensively via test files).

### `find_second_minimum_value(root) -> int`
The main solver. Contract:
- **Input**: root of a special binary tree where `root.val == min(left.val, right.val)` at every internal node.
- **Output**: the second-smallest distinct value in the tree, or `-1` if every node has the same value (or the tree is empty).

## Patterns

**DFS with pruning.** The key insight is the tree's structural invariant: every parent's value equals the minimum of its children. Therefore `root.val` is the global minimum. The algorithm walks the tree looking for the smallest value strictly greater than `root.val`.

The pruning at line 27 (`return` when `node.val > min_val`) is correct because once a node has a value larger than the minimum, all of its descendants must be `>=` that value (by the tree's invariant). There's no point descending further — we already captured this node's value as a candidate.

**Closure over mutable state.** The nested `dfs` function uses `nonlocal candidate` to track the best second-minimum found so far, avoiding the need to pass and return state through recursive calls.

## Dependencies

**Imports**: Only `typing.Optional` — no external libraries.

**Imported by**: Heavily referenced by test files across the repo. The `TreeNode` class defined here is the canonical tree node used in many other solutions' test suites (hundreds of test files import it). This makes `TreeNode` a de facto shared utility, even though it's defined inline rather than in a shared module.

## Flow

1. Guard: if `root` is `None`, return `-1`.
2. Capture `min_val = root.val` — guaranteed global minimum by the tree invariant.
3. Initialize `candidate = -1` (sentinel meaning "no second minimum found yet").
4. Run `dfs(root)`:
   - If a node's value exceeds `min_val`, it's a candidate for second minimum. Update `candidate` if this is the first candidate or a smaller one. **Prune** — don't recurse into children.
   - If a node's value equals `min_val`, recurse into both children (the second minimum might be deeper).
5. Return `candidate` (still `-1` if no distinct second value exists).

## Invariants

- The tree satisfies `node.val == min(node.left.val, node.right.val)` for all internal nodes. The algorithm depends on this but doesn't verify it.
- `candidate` is always either `-1` (no candidate found) or the smallest value strictly greater than `root.val` seen so far.
- The pruning is safe: if `node.val > min_val`, then `child.val >= node.val > min_val` for all descendants, so no descendant can improve on `node.val` as a candidate.

## Error Handling

None explicitly. An empty tree (`root is None`) returns `-1`. The sentinel `-1` serves double duty as both "no answer" and the LeetCode-specified return value for that case. No exceptions are raised.

## Topics to Explore

- [file] `second-minimum-node-in-a-binary-tree/test_solution.py` — See edge cases tested: all-same-value trees, single-node trees, deep candidates
- [file] `second-minimum-node-in-a-binary-tree/plan.md` — The planning rationale that led to the pruning approach over alternatives (full traversal, set-based, etc.)
- [function] `evaluate-boolean-binary-tree/solution.py:evaluate_tree` — Another recursive tree solution using the same `TreeNode` class, but with a different DFS pattern (bottom-up evaluation vs. top-down search)
- [general] `tree-node-sharing` — Why hundreds of test files import `TreeNode` from individual solution files rather than a shared module — potential refactoring opportunity
- [file] `minimum-depth-of-binary-tree/solution.py` — Contrasting DFS strategy: early termination at leaves vs. pruning on value threshold

## Beliefs

- `prune-on-greater-value` — When `node.val > min_val`, no descendant can have a value between `min_val` and `node.val`, so the subtree is safely pruned.
- `root-is-global-min` — `root.val` is always the global minimum of the tree due to the parent-equals-min-of-children invariant.
- `sentinel-minus-one` — The value `-1` is used both as the "not found" sentinel during search and as the final return value when no second minimum exists.
- `treenode-is-shared-utility` — The `TreeNode` class defined in this file is imported by hundreds of test files across the repo, making it a critical shared dependency despite not living in a shared module.

