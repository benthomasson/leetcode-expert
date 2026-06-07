# File: univalued-binary-tree/solution.py

**Date:** 2026-06-06
**Time:** 19:37

## `univalued-binary-tree/solution.py`

### Purpose

Solves [LeetCode #965 — Univalued Binary Tree](https://leetcode.com/problems/univalued-binary-tree/). The file is a self-contained module: it defines the tree node type, the solution, and a full test suite. Its responsibility is to determine whether every node in a binary tree holds the same value.

### Key Components

**`TreeNode`** — Standard binary tree node with `val`, `left`, `right`. This is a local definition (not imported from a shared module), which is the convention across this repo — each solution is self-contained.

**`Solution.isUnivalTree(root)`** — The entry point. Captures `root.val` as the target, then delegates to a nested `dfs` closure that recursively checks every node against that target. Returns `True` for an empty tree (the vacuous truth case).

**`dfs(node)`** (nested in `isUnivalTree`) — Recursive DFS that short-circuits on the first mismatch via `and` chaining: `node.val == target and dfs(node.left) and dfs(node.right)`. If the left subtree contains a mismatch, the right subtree is never visited.

**`TestIsUnivalTree`** — Eight test cases covering: single node, all-same tree, mismatches at various depths (child, deep leaf, right subtree leaf), two-node trees (same/different), and `None` root.

### Patterns

- **Closure over target value**: Rather than passing `target` as a parameter through every recursive call, `dfs` closes over `target` from the enclosing scope. This is a common Python idiom that keeps the recursive signature clean.
- **Short-circuit recursion**: The `and` chain in `dfs` exploits Python's lazy evaluation — the moment any node fails the equality check, recursion stops. This gives O(1) best-case when the root's immediate child differs.
- **Self-contained solution files**: `TreeNode` is defined locally rather than imported from a shared module. Every problem directory in this repo follows this pattern, making each solution runnable in isolation.

### Dependencies

**Imports**: `typing.Optional` (for the type annotation on `root`) and `unittest` (for the test suite). No project-internal imports.

**Imported by**: The `test_solution.py` file in the same directory. The massive "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that happen to share a common filename pattern; they don't actually import from this file.

### Flow

1. `isUnivalTree` is called with a root node.
2. If `root` is `None`, return `True` immediately.
3. Capture `root.val` as `target`.
4. Call `dfs(root)`, which recursively visits every node in pre-order (node → left → right).
5. At each node: if `None`, return `True` (base case). Otherwise, check `node.val == target` and recurse into both children.
6. The `and` chain short-circuits on the first `False`.

**Complexity**: O(n) time, O(h) space (call stack depth = tree height). Worst case for a skewed tree is O(n) stack frames.

### Invariants

- `target` is always set to the root's value before any traversal begins — this is the single reference value the entire tree is compared against.
- An empty tree (None root) is defined as uni-valued. This matches LeetCode's contract.
- `dfs` never mutates the tree. The operation is purely read-only.

### Error Handling

None. The function assumes valid input per LeetCode conventions — `root` is either `None` or a valid `TreeNode`. No explicit exception handling, no input validation. If called with a non-TreeNode argument, it would raise `AttributeError` on attribute access, which is appropriate for an internal algorithm module.

## Topics to Explore

- [file] `univalued-binary-tree/test_solution.py` — The companion test file; check whether it duplicates or extends the inline tests
- [function] `symmetric-tree/solution.py:isSymmetric` — Another tree DFS that uses a similar recursive pattern but compares two subtrees against each other instead of against a fixed value
- [function] `evaluate-boolean-binary-tree/solution.py:evaluateTree` — A tree DFS that returns computed values rather than a boolean check, showing how the same recursive skeleton adapts to different problems
- [general] `tree-traversal-patterns` — Compare pre-order DFS (used here), BFS (used in `average-of-levels-in-binary-tree`), and iterative approaches across the repo's tree solutions

## Beliefs

- `dfs-short-circuits-on-mismatch` — `dfs` stops traversing the moment it finds a node whose value differs from the root's value, due to Python's `and` short-circuit evaluation
- `none-root-is-univalued` — `isUnivalTree(None)` returns `True`, treating the empty tree as vacuously uni-valued
- `target-is-root-val` — The comparison target is always `root.val`, captured once before traversal begins; no other reference value is considered
- `no-shared-tree-node` — `TreeNode` is defined locally in the solution file rather than imported from a shared module, matching the repo's self-contained convention

