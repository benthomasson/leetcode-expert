# File: same-tree/solution.py

**Date:** 2026-06-06
**Time:** 18:59

## `same-tree/solution.py`

### Purpose

This file implements [LeetCode 100 — Same Tree](https://leetcode.com/problems/same-tree/). It defines the `TreeNode` data structure and a recursive function that determines whether two binary trees are structurally identical with equal node values. It also serves as a shared `TreeNode` definition imported by test files across hundreds of other solutions in this repo.

### Key Components

**`TreeNode`** (lines 4–7) — A standard binary tree node with three attributes: `val` (int, default 0), `left` (optional child), and `right` (optional child). Uses `from __future__ import annotations` to enable PEP 604 union syntax (`TreeNode | None`) in the type hints, which would otherwise require `Optional[TreeNode]` for the forward reference.

**`is_same_tree(p, q)`** (lines 10–22) — Pure function that checks structural and value equality of two binary trees. Contract:
- Accepts two nullable `TreeNode` roots.
- Returns `True` iff every node in `p` has a corresponding node in `q` at the same position with the same value, and both trees have the same shape.
- Does not mutate either tree.

### Patterns

**Recursive structural decomposition.** The function follows the canonical three-case pattern for binary tree comparison:

1. **Both null** → base case, return `True` (lines 18–19)
2. **Exactly one null** → structural mismatch, return `False` (lines 20–21)
3. **Both non-null** → compare values, then recurse on both children (line 22)

The short-circuit evaluation in the final `return` means it checks `p.val == q.val` first, then left subtrees, then right subtrees — it bails early on the first mismatch without visiting remaining nodes.

**Standalone function, not a method.** Unlike LeetCode's boilerplate `Solution` class pattern, this exposes `is_same_tree` as a module-level function, which is the convention used throughout this repo for importability.

### Dependencies

**Imports:** Only `from __future__ import annotations` — no external libraries. The `TreeNode` class is self-contained.

**Imported by:** This file is imported by an enormous number of test files (300+) across the repo. The "Imported By" list in the context shows virtually every `test_solution.py` file references it. This means `TreeNode` from this module is the canonical tree node definition used repo-wide for building test fixtures — not just for the "same tree" problem. Changes to `TreeNode`'s interface would have massive blast radius.

### Flow

Given two tree roots `p` and `q`:

1. If both are `None`, the algorithm has reached matching leaf boundaries — return `True`.
2. If only one is `None`, the trees diverge structurally — return `False`.
3. Compare `p.val == q.val`. If unequal, short-circuit to `False`.
4. Recurse into `(p.left, q.left)`. If that returns `False`, short-circuit.
5. Recurse into `(p.right, q.right)`. Return its result.

Time complexity: O(min(n, m)) where n, m are the node counts of the two trees — it visits at most every node in the smaller tree. Space complexity: O(min(h_p, h_q)) for the call stack, where h is tree height — O(n) worst case for a skewed tree, O(log n) for a balanced tree.

### Invariants

- The function never modifies either tree (read-only traversal).
- It handles all null combinations explicitly before accessing `.val`, so it never raises `AttributeError`.
- Structural equality is checked before value equality — the `None` guards on lines 18–21 ensure that `p.val` on line 22 is always safe.

### Error Handling

None. The function's domain is fully covered by the three cases, and it assumes valid `TreeNode` inputs (or `None`). No exceptions are raised or caught. If called with non-`TreeNode` arguments, it would raise `AttributeError` on `.val`/`.left`/`.right` access — but that's a caller bug, not something this code is designed to handle.

## Topics to Explore

- [file] `same-tree/test_solution.py` — How the repo builds tree fixtures and validates this function's behavior
- [file] `subtree-of-another-tree/solution.py` — Uses `is_same_tree` as a subroutine; shows how tree comparison composes into harder problems
- [function] `symmetric-tree/solution.py:is_symmetric` — Mirror-image variant of the same recursive decomposition pattern
- [general] `tree-node-reuse-across-repo` — Why hundreds of test files import from this module rather than defining their own `TreeNode`
- [file] `balanced-binary-tree/solution.py` — Another single-pass recursive tree traversal with a different return-type contract (height vs. bool)

## Beliefs

- `same-tree-is-canonical-treenode` — `TreeNode` in `same-tree/solution.py` is the repo-wide canonical binary tree node definition, imported by 300+ test files
- `is-same-tree-short-circuits` — `is_same_tree` short-circuits on the first value or structural mismatch without visiting remaining nodes
- `is-same-tree-null-safe` — The null-check cases on lines 18–21 guarantee `.val` access on line 22 is never called on `None`
- `is-same-tree-is-pure` — `is_same_tree` is a pure function: no mutation of inputs, no side effects, deterministic output

