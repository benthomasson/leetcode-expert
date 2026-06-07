# File: binary-tree-inorder-traversal/solution.py

**Date:** 2026-06-06
**Time:** 15:25

## `binary-tree-inorder-traversal/solution.py`

### Purpose

This file is a self-contained solution to [LeetCode #94 — Binary Tree Inorder Traversal](https://leetcode.com/problems/binary-tree-inorder-traversal/). It defines the tree data structure, implements the traversal algorithm, and includes its own test suite. Within the `leetcode-implementations` repo, it follows the standard pattern: each problem directory has a `solution.py` that both solves and tests.

### Key Components

**`TreeNode`** (line 8-11) — Standard binary tree node with `val`, `left`, `right`. Uses the union type hint `'TreeNode | None'` for children alongside `Optional[TreeNode]` on the function signature — a minor style inconsistency but functionally identical.

**`inorderTraversalHelper(root)`** (line 14-28) — The core algorithm. Returns a `list[int]` of node values in left-root-right order. Despite the name "Helper," this is the primary entry point — there's no wrapper `Solution` class or outer function. The naming likely reflects that this repo strips away the LeetCode `Solution` class boilerplate and exposes a standalone function.

**`TestInorderTraversal`** (line 31-55) — Seven unit tests covering: the canonical LeetCode example, empty tree, single node, left-skewed chain, right-skewed chain, balanced tree, and negative values.

### Patterns

**Iterative stack-based traversal** — This is the Morris-traversal-free, recursion-free approach. It uses an explicit stack to simulate the call stack, which avoids Python's default recursion limit (~1000). The pattern is:

1. Push all left children onto the stack (inner `while current`).
2. Pop, record the value.
3. Move to the right child and repeat.

This is the textbook iterative inorder pattern. The two-while-loop structure (outer: `while current or stack`, inner: `while current`) is the standard idiom.

**No `Solution` class** — Unlike raw LeetCode submissions, this repo uses plain module-level functions. This makes them directly importable and testable without instantiating a class.

### Dependencies

**Imports**: `typing.Optional` and `unittest` — both stdlib, no external dependencies.

**Imported by**: The `test_solution.py` in this same directory imports this file. The massive "Imported By" list in the prompt is misleading — those hundreds of test files don't actually import *this* file. They likely share a common test runner (`run_tests.py` at the repo root) or were auto-detected by a dependency scanner matching on `unittest` usage.

### Flow

```
inorderTraversalHelper(root)
  current = root
  ┌─────────────────────────────┐
  │ while current or stack:     │
  │   ┌───────────────────────┐ │
  │   │ while current:        │ │  ← drill down left
  │   │   push current        │ │
  │   │   current = left      │ │
  │   └───────────────────────┘ │
  │   pop → current             │  ← visit node
  │   append current.val        │
  │   current = right           │  ← pivot to right subtree
  └─────────────────────────────┘
  return result
```

For a tree `[2, 1, 3]`: push 2, push 1 → pop 1 (append), right is None → pop 2 (append), right is 3 → push 3, pop 3 (append). Result: `[1, 2, 3]`.

### Invariants

- **Stack ordering**: At any point, the stack contains ancestors whose left subtrees are being/have been processed but whose values haven't been recorded yet. The top of the stack is always the deepest unvisited ancestor.
- **Termination**: Each node is pushed exactly once and popped exactly once. The outer loop exits when both `current` is `None` and the stack is empty.
- **`None` input is safe**: The outer `while` condition fails immediately, returning `[]`.

### Error Handling

None. The function assumes well-formed `TreeNode` objects or `None`. No validation, no try/except. A cyclic graph would infinite-loop. This is appropriate for a LeetCode solution where inputs are guaranteed valid.

---

## Topics to Explore

- [function] `binary-tree-preorder-traversal/solution.py:preorderTraversalHelper` — Compare the iterative structure; preorder swaps when the value is appended relative to the stack push
- [file] `binary-tree-tilt/solution.py` — Uses recursive traversal with accumulation — contrast with the iterative approach here
- [general] `morris-traversal` — The O(1)-space alternative to the stack-based approach used here; worth understanding the tradeoff
- [file] `convert-sorted-array-to-binary-search-tree/solution.py` — The inverse operation: builds a BST whose inorder traversal is the sorted input
- [file] `run_tests.py` — Understand how these per-directory test suites are discovered and executed across the whole repo

## Beliefs

- `iterative-inorder-o1-stack-space-per-depth` — `inorderTraversalHelper` uses O(h) auxiliary space where h is tree height, via an explicit stack that never holds more than h nodes simultaneously
- `no-solution-class-wrapper` — Solutions in this repo are exposed as module-level functions, not wrapped in a LeetCode-style `Solution` class
- `inorder-visits-each-node-exactly-once` — Every node is pushed onto and popped from the stack exactly once, giving O(n) time complexity
- `none-root-returns-empty-list` — Passing `None` as root produces `[]` without error, enforced by the outer while-loop guard

