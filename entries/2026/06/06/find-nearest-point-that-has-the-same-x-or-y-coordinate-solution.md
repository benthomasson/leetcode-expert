# File: find-nearest-point-that-has-the-same-x-or-y-coordinate/solution.py

**Date:** 2026-06-06
**Time:** 16:39

## Purpose

This file solves [LeetCode 1779: Find Nearest Point That Has the Same X or Y Coordinate](https://leetcode.com/problems/find-nearest-point-that-has-the-same-x-or-y-coordinate/). It implements a single function that finds the index of the closest "valid" point — one sharing an x- or y-coordinate with a reference location — using Manhattan distance as the metric.

## Key Components

### `nearestValidPoint(x, y, points) -> int`

**Contract**: Given a reference point `(x, y)` and a list of coordinate pairs, return the index of the nearest point that shares either `x` or `y` with the reference. If no valid point exists, return `-1`. On ties, the smallest index wins (guaranteed by the strict `<` comparison — first occurrence is kept).

**Parameters**:
- `x`, `y`: the query coordinates (integers)
- `points`: list of `[ai, bi]` pairs

**Return**: index into `points`, or `-1`

## Patterns

**Linear scan with running minimum** — the classic pattern for finding an extremum in a single pass. No sorting, no heap, no auxiliary data structure. The sentinel `float('inf')` for `min_dist` avoids a special case for the first valid point.

**Filter-then-reduce fused into one loop** — the validity check (`ai == x or bi == y`) and the distance comparison happen in the same iteration, avoiding a second pass or intermediate list.

## Dependencies

**Imports**: None. Pure function with no standard-library or third-party dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files from *other* problems that happen to share a common test harness structure. The actual consumer is `find-nearest-point-that-has-the-same-x-or-y-coordinate/test_solution.py`.

## Flow

1. Initialize `min_dist = inf`, `min_idx = -1`.
2. Iterate over `points` with index via `enumerate`, destructuring each point as `(ai, bi)`.
3. **Validity gate**: skip any point where neither coordinate matches.
4. **Distance**: compute Manhattan distance `|x - ai| + |y - bi|`.
5. **Update**: if this distance is strictly less than the current minimum, record it.
6. Return `min_idx` (still `-1` if no valid point was found).

## Invariants

- **Valid point definition**: a point is valid iff `ai == x` or `bi == y`. This is an OR, not AND — sharing *either* axis suffices.
- **Tie-breaking by index**: `dist < min_dist` (strict inequality) means the first valid point at a given distance wins. This matches the LeetCode problem's tie-breaking rule.
- **Manhattan distance is always non-negative**: guaranteed by the absolute values. A valid point at the same location as `(x, y)` has distance 0 and will always be selected.

## Error Handling

None. The function trusts its inputs — no type checks, no bounds validation. If `points` is empty or contains no valid points, the sentinel `-1` is returned. This is correct per the LeetCode contract.

## Complexity

- **Time**: O(n) — single pass over `points`.
- **Space**: O(1) — only two scalar trackers.

## Topics to Explore

- [file] `find-nearest-point-that-has-the-same-x-or-y-coordinate/test_solution.py` — See what edge cases the tests cover (empty list, all invalid, tie-breaking)
- [file] `find-nearest-point-that-has-the-same-x-or-y-coordinate/plan.md` — The solution planning document may reveal alternative approaches considered
- [function] `minimum-time-visiting-all-points/solution.py:minTimeToVisitAllPoints` — Another Manhattan-distance problem in the repo; compare how the metric is used differently
- [general] `valid-point-filtering-patterns` — Several problems in this repo filter points by geometric predicates before optimizing; compare with `find-closest-number-to-zero` and `find-the-distance-value-between-two-arrays`

## Beliefs

- `nearest-valid-point-returns-first-index-on-tie` — When multiple valid points share the minimum Manhattan distance, the function returns the smallest index due to strict `<` comparison
- `nearest-valid-point-or-means-either-axis` — A point is valid if it shares the x-coordinate OR the y-coordinate (not necessarily both)
- `nearest-valid-point-single-pass` — The solution runs in O(n) time with O(1) space, fusing the filter and argmin into one loop
- `nearest-valid-point-no-imports` — The function is self-contained with zero imports, depending only on Python builtins (`float`, `abs`, `enumerate`)

