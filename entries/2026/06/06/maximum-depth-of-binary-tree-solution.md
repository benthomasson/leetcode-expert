# File: maximum-depth-of-binary-tree/solution.py

**Date:** 2026-06-06
**Time:** 17:35

## `maximum-depth-of-binary-tree/solution.py`

### Purpose

This file is the self-contained solution for [LeetCode #104 — Maximum Depth of Binary Tree](https://leetcode.com/problems/maximum-depth-of-binary-tree/). It owns the problem definition (the `TreeNode` class), the algorithm (`maxDepth`), and the test suite. Like every other solution in this repo, it follows a one-directory-per-problem layout where `solution.py` is both the implementation and the canonical reference for correctness.

### Key Components

**`TreeNode`** (lines 8–11) — Standard binary tree node with `val`, `left`, `right`. This is the local copy of the LeetCode-provided definition; each tree problem in the repo redefines it rather than sharing one, keeping solutions independently runnable.

**`maxDepth(root: Optional[TreeNode]) -> int`** (lines 14–23) — The core algorithm. Contract: given the root of a binary tree (or `None`), return the count of nodes on the longest root-to-leaf path. An empty tree returns `0`; a single node returns `1`.

**`TestMaxDepth`** (lines 26–58) — Seven test cases covering the full shape spectrum: empty tree, single node, the two LeetCode examples, left-skewed, right-skewed, and a balanced tree.

### Patterns

**Recursive DFS.** The solution uses the classic post-order pattern: recurse into both children, take the max, add 1. This is the textbook approach for depth problems and runs in O(n) time, O(h) stack space where h is tree height.

**Self-contained module.** `TreeNode` is defined inline rather than imported from a shared module. This is a deliberate repo-wide convention — every solution can be run or tested in isolation with `python solution.py` or `pytest`.

**Inline tests with `unittest`.** Tests live alongside the implementation and double as executable documentation of the problem's examples.

### Dependencies

**Imports:** `typing.Optional` (type annotation), `unittest` (test framework). No project-internal imports.

**Imported by:** The massive `imported_by` list is misleading — those are test files across the entire repo that share the same structural pattern (importing `unittest`, etc.), not files that actually import `maxDepth` or `TreeNode` from this module. The true consumer is `maximum-depth-of-binary-tree/test_solution.py`.

### Flow

1. `maxDepth(root)` is called with the root node.
2. Base case: if `root` is `None`, return `0`.
3. Recursive case: compute `maxDepth(root.left)` and `maxDepth(root.right)`, return `1 + max(left, right)`.
4. The recursion bottoms out at every leaf's `None` children, then the max depths propagate back up.

For the Example 1 tree `[3,9,20,null,null,15,7]`:
- `maxDepth(15)` and `maxDepth(7)` each return 1
- `maxDepth(20)` returns `1 + max(1,1) = 2`
- `maxDepth(9)` returns 1
- `maxDepth(3)` returns `1 + max(1,2) = 3`

### Invariants

- **Depth of `None` is 0.** This is the base case that makes the recursion well-founded.
- **Depth is always non-negative.** Since every path through the recursion adds 1 to a non-negative base, the result is always >= 0.
- **Depth of a single node is 1.** The problem counts nodes, not edges. `1 + max(0, 0) = 1`.

### Error Handling

None. The function trusts its input — there's no validation that the tree is acyclic or that nodes are well-formed. A cyclic graph would cause infinite recursion and a stack overflow. This is appropriate for a LeetCode solution where inputs are guaranteed valid.

---

## Topics to Explore

- [file] `minimum-depth-of-binary-tree/solution.py` — The mirror problem; compare how min-depth requires special handling for one-child nodes that max-depth doesn't
- [file] `balanced-binary-tree/solution.py` — Uses a similar recursive depth computation but adds a balance check, showing how to compose depth with structural validation
- [file] `diameter-of-binary-tree/solution.py` — Extends the depth pattern to track the longest path through any node, requiring side-effect accumulation during recursion
- [general] `iterative-vs-recursive-tree-traversal` — This solution would stack-overflow on a 10,000-node skewed tree in Python (default recursion limit ~1000); an iterative BFS with a queue avoids that
- [function] `binary-tree-tilt/solution.py:findTilt` — Another post-order pattern that returns one thing (sum) while accumulating another (tilt), a common variant of this recursion shape

## Beliefs

- `maxdepth-none-returns-zero` — `maxDepth(None)` returns `0`, establishing that depth counts nodes not edges
- `maxdepth-is-pure-recursive` — The implementation uses no auxiliary data structures; space complexity is O(h) from the call stack alone
- `solution-files-self-contain-treenode` — Each tree problem redefines `TreeNode` locally rather than importing from a shared module, so solutions are independently runnable
- `maxdepth-no-input-validation` — The function performs no cycle detection or type checking; it assumes a well-formed acyclic binary tree as guaranteed by LeetCode constraints

