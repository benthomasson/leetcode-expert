# File: path-sum/solution.py

**Date:** 2026-06-06
**Time:** 18:31

## `path-sum/solution.py`

### Purpose

This file implements [LeetCode 112 - Path Sum](https://leetcode.com/problems/path-sum/), a classic binary tree problem. It determines whether any root-to-leaf path in a binary tree has node values that sum to a given target. The file is self-contained: it defines the tree data structure, the solution function, and a comprehensive test suite.

### Key Components

**`TreeNode`** — Standard binary tree node with `val`, `left`, and `right`. This is the local definition used by both the solution and tests; it mirrors LeetCode's provided class.

**`hasPathSum(root, targetSum) -> bool`** — The core algorithm. Contract:
- Accepts a nullable tree root and an integer target.
- Returns `True` iff there exists a path from root to a **leaf** (both children `None`) where the sum of all node values equals `targetSum`.
- Returns `False` for an empty tree (`root is None`), even if `targetSum` is 0.

**`TestPathSum`** — Nine test cases covering the key boundaries: standard trees, empty tree, single node, negative values, left-only paths, zero target, and the critical edge case where the sum matches at a non-leaf node (which must return `False`).

### Patterns

**Recursive subtraction** — Rather than accumulating a running sum downward, the function subtracts the current node's value from `targetSum` and passes the `remainder` to children. At a leaf, it checks `root.val == targetSum` (i.e., the remainder equals the leaf's value). This avoids threading an accumulator parameter.

**Base-case-first recursion** — The function handles three cases in order: (1) null node → `False`, (2) leaf node → equality check, (3) internal node → recurse on children with short-circuit `or`. This ordering ensures the null check acts as both the "empty tree" case and the guard for recursive calls on absent children.

### Dependencies

**Imports:** Only stdlib — `annotations` (for deferred type evaluation of the self-referential `TreeNode`), `unittest`, and `typing.Optional`.

**Imported by:** `path-sum/test_solution.py` and hundreds of other test files across the repo. The "Imported By" list in the prompt is misleading — those other test files don't actually import from this file. They appear because the repo's dependency scanner likely flagged all test files sharing the same `TreeNode` pattern. The real consumer is `path-sum/test_solution.py`.

### Flow

```
hasPathSum(root, 22)
  root=5, not None, not leaf → remainder = 22-5 = 17
    hasPathSum(left=4, 17)
      not None, not leaf → remainder = 17-4 = 13
        hasPathSum(left=11, 13)
          not None, not leaf → remainder = 13-11 = 2
            hasPathSum(left=7, 2) → leaf, 7≠2 → False
            hasPathSum(right=2, 2) → leaf, 2==2 → True  ← short-circuits
          → True
        → True (short-circuits, never checks right=None)
      → True
    → True (short-circuits, never checks right=8 subtree)
```

The `or` short-circuits: once a valid path is found in the left subtree, the right subtree is never explored.

### Invariants

1. **Leaf-only matching** — A path must terminate at a leaf. Internal nodes whose cumulative sum equals the target are explicitly rejected. `test_non_leaf_sum_match` validates this: a tree `1→2→3` with target `1` returns `False` because node `1` is not a leaf.

2. **Null tree is always False** — Even `hasPathSum(None, 0)` returns `False`. An empty tree has no paths, therefore no path can match any target.

3. **No mutation** — The tree and target are never modified. The `remainder` is a new local variable each frame.

### Error Handling

None. The function assumes valid inputs (a well-formed tree or `None`, and an integer target). No exceptions are raised or caught. This is appropriate for a LeetCode solution where inputs are guaranteed by the problem constraints.

---

## Topics to Explore

- [file] `path-sum/plan.md` — The planning document for this solution; reveals the approach selection process and any alternatives considered
- [file] `balanced-binary-tree/solution.py` — Another tree recursion that returns a composite result (height + balance); compare the recursion pattern to the simple boolean propagation here
- [function] `minimum-depth-of-binary-tree/solution.py:minDepth` — The dual problem: instead of checking if a target sum exists along any root-to-leaf path, it finds the shortest such path; same leaf-detection logic applies
- [general] `root-to-leaf-vs-any-path` — LeetCode 437 (Path Sum III) removes the root-to-leaf constraint, requiring prefix sums; understanding why that changes the algorithm from O(n) recursion to O(n) hash-map is valuable
- [file] `binary-tree-paths/solution.py` — Enumerates all root-to-leaf paths as strings; shows the accumulator-based alternative to the subtraction pattern used here

## Beliefs

- `path-sum-leaf-only` — `hasPathSum` only returns `True` when the matching path ends at a leaf node (both children `None`); partial paths to internal nodes are never accepted
- `path-sum-null-false` — An empty tree (`root is None`) always returns `False` regardless of `targetSum`, including `targetSum=0`
- `path-sum-subtraction-pattern` — The algorithm subtracts each node's value from the remaining target rather than accumulating a sum, avoiding an extra parameter
- `path-sum-short-circuit` — The `or` in the recursive return means the right subtree is never explored if the left subtree already contains a valid path

