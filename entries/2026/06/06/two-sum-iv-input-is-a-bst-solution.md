# File: two-sum-iv-input-is-a-bst/solution.py

**Date:** 2026-06-06
**Time:** 19:33

## `two-sum-iv-input-is-a-bst/solution.py`

### Purpose

This file solves [LeetCode 653 — Two Sum IV](https://leetcode.com/problems/two-sum-iv-input-is-a-bst/): given a BST and a target integer `k`, determine whether any two distinct nodes in the tree have values that sum to `k`. It owns both the solution and its test suite in a single file, following the repo's standard layout.

### Key Components

**`TreeNode`** — A minimal BST node class with `val`, `left`, and `right`. Defined locally rather than imported from a shared module, keeping each problem self-contained.

**`findTarget(root, k) -> bool`** — The core solver. Contract: given an optional tree root and an integer target, returns `True` if two distinct node values sum to `k`, `False` otherwise. Accepts `None` as a valid input (empty tree).

**`TestFindTarget`** — Seven unit tests covering the standard cases: LeetCode examples, single node, two-node trees (hit and miss), negative values, and empty tree.

**`_build(vals)`** — Test helper that constructs a `TreeNode` tree from a level-order list (the same format LeetCode uses for tree serialization). `None` entries represent absent children.

### Patterns

**HashSet two-sum reduction.** The solution reduces the BST two-sum problem to the classic array two-sum pattern: for each node value `v`, check if `k - v` was already seen. This deliberately ignores the BST ordering property in favor of simplicity — O(n) time, O(n) space regardless of tree shape.

**BFS traversal via `deque`.** Rather than recursion (which would risk stack overflow on deep trees), it uses an iterative BFS with `collections.deque`. This is a common idiom in this repo's tree solutions.

**Single-file solution + tests.** Matches the repo convention where `solution.py` contains the algorithm and inline `unittest` tests, while `test_solution.py` exists separately (likely auto-generated, importing from here).

### Dependencies

**Imports:** `collections.deque` (BFS queue), `typing.Optional` (type annotation), `unittest` (inline tests).

**Imported by:** `two-sum-iv-input-is-a-bst/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the repo-wide test infrastructure — those files don't actually import from this solution; they follow the same structural pattern.

### Flow

1. Guard clause: return `False` immediately if `root` is `None`.
2. Initialize an empty `seen` set and a `deque` seeded with the root node.
3. BFS loop: pop a node, check if its complement (`k - node.val`) is in `seen`. If yes, return `True`. Otherwise, add `node.val` to `seen` and enqueue non-null children.
4. If the queue empties without finding a pair, return `False`.

### Invariants

- **Two distinct nodes required.** A single node with value `k/2` won't match itself because `seen` is checked *before* the current node's value is added. This is the critical ordering: check-then-add prevents a node from pairing with itself.
- **All nodes visited exactly once.** BFS over a tree (no cycles) guarantees each node is dequeued once, so time is O(n) and space is O(n) for the set + queue.
- **BST property is unused.** The algorithm works on any binary tree, not just BSTs. Correctness doesn't depend on ordering.

### Error Handling

None beyond the `None`-root guard. The function assumes well-formed `TreeNode` inputs with integer values. No exceptions are raised or caught.

---

## Topics to Explore

- [file] `two-sum/solution.py` — The original array-based two-sum; compare the hash-set technique used here against the array version
- [file] `two-sum-iii-data-structure-design/solution.py` — The streaming/design variant of two-sum; shows how the same hash pattern adapts to an online setting
- [general] `bst-aware-two-pointer-approach` — An alternative O(n) time, O(log n) space solution using an in-order iterator + reverse in-order iterator as a two-pointer scan, which actually exploits the BST property
- [file] `convert-sorted-array-to-binary-search-tree/solution.py` — Tree construction from sorted data; the inverse problem of extracting sorted order from a BST
- [function] `two-sum-iv-input-is-a-bst/solution.py:_build` — The level-order tree builder used across many tree-problem test suites in this repo

## Beliefs

- `two-sum-iv-no-self-pair` — `findTarget` prevents a node from pairing with itself because it checks `seen` before inserting the current node's value
- `two-sum-iv-ignores-bst-property` — The algorithm works on any binary tree; it does not exploit BST ordering for correctness or performance
- `two-sum-iv-linear-time-space` — `findTarget` runs in O(n) time and O(n) space where n is the number of nodes
- `two-sum-iv-bfs-not-recursive` — Traversal uses iterative BFS via `deque`, not recursion, avoiding stack overflow on skewed trees

