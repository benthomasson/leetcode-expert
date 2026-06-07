# File: invert-binary-tree/solution.py

**Date:** 2026-06-06
**Time:** 17:08

## `invert-binary-tree/solution.py`

### Purpose

This file is a self-contained solution to [LeetCode #226 — Invert Binary Tree](https://leetcode.com/problems/invert-binary-tree/). It owns the complete lifecycle: tree data structure, the inversion algorithm, serialization/deserialization helpers for testing, and the test suite itself. Within the project, it follows the standard pattern where each problem directory contains a `solution.py` that doubles as both implementation and test module.

### Key Components

**`TreeNode`** (line 7–10) — Standard binary tree node with `val`, `left`, `right`. Uses `from __future__ import annotations` to allow the forward-reference `TreeNode | None` in the type hints without quoting.

**`invert_tree(root)`** (line 13–23) — The core algorithm. Takes a root node (or `None`) and returns the root of the inverted tree. The inversion is done **in-place** — it mutates the existing tree rather than building a new one.

The key line is:
```python
root.left, root.right = invert_tree(root.right), invert_tree(root.left)
```
This is a simultaneous swap via tuple unpacking. Both recursive calls execute before either assignment lands, so there's no risk of clobbering `root.left` before the right-side recursion reads it.

**`tree_to_list(root)`** (line 26–39) — BFS level-order serialization. Converts a tree into LeetCode's standard list format (`[4, 7, 2, 9, 6, 3, 1]`), stripping trailing `None`s. Used exclusively for test assertions.

**`list_to_tree(vals)`** (line 42–57) — The inverse: builds a `TreeNode` tree from a level-order list. Drives test setup. Handles `None` entries as absent children.

**`TestInvertTree`** (line 60–78) — Six test cases covering: a full binary tree, a small tree, empty input, single node, left-skewed, and right-skewed trees.

### Patterns

- **Recursive divide-and-conquer**: `invert_tree` uses post-order recursion — it inverts both subtrees first, then swaps them at the current node. This is the canonical O(n) solution.
- **Tuple swap idiom**: `a, b = f(b), f(a)` ensures atomicity of the swap without a temp variable.
- **Round-trip serialization for testing**: Rather than manually building expected trees and comparing node-by-node, tests serialize both input and output to lists. This is a pragmatic pattern used across the entire repository.
- **Self-contained module**: `TreeNode`, helpers, algorithm, and tests all live in one file — no cross-problem imports.

### Dependencies

**Imports**: Only `__future__.annotations` (for PEP 604 union syntax on older Pythons) and `unittest` (stdlib). No external libraries.

**Imported by**: The "Imported By" list in the prompt is misleading — it lists hundreds of test files across other problems. These almost certainly import `unittest` or share a test runner, not this specific file. The actual `invert-binary-tree/test_solution.py` is the real consumer, likely importing `invert_tree`, `TreeNode`, `list_to_tree`, and `tree_to_list`.

### Flow

1. `list_to_tree` builds a tree from a level-order list using BFS (queue-based construction).
2. `invert_tree` recurses depth-first to the leaves, then swaps children on the way back up.
3. `tree_to_list` serializes the result via BFS for comparison against the expected list.

The recursion depth is O(h) where h is the tree height — O(log n) for balanced trees, O(n) worst case for skewed trees.

### Invariants

- `invert_tree(None)` always returns `None` — the base case guarantees this.
- The function is idempotent over two calls: `invert_tree(invert_tree(root))` restores the original tree.
- `tree_to_list` always strips trailing `None`s, so `[1, None]` and `[1]` are equivalent representations.
- `list_to_tree` treats `None` entries as missing children but still advances the index, maintaining level-order alignment.

### Error Handling

There is none beyond the `None` base case. The code assumes well-formed input: `vals[0]` is never `None` in `list_to_tree`, tree nodes always have integer values, and the list length is consistent with a valid binary tree. This is appropriate for a LeetCode solution where inputs are guaranteed valid.

## Topics to Explore

- [file] `invert-binary-tree/test_solution.py` — The companion test file; check whether it imports from `solution.py` or duplicates definitions
- [function] `balanced-binary-tree/solution.py:isBalanced` — Another recursive tree problem; compare the recursion pattern (returns height vs. returns node)
- [function] `symmetric-tree/solution.py:isSymmetric` — Inverting is closely related to checking symmetry; compare how both traverse mirrored subtrees
- [general] `tree-serialization-convention` — The `list_to_tree`/`tree_to_list` helpers are duplicated across many tree problems; worth checking if they're shared or copy-pasted
- [file] `maximum-depth-of-binary-tree/solution.py` — Simplest tree recursion; useful baseline for comparing recursive structure

## Beliefs

- `invert-tree-is-in-place` — `invert_tree` mutates the input tree's node pointers rather than allocating new nodes; the returned root is the same object as the input root
- `invert-tree-tuple-swap-atomicity` — The simultaneous tuple assignment `root.left, root.right = invert_tree(root.right), invert_tree(root.left)` evaluates both recursive calls before either assignment, preventing the left-clobber bug
- `tree-to-list-strips-trailing-nones` — `tree_to_list` always removes trailing `None` values, making `[1, None, 2]` and `[1, None, 2, None, None]` produce identical output
- `list-to-tree-assumes-valid-input` — `list_to_tree` does not validate that the input list represents a structurally valid binary tree; it will index out of bounds or produce malformed trees on bad input

