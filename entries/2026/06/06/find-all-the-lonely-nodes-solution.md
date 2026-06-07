# File: find-all-the-lonely-nodes/solution.py

**Date:** 2026-06-06
**Time:** 16:34

## Purpose

This file is the complete solution + test suite for **LeetCode 1469: Find All The Lonely Nodes**. A "lonely node" in a binary tree is any node that is the only child of its parent — i.e., the parent has exactly one child, not two. The file owns the problem definition (`TreeNode`), the solving logic (`Solution.getLonelyNodes`), a tree-construction helper (`build_tree`), and all test cases.

## Key Components

### `TreeNode`
Standard binary tree node with `val`, `left`, `right`. Defines its own type locally rather than importing a shared one — this is the pattern across the repo (each problem is self-contained).

### `Solution.getLonelyNodes(root) -> List[int]`
The core solver. Returns a flat list of values for all lonely nodes in the tree rooted at `root`. Order is not guaranteed (tests sort before comparing).

### `build_tree(vals: list) -> Optional[TreeNode]`
Level-order construction from a list where `None` marks absent nodes. Used exclusively by the test harness. This is the standard LeetCode serialization format.

### `TestGetLonelyNodes`
Eight test cases covering the three LeetCode examples, edge cases (single node, `None` root, full binary tree with zero lonely nodes), and structural extremes (pure left chain, pure right chain).

## Patterns

**Closure-based DFS**: The inner `dfs` function captures `result` from the enclosing scope rather than passing it as a parameter or using an instance variable. This is idiomatic Python for tree problems — it avoids return-value plumbing while keeping the recursion signature clean.

**Parent-perspective detection**: Loneliness is checked from the *parent* node, not from the child. At each node, the code checks whether exactly one of `left`/`right` exists, and if so, appends that child's value. This avoids needing to track "was I the only child?" state during recursion.

**Self-contained module**: `TreeNode`, solution, builder, and tests all live in one file with inline `unittest.main()`. No cross-problem imports.

## Dependencies

**Imports**: `typing.List`, `typing.Optional`, `unittest` — all stdlib.

**Imported by**: The "Imported By" list in the prompt is misleading. Those ~400+ test files don't actually import *this* file — they follow the same structural pattern. The real dependency graph for this file is zero inbound imports; it's a standalone leaf module.

## Flow

1. `getLonelyNodes` initializes an empty `result` list.
2. `dfs` is called on the root.
3. At each node, the two `if`/`elif` branches detect one-child parents:
   - `left and not right` → left child is lonely, append `node.left.val`
   - `right and not left` → right child is lonely, append `node.right.val`
   - Both children present or both absent → no lonely child at this node.
4. Recurse into both subtrees (both calls run regardless of the lonely-check outcome).
5. Return accumulated `result`.

The traversal is preorder (check parent, then recurse left, then right), but order doesn't matter — the problem accepts any order.

## Invariants

- The root node is **never** lonely (it has no parent), so it's never added to the result. The parent-perspective detection enforces this structurally — no special-casing needed.
- `dfs(None)` is a no-op, so null subtrees are safe without guards at call sites.
- The `if`/`elif` structure is mutually exclusive — a node with both children hits neither branch. A node with zero children also hits neither (both `node.left` and `node.right` are falsy).

## Error Handling

None. The function assumes valid `TreeNode` inputs (or `None`). No validation of node values, no cycle detection, no depth limits. This is appropriate for LeetCode — the constraint guarantees are external.

`build_tree` has a subtle issue: if `vals` has an odd length > 1 and the last element would be a left child, the `i += 1` after the right-child block still executes, which is fine — the `while i < len(vals)` guard on the next iteration prevents out-of-bounds. But the inner `if i < len(vals)` guard before the right-child assignment is necessary to avoid an `IndexError` when the list ends on a left child.

## Topics to Explore

- [file] `find-all-the-lonely-nodes/test_solution.py` — Separate test file that may test the same solution with different cases or import structure
- [function] `balanced-binary-tree/solution.py:isBalanced` — Another tree DFS that uses the closure pattern but returns computed values up the recursion stack, contrasting with the append-to-list approach here
- [general] `lonely-vs-leaf-distinction` — Lonely nodes and leaf nodes are different concepts: a leaf has no children, a lonely node has no sibling. A node can be both (only child with no children of its own)
- [file] `cousins-in-binary-tree/solution.py` — Related tree problem that also reasons about parent-child relationships and sibling structure
- [general] `level-order-tree-serialization` — The `build_tree` helper implements LeetCode's standard serialization; understanding it is key to writing tree tests across the repo

## Beliefs

- `lonely-nodes-never-includes-root` — The root node is structurally excluded from results because loneliness is detected from the parent's perspective, and the root has no parent.
- `dfs-visits-all-nodes-exactly-once` — Every non-null node is visited exactly once via preorder traversal, giving O(n) time complexity.
- `lonely-detection-is-xor-like` — A child is appended to results if and only if exactly one of (left, right) exists at the parent — this is a logical XOR on child presence.
- `build-tree-uses-bfs-construction` — `build_tree` constructs the tree level-by-level using a queue, matching LeetCode's standard level-order serialization format where `None` marks absent nodes.

