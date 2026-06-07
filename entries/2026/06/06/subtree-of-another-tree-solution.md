# File: subtree-of-another-tree/solution.py

**Date:** 2026-06-06
**Time:** 19:19

## Purpose

This file is the complete solution package for [LeetCode 572 — Subtree of Another Tree](https://leetcode.com/problems/subtree-of-another-tree/). It owns three responsibilities: the `TreeNode` data structure, the `Solution` class implementing the subtree check algorithm, and the test suite validating it. A helper `_build` function bridges between level-order lists (LeetCode's standard tree encoding) and the `TreeNode` tree structure used by the algorithm.

## Key Components

### `TreeNode`
A standard binary tree node with `val`, `left`, `right`. This is a local definition — it doesn't import from a shared module, which keeps each solution self-contained.

### `Solution.isSubtree(root, subRoot) -> bool`
The public API matching LeetCode's expected signature. It answers: "Does `subRoot` appear as an exact subtree somewhere in `root`?" The algorithm walks every node in `root` and, at each one, checks whether the subtree rooted there is structurally and value-identical to `subRoot`.

**Contract:**
- `subRoot is None` → always `True` (an empty tree is a subtree of anything)
- `root is None` (with non-None `subRoot`) → always `False`
- Otherwise, performs a full structural + value match at the current node, then recurses left/right

### `Solution._is_same(s, t) -> bool`
Private helper implementing the "same tree" check (LeetCode 100). Two trees are the same iff both are `None`, or their values match and both subtrees are recursively the same. This is the inner kernel that `isSubtree` calls at every candidate node.

### `_build(vals) -> Optional[TreeNode]`
Module-level utility that constructs a `TreeNode` tree from a level-order list (BFS encoding). `None` entries represent missing children. Uses a queue-based approach — standard for LeetCode tree construction.

### `TestSubtree`
Nine test cases covering: both LeetCode examples, identical trees, single-node match/mismatch, `None` inputs for both root and subRoot, subtree at a non-root position, and same values with different structure.

## Patterns

**Brute-force DFS + DFS.** The outer `isSubtree` does a DFS over `root`. At each node it calls `_is_same`, which itself is a DFS over the two trees being compared. This gives O(m * n) worst-case time where m and n are the sizes of the two trees.

**Short-circuit evaluation.** Both `isSubtree` and `_is_same` use Python's `or`/`and` short-circuiting to bail early. If `_is_same` finds a match at the current node, the left/right recursive `isSubtree` calls never execute. Similarly, `_is_same` returns `False` the moment any node pair disagrees, without visiting the rest of the tree.

**Self-contained solution file.** Each problem directory bundles solution + tests in one file with an `if __name__ == "__main__"` guard. No shared tree utilities are imported — the `TreeNode` class and `_build` helper are redefined locally.

## Dependencies

**Imports:** `annotations` (for `TreeNode | None` forward-reference syntax), `unittest`, `typing.Optional`. No external or project-internal dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — those are test files for *other* problems that likely share the same structural pattern or were auto-generated from the same template. They don't actually import from this file's module. The true consumer is `subtree-of-another-tree/test_solution.py`, which either imports from this file or is this file's own inline test class.

## Flow

1. A test case calls `_build` twice: once for `root`, once for `subRoot`, converting level-order lists into `TreeNode` trees.
2. `isSubtree` is called with both trees.
3. It checks base cases (None inputs), then calls `_is_same(root, subRoot)` at the current node.
4. If `_is_same` returns `True`, we're done — return `True`.
5. Otherwise, recurse: `isSubtree(root.left, subRoot) or isSubtree(root.right, subRoot)`.
6. `_is_same` recursively compares every node pair in the two trees. A mismatch at any node short-circuits to `False`.

## Invariants

- **Null subRoot is always a subtree.** The code treats an empty candidate as trivially present — this matches LeetCode's definition.
- **Structural equality required.** A subtree must match from a node all the way down to the leaves. A partial prefix match (e.g., `subRoot` is `[1, 2]` but the corresponding node in `root` has `[1, 2, 3]`) correctly returns `False` because `_is_same` checks that both children are `None` when one tree's node is a leaf.
- **`_build` assumes well-formed input.** If `vals` contains an odd-length trailing entry, the second-child branch is silently skipped by the `if i < len(vals)` guard. No validation is performed on the input list.

## Error Handling

There is none beyond Python's built-in exceptions. `_build` will raise `IndexError` on truly malformed input, but in practice the `i < len(vals)` guards prevent out-of-bounds access. The solution assumes valid `TreeNode` inputs as guaranteed by the LeetCode contract. Test assertions use `assertTrue`/`assertFalse` — failures surface as `unittest` test failures, not exceptions.

## Topics to Explore

- [file] `same-tree/solution.py` — The `_is_same` helper is effectively LeetCode 100; compare to see if the standalone solution uses the same approach or optimizes differently
- [general] `subtree-serialization-approach` — An O(m + n) alternative using tree serialization (preorder with sentinel markers) and string matching (KMP or hashing) avoids the O(m*n) brute force
- [function] `subtree-of-another-tree/solution.py:_build` — This queue-based level-order builder is duplicated across hundreds of tree problems; understanding its edge cases (trailing Nones, unbalanced trees) matters for test correctness
- [file] `balanced-binary-tree/solution.py` — Another tree problem using recursive DFS with a similar two-function structure (public entry + private helper); compare the pattern
- [general] `merkle-hash-subtree-matching` — An O(m + n) approach using hash-based tree comparison (Merkle hashing) that avoids both brute-force and serialization drawbacks

## Beliefs

- `subtree-null-subroot-always-true` — `isSubtree(any_root, None)` always returns `True`, matching the LeetCode contract that an empty tree is a subtree of any tree
- `is-same-requires-structural-equality` — `_is_same` returns `True` only when both trees have identical structure and identical node values at every position; a prefix match (same values but extra children) returns `False`
- `issubtree-worst-case-quadratic` — The brute-force approach has O(m * n) time complexity where m = |root| and n = |subRoot|, because `_is_same` (O(n)) is called at up to m nodes
- `build-helper-uses-bfs-queue` — `_build` constructs trees via BFS with a list-as-queue (`queue.pop(0)`), which is O(n^2) total due to list shifting but acceptable for small test inputs
- `solution-is-self-contained` — The file defines its own `TreeNode` class locally rather than importing from a shared module, making each problem directory independently runnable

