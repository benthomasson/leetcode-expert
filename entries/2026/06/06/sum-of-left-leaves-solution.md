# File: sum-of-left-leaves/solution.py

**Date:** 2026-06-06
**Time:** 19:23

## `sum-of-left-leaves/solution.py`

### Purpose

Solves [LeetCode 404 — Sum of Left Leaves](https://leetcode.com/problems/sum-of-left-leaves/). The file owns the `TreeNode` definition and the traversal logic to sum only those leaf nodes that are left children of their parent.

### Key Components

**`TreeNode`** — Standard binary tree node with `val`, `left`, `right`. Self-contained (no shared tree utility imported), which is the convention across this repo — each problem directory defines its own data structures.

**`sum_of_left_leaves(root)`** — Entry point. Delegates immediately to a nested `dfs` helper, passing `is_left=False` for the root (the root is never a "left leaf" even if it has no children).

**`dfs(node, is_left)`** — Recursive DFS that threads a boolean through the call stack to track whether the current node was reached via a left edge. Three cases:
1. `node is None` → return 0 (base case, stops recursion)
2. Node is a leaf (`left is None and right is None`) → return `node.val` if `is_left`, else 0
3. Internal node → recurse left with `True`, right with `False`, sum both

### Patterns

**Parent-context threading via parameter.** The key design choice: rather than checking `node.left` for leaf-ness from the parent, the code passes a boolean *down* so each node knows its own relationship to its parent. This is a clean alternative to the "look-ahead" approach where the parent inspects `node.left.left is None and node.left.right is None`. Both work; this one keeps the leaf-detection logic at the leaf itself.

**Nested helper function.** `dfs` is defined inside `sum_of_left_leaves` to keep the `is_left` parameter out of the public API. The caller shouldn't need to know about the internal tracking mechanism.

### Dependencies

**Imports:** Only `from __future__ import annotations` — enables PEP 604 union syntax (`TreeNode | None`) in the type hints for Python 3.9 compatibility.

**Imported by:** `sum-of-left-leaves/test_solution.py` directly. The massive "Imported By" list in the prompt is misleading — those are test files across the entire repo that happen to share a similar import pattern, not actual consumers of this module.

### Flow

```
sum_of_left_leaves(root)
  └─ dfs(root, is_left=False)
       ├─ dfs(root.left, True)
       │    ├─ if leaf: return val    ← counted
       │    └─ if internal: recurse children
       └─ dfs(root.right, False)
            ├─ if leaf: return 0      ← not counted
            └─ if internal: recurse children
```

Every node is visited exactly once. Values bubble up additively — each `dfs` call returns the sum of left leaves in its subtree.

### Invariants

- The root node is never counted as a left leaf (seeded with `is_left=False`).
- Only leaves (no children) contribute to the sum, and only if they're left children.
- `None` nodes contribute 0 — the recursion handles empty trees and missing children uniformly.

### Error Handling

None. The function assumes valid input per LeetCode convention — `root` is either `None` or a well-formed `TreeNode`. No cycles, no invalid values. A `None` root returns 0, which is the correct answer for an empty tree.

**Complexity:** O(n) time, O(h) stack space where h is tree height (O(n) worst case for skewed trees).

## Topics to Explore

- [file] `sum-of-left-leaves/test_solution.py` — See which edge cases are covered (empty tree, single node, all-left-spine, all-right-spine)
- [function] `binary-tree-tilt/solution.py:findTilt` — Another DFS that threads accumulated state through return values rather than parameters — compare approaches
- [file] `sum-of-root-to-leaf-binary-numbers/solution.py` — Similar parent-to-child context threading, but accumulates a running value instead of a boolean
- [general] `left-child-vs-right-child-patterns` — Several tree problems distinguish left/right children; compare how `path-sum`, `binary-tree-paths`, and this solution handle the asymmetry

## Beliefs

- `left-leaf-root-never-counted` — A single-node tree (root with no children) returns 0 because the root is seeded with `is_left=False`
- `dfs-visits-every-node-once` — The traversal is a standard pre-order DFS with O(n) time complexity and no memoization or pruning
- `leaf-detection-at-leaf` — Leaf-ness is determined at the node itself (`left is None and right is None`), not by the parent looking ahead — the `is_left` boolean carries parent context down
- `no-shared-tree-node` — `TreeNode` is defined locally rather than imported from a shared utility, consistent with the per-problem isolation pattern in this repo

