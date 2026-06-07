# File: evaluate-boolean-binary-tree/solution.py

**Date:** 2026-06-06
**Time:** 16:29

## Purpose

This file solves [LeetCode 2331 — Evaluate Boolean Binary Tree](https://leetcode.com/problems/evaluate-boolean-binary-tree/). It defines the tree node structure, the recursive evaluator, a test helper for building trees from level-order lists, and a full test suite — all in a single self-contained module.

## Key Components

### `TreeNode` (class)
Standard binary tree node with `val`, `left`, `right`. Used both as the input structure for the evaluator and by the test helper. The `val` field carries dual semantics: for leaf nodes it's `0` (False) or `1` (True); for internal nodes it's `2` (OR) or `3` (AND).

### `evalTree(root) -> bool`
The core algorithm. Recursively evaluates a **full binary tree** — every node is either a leaf (both children `None`) or has exactly two children. The recursion bottoms out when `root.left is None`, returning `bool(root.val)`. For internal nodes, it evaluates both subtrees then applies OR (val 2) or AND (val 3).

### `_build_tree(vals) -> Optional[TreeNode]`
Test utility that constructs a `TreeNode` tree from a level-order list (BFS order), where `None` entries represent absent children. Uses a queue-based approach identical to LeetCode's own serialization format.

### `TestEvalTree` (unittest.TestCase)
Nine test cases covering: both LeetCode examples, single-node trees, all four boolean combinations for AND/OR, nested multi-level trees, and a chained AND structure.

## Patterns

- **Recursive post-order traversal**: Evaluate children before applying the current node's operator — standard for expression-tree evaluation.
- **Implicit base-case via full-tree invariant**: The code checks only `root.left is None` to detect a leaf, relying on the problem's guarantee that the tree is full (no node has exactly one child). It does not check `root.right`.
- **Single-file module**: Solution, data structure, helper, and tests all colocate — consistent with every other problem directory in this repo.
- **Convention-based val encoding**: `0/1` = boolean literals, `2` = OR, `3` = AND. This mapping comes directly from the problem statement and is hardcoded rather than using an enum or constant.

## Dependencies

**Imports**: `annotations` (PEP 604 union syntax), `unittest`, `typing.Optional`. No external libraries.

**Imported by**: The `test_solution.py` file in this same directory imports from it. The massive "Imported By" list in the prompt is misleading — those are other problems' test files that share the same `test_solution.py` naming pattern; they don't actually import *this* file.

## Flow

1. Caller passes a `TreeNode` root to `evalTree`.
2. If the node is a leaf (`left is None`), return `bool(val)` — converts `0 → False`, `1 → True`.
3. Otherwise, recurse into `left` and `right` subtrees.
4. Apply the operator: `val == 2` → `left or right`; anything else (implicitly `val == 3`) → `left and right`.
5. Python's `or`/`and` operators short-circuit, but since both subtrees are already evaluated before the operator check, no short-circuit optimization actually occurs.

## Invariants

- **Full binary tree**: The code assumes every non-leaf has exactly two children. If a node has `left=None` but `right` is not `None`, the code treats it as a leaf and ignores the right subtree — silent wrong answer, not a crash.
- **Val encoding**: Leaves must be `0` or `1`. Internal nodes must be `2` or `3`. A val of `2` triggers OR; *any other value* falls through to AND (no explicit `val == 3` check).
- **Non-null root**: `evalTree` accesses `root.left` immediately — passing `None` raises `AttributeError`.

## Error Handling

None. The function trusts its input completely, consistent with LeetCode's problem constraints. No validation of val ranges, tree structure, or null root.

## Topics to Explore

- [file] `evaluate-boolean-binary-tree/test_solution.py` — See how the separate test file imports and exercises this solution vs. the inline tests
- [function] `evaluate-boolean-binary-tree/solution.py:_build_tree` — Level-order tree construction is reused across many tree problems in this repo; compare with other solutions' helpers
- [file] `balanced-binary-tree/solution.py` — Another recursive tree problem; compare traversal strategy (post-order with height propagation vs. boolean evaluation)
- [general] `full-vs-complete-binary-tree-assumptions` — How the full-tree invariant lets `evalTree` skip the right-child null check, and where that breaks if the invariant is violated
- [file] `invert-binary-tree/solution.py` — Contrasting tree recursion pattern: structural transformation vs. value computation

## Beliefs

- `evalTree-leaf-detection-is-left-only` — `evalTree` detects leaf nodes by checking only `root.left is None`; it never checks `root.right`, relying on the full binary tree guarantee
- `evalTree-and-is-default-operator` — Any internal node with `val != 2` is treated as AND; there is no explicit check for `val == 3` or validation of the val range
- `evalTree-evaluates-both-children-before-operator` — Both subtrees are fully evaluated via recursive calls before the OR/AND operator is applied, so Python's short-circuit semantics provide no performance benefit
- `build-tree-uses-leetcode-serialization` — `_build_tree` accepts the standard LeetCode level-order format with `None` for missing nodes, making test cases directly portable from problem examples

