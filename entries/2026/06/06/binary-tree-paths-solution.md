# File: binary-tree-paths/solution.py

**Date:** 2026-06-06
**Time:** 15:25

## `binary-tree-paths/solution.py`

### Purpose

This file solves [LeetCode 257 — Binary Tree Paths](https://leetcode.com/problems/binary-tree-paths/). It finds every root-to-leaf path in a binary tree and returns them as arrow-delimited strings like `"1->2->5"`. The file is self-contained: it defines the tree node class, the solution function, and a full test suite.

### Key Components

**`TreeNode`** — Standard binary tree node with `val`, `left`, `right`. Defined locally rather than imported, making the file standalone. The type annotation for children uses the union syntax (`"TreeNode | None"`) as a forward-reference string.

**`binary_tree_paths(root)`** — The public API. Takes an optional root node, returns a list of path strings. The empty-tree case returns `[]` immediately.

**`dfs(node, path)`** — Inner closure that performs the actual traversal. It mutates the outer `results` list as a side effect rather than returning values. The `path` parameter is a string that accumulates the arrow-delimited representation as recursion deepens.

### Patterns

**Closure-based DFS with string accumulation.** The inner `dfs` function captures `results` from the enclosing scope. Path state is carried via the `path` string parameter — since strings are immutable in Python, each recursive call gets its own copy, so there's no need for explicit backtracking. This is a common alternative to passing a mutable list and joining at leaf nodes.

**Root value pre-seeded.** The initial call `dfs(root, str(root.val))` seeds the path with the root's value. Subsequent recursive calls append `"->" + str(child.val)` before descending. This means the path string is always built one level ahead — the caller adds the child's value, not the child itself. This avoids a trailing arrow or an extra conditional inside `dfs`.

### Dependencies

**Imports:** `typing.List`, `typing.Optional`, `unittest` — all stdlib. No external dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — those are test files for *other* problems, not actual importers of this module. This file defines `TreeNode` locally, so other solutions that need a tree node likely define their own or share a common one. The cross-references likely come from a static analysis tool picking up the `TreeNode` class name rather than real import edges.

### Flow

1. `binary_tree_paths(None)` → returns `[]`.
2. `binary_tree_paths(root)` → initializes empty `results`, calls `dfs(root, str(root.val))`.
3. `dfs` checks if `node` is a leaf (no left, no right). If so, appends the accumulated `path` to `results` and returns.
4. If `node.left` exists, recurse with `path + "->" + str(node.left.val)`.
5. If `node.right` exists, recurse with `path + "->" + str(node.right.val)`.
6. After DFS completes, `results` contains all root-to-leaf paths.

### Invariants

- **Leaf detection**: a node is a leaf iff both `left` and `right` are `None`. Internal nodes with one child are not leaves — the single-child branch is followed.
- **Path format**: values are joined with `"->"`, no leading or trailing separator. Negative values are handled naturally by `str()`.
- **Completeness**: every root-to-leaf path appears exactly once in the output. The order is left-subtree-first (pre-order).

### Error Handling

None. The function trusts its input — there's no cycle detection, no type checking on node values. A `None` root is the only guarded case. If `root.val` is not stringifiable, `str()` would raise, but that's outside the problem's contract.

---

## Topics to Explore

- [file] `binary-tree-preorder-traversal/solution.py` — Uses the same DFS pattern but collects values instead of paths; compare the traversal structure
- [file] `path-sum/solution.py` — Another root-to-leaf problem that accumulates a running total instead of a string; shows the numeric variant of the same pattern
- [function] `construct-string-from-binary-tree/solution.py:tree2str` — Builds a parenthesized string from a tree, requiring different leaf/child handling logic
- [general] `string-vs-list-path-accumulation` — This solution concatenates strings at each level (O(n) per concat, O(n^2) total for a skewed tree); an alternative is to append to a list and `"->".join()` only at leaves
- [file] `sum-of-root-to-leaf-binary-numbers/solution.py` — Root-to-leaf traversal with bit-shifting accumulation instead of string building

## Beliefs

- `dfs-appends-at-leaves-only` — `results.append(path)` is called exclusively when `node` has no children; internal nodes never produce output
- `path-built-by-caller` — Each recursive call pre-formats the child's value into the path string before descending, so `dfs` never prepends its own node's value
- `no-backtracking-needed` — String immutability guarantees each recursive branch has an independent `path` snapshot without explicit undo
- `empty-tree-returns-empty-list` — `binary_tree_paths(None)` returns `[]`, not `[""]` or an error
- `left-before-right-ordering` — Output paths follow left-subtree-first ordering because `node.left` is visited before `node.right` in every call

