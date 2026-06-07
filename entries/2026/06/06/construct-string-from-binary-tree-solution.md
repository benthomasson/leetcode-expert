# File: construct-string-from-binary-tree/solution.py

**Date:** 2026-06-06
**Time:** 15:49

## `construct-string-from-binary-tree/solution.py`

### Purpose

This file solves [LeetCode 606 — Construct String from Binary Tree](https://leetcode.com/problems/construct-string-from-binary-tree/). It converts a binary tree into a string using preorder traversal with parentheses to denote subtrees, omitting empty parenthesis pairs only when doing so doesn't create ambiguity. The file is self-contained: it defines the tree node, the solution, and the test suite.

### Key Components

**`TreeNode`** — Standard binary tree node with `val`, `left`, `right`. Defined locally rather than imported from a shared module, making the solution self-contained for LeetCode submission.

**`tree2str(root: Optional[TreeNode]) -> str`** — The core algorithm. Recursively builds a string representation where:
- Each node's value is printed first (preorder)
- Left and right subtrees are wrapped in `()`
- Empty `()` for the left child is included *only* when a right child exists (to preserve positional information)
- Empty `()` for the right child is always omitted

### Patterns

**Selective omission via asymmetric conditionals.** The two `if` guards on lines 20-23 encode the parenthesis-omission rules:

```python
if root.left or root.right:      # left parens: include if EITHER child exists
if root.right:                    # right parens: include ONLY if right exists
```

This asymmetry is the entire point of the problem. A left-only tree `1->2` produces `"1(2)"` (no right parens). A right-only tree `1->None->3` produces `"1()(3)"` (empty left parens preserved as a positional marker).

**Recursive string building with f-strings.** Each recursive call returns a complete subtree string, and the caller wraps it in parentheses. String concatenation via `+=` is used rather than a list-join approach — fine for LeetCode constraints.

### Dependencies

**Imports:** `typing.Optional` for the type hint, `unittest` for the inline test suite.

**Imported by:** The `test_solution.py` in the same directory imports from this module. The massive "Imported By" list in the prompt appears to be a repo-wide artifact — those hundreds of test files don't actually import *this* solution; they're likely a tooling/indexing error or a shared test harness pattern.

### Flow

1. Base case: `root is None` → return `""`
2. Start with `str(root.val)`
3. If either child exists, recurse on left and wrap in `()`
4. If right child exists, recurse on right and wrap in `()`
5. Return accumulated string

For tree `1(2(4))(3)`:
```
tree2str(1) → "1" + "(2(4))" + "(3)"
  tree2str(2) → "2" + "(4)"
    tree2str(4) → "4"
  tree2str(3) → "3"
```

### Invariants

- **Positional unambiguity**: If a node has a right child but no left child, the output always includes `()` for the missing left subtree. This is what distinguishes `1(2)(3)` (both children) from `1()(3)` (right-only).
- **No trailing empty parens**: A node with only a left child never emits `()` for the absent right subtree.
- **Preorder guarantee**: The root value always appears before any subtree content.

### Error Handling

None beyond the `None` base case. The function assumes valid `TreeNode` input. Negative values are handled naturally by `str()` — the test at `test_negative_values` confirms this.

---

## Topics to Explore

- [file] `construct-string-from-binary-tree/test_solution.py` — The separate test file may have additional edge cases or a different TreeNode construction pattern
- [function] `binary-tree-preorder-traversal/solution.py:preorderTraversal` — Compare the raw preorder traversal with this parenthesized variant to see how the same traversal order serves different output formats
- [general] `tree-serialization-patterns` — This is one of several tree-to-string serializations in the repo (see also `binary-tree-paths`, `same-tree`); comparing them reveals how output format drives the recursion structure
- [file] `evaluate-boolean-binary-tree/solution.py` — Another recursive tree solution that returns a transformed result per node, showing the same bottom-up pattern with different semantics

## Beliefs

- `tree2str-empty-left-parens-preserved` — `tree2str` emits `()` for a missing left child if and only if the right child exists, ensuring the output is unambiguous
- `tree2str-no-unnecessary-right-parens` — `tree2str` never emits parentheses for an absent right child, regardless of whether the left child exists
- `tree2str-preorder-string` — The output string always places the node's value before any parenthesized subtree content, following preorder traversal order
- `tree2str-handles-negative-vals` — Negative node values are serialized correctly (e.g., `-1(-2)(-3)`) with no special-case logic required

