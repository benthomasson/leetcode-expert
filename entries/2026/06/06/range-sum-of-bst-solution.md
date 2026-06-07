# File: range-sum-of-bst/solution.py

**Date:** 2026-06-06
**Time:** 18:37

## `range-sum-of-bst/solution.py`

### Purpose

This file is the self-contained solution and test suite for [LeetCode 938 — Range Sum of BST](https://leetcode.com/problems/range-sum-of-bst/). It owns the problem's data structure (`TreeNode`), the solving algorithm (`range_sum_bst`), a tree-building helper, and all unit tests. Like every other problem directory in this repo, it follows the pattern of a single `solution.py` that can be run standalone via `unittest`.

### Key Components

**`TreeNode`** — Standard BST node with `val`, `left`, `right`. Defined locally rather than imported from a shared module, making the file self-contained. Uses `Optional[TreeNode]` with `from __future__ import annotations` to allow the forward reference in the type hint.

**`range_sum_bst(root, low, high) -> int`** — The core algorithm. Given a BST root and an inclusive range `[low, high]`, returns the sum of all node values within that range. It exploits BST ordering to prune:

- `root.val < low`: the entire left subtree is out of range — recurse right only.
- `root.val > high`: the entire right subtree is out of range — recurse left only.
- Otherwise: the current node is in range — include its value and recurse both directions.

**`_build_tree(values) -> Optional[TreeNode]`** — Test utility that constructs a tree from a level-order list (BFS serialization), where `None` entries represent missing children. Uses a queue to assign children left-to-right at each level.

**`TestRangeSumBST`** — Nine test cases covering: LeetCode examples, single-node in/out of range, all/none in range, empty tree, left-skewed tree, and boundary-value inclusion.

### Patterns

**BST-aware pruning** — Rather than visiting every node (which would be O(n)), the algorithm skips entire subtrees that can't contain in-range values. This is the canonical approach for BST range queries and brings the complexity down toward O(h + k) where h is tree height and k is the number of in-range nodes.

**Recursive DFS** — The solution uses pure recursion with no explicit stack. The base case (`not root`) returns the additive identity 0, and the three branches cleanly partition all cases. No mutable state.

**Self-contained problem module** — `TreeNode` is redefined locally in every tree problem rather than shared, matching LeetCode's submission format where the class is provided in-scope.

### Dependencies

**Imports:** Only stdlib — `annotations` (for self-referential type hints), `unittest`, `typing.Optional`. No external packages.

**Imported by:** The `test_solution.py` file in this same directory, plus the massive list of `test_solution.py` files across ~450 other problem directories. That "imported by" list is misleading — those files don't actually import `range_sum_bst`. They likely share the same test runner infrastructure or the dependency graph is showing co-membership in the test suite run by `run_tests.py` at the repo root.

### Flow

1. Caller passes a BST root and `[low, high]` bounds.
2. At each node, one of four things happens:
   - `None` node → return 0 (base case).
   - Node value below range → discard left subtree, recurse right.
   - Node value above range → discard right subtree, recurse left.
   - Node value in range → sum current value + left result + right result.
3. Recursion unwinds, accumulating the sum via return values.

### Invariants

- **BST property assumed, not verified.** The pruning logic is only correct if the tree actually satisfies `left.val < node.val < right.val` throughout. Feeding a non-BST tree silently produces wrong results.
- **Inclusive bounds.** Both `low` and `high` are included in the range — the comparisons are strict (`<` and `>`), so a node with `val == low` or `val == high` falls into the "in range" branch.
- **No mutation.** The tree is read-only; the function is pure.

### Error Handling

None. The function trusts its inputs: `root` is either `None` or a valid `TreeNode`, and `low <= high`. There are no exceptions, no input validation, no sentinel error values. This is appropriate for a LeetCode solution where inputs are guaranteed by the judge.

## Topics to Explore

- [file] `range-sum-of-bst/test_solution.py` — Check whether the separate test file adds cases beyond what's inline here
- [function] `closest-binary-search-tree-value/solution.py:closestValue` — Another BST problem that uses the same pruning-by-ordering technique
- [function] `two-sum-iv-input-is-a-bst/solution.py:findTarget` — BST traversal combined with a hash set, contrasting pure-recursion vs. hybrid approaches
- [file] `run_tests.py` — How all these self-contained solution files are discovered and executed as a suite
- [general] `bst-pruning-vs-full-traversal` — When BST ordering lets you prune vs. when you must visit every node (e.g., `binary-tree-tilt` which needs full traversal despite being a BST)

## Beliefs

- `bst-pruning-correctness` — `range_sum_bst` skips the left subtree when `root.val < low` and the right subtree when `root.val > high`, which is correct only if the input is a valid BST
- `range-bounds-inclusive` — Both `low` and `high` are included in the sum because the comparisons use strict `<` and `>`, not `<=` and `>=`
- `range-sum-bst-pure-function` — `range_sum_bst` is a pure function with no side effects — it reads the tree without mutation and accumulates the sum via return values only
- `build-tree-level-order` — `_build_tree` constructs a tree from a level-order (BFS) list where `None` represents absent children, matching LeetCode's standard serialization format

