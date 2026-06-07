# File: valid-boomerang/solution.py

**Date:** 2026-06-06
**Time:** 19:37

## Purpose

This file solves [LeetCode 1037 — Valid Boomerang](https://leetcode.com/problems/valid-boomerang/). It determines whether three 2D points form a "boomerang" — three distinct, non-collinear points. It owns exactly one responsibility: the collinearity check for a triple of points.

## Key Components

### `Solution.isBoomerang`

**Contract**: Takes a list of exactly three `[x, y]` coordinate pairs. Returns `True` if the three points are not collinear (i.e., they form a triangle with nonzero area), `False` otherwise.

The entire solution is a single expression — the cross product of two vectors:

```python
(x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1) != 0
```

This computes the z-component of the cross product of vectors `(P1→P2)` and `(P1→P3)`. If it's zero, the three points are collinear (or at least two are identical); if nonzero, they form a valid boomerang.

## Patterns

**Cross-product collinearity test** — instead of computing slopes (which requires division and special-casing vertical lines / division by zero), the solution uses the cross product. This is the standard idiom for collinearity in computational geometry: it's branchless, works for all orientations including vertical/horizontal lines, and uses only integer arithmetic when inputs are integers, avoiding floating-point precision issues entirely.

**Destructuring assignment** — the tuple unpack `(x1, y1), (x2, y2), (x3, y3) = points` gives each coordinate a readable name in one line.

## Dependencies

**Imports**: `typing.List` — used only for the type annotation on the method signature.

**Imported by**: `valid-boomerang/test_solution.py` directly. The "Imported By" list in the prompt is misleading — it shows every test file across the entire repo because they all import `Solution` from their respective `solution.py`, not from this file specifically.

## Flow

1. Destructure the three points into six scalar coordinates.
2. Compute the cross product of vectors `P1→P2` and `P1→P3`.
3. Return whether the result is nonzero.

No loops, no branches, no allocations. O(1) time and space.

## Invariants

- The cross product is zero **if and only if** the points are collinear. This covers all degenerate cases: two identical points, three identical points, and three distinct but collinear points.
- Integer arithmetic only (assuming integer inputs from LeetCode constraints), so there are no floating-point rounding concerns.

## Error Handling

None. The function assumes exactly three points, each with exactly two coordinates, as guaranteed by the LeetCode problem constraints. A malformed input (fewer points, wrong dimensions) would raise a `ValueError` from the destructuring unpack — this is fine since the caller is responsible for honoring the contract.

## Topics to Explore

- [file] `valid-boomerang/test_solution.py` — See what edge cases are covered (duplicate points, horizontal/vertical lines, etc.)
- [file] `check-if-it-is-a-straight-line/solution.py` — Uses the same cross-product collinearity test generalized to N points
- [file] `largest-triangle-area/solution.py` — Uses the cross product to compute area rather than just checking for zero
- [general] `cross-product-collinearity` — Why cross product beats slope comparison: no division-by-zero edge cases, exact integer arithmetic, single expression

## Beliefs

- `boomerang-cross-product-equivalence` — The cross product being nonzero is equivalent to the three points being distinct and non-collinear; no separate duplicate-point check is needed.
- `boomerang-integer-only` — The solution uses only integer multiplication and subtraction, avoiding all floating-point precision issues.
- `boomerang-constant-complexity` — `isBoomerang` executes in O(1) time and O(1) space with no loops or conditionals.
- `boomerang-no-slope-division` — The solution avoids slope-based comparison (`dy/dx`), which would require handling vertical lines and division by zero as special cases.

