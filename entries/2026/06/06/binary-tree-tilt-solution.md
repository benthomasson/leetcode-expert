# File: binary-tree-tilt/solution.py

**Date:** 2026-06-06
**Time:** 15:26

## Binary Tree Tilt — Solution Explanation

### Purpose

This file solves [LeetCode 563: Binary Tree Tilt](https://leetcode.com/problems/binary-tree-tilt/). It defines the `TreeNode` structure and a `findTilt` function that computes the sum of every node's "tilt" in a binary tree, where a node's tilt is `|sum(left subtree) - sum(right subtree)|`.

### Key Components

**`TreeNode`** — Standard binary tree node with `val`, `left`, `right`. Defined locally rather than imported, making the solution self-contained.

**`findTilt(root) -> int`** — The public entry point. Takes a tree root, returns the total tilt across all nodes. Delegates all work to a nested closure.

**`subtree_sum(node) -> int`** — The recursive workhorse. Does two things simultaneously via a single postorder traversal:
1. Returns the sum of all values in the subtree rooted at `node`
2. Accumulates tilt into the `nonlocal total_tilt` variable as a side effect

### Patterns

**Dual-purpose DFS**: The key insight is that computing tilt requires subtree sums, and subtree sums require a full traversal anyway. Rather than traversing once to compute sums and again to compute tilts, `subtree_sum` does both in one pass. The return value carries the subtree sum upward, while tilt accumulates laterally into the closure variable.

**Closure over mutable state**: `total_tilt` is captured via `nonlocal` instead of passing an accumulator parameter or using a mutable container (`[0]`). This is idiomatic Python for tree problems where you need to aggregate across recursive calls without threading state through return values.

**Postorder traversal**: `subtree_sum` processes children before the current node (`left` and `right` computed before `total_tilt += ...`). This is the only viable order — you need both children's sums before you can compute the current node's tilt.

### Dependencies

**Imports**: `annotations` (for PEP 604 `X | None` syntax in the `TreeNode` constructor) and `typing.Optional` (used in the function signatures). The `Optional` import is technically redundant given `from __future__ import annotations` — the `X | None` form would work everywhere — but both styles coexist.

**Imported by**: `binary-tree-tilt/test_solution.py` directly. The massive "Imported By" list in the prompt is noise — those are unrelated test files that happen to share a common test runner import, not actual consumers of this module's `findTilt`.

### Flow

```
findTilt(root)
  └─ total_tilt = 0
  └─ subtree_sum(root)
       ├─ subtree_sum(root.left)   → left_sum
       ├─ subtree_sum(root.right)  → right_sum
       ├─ total_tilt += |left_sum - right_sum|
       └─ return root.val + left_sum + right_sum
  └─ return total_tilt
```

For a leaf node, both `left` and `right` return 0, so its tilt is 0 and its subtree sum is just `node.val`. The tilt contribution grows as you move toward the root, where asymmetry in subtree values gets captured.

### Invariants

- **Null-safe base case**: `subtree_sum(None)` returns 0, meaning null children contribute nothing to sums or tilts.
- **Each node visited exactly once**: Standard postorder DFS — O(n) time, O(h) stack space.
- **Tilt is non-negative**: `abs()` ensures each node's tilt contribution is >= 0.
- **Return value contract**: `subtree_sum` always returns the total value sum of its subtree, never the tilt. Tilt is accumulated separately.

### Error Handling

None. The function assumes well-formed input — a valid `TreeNode` tree or `None`. No cycle detection, no type checking. This is standard for LeetCode solutions where input constraints are guaranteed by the problem.

---

## Topics to Explore

- [file] `binary-tree-tilt/test_solution.py` — Test cases that validate edge cases (empty tree, single node, skewed trees)
- [function] `diameter-of-binary-tree/solution.py:diameterOfBinaryTree` — Same dual-purpose DFS pattern: returns depth while accumulating diameter via closure
- [function] `balanced-binary-tree/solution.py:isBalanced` — Another postorder traversal that computes height while checking a property
- [general] `postorder-accumulator-pattern` — The recurring idiom across this repo of using `nonlocal` + postorder DFS to compute aggregate tree properties in a single pass

## Beliefs

- `findtilt-single-pass` — `findTilt` computes the answer in a single O(n) postorder traversal, not separate passes for sums and tilts
- `subtree-sum-return-contract` — `subtree_sum` returns the sum of all node values in the subtree, not the tilt; tilt is accumulated via side effect into `total_tilt`
- `leaf-tilt-is-zero` — Leaf nodes always contribute 0 to the total tilt because both child subtree sums are 0
- `treenode-self-contained` — `TreeNode` is defined locally in this file rather than imported from a shared module, making each solution independently runnable

