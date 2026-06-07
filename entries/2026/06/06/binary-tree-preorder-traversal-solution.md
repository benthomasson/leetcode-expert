# File: binary-tree-preorder-traversal/solution.py

**Date:** 2026-06-06
**Time:** 15:26

## Purpose

This file implements [LeetCode 144 — Binary Tree Preorder Traversal](https://leetcode.com/problems/binary-tree-preorder-traversal/). It owns the `TreeNode` definition, the iterative traversal algorithm, and its own unit tests — a self-contained solution module following the repo's per-problem directory convention.

## Key Components

### `TreeNode` (lines 7–10)
Standard binary tree node with `val`, `left`, `right`. This is the canonical definition used across the repo — the massive "Imported By" list shows that hundreds of test files reference this module (likely importing `TreeNode` for test setup).

### `Solution.preorderTraversal` (lines 14–28)
Returns node values in **preorder** (root → left → right) using an explicit stack rather than recursion.

**Contract:** accepts `Optional[TreeNode]`, returns `List[int]`. Returns `[]` for a null root.

## Patterns

**Iterative DFS with a stack.** The key trick is push order: right child is pushed *before* left child (lines 25–28). Since stacks are LIFO, this guarantees left is popped (and thus visited) first — producing root-left-right order without recursion.

This avoids Python's default recursion limit (~1000), making it safe for deep/skewed trees up to memory limits.

**Self-contained solution module.** Tests live in the same file (below the `# --- Tests ---` marker) and also in a separate `test_solution.py`. The file doubles as both importable module and standalone test runner via `if __name__ == "__main__"`.

## Dependencies

**Imports:** `typing.List`, `typing.Optional`, `unittest` — all stdlib, no external deps.

**Imported by:** The `TreeNode` class from this file is imported by 400+ test files across the repo. This makes it a de facto shared definition — any change to `TreeNode`'s constructor signature would be a breaking change across most of the codebase.

## Flow

1. Guard clause: null root → return `[]`
2. Initialize `result = []`, seed `stack = [root]`
3. Loop: pop node, append its value to result
4. Push right child (if exists), then left child (if exists)
5. Stack drains naturally when all nodes are visited → return `result`

The data transformation is: `TreeNode` graph → flat `List[int]` via depth-first, preorder walk.

## Invariants

- **Visit order:** Every node's value is appended before any of its descendants'. Right is always pushed before left, so left subtree is always fully explored before right.
- **No duplicates/omissions:** Each node enters and leaves the stack exactly once.
- **Null safety:** Both the root check (line 22) and child checks (lines 25–28) guard against `None`.

## Error Handling

None explicit — the function assumes a well-formed tree (no cycles, no non-`TreeNode` objects). An infinite cycle in the tree would cause an infinite loop. There's no input validation beyond the null-root guard; this is standard for LeetCode solutions where inputs are guaranteed valid.

## Topics to Explore

- [file] `binary-tree-inorder-traversal/solution.py` — Compare the iterative stack technique for inorder (requires tracking "go left" vs "process" states, making it more complex)
- [file] `binary-tree-paths/solution.py` — Uses the same tree structure but must track full root-to-leaf paths, showing how traversal adapts to different output shapes
- [function] `construct-string-from-binary-tree/solution.py:Solution.tree2str` — Another preorder walk, but with parenthesization rules that complicate the right-child-omission logic
- [general] `iterative-vs-recursive-tree-traversal` — Why this repo consistently uses iterative approaches (stack safety, interview preference) vs the 3-line recursive version

## Beliefs

- `preorder-iterative-push-order` — Right child is pushed before left child to ensure left subtree is visited first in the LIFO stack
- `treenode-shared-definition` — `TreeNode` from this file is imported by 400+ test files, making it the repo's de facto shared binary tree node class
- `preorder-null-root-returns-empty` — `preorderTraversal(None)` returns `[]`, not `None` or an error
- `preorder-linear-time-space` — The algorithm visits each node exactly once (O(n) time) and uses O(n) stack space in the worst case (skewed tree)

