# File: leaf-similar-trees/solution.py

**Date:** 2026-06-06
**Time:** 17:20

## `leaf-similar-trees/solution.py`

### Purpose

This file solves [LeetCode 872 - Leaf-Similar Trees](https://leetcode.com/problems/leaf-similar-trees/). It determines whether two binary trees have the same **leaf value sequence** — the left-to-right ordering of values at leaf nodes. The file is self-contained: it defines the tree data structure, the solution, a tree builder utility, and unit tests.

### Key Components

**`TreeNode`** (line 9-12) — Standard binary tree node with `val`, `left`, `right`. This is the canonical LeetCode tree node definition, used across many solutions in this repo.

**`Solution.leafSimilar`** (line 16-29) — The core algorithm. Takes two tree roots, extracts the leaf sequence from each, and compares them for equality.

**`get_leaves`** (line 25-29) — Nested helper that recursively collects leaf values via DFS. The base cases are:
- `None` node → empty list
- No children → single-element list with the node's value
- Otherwise → concatenate left leaves + right leaves

This guarantees left-to-right ordering because left subtree is always visited before right.

**`build_tree`** (line 32-46) — Constructs a `TreeNode` tree from a level-order list (LeetCode's standard serialization format where `None` represents absent nodes). Uses BFS with a queue to assign children.

**`TestLeafSimilar`** (line 49-75) — Six test cases covering: the two LeetCode examples, single-node trees (equal and unequal), trees with different structures but identical leaf sequences, and mismatched leaf counts.

### Patterns

- **Recursive decomposition**: `get_leaves` uses the classic "collect and concatenate" pattern for tree traversal. It builds the result bottom-up by concatenating left and right subtree results.
- **Self-contained problem file**: Every problem directory in this repo follows the same structure — `solution.py` bundles the solution class, any necessary data structures, helper utilities, and tests in one file.
- **LeetCode method signature convention**: `leafSimilar` uses camelCase (matching LeetCode's interface), while helper functions use snake_case (Python convention).

### Dependencies

**Imports**: `annotations` (for forward-reference type hints in `TreeNode`), `unittest`, `typing.Optional`.

**Imported by**: The "Imported By" list is misleadingly large — it reflects `test_solution.py` files across the repo that likely import a shared test runner or tree utility, not this specific file. The actual `leaf-similar-trees/test_solution.py` imports from this module.

### Flow

1. Caller passes two tree roots to `leafSimilar`.
2. `get_leaves` performs a depth-first traversal of each tree, collecting values only at leaf nodes (nodes with no children).
3. The two resulting lists are compared with `==`.

For a tree like `[3, 5, 1, 6, 2, 9, 8, None, None, 7, 4]`, `get_leaves` produces `[6, 7, 4, 9, 8]` — the leaves read left-to-right.

### Invariants

- **Leaf ordering is deterministic**: left subtree leaves always precede right subtree leaves in the returned list, enforced by the concatenation order on line 29.
- **`None` input produces an empty leaf list**: a `None` root returns `[]`, so two `None` trees are considered leaf-similar (both empty).
- **`build_tree` assumes valid level-order input**: it doesn't guard against malformed input (e.g., children specified for a `None` node).

### Error Handling

None. The code trusts its inputs — no validation on tree structure, no exception handling. This is standard for LeetCode solutions where inputs are guaranteed well-formed.

### Performance Note

`get_leaves` builds intermediate lists via concatenation (`+`), which is O(n) per concatenation. For a balanced tree of n nodes this gives O(n log n) total work. A production version would use a single list with `.append()` or a generator to achieve O(n). For LeetCode's constraints (up to 200 nodes), this doesn't matter.

---

## Topics to Explore

- [file] `leaf-similar-trees/test_solution.py` — The separate test file likely has additional edge cases or a different test harness pattern
- [function] `leaf-similar-trees/solution.py:build_tree` — This BFS level-order builder is reused conceptually across many tree problems; understanding its `None`-skipping logic is essential for tree problems
- [general] `generator-based-leaf-comparison` — An alternative approach using `yield` and `zip` that short-circuits on the first mismatch without materializing full lists
- [file] `same-tree/solution.py` — A related tree comparison problem that compares structure + values rather than just leaf sequences
- [file] `subtree-of-another-tree/solution.py` — Another tree-matching problem with a different comparison strategy

---

## Beliefs

- `leaf-sequence-is-left-to-right` — `get_leaves` always returns leaves in left-to-right order because it recurses into `node.left` before `node.right` and concatenates in that order
- `none-roots-are-leaf-similar` — Two `None` roots are considered leaf-similar because `get_leaves(None)` returns `[]` and `[] == []` is `True`
- `list-concat-not-optimal` — The `get_leaves` implementation uses list concatenation (`+`) giving O(n log n) for balanced trees instead of the optimal O(n) with append or generators
- `build-tree-uses-bfs` — `build_tree` constructs trees via BFS queue traversal of the level-order array, matching LeetCode's standard serialization format

