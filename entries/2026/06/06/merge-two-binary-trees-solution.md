# File: merge-two-binary-trees/solution.py

**Date:** 2026-06-06
**Time:** 17:48

## `merge-two-binary-trees/solution.py`

### Purpose

This file is a self-contained solution to [LeetCode 617 — Merge Two Binary Trees](https://leetcode.com/problems/merge-two-binary-trees/). It owns the core algorithm (`merge_trees`), the tree data structure (`TreeNode`), serialization helpers for testing (`tree_to_list`, `list_to_tree`), and a full test suite. Like every other problem directory in this repo, it follows the pattern of being runnable standalone via `unittest`.

### Key Components

**`TreeNode`** — Standard binary tree node with `val`, `left`, `right`. Uses `Optional[TreeNode]` via `from __future__ import annotations` to allow forward-referencing in the type hint on the same line as the class definition.

**`merge_trees(root1, root2) -> Optional[TreeNode]`** — The core algorithm. Takes two tree roots, returns a *new* tree where overlapping nodes have summed values and non-overlapping subtrees are grafted in directly. Two critical properties:
- It creates new `TreeNode` instances for overlapping nodes (line 30–34), so it doesn't mutate either input tree at those positions.
- It *reuses* existing subtree references when one side is `None` (lines 27–28). This means the returned tree shares structure with the input trees for non-overlapping subtrees — a deliberate space optimization, not a bug.

**`tree_to_list(root) -> list`** — BFS serialization to LeetCode's level-order format. Strips trailing `None` values so `[3, 4, 5, 5, 4, None, 7]` doesn't carry unnecessary nulls. Used exclusively for test assertions.

**`list_to_tree(vals) -> Optional[TreeNode]`** — Inverse of `tree_to_list`. Builds a tree from LeetCode's level-order list format. Skips `None` entries without enqueuing children.

**`TestMergeTrees`** — 8 test cases covering: the LeetCode examples, both/either/neither tree being empty, single nodes, negative values, and unbalanced structures.

### Patterns

**Recursive structural decomposition**: `merge_trees` follows the standard recursive binary tree pattern — base cases for null nodes, then construct the current node from recursive results on children. This is the idiomatic approach for tree problems where both subtrees must be visited.

**LeetCode-style serialization**: `tree_to_list` / `list_to_tree` implement the same level-order encoding LeetCode uses in its problem descriptions. This lets tests express inputs/outputs as flat lists directly matching the problem examples.

**Self-contained test file**: The `check` helper method abstracts the serialize → build → merge → serialize round-trip, keeping individual test methods to one-liners.

### Dependencies

**Imports**: `deque` (BFS queues in serialization helpers), `Optional` (type hints), `annotations` (forward references), `unittest` (test framework). No external packages.

**Imported by**: The "Imported By" list (300+ test files) is misleading — those files don't actually import `merge_trees`. They likely share a common test runner or the dependency graph tool is tracking something at the directory/project level rather than true Python imports.

### Flow

1. `list_to_tree` deserializes two flat lists into `TreeNode` trees via BFS construction
2. `merge_trees` recursively walks both trees in lockstep:
   - If either root is `None`, return the other (grafting the surviving subtree)
   - Otherwise, create a new node with summed value and recurse on left/right children
3. `tree_to_list` serializes the result back to a flat list via BFS for comparison

The recursion depth equals the height of the taller tree. For a balanced tree of *n* nodes, that's O(log n); worst case (skewed) is O(n).

### Invariants

- `merge_trees(None, None)` returns `None` — follows from the first base case
- `merge_trees(t, None)` returns `t` unchanged (identity, not a copy)
- The output tree's structure is the union of both input structures — every position that has a node in either input has a node in the output
- `tree_to_list` output never ends with `None` — the trailing-null stripping loop guarantees this

### Error Handling

None. The functions trust their callers completely — no validation on node types, list contents, or structure. This is appropriate for a LeetCode solution where inputs are guaranteed well-formed by the problem constraints.

## Topics to Explore

- [file] `merge-two-binary-trees/test_solution.py` — Likely a separate test file; compare with the inline tests to see if the repo uses a different test harness
- [function] `merge-two-binary-trees/solution.py:list_to_tree` — The BFS deserialization is reused across hundreds of tree-problem test files; understanding its null-handling is essential for writing new tree tests
- [general] `recursive-vs-iterative-tree-merge` — An iterative BFS version using a stack/queue would avoid stack overflow on deep trees; worth comparing tradeoffs
- [file] `invert-binary-tree/solution.py` — Another recursive tree-manipulation problem; compare whether it mutates in-place or creates new nodes
- [general] `subtree-sharing-semantics` — The fact that `merge_trees` shares subtree references with inputs when one side is null has implications for post-merge mutation; worth understanding when this matters

## Beliefs

- `merge-trees-creates-new-nodes-for-overlaps` — `merge_trees` allocates a new `TreeNode` for every position where both input trees have a node; it never mutates either input at those positions
- `merge-trees-shares-subtrees-for-non-overlaps` — When one input is `None` at a position, `merge_trees` returns the other tree's subtree by reference, not by copy
- `tree-to-list-strips-trailing-nulls` — `tree_to_list` removes all trailing `None` entries from the level-order output, matching LeetCode's canonical serialization format
- `merge-trees-recursion-depth-equals-max-height` — The call stack depth is bounded by the height of the taller input tree, making it O(n) worst case for skewed trees

