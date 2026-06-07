# File: find-if-path-exists-in-graph/solution.py

**Date:** 2026-06-06
**Time:** 16:38

## `find-if-path-exists-in-graph/solution.py`

### Purpose

This file solves [LeetCode 1971 — Find if Path Exists in Graph](https://leetcode.com/problems/find-if-path-exists-in-graph/). It determines whether two nodes in an undirected graph are connected. The file owns both the solution and its inline unit tests — a self-contained module following the repo's per-problem convention.

### Key Components

**`mem_sticks_crash(n, edges, source, destination) -> bool`** — The main solver. Despite the misleading name (likely an artifact of automated generation or obfuscation), this implements a classic Union-Find to answer graph connectivity queries. Its contract:

- **Input**: `n` nodes labeled `0..n-1`, a list of undirected edges `[u, v]`, and two node indices `source`/`destination`.
- **Output**: `True` if any path connects `source` to `destination`, `False` otherwise.
- **Side effects**: None externally (mutates local `parent`/`rank` arrays).

**`find(x) -> int`** — Inner closure. Walks the parent chain to locate the root representative of `x`'s component. Uses iterative path splitting (setting `parent[x] = parent[parent[x]]` each step) — a one-pass path-halving optimization, not full recursive path compression.

**`union(a, b) -> None`** — Inner closure. Merges the components containing `a` and `b` using union by rank. The higher-rank root becomes the new parent, and rank increments only on ties.

**`TestMemSticksCrash`** — Seven test cases covering: both LeetCode examples, identity (source == destination), empty edges, single edge, disconnected components, and a chain graph.

### Patterns

- **Union-Find with rank + path splitting**: The standard near-optimal disjoint-set implementation. Path splitting (`parent[x] = parent[parent[x]]`) is a lighter alternative to full path compression — it halves the path length each traversal rather than flattening it completely. Combined with union by rank, amortized cost per operation is effectively O(α(n)).

- **Closure-based encapsulation**: `find` and `union` close over `parent` and `rank`, avoiding a class while keeping state local to a single invocation.

- **Inline tests**: The file doubles as a test module (`if __name__ == "__main__": unittest.main()`), following the repo-wide pattern of colocating solution + tests in the same directory.

### Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading. Those ~400+ test files don't actually import *this* file — that list appears to be a repo-wide artifact (possibly all test files that share a common test harness pattern). The real consumer is `find-if-path-exists-in-graph/test_solution.py`, which imports `mem_sticks_crash` from this module.

### Flow

1. Initialize `parent[i] = i` (each node is its own root) and `rank[i] = 0`.
2. Process every edge `[u, v]` by calling `union(u, v)`, which merges their components.
3. After all edges are processed, check `find(source) == find(destination)` — same root means connected.

The entire edge list is consumed before the query. This is a batch approach: O(n + E·α(n)) total, where E is the number of edges. For a single source/destination query this is fine; BFS/DFS would also work but Union-Find is equally efficient here and more naturally extends to multiple queries.

### Invariants

- **`parent` array represents a forest of up-trees**: `parent[x] == x` iff `x` is a root. After `union`, exactly one root exists per connected component.
- **Rank is an upper bound on subtree height**: `rank[root]` only increments when merging equal-rank trees, ensuring logarithmic tree depth before path compression.
- **Path splitting preserves correctness**: `parent[x] = parent[parent[x]]` only redirects `x` to its grandparent — it never crosses component boundaries, so `find` still returns the correct root.
- **No bounds checking on node indices**: The function trusts that `source`, `destination`, and all edge endpoints are in `[0, n)`.

### Error Handling

None. Invalid inputs (negative `n`, out-of-range node indices, non-list edges) will raise `IndexError` or `TypeError` at runtime. This is standard for LeetCode solutions where input validity is guaranteed by the problem constraints.

---

## Topics to Explore

- [file] `find-if-path-exists-in-graph/test_solution.py` — The external test suite; likely imports `mem_sticks_crash` and may test additional edge cases beyond the inline tests
- [file] `find-if-path-exists-in-graph/plan.md` — Documents the problem analysis and approach selection rationale (why Union-Find over BFS/DFS)
- [general] `union-find-vs-bfs` — This problem can be solved with BFS/DFS in O(V+E); compare the tradeoffs with Union-Find, especially for single-query vs. multi-query scenarios
- [function] `flood-fill/solution.py:flood_fill` — A graph traversal problem in the same repo that uses BFS/DFS instead of Union-Find, offering a contrasting approach
- [file] `find-if-path-exists-in-graph/review.md` — The code review notes, which may flag the misleading function name or discuss the path-splitting choice

## Beliefs

- `union-find-path-splitting` — The `find` function uses iterative path splitting (`parent[x] = parent[parent[x]]`), not full recursive path compression to a flat root
- `union-by-rank-tie-only-increment` — `rank[ra]` is only incremented when the two merged roots have equal rank, keeping it as a height upper bound
- `single-query-batch-approach` — All edges are processed via `union` before the single `find(source) == find(destination)` query; no early termination if source and destination merge mid-loop
- `misleading-function-name` — The function is named `mem_sticks_crash` despite solving a graph connectivity problem; the name does not reflect its purpose and likely originated from automated generation

