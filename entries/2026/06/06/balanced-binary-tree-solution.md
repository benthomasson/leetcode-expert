# File: balanced-binary-tree/solution.py

**Date:** 2026-06-06
**Time:** 15:20

## `balanced-binary-tree/solution.py`

### Purpose

This file solves [LeetCode #110 — Balanced Binary Tree](https://leetcode.com/problems/balanced-binary-tree/). It determines whether a binary tree is height-balanced, meaning the left and right subtree depths of every node differ by at most 1. The file is self-contained: it defines the tree data structure, the solution logic, and a full test suite.

### Key Components

**`TreeNode`** — Standard binary tree node with `val`, `left`, `right`. Uses the union syntax (`TreeNode | None`) in the constructor signature alongside `Optional[TreeNode]` in the function signatures — a minor inconsistency but functionally identical.

**`getHeight(root) -> int`** — The core algorithm. This is a dual-purpose function: it computes the height of a subtree *and* detects imbalance, using `-1` as a sentinel value meaning "this subtree is unbalanced." The contract is:
- Returns `0` for `None` (base case — empty tree has height 0)
- Returns `-1` if any subtree is unbalanced
- Returns `max(left, right) + 1` otherwise (standard height computation)

**`isBalanced(root) -> bool`** — Thin wrapper that converts `getHeight`'s integer signal into a boolean. The entire balance check is delegated to `getHeight`; this function exists solely to match the LeetCode API.

### Patterns

**Sentinel return for early termination.** Rather than computing heights in one pass and checking balance in another (O(n) space via a separate structure or O(n^2) time via redundant traversal), `getHeight` fuses both concerns into a single post-order traversal by using `-1` as a "poison" value. Once any subtree returns `-1`, it propagates upward immediately — no further recursion into sibling subtrees occurs. This is the standard O(n) time, O(h) space solution for this problem.

**Short-circuit evaluation.** Lines 22–25 check `left == -1` and `right == -1` *before* recursing further or computing the balance condition. This means an unbalanced left subtree prevents any traversal of the right subtree, giving best-case performance better than a naive height-then-check approach.

**Post-order traversal.** The function processes children before the current node — left subtree height, then right subtree height, then the balance check at the current level. This is necessary because balance at a node depends on the heights of its children.

### Dependencies

**Imports:** `typing.Optional` (for type annotations) and `unittest` (for inline tests). No external libraries.

**Imported by:** The "Imported By" list in the prompt is misleading — those are test files from *other* LeetCode problems that happen to share a common test runner or import pattern. The actual direct dependent is `balanced-binary-tree/test_solution.py`. The `TreeNode` class defined here is local to this file; other tree problems define their own `TreeNode`.

### Flow

1. `isBalanced(root)` is called with the root of a binary tree.
2. It delegates to `getHeight(root)`.
3. `getHeight` recurses post-order: left child → right child → current node.
4. At each node, if either child returned `-1`, return `-1` immediately (propagate imbalance).
5. If `abs(left - right) > 1`, this node is the first point of imbalance — return `-1`.
6. Otherwise return `max(left, right) + 1` (valid height).
7. `isBalanced` checks whether the result is `-1` (unbalanced) or not.

### Invariants

- `getHeight` returns a value in `{-1} ∪ {0, 1, 2, ...}`. It never returns any other negative number.
- If `getHeight` returns a non-negative value `h`, then the subtree rooted at that node is balanced and has height exactly `h`.
- If `getHeight` returns `-1`, at least one node in the subtree violates the balance property.
- A `None` node is always balanced (height 0).

### Error Handling

None. The function assumes valid input (a proper binary tree or `None`). There's no cycle detection, no null-safety beyond the `None` base case, and no exception handling. This is appropriate for a LeetCode solution where inputs are guaranteed well-formed.

---

## Topics to Explore

- [file] `diameter-of-binary-tree/solution.py` — Uses the same "compute height, detect property" post-order pattern but tracks diameter instead of balance
- [file] `maximum-depth-of-binary-tree/solution.py` — Pure height computation without the sentinel; contrast the simpler version with this dual-purpose variant
- [function] `subtree-of-another-tree/solution.py:isSubtree` — Another tree problem combining two recursive concerns into one traversal
- [general] `sentinel-return-pattern` — How using a special return value (-1, None, etc.) to signal failure compares to exception-based or tuple-based approaches in tree algorithms
- [file] `symmetric-tree/solution.py` — A different tree invariant check (mirror symmetry) that also uses short-circuit recursion

## Beliefs

- `getheight-sentinel-neg1` — `getHeight` returns exactly `-1` for any unbalanced subtree and never any other negative value
- `balanced-tree-linear-time` — The solution visits each node at most once, giving O(n) time complexity via short-circuit propagation of `-1`
- `isbalanced-is-pure-wrapper` — `isBalanced` contains no logic beyond converting `getHeight`'s int result to a bool; all balance-checking logic lives in `getHeight`
- `height-zero-for-none` — The empty tree (`None`) is defined as having height 0, not -1 or 1, which makes the `max(left, right) + 1` formula produce height 1 for a single leaf node

