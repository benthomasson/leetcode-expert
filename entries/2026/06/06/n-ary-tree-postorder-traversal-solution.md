# File: n-ary-tree-postorder-traversal/solution.py

**Date:** 2026-06-06
**Time:** 18:10

## Purpose

This file implements LeetCode problem "N-ary Tree Postorder Traversal" — returning node values in postorder (children before parent) for a tree where each node can have an arbitrary number of children. It owns the `Node` class definition, the traversal algorithm, and inline tests.

## Key Components

**`Node` class (lines 5-8)** — Represents an n-ary tree node with `val: int` and `children: List[Node]`. The constructor defaults `children` to an empty list (avoiding the mutable default argument pitfall by using `None` as the sentinel).

**`postorder(root)` (lines 11-22)** — The core algorithm. Takes an optional root node, returns a flat list of values in postorder sequence. Returns `[]` for a null root.

## Patterns

The implementation uses the **iterative reverse-preorder trick** rather than recursion or a true iterative postorder with visited markers:

1. Push root onto a stack.
2. Pop a node, append its value to `result`, push all its children left-to-right.
3. Reverse the result at the end.

This works because the loop visits nodes in a modified preorder (root, then rightmost child first due to stack LIFO over the children list). Reversing that yields postorder. The key insight: `stack.extend(node.children)` pushes children in left-to-right order, so the rightmost child is popped first — producing root-right-left traversal. Reversing gives left-right-root, which is postorder.

This is a well-known idiom for postorder traversal that avoids the complexity of tracking "visited" state on the stack.

## Dependencies

**Imports**: `typing.List`, `typing.Optional`, `unittest` — all stdlib, no external dependencies.

**Imported by**: The `test_solution.py` in this same directory, plus hundreds of other `test_solution.py` files across the repo. The "Imported By" list in the prompt is misleading — those other test files don't actually import *this* module. That list appears to be an artifact of the repo's structure or tooling, not real import relationships.

## Flow

```
postorder(root)
  → empty check → return []
  → initialize stack=[root], result=[]
  → loop: pop node, record val, push all children
  → reverse result → return
```

For a tree `1 -> [3(->5,6), 2, 4]`:
- Stack pops: 1, 4, 2, 3, 6, 5
- Result before reverse: `[1, 4, 2, 3, 6, 5]`
- After reverse: `[5, 6, 3, 2, 4, 1]` — correct postorder

## Invariants

- **Null safety**: `if not root` guards the only entry point; children default to `[]` so `stack.extend` never fails on a leaf.
- **Ordering**: `stack.extend(node.children)` preserves left-to-right child order on the stack, which means right-to-left pop order, which after reversal produces left-to-right postorder.
- **O(n) time, O(n) space**: Every node is pushed/popped exactly once. The result list and stack together hold at most all nodes.

## Error Handling

None. The function assumes well-formed tree input — no cycles, no null children in the list. This is standard for LeetCode solutions where input constraints are guaranteed.

## Topics to Explore

- [file] `n-ary-tree-preorder-traversal/solution.py` — Compare with preorder; likely uses the same stack approach without the reversal step
- [function] `binary-tree-preorder-traversal/solution.py:preorderTraversal` — See how the same iterative stack technique applies to binary trees
- [general] `iterative-vs-recursive-tree-traversal` — Understanding when the reverse-preorder trick breaks down (e.g., when you need to process nodes during traversal, not just collect values)
- [file] `maximum-depth-of-n-ary-tree/solution.py` — Another n-ary tree problem; compare how the same `Node` class is redefined per-problem vs shared

## Beliefs

- `postorder-uses-reverse-preorder` — The postorder function computes a modified preorder traversal and reverses the result, rather than using recursion or a visited-node tracking approach
- `node-children-default-empty-list` — `Node.__init__` avoids Python's mutable default argument bug by using `None` as the default and replacing with `[]` inside the constructor
- `stack-extend-preserves-child-order` — `stack.extend(node.children)` pushes children left-to-right so rightmost is popped first, producing root-right-left order that reverses to correct postorder
- `no-shared-node-class` — Each solution directory defines its own `Node`/`TreeNode` class rather than importing from a shared module

