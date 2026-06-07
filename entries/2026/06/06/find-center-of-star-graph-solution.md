# File: find-center-of-star-graph/solution.py

**Date:** 2026-06-06
**Time:** 16:35

## Find Center of Star Graph — `solution.py`

### Purpose

This file solves [LeetCode 1791: Find Center of Star Graph](https://leetcode.com/problems/find-center-of-star-graph/). It identifies the center node of a star graph — the single node that every edge connects to. The file owns both the solution and its test suite, following the repo's per-problem directory convention.

### Key Components

**`Solution.find_center(edges: List[List[int]]) -> int`** — The core algorithm. Exploits the structural property of a star graph: the center node must appear in every edge. Therefore, it only needs to inspect the first two edges. If `edges[0][0]` appears in `edges[1]`, it's the center; otherwise `edges[0][1]` must be.

**`TestSolution`** — Five test cases covering:
- Standard examples with the center at various positions
- Minimal two-edge graph
- Center appearing as the second element in edges
- Mixed positions across multiple edges

### Patterns

**O(1) solution via structural insight.** Instead of counting node degrees (O(n)), the solution recognizes that in a star graph, the center appears in *all* edges. Checking just two edges is sufficient — the center must be in both, and each edge has only two nodes, so comparing `edges[0][0]` against `edges[1]` (using Python's `in` on a two-element list) identifies it immediately.

**`in` operator on a small list.** `edges[0][0] in edges[1]` does a linear scan of a two-element list, which is effectively O(1). This is idiomatic Python for small membership checks where importing or constructing a set would be overkill.

### Dependencies

**Imports:** `List` from `typing` (type annotation), `unittest` (test framework). No project-internal dependencies.

**Imported by:** The `test_solution.py` in this same directory, plus the "Imported By" list in the prompt shows hundreds of other test files — this is likely an artifact of the repo's import graph tooling rather than actual runtime imports.

### Flow

1. Take the first edge `edges[0]`, which connects two nodes: `[u, v]`.
2. Check if `u` (`edges[0][0]`) appears in the second edge `edges[1]`.
3. If yes, `u` is the center. If no, `v` (`edges[0][1]`) must be.
4. Return the center node.

No iteration, no data structures, no preprocessing. The entire function is two comparisons and a return.

### Invariants

- **Star graph guarantee:** The input is assumed to be a valid star graph with `n-1` edges for `n` nodes. If the input isn't a star graph, the result is undefined.
- **At least two edges:** The function indexes `edges[0]` and `edges[1]` unconditionally, so the input must have at least two edges (i.e., at least 3 nodes).

### Error Handling

None. Invalid inputs (empty list, single edge, non-star graphs) will either raise `IndexError` or return an incorrect result silently. This is standard for LeetCode solutions where inputs are guaranteed valid by the problem constraints.

## Topics to Explore

- [file] `find-center-of-star-graph/plan.md` — How the approach was reasoned about before implementation
- [file] `find-center-of-star-graph/review.md` — Post-implementation review and any noted alternatives
- [file] `find-if-path-exists-in-graph/solution.py` — Another graph problem in the repo; compare graph representation and traversal strategy
- [general] `star-graph-properties` — Mathematical properties of star graphs (degree sequence, diameter=2, unique center) that make O(1) detection possible
- [function] `find-center-of-star-graph/test_solution.py:TestSolution` — Whether tests cover edge cases like large node values or the minimum 3-node star

## Beliefs

- `star-center-two-edge-sufficiency` — The center of a star graph is uniquely determined by inspecting only the first two edges, since the center must appear in both.
- `find-center-constant-time` — `find_center` runs in O(1) time and O(1) space regardless of input size — it never reads beyond `edges[1]`.
- `find-center-minimum-input-size` — The function requires `len(edges) >= 2`; fewer edges will raise an `IndexError` at `edges[1]`.
- `python-in-on-pair` — The `in` check against `edges[1]` works because Python's `in` operator performs element-wise equality on lists, and each edge is a two-element list `[u, v]`.

