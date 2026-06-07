# File: maximum-depth-of-n-ary-tree/solution.py

**Date:** 2026-06-06
**Time:** 17:36

## Purpose

This file is a self-contained LeetCode solution for [problem 559: Maximum Depth of N-ary Tree](https://leetcode.com/problems/maximum-depth-of-n-ary-tree/). It defines the tree data structure, implements the solution, and includes its own test suite — following the repo's convention of one directory per problem with a `solution.py` and `test_solution.py`.

## Key Components

### `Node` class
The N-ary tree node. Unlike a binary tree's fixed `left`/`right`, it stores an arbitrary-length `children` list. The constructor defaults `children` to `[]` (via a `None` guard to avoid the mutable default argument pitfall).

### `max_depth(root)` function
The core solution. Returns the number of nodes on the longest root-to-leaf path (1-indexed depth, not 0-indexed).

**Contract:**
- Input: `Optional[Node]` — `None` means empty tree
- Output: `int >= 0`
- Pure function, no mutation

## Patterns

**Recursive decomposition** — the classic tree recursion pattern with three cases:

1. **Empty tree** (`root is None`): return 0
2. **Leaf node** (`not root.children`): return 1
3. **Internal node**: return `1 + max(max_depth(child) for child in root.children)`

The leaf-node check on line 23 is an optimization that avoids calling `max()` on an empty generator (which would raise `ValueError`). It's also the correctness guard — without it, `max()` over zero children would crash.

**Self-contained module** — the `Node` class is defined locally rather than imported from a shared module. This is typical for LeetCode solutions where each problem is standalone.

## Dependencies

**Imports:** Only `typing.List` and `typing.Optional` (type hints) and `unittest` (tests). No project-internal dependencies.

**Imported by:** The `test_solution.py` in the same directory imports this. The massive "Imported By" list in the prompt is misleading — those are other problems' test files that likely share a test runner pattern, not actual imports of this specific module.

## Flow

For a tree like:
```
      1
    / | \
   3  2  4
  / \
 5   6
```

Execution traces as:
1. `max_depth(1)` → has children → `1 + max(max_depth(3), max_depth(2), max_depth(4))`
2. `max_depth(3)` → has children → `1 + max(max_depth(5), max_depth(6))`
3. `max_depth(5)` → leaf → `1`
4. `max_depth(6)` → leaf → `1`
5. `max_depth(3)` = `1 + 1` = `2`
6. `max_depth(2)` → leaf → `1`
7. `max_depth(4)` → leaf → `1`
8. `max_depth(1)` = `1 + max(2, 1, 1)` = `3`

**Time:** O(n) — visits every node once. **Space:** O(h) stack frames where h is tree height (O(n) worst case for a degenerate chain).

## Invariants

- `max_depth` always returns a non-negative integer
- A single node has depth 1, not 0 (LeetCode's convention)
- `root.children` is never `None` at runtime due to the `Node.__init__` guard — but `max_depth` doesn't rely on this; it checks `not root.children` which handles both `None` and `[]`

## Error Handling

None. The function assumes well-formed input (no cycles, no `None` entries in `children`). A cycle would cause infinite recursion / stack overflow. This is acceptable for LeetCode context where inputs are guaranteed valid.

## Topics to Explore

- [file] `maximum-depth-of-binary-tree/solution.py` — Binary tree variant of the same problem; compare how fixed left/right children simplify the recursion vs. the `children` list approach here
- [file] `n-ary-tree-preorder-traversal/solution.py` — Another N-ary tree problem that likely reuses the same `Node` definition; compare traversal patterns
- [function] `minimum-depth-of-binary-tree/solution.py:min_depth` — The inverse problem (minimum depth); the leaf-check logic is more subtle there because you must not count a path that ends at a non-leaf
- [general] `python-max-recursion-depth` — For very deep trees (>1000 nodes in a chain), CPython's default recursion limit would hit; an iterative BFS/DFS approach avoids this

## Beliefs

- `max-depth-nary-leaf-guard` — The `if not root.children: return 1` check on line 23 prevents `ValueError` from calling `max()` on an empty generator; removing it breaks leaf nodes
- `max-depth-nary-time-linear` — `max_depth` visits each node exactly once, giving O(n) time complexity
- `max-depth-nary-node-children-default` — `Node.__init__` normalizes `children=None` to `[]`, so callers can omit the argument without risking `AttributeError` on iteration
- `max-depth-nary-depth-convention` — Depth is 1-indexed: a single-node tree returns 1, an empty tree returns 0

