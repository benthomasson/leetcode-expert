# File: find-mode-in-binary-search-tree/solution.py

**Date:** 2026-06-06
**Time:** 16:38

## Find Mode in Binary Search Tree — `solution.py`

### 1. Purpose

This file solves [LeetCode 501: Find Mode in Binary Search Tree](https://leetcode.com/problems/find-mode-in-binary-search-tree/). It finds all values that appear most frequently in a BST that may contain duplicates. The file is self-contained: solution + `TreeNode` definition + unit tests.

### 2. Key Components

**`TreeNode`** — Standard BST node with `val`, `left`, `right`. Defined locally rather than imported, making the file standalone.

**`findMode(root) -> List[int]`** — The core algorithm. Takes the root of a BST and returns all mode values (values with the highest frequency). Uses four pieces of mutable state lifted into the enclosing scope via `nonlocal`:

| Variable | Role |
|----------|------|
| `modes` | Accumulates current mode candidates |
| `max_count` | Highest frequency seen so far |
| `cur_count` | Running count of the current value streak |
| `prev` | Last value visited (for detecting value changes) |

**`inorder(node)`** — Nested helper that performs a recursive in-order traversal. This is where the BST property is exploited: in-order traversal visits nodes in sorted order, so equal values are always consecutive. The function mutates the four `nonlocal` variables as a side effect.

### 3. Patterns

**Morris-free O(1)-extra-space-spirit approach.** While this implementation does use O(h) stack space for recursion, it avoids the naive two-pass approach (first pass to find max frequency, second to collect modes). Instead, it does a single pass with a mode-replacement strategy: when a new higher count is found, `modes` is reset to just that value; when a tie is found, the value is appended.

**BST in-order invariant exploitation.** The algorithm relies on the fact that in-order traversal of a BST yields sorted output. This turns frequency counting into a simple consecutive-run-length problem — no hash map needed.

**Closure-based state.** Rather than passing state through parameters or using a class, the function uses `nonlocal` to share mutable state between `findMode` and `inorder`. This is idiomatic for LeetCode-style tree traversal in Python.

### 4. Dependencies

**Imports:** `typing.Optional`, `typing.List` (type annotations only), `unittest` (test harness).

**Imported by:** `find-mode-in-binary-search-tree/test_solution.py` and, per the provided list, hundreds of other test files — though those imports are likely for the `TreeNode` class or unrelated test infrastructure, not for `findMode` itself.

### 5. Flow

1. Initialize `modes=[]`, `max_count=0`, `cur_count=0`, `prev=None`.
2. Call `inorder(root)`, which recurses left-first (in-order).
3. At each node:
   - If `prev == node.val`, increment `cur_count`; otherwise reset to 1.
   - Update `prev` to `node.val`.
   - If `cur_count > max_count`: new sole mode found — replace `modes` list entirely, update `max_count`.
   - If `cur_count == max_count`: tied mode — append to `modes`.
4. Recurse right.
5. Return `modes`.

For the tree `[1, null, 2, 2]`, the in-order visit is `1, 2, 2`. After visiting `1`: `cur_count=1, max_count=1, modes=[1]`. After first `2`: `cur_count=1, max_count=1, modes=[1,2]`. After second `2`: `cur_count=2, max_count=2, modes=[2]`.

### 6. Invariants

- **BST property assumed.** The algorithm produces correct results only if the input is a valid BST. On a non-BST tree, equal values might not be adjacent in the traversal, leading to undercounting.
- **Single-pass completeness.** After `inorder` returns, `modes` contains exactly the set of values whose count equals `max_count` — no post-processing needed.
- **`prev is None` only before the first node.** This ensures the first node always gets `cur_count = 1` (since `None != any int`).
- **Empty tree returns `[]`.** When `root is None`, `inorder` returns immediately and `modes` stays empty.

### 7. Error Handling

None. The function trusts its input is a valid BST (or `None`). No exceptions are raised or caught. The tests cover edge cases (single node, all-same, all-unique, negative values, skewed trees) but the function itself has no defensive checks.

## Topics to Explore

- [file] `find-mode-in-binary-search-tree/plan.md` — Design rationale and alternative approaches considered before implementation
- [function] `minimum-absolute-difference-in-bst/solution.py:getMinimumDifference` — Another problem that exploits the same BST in-order-yields-sorted-values pattern for O(1) extra space
- [general] `bst-inorder-state-tracking` — The family of BST problems solvable by tracking prev/count/accumulator during in-order traversal (mode, kth smallest, validate BST, min diff)
- [file] `find-mode-in-binary-search-tree/test_solution.py` — Separate test file that imports from this solution; check for additional edge cases
- [general] `morris-traversal` — How to achieve true O(1) space (no recursion stack) for in-order traversal, which would make this solution optimal in both time and space

## Beliefs

- `findmode-single-pass` — `findMode` computes all modes in a single in-order traversal with no hash map, relying on BST-sorted-order to group equal values consecutively
- `findmode-bst-assumption` — The algorithm produces incorrect results on non-BST trees because it only counts consecutive runs of equal values in in-order order
- `findmode-mode-replacement` — When `cur_count` exceeds `max_count`, the entire `modes` list is replaced (not appended to), ensuring only the true modes survive
- `findmode-empty-tree-safe` — Passing `None` as root returns an empty list without error

