# File: minimum-depth-of-binary-tree/solution.py

**Date:** 2026-06-06
**Time:** 17:56

## Purpose

This file solves [LeetCode 111 — Minimum Depth of Binary Tree](https://leetcode.com/problems/minimum-depth-of-binary-tree/). It defines the `TreeNode` data structure and a `Solution` class with a single method `minDepth` that returns the number of nodes on the shortest root-to-leaf path. It's one of ~400+ problem solutions in the `leetcode-implementations` repo, each following a uniform `solution.py` + `test_solution.py` + `review.md` + `plan.md` structure.

## Key Components

**`TreeNode`** — Standard binary tree node with `val`, `left`, `right`. This is the canonical LeetCode definition, included inline so the file is self-contained.

**`Solution.minDepth(root)`** — The core algorithm. Contract: given a `TreeNode` or `None`, return an `int` representing the minimum depth (0 for an empty tree, otherwise the shortest root-to-leaf path length counted in nodes).

## Patterns

**BFS over DFS.** This is the critical design choice. BFS (level-order traversal) guarantees the *first* leaf encountered is at minimum depth, so it can return immediately without exploring the rest of the tree. A DFS approach would need to visit every node to confirm no shorter path exists. For unbalanced trees skewed toward one side, BFS can be dramatically faster.

**Tuple-packed queue entries.** Each queue entry is `(node, depth)`, carrying depth alongside the node rather than tracking it externally. This avoids a separate depth counter or level-by-level processing loop.

**Leaf detection as termination condition.** The check `not node.left and not node.right` identifies leaves — the only nodes where depth is meaningful for this problem. Internal nodes with one child are *not* leaves, which is the classic gotcha in this problem (a node with only a right child has minimum depth through that right subtree, not depth 1).

## Dependencies

**Imports:** `deque` from `collections` (O(1) popleft for BFS), `Optional` from `typing`, and `annotations` from `__future__` (enables forward-reference `TreeNode` in type hints without quotes).

**Imported by:** The `test_solution.py` in the same directory imports `Solution` and `TreeNode` to run test cases. The massive "Imported By" list in the prompt is noise — those are *other* problems' test files, not actual consumers of this code.

## Flow

1. **Empty tree check** — if `root` is `None`, return 0.
2. **Initialize queue** — seed with `(root, 1)`.
3. **BFS loop** — pop front of queue. If the node is a leaf, return its depth immediately. Otherwise, enqueue non-null children with `depth + 1`.
4. **Unreachable return** — `return 0` after the loop. The loop always terminates at a leaf (every non-empty tree has at least one leaf), so this line never executes. It exists to satisfy linters/type checkers that expect a return on every path.

## Invariants

- Depth is 1-indexed (root is depth 1, not 0).
- A single-node tree returns 1, not 0.
- A node with one child is *not* a leaf — the algorithm correctly descends into the existing child rather than returning early. This is the key correctness property that distinguishes minimum depth from maximum depth.

## Error Handling

None. The function assumes valid input per LeetCode conventions. There's no validation of node values, cycle detection, or exception handling. `None` root is the only edge case handled explicitly.

## Topics to Explore

- [file] `minimum-depth-of-binary-tree/test_solution.py` — See which edge cases are tested (single-child nodes, single node, deep skewed trees)
- [file] `maximum-depth-of-binary-tree/solution.py` — Compare with the max-depth counterpart to see where BFS vs DFS tradeoffs diverge
- [file] `balanced-binary-tree/solution.py` — Another tree-depth problem with different structural constraints
- [general] `bfs-vs-dfs-for-shortest-path` — Why BFS is optimal for minimum-depth/shortest-path problems in unweighted graphs and trees
- [file] `path-sum/solution.py` — Related root-to-leaf traversal that adds a target-sum constraint

## Beliefs

- `mindepth-bfs-early-exit` — `minDepth` returns at the first leaf encountered in BFS order, guaranteeing O(n) worst-case but often visiting far fewer nodes than a DFS approach on unbalanced trees.
- `mindepth-single-child-not-leaf` — A node with exactly one child is never treated as a leaf; the algorithm always descends into the existing subtree, which is the key correctness property distinguishing this from max-depth.
- `mindepth-depth-one-indexed` — Depth counting starts at 1 (root = depth 1), so a single-node tree returns 1 and an empty tree returns 0.
- `mindepth-unreachable-return` — The `return 0` after the while loop is dead code; every non-empty tree has at least one leaf, so the loop always terminates via the early return inside it.

