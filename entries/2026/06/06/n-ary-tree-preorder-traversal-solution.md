# File: n-ary-tree-preorder-traversal/solution.py

**Date:** 2026-06-06
**Time:** 18:11

## N-ary Tree Preorder Traversal

### Purpose

This file solves [LeetCode 589 — N-ary Tree Preorder Traversal](https://leetcode.com/problems/n-ary-tree-preorder-traversal/). It defines the `Node` data structure for an n-ary tree and implements an iterative preorder traversal that returns node values in root-first, left-to-right order. It's a standalone solution module following the repo's one-problem-per-directory convention.

### Key Components

**`Node`** — The n-ary tree node. Each node holds an integer `val` and a list of `children` (defaulting to `[]` if `None` is passed). Unlike a binary tree's `left`/`right`, children is an arbitrarily-sized list.

**`preorder(root) -> List[int]`** — The solver. Takes an optional root node, returns a flat list of values in preorder (parent before children, left-to-right among siblings). Returns `[]` for an empty tree.

### Patterns

**Iterative DFS with an explicit stack.** Rather than using recursion (which would be the more natural expression of preorder traversal), this uses a `while stack` loop. The key trick is on the last line of the loop body:

```python
stack.extend(reversed(node.children))
```

Children are pushed in reverse order so that when popped (LIFO), the leftmost child comes off first. This preserves left-to-right visitation order without recursion. This is the standard iterative preorder idiom — identical to what you'd do for a binary tree with `stack.append(right); stack.append(left)`, generalized to n children.

**Top-level function, not a class method.** The repo's convention is a bare function rather than wrapping it in LeetCode's `class Solution`. This makes it directly importable by test files.

### Dependencies

**Imports:** `List` and `Optional` from `typing` — standard type annotations, no external libraries.

**Imported by:** The test file `n-ary-tree-preorder-traversal/test_solution.py` imports this directly. The massive "Imported By" list in the prompt is misleading — those are other test files that share the same import *pattern*, not files that actually import from this module.

### Flow

1. Guard clause: if `root` is `None`, return `[]` immediately.
2. Initialize `result = []` and seed the stack with `[root]`.
3. Pop a node, append its value to `result`.
4. Push its children in reverse order onto the stack.
5. Repeat until the stack is empty.
6. Return `result`.

For a tree `1 -> [3 -> [5, 6], 2, 4]`, the stack evolves as:
- `[1]` → pop 1, push `[3, 2, 4]` reversed → stack `[4, 2, 3]`
- pop 3, push `[5, 6]` reversed → stack `[4, 2, 6, 5]`
- pop 5 (leaf) → stack `[4, 2, 6]`
- ... yielding `[1, 3, 5, 6, 2, 4]`

### Invariants

- **Visit order**: a node's value is appended before any of its descendants are processed (preorder guarantee).
- **Sibling order**: `reversed()` + LIFO pop ensures children are visited left-to-right as they appear in the `children` list.
- **Termination**: each node is pushed exactly once and popped exactly once; the stack strictly shrinks toward empty.

### Error Handling

None. The function trusts its input — `node.children` is always iterable (guaranteed by the `Node` constructor's default), and `node.val` is always an `int`. No validation, no exceptions. This is appropriate for a LeetCode solution where the problem guarantees well-formed input.

## Topics to Explore

- [file] `n-ary-tree-preorder-traversal/test_solution.py` — See how the `Node` tree is constructed in tests and what edge cases are covered
- [file] `n-ary-tree-postorder-traversal/solution.py` — Compare the postorder variant; the stack manipulation differs in an instructive way
- [file] `binary-tree-preorder-traversal/solution.py` — Compare the binary-tree specialization to see how `left`/`right` maps to the generalized `children` list approach
- [file] `maximum-depth-of-n-ary-tree/solution.py` — Another n-ary tree problem; likely reuses the same `Node` structure with a different traversal goal
- [general] `iterative-vs-recursive-dfs` — When iterative DFS matters: stack overflow risk on deep trees, and how the explicit stack mirrors the call stack

## Beliefs

- `preorder-returns-empty-for-none` — `preorder(None)` returns `[]`, not `None` or an error
- `children-visited-left-to-right` — The `reversed()` + LIFO pop guarantees children are visited in their original list order, not reversed
- `iterative-not-recursive` — The solution uses an explicit stack loop, not recursion, so it won't hit Python's default 1000-frame recursion limit on deep trees
- `node-default-children-empty-list` — `Node(val=5)` (no children arg) gets `self.children = []`, not `None`, so iteration is always safe

