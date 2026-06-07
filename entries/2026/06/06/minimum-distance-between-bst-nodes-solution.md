# File: minimum-distance-between-bst-nodes/solution.py

**Date:** 2026-06-06
**Time:** 17:57

## `minimum-distance-between-bst-nodes/solution.py`

### Purpose

Solves [LeetCode 783 — Minimum Distance Between BST Nodes](https://leetcode.com/problems/minimum-distance-between-bst-nodes/). Given a BST, find the minimum absolute difference between the values of any two nodes. This file owns the solution, the tree construction helper, and the test suite — a self-contained unit typical of this repo's per-problem structure.

### Key Components

**`TreeNode`** — Standard binary tree node with `val`, `left`, `right`. Used both by the solution and the test harness.

**`Solution.minDiffInBST(root)`** — The core algorithm. Uses an in-order traversal to visit nodes in sorted order, tracking the previous value via `self.prev` and updating `self.min_diff` with the smallest gap seen. Returns `self.min_diff` (an `int` for valid BSTs, initialized to `float('inf')`).

**`build_tree(vals)`** — Constructs a `TreeNode` tree from a level-order list (LeetCode's standard serialization format). `None` entries represent absent children. Used exclusively by tests.

**`TestSolution`** — Six test cases covering both LeetCode examples, two-node trees, large gaps, consecutive values, and right-skewed trees.

### Patterns

**In-order traversal on BST yields sorted order.** This is the central insight. Rather than collecting all values into a list and sorting, the solution streams through sorted values and computes adjacent differences on the fly — O(n) time, O(h) stack space.

**Instance variables as closure state.** `self.prev` and `self.min_diff` are set on `self` before traversal starts, then mutated by the nested `inorder` function. This avoids passing accumulators through recursive calls or using `nonlocal`. It does mean the `Solution` instance is stateful during execution — calling `minDiffInBST` resets both fields at the top, so it's safe to reuse across calls.

**Level-order deserialization.** `build_tree` uses a queue (list with `pop(0)`) to assign children left-to-right, matching LeetCode's bracket notation.

### Dependencies

**Imports:** `Optional` from `typing` (for the type hint), `unittest` (test framework). No external dependencies.

**Imported by:** The test file `minimum-distance-between-bst-nodes/test_solution.py` imports from this module. The massive "Imported By" list in the prompt is an artifact of the repo's structure — those are unrelated test files that share the same import pattern, not actual consumers of this solution.

### Flow

1. `minDiffInBST` initializes `self.prev = None`, `self.min_diff = inf`.
2. `inorder(node)` recurses left, processes current node, recurses right.
3. On each node visit: if `self.prev` is not `None`, compute `node.val - self.prev` (guaranteed non-negative because BST in-order is sorted ascending) and update `self.min_diff` if smaller.
4. Set `self.prev = node.val` so the next visited node can compare against it.
5. After traversal completes, return `self.min_diff`.

### Invariants

- **BST property assumed, not validated.** The subtraction `node.val - self.prev` relies on in-order yielding ascending values. Non-BST input would produce incorrect (possibly negative) results.
- **At least two nodes required.** If the tree has fewer than two nodes, `self.prev` stays `None` and the method returns `float('inf')`. The problem constraints guarantee at least two nodes.
- **`self.prev` and `self.min_diff` are reset per call**, so the `Solution` instance is reusable.

### Error Handling

None. The function trusts its input is a valid BST with at least two nodes per the problem constraints. No exceptions are raised or caught. `build_tree` will silently produce a malformed tree if the input list is inconsistent.

---

## Topics to Explore

- [file] `minimum-absolute-difference-in-bst/solution.py` — LeetCode 530 is the same problem under a different name; compare whether the implementations are identical or diverge
- [function] `minimum-distance-between-bst-nodes/solution.py:build_tree` — The level-order deserializer is reused across hundreds of tree-problem test files; understanding its `None`-handling matters for writing correct test cases
- [general] `inorder-bst-patterns` — Many BST solutions in this repo (find-mode, range-sum, closest-value, two-sum-iv) use in-order traversal with state tracking; compare how they manage the "previous node" pattern
- [file] `closest-binary-search-tree-value/solution.py` — Another BST problem that walks the tree comparing values; uses a different traversal strategy worth contrasting

## Beliefs

- `inorder-yields-sorted` — In-order traversal of a BST visits nodes in strictly ascending value order, which this solution relies on to reduce minimum-difference to an adjacent-pair comparison
- `solution-resets-state-per-call` — `minDiffInBST` sets `self.prev = None` and `self.min_diff = inf` at the top of every call, making the `Solution` instance safe to reuse across multiple invocations
- `build-tree-uses-level-order` — `build_tree` deserializes LeetCode's bracket/level-order format using a FIFO queue, assigning left then right children per node
- `no-input-validation` — Neither `minDiffInBST` nor `build_tree` validates its input; a non-BST tree or a single-node tree will produce `float('inf')` or incorrect results without raising an error

