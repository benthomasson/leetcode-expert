# File: increasing-order-search-tree/solution.py

**Date:** 2026-06-06
**Time:** 17:04

## Purpose

This file solves [LeetCode 897: Increasing Order Search Tree](https://leetcode.com/problems/increasing-order-search-tree/). It takes a BST and rearranges it into a right-skewed tree (a linked list via `.right` pointers) where nodes appear in in-order (ascending) sequence. The file is self-contained: it defines the tree node, the solution, test helpers, and unit tests.

## Key Components

### `TreeNode`
Standard binary tree node with `val`, `left`, `right`. Used both as input (arbitrary BST shape) and output (right-only chain).

### `Solution.increasingBST`
The core algorithm. Uses the **dummy node + mutable cursor** pattern:

1. Creates a `dummy` sentinel node (value 0, never returned).
2. Stores a mutable cursor `self.current` pointing to the tail of the result chain being built.
3. Runs an in-order traversal. At each visit:
   - **Nulls out `node.left`** — severing the old left subtree link.
   - **Appends `node` to the right of `self.current`** — extending the chain.
   - **Advances the cursor** to the newly appended node.
4. Returns `dummy.right` — the first real node in the chain.

### `build_tree`
Level-order (BFS) construction from a list. `None` entries represent absent children. Used exclusively by tests to set up input trees.

### `tree_to_list`
Serializes a right-skewed tree into a flat list with `None` separators between values (matching LeetCode's expected output format). Only walks `.right` pointers.

## Patterns

**In-place tree restructuring via dummy head**: The dummy/sentinel node avoids special-casing the first insertion. This is the same idiom used in linked-list problems (merge two sorted lists, etc.) — you build the result off a throwaway head and return `head.right` (or `.next`).

**Instance variable as mutable closure state**: `self.current` acts as shared mutable state between `increasingBST` and the nested `inorder` function. This avoids passing the cursor as a parameter or using `nonlocal`. It works but couples the traversal to the `Solution` instance — calling `increasingBST` concurrently on the same `Solution` object would race.

**Destructive mutation**: The algorithm modifies the input tree in place. After `increasingBST` returns, the original tree structure is destroyed — every node's `.left` is `None` and `.right` points to its in-order successor.

## Dependencies

**Imports**: Only standard library — `annotations` (PEP 604 union syntax), `typing.Optional`, `unittest`. No external dependencies.

**Imported by**: The `test_solution.py` in the same directory. The massive "Imported By" list in the prompt is noise — those are unrelated test files across other problems that don't actually import this module. They share the same filename pattern but are independent.

## Flow

```
increasingBST(root)
  │
  ├── create dummy(0), cursor = dummy
  │
  ├── inorder(root)          ← recursive DFS
  │     ├── inorder(left)    ← visit left subtree first
  │     ├── node.left = None ← sever old left link
  │     ├── cursor.right = node ← append to result chain
  │     ├── cursor = node    ← advance tail pointer
  │     └── inorder(right)   ← visit right subtree
  │
  └── return dummy.right     ← skip sentinel
```

For the BST `[5, 3, 6, 2, 4, None, 8, 1, None, None, None, 7, 9]`, the in-order traversal visits `1, 2, 3, 4, 5, 6, 7, 8, 9` and chains them left-to-right via `.right` pointers.

## Invariants

- **BST property assumed**: The algorithm relies on in-order traversal producing sorted output, which only holds if the input is a valid BST. No validation is performed.
- **Left pointers nulled**: Every visited node has `.left = None` after processing. This is critical — without it, the restructured tree would contain cycles or stale references.
- **No new nodes created**: The output tree reuses the exact same `TreeNode` objects from the input. Only pointer assignments change.
- **Result is a right-only chain**: Every node in the output has `left == None`. The test `test_no_left_children_in_result` explicitly verifies this invariant.

## Error Handling

None. The function assumes valid input (a BST or `None`). Passing `None` returns `None` correctly (the dummy's `.right` stays `None`). No exceptions are raised or caught. Stack overflow is possible on deeply unbalanced trees (~1000+ depth in CPython), but LeetCode constraints keep tree sizes small.

## Topics to Explore

- [file] `increasing-order-search-tree/plan.md` — Design rationale and alternative approaches considered before implementation
- [function] `convert-sorted-array-to-binary-search-tree/solution.py:sortedArrayToBST` — The inverse operation: building a balanced BST from sorted data
- [general] `in-order-traversal-restructuring` — Compare this dummy-head approach with the alternative of collecting values into a list and rebuilding the tree
- [function] `binary-tree-inorder-traversal/solution.py:inorderTraversal` — The standalone in-order traversal this solution builds upon
- [file] `closest-binary-search-tree-value/solution.py` — Another BST problem that exploits sorted traversal order

## Beliefs

- `increasing-bst-is-destructive` — `increasingBST` mutates the input tree in place; after the call, the original BST structure no longer exists
- `increasing-bst-uses-instance-state` — The mutable cursor is stored as `self.current` on the Solution instance, making concurrent calls on the same instance unsafe
- `increasing-bst-linear-time` — The algorithm visits each node exactly once via in-order traversal, giving O(n) time and O(h) stack space where h is tree height
- `build-tree-uses-bfs` — `build_tree` constructs from a level-order list using a queue, matching LeetCode's standard serialization format

