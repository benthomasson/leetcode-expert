# File: assign-cookies/solution.py

**Date:** 2026-06-06
**Time:** 15:17

## Assign Cookies — LeetCode 455

### Purpose

This file implements the solution to [LeetCode 455: Assign Cookies](https://leetcode.com/problems/assign-cookies/). It solves the problem of maximizing the number of children who each receive a cookie that meets or exceeds their greed factor. It's one solution module among hundreds in the `leetcode-implementations` repo, following the standard `solution.py` convention.

### Key Components

**`find_content_children(g, s) -> int`** — The sole public function. Takes two lists:
- `g`: greed factors (each child's minimum acceptable cookie size)
- `s`: available cookie sizes

Returns the maximum number of children that can be satisfied.

### Patterns

**Greedy two-pointer on sorted arrays.** This is the textbook greedy approach for assignment problems where you want to maximize matches under a capacity constraint. The insight: sort both lists, then try to match the least greedy child with the smallest sufficient cookie. If a cookie is too small for the current child, skip it — it won't satisfy any greedier child either.

The algorithm mutates the input lists in-place via `.sort()` rather than creating sorted copies. This is a deliberate space optimization (O(1) extra space vs O(n) for `sorted()`), though it means the caller's lists are modified as a side effect.

### Dependencies

**Imports:** None — pure standard library, no external dependencies.

**Imported by:** `assign-cookies/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are all test files for *other* problems that happen to share a common test harness or conftest, not actual importers of this solution's logic.

### Flow

1. Sort `g` (greed factors) ascending — least greedy child first
2. Sort `s` (cookie sizes) ascending — smallest cookie first
3. Walk both lists with two pointers (`child`, `cookie`):
   - If `s[cookie] >= g[child]`: this cookie satisfies this child. Advance `child` (matched) and `cookie` (consumed).
   - Otherwise: this cookie is too small. Advance only `cookie` (discard it for this child).
4. Loop terminates when either all children are checked or all cookies are exhausted.
5. Return `child` — the count of satisfied children.

The `child` pointer only advances on a successful match, so its final value equals the number of content children.

### Invariants

- **Greedy correctness**: Assigning the smallest sufficient cookie to the least greedy unmatched child is always optimal. No cookie is wasted on an over-qualified child when a needier child could use it.
- **Monotonic progress**: `cookie` increments every iteration, so the loop terminates in at most `len(s)` steps.
- **No duplicate assignment**: Each cookie is consumed exactly once (pointer only moves forward).

### Error Handling

None. The function assumes valid inputs per LeetCode constraints (non-negative integers). Empty lists work correctly — the while-loop body never executes and `child` returns as 0.

---

## Topics to Explore

- [file] `assign-cookies/test_solution.py` — See what edge cases are covered (empty lists, all cookies too small, exact matches)
- [file] `assign-cookies/plan.md` — The planning document may capture alternative approaches considered (e.g., heap-based assignment)
- [general] `greedy-vs-dp-assignment` — Why greedy works here but not for variants like the assignment problem with costs
- [function] `maximum-units-on-a-truck/solution.py:maximumUnits` — Another greedy assignment problem in this repo; compare the two-pointer approach vs. sort-and-accumulate
- [file] `assign-cookies/review.md` — Code review notes that may flag the in-place sort trade-off

## Beliefs

- `assign-cookies-greedy-optimal` — The greedy strategy (smallest sufficient cookie to least greedy child) produces a provably optimal assignment for this problem.
- `assign-cookies-mutates-inputs` — `find_content_children` mutates both input lists via in-place `.sort()`; callers cannot assume list order is preserved.
- `assign-cookies-linear-after-sort` — The two-pointer scan is O(n + m) after sorting, giving overall O(n log n + m log m) time complexity.
- `assign-cookies-zero-extra-space` — The algorithm uses O(1) auxiliary space beyond the in-place sort (no heaps, no hash maps, no copied arrays).

