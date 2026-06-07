# File: largest-perimeter-triangle/solution.py

**Date:** 2026-06-06
**Time:** 17:16

## `largest-perimeter-triangle/solution.py`

### Purpose

This file implements LeetCode problem 976 ("Largest Perimeter Triangle"). It owns the single responsibility of determining the largest possible perimeter from any three side lengths in a given list that can form a valid triangle. It returns 0 when no valid triangle exists.

### Key Components

**`largest_perimeter_triangle(nums: list[int]) -> int`** — The sole public function. Takes a list of candidate side lengths and returns the largest perimeter achievable, or 0 if no triple satisfies the triangle inequality.

Contract: `nums` must have at least 3 elements for a meaningful result. The function mutates `nums` in-place via `sort()`.

### Patterns

**Greedy via sorted scan.** The solution sorts descending then checks consecutive triples. This is the canonical greedy approach for this problem: if the three largest sides don't form a triangle, no combination involving the largest side will either, so you can safely discard it and move on.

**Early return on first valid triple.** Because the array is sorted largest-first, the first triple that satisfies the triangle inequality is guaranteed to yield the maximum perimeter. No need to examine further.

### Dependencies

**Imports:** None — pure stdlib, no external dependencies.

**Imported by:** Its own `test_solution.py`. The "Imported By" list in the prompt is misleading — that list appears to be every test file in the repo, likely an artifact of a shared test runner or import structure, not actual cross-problem imports.

### Flow

1. **Sort descending** — `nums.sort(reverse=True)` arranges sides from largest to smallest.
2. **Scan consecutive triples** — Iterate `i` from 0 to `len(nums) - 3`. At each step, check `nums[i]`, `nums[i+1]`, `nums[i+2]`.
3. **Triangle inequality check** — Only the "largest < sum of two smaller" condition is tested (`nums[i] < nums[i+1] + nums[i+2]`). The other two inequalities are automatically satisfied because `nums[i] >= nums[i+1] >= nums[i+2]`.
4. **Return perimeter or 0** — First valid triple returns immediately. If the loop exhausts, return 0.

### Invariants

- **Triangle inequality (sufficient check):** Only one of the three triangle inequality conditions needs explicit testing. Since `nums[i] >= nums[i+1] >= nums[i+2]` after sorting, `nums[i+1] < nums[i+1] + nums[i+2]` and `nums[i+2] < nums[i] + nums[i+1]` are always true. The binding constraint is always `nums[i] < nums[i+1] + nums[i+2]`.
- **Greedy correctness:** Consecutive triples in the sorted array are sufficient — no need to check non-adjacent triples. If `(a, b, c)` with `a >= b >= c` fails the inequality, replacing `b` or `c` with any smaller element only makes the sum smaller, so it can never help.
- **Mutation:** The input list is sorted in-place. Callers who need the original order must copy first.

### Error Handling

None. The function assumes valid input (list of positive integers with length >= 3, per LeetCode constraints). If `len(nums) < 3`, the loop body never executes and it returns 0, which happens to be correct but isn't explicitly guarded.

## Topics to Explore

- [file] `largest-perimeter-triangle/test_solution.py` — See what edge cases are covered (degenerate triangles, all-equal sides, minimum-length inputs)
- [file] `largest-triangle-area/solution.py` — Related triangle problem using a different geometric property (Shoelace formula vs. triangle inequality)
- [general] `greedy-sort-then-scan` — This pattern (sort + linear scan for optimal triple/pair) recurs across many LeetCode solutions in this repo
- [function] `maximum-product-of-three-numbers/solution.py:maxProduct` — Another "pick 3 from sorted array" problem with a similar greedy structure but different selection logic

## Beliefs

- `greedy-consecutive-triples-sufficiency` — After sorting descending, only consecutive triples need to be checked; non-adjacent triples can never produce a larger valid perimeter than the first valid consecutive triple.
- `single-inequality-sufficiency` — Only `nums[i] < nums[i+1] + nums[i+2]` is checked because the descending sort guarantees the other two triangle inequalities hold automatically.
- `input-mutation` — `largest_perimeter_triangle` mutates the input list in-place via `sort()`; it does not create a copy.
- `zero-as-failure-sentinel` — The function returns 0 (not `None` or `-1`) when no valid triangle can be formed, matching the LeetCode problem specification.

