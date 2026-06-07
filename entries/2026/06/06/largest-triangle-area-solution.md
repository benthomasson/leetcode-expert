# File: largest-triangle-area/solution.py

**Date:** 2026-06-06
**Time:** 17:18

## `largest-triangle-area/solution.py`

### Purpose

This file solves [LeetCode 812 — Largest Triangle Area](https://leetcode.com/problems/largest-triangle-area/). Given a list of 2D points, it finds the maximum area among all triangles formed by any three of those points. It's a brute-force combinatorial geometry solution.

### Key Components

**`Solution.largestTriangleArea(self, points: list[list[int]]) -> float`**

The single method. Takes a list of `[x, y]` coordinate pairs and returns the largest triangle area as a float.

The area computation uses the **Shoelace formula** (a.k.a. the surveyor's formula), which computes a triangle's area from vertex coordinates without needing side lengths or angles:

```
area = |x1(y2 - y3) + x2(y3 - y1) + x3(y1 - y2)| / 2
```

This is equivalent to half the absolute value of the cross product of two edge vectors, which gives the area of the parallelogram they span.

### Patterns

- **Brute-force enumeration**: Iterates over all C(n, 3) triples. No pruning, no convex hull optimization. For the problem's constraint (n ≤ 50), this is O(n³) ≈ 125k iterations — perfectly fine.
- **Tuple unpacking in the loop header**: `for (x1, y1), (x2, y2), (x3, y3) in combinations(points, 3)` destructures each 3-combination into six named scalars in one shot, keeping the formula readable.
- **Running-max idiom**: Tracks `max_area` with a comparison rather than collecting all areas and calling `max()`, avoiding unnecessary allocation.

### Dependencies

- **Imports**: `itertools.combinations` — generates all unordered 3-element subsets.
- **Imported by**: `largest-triangle-area/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of how the repo's test harness discovers solution modules — those test files don't actually call `largestTriangleArea`.

### Flow

1. Initialize `max_area = 0.0`.
2. For each triple of points from `combinations(points, 3)`:
   - Destructure into `(x1, y1)`, `(x2, y2)`, `(x3, y3)`.
   - Compute the triangle area via the Shoelace formula.
   - Update `max_area` if this area is larger.
3. Return `max_area`.

### Invariants

- The Shoelace formula returns 0 for collinear points (degenerate triangle), so collinear triples naturally contribute area 0 and never win the max unless all points are collinear.
- `abs()` makes the formula orientation-independent — the vertex winding order doesn't matter.
- `max_area` starts at `0.0`, so if every triple is degenerate, the function returns `0.0`.

### Error Handling

None. The function trusts its input matches the LeetCode contract (at least 3 points, integer coordinates). Passing fewer than 3 points would cause `combinations` to yield nothing, and the function would silently return `0.0`.

---

## Topics to Explore

- [file] `largest-triangle-area/test_solution.py` — See what edge cases are tested (collinear points, minimal input, negative coords)
- [file] `valid-boomerang/solution.py` — Related geometry problem using the same cross-product / collinearity check
- [file] `check-if-it-is-a-straight-line/solution.py` — Another collinearity problem; compare how the cross-product formula is applied there
- [general] `shoelace-formula-extensions` — The Shoelace formula generalizes to arbitrary polygons; understanding the general form clarifies why dividing by 2 works for triangles
- [general] `convex-hull-optimization` — For large n, computing the convex hull first (O(n log n)) and only checking hull vertices would reduce the search space, since the largest triangle always has vertices on the hull

## Beliefs

- `shoelace-returns-zero-for-collinear` — The Shoelace formula produces area 0 exactly when the three points are collinear, so degenerate triangles are handled implicitly without a separate check.
- `brute-force-cubic-complexity` — The solution enumerates all C(n,3) triples with no pruning, giving O(n³) time complexity.
- `orientation-independent` — The `abs()` call makes the area computation independent of vertex ordering (clockwise vs counterclockwise).
- `no-input-validation` — The function performs no validation on input length or coordinate types; it relies on the LeetCode constraint guaranteeing at least 3 well-formed points.

