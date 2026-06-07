# File: closest-binary-search-tree-value/solution.py

**Date:** 2026-06-06
**Time:** 15:47

## Purpose

This file implements LeetCode problem **270 — Closest Binary Search Tree Value**. Given a BST and a float target, it finds the node value closest to the target, breaking ties by returning the smaller value. The file is self-contained: it defines the tree data structure, the solution, a tree builder helper, and a full test suite.

## Key Components

### `TreeNode`
Standard BST node with `val`, `left`, `right`. Uses the union-style type hint (`"TreeNode | None"`) for children alongside `Optional[TreeNode]` on the solution method — a minor inconsistency but functionally equivalent.

### `Solution.closestValue(root, target) -> int`
The core algorithm. Walks the BST iteratively, maintaining the best candidate in `closest`. At each node it:

1. **Updates `closest`** if the current node is strictly nearer, or equally near but numerically smaller (the tie-break rule).
2. **Chooses a direction** — goes left if `target < node.val`, right otherwise — pruning the half of the tree that can't contain a closer value.

This is O(h) time, O(1) space, where h is the tree height.

### `_build(vals) -> Optional[TreeNode]`
Module-level helper that constructs a BST from a level-order list (BFS encoding), where `None` entries represent absent children. Used exclusively by the test suite.

### `TestClosestValue`
Eight test cases covering: the LeetCode examples, exact match, tie-breaking (equidistant values), left-only and right-only skewed trees, and extreme targets (far positive/negative).

## Patterns

- **Iterative BST traversal** instead of recursion — avoids stack overhead and makes the O(1) space guarantee explicit.
- **BST-directed search** — the `left if target < node.val else right` decision leverages BST ordering to skip irrelevant subtrees, the same pattern as standard BST lookup.
- **Self-contained problem file** — solution, data structure, and tests all in one module. This matches the repo's convention of one directory per problem with `solution.py` and `test_solution.py`.

## Dependencies

**Imports:** `typing.Optional` (type hint), `unittest` (test framework). No project-internal dependencies.

**Imported by:** The `test_solution.py` in this same directory. The massive "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that happen to share the same module name pattern; they don't actually import *this* file.

## Flow

```
closestValue(root=4, target=3.71)
  closest = 4
  node = 4  →  |4 - 3.71| = 0.29, closest stays 4
                target < 4 → go left
  node = 2  →  |2 - 3.71| = 1.71 > 0.29, closest stays 4
                target > 2 → go right
  node = 3  →  |3 - 3.71| = 0.71 > 0.29, closest stays 4
                target > 3 → go right
  node = None → return 4
```

The key insight: the BST property guarantees that once you choose a direction, all values in the discarded subtree are farther from the target than the current node — so you never miss the optimal answer.

## Invariants

- **`root` is non-null** — the method dereferences `root.val` on the first line with no null check. An empty tree will raise `AttributeError`.
- **Tie-break: smaller wins** — enforced by the compound condition on lines 23–24. When distances are equal, the candidate with the smaller `val` is preferred.
- **BST ordering assumed** — the directional choice (`left if target < node.val else right`) is only correct if the tree satisfies the BST invariant. A non-BST input will silently produce wrong results.

## Error Handling

None. The code assumes valid input (non-null root, valid BST). There's no defensive checking — which is standard for LeetCode solutions where constraints guarantee valid input.

The `_build` helper also has a subtle issue: if `vals` has an odd number of elements after the root, the inner loop's second `if i < len(vals)` check prevents an out-of-bounds access, but it does mean trailing `None` values are silently ignored.

## Topics to Explore

- [file] `closest-binary-search-tree-value/test_solution.py` — The separate test file that imports this solution; see how it differs from the inline tests here
- [function] `closest-binary-search-tree-value/solution.py:_build` — Level-order tree construction is reused across many BST problem test suites in this repo
- [file] `search-in-a-binary-search-tree/solution.py` — Same iterative BST traversal pattern applied to a simpler search problem
- [file] `minimum-absolute-difference-in-bst/solution.py` — A related BST problem that likely uses in-order traversal instead of directed search
- [general] `bst-iterative-vs-recursive` — When iterative traversal (as used here) wins over recursive approaches in BST problems

## Beliefs

- `closest-value-is-o-h-time` — `closestValue` visits at most one node per tree level, making it O(h) time and O(1) space
- `closest-value-requires-non-null-root` — Passing `root=None` raises `AttributeError` because the first line unconditionally accesses `root.val`
- `tie-break-favors-smaller` — When two node values are equidistant from the target, the solution returns the numerically smaller value
- `bst-ordering-assumed-not-validated` — The directional pruning (`left if target < node.val else right`) produces correct results only if the input is a valid BST; no validation is performed

