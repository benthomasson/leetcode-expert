# File: check-if-it-is-a-straight-line/solution.py

**Date:** 2026-06-06
**Time:** 15:39

## `check-if-it-is-a-straight-line/solution.py`

### Purpose

Solves [LeetCode 1232 — Check If It Is a Straight Line](https://leetcode.com/problems/check-if-it-is-a-straight-line/). Given a list of 2D coordinate pairs, determines whether all points are collinear (lie on a single straight line). This is the sole solution module for this problem directory.

### Key Components

**`Solution.checkStraightLine(coordinates)`** — The only public method. Takes a list of `[x, y]` pairs and returns a boolean.

The method uses the **cross-product collinearity test**. It computes a reference direction vector `(dx, dy)` from the first two points, then checks every subsequent point against it.

### Patterns

**Cross-product instead of slope division.** The classic approach would compute slope as `dy/dx` and compare, but that breaks when `dx == 0` (vertical lines) and introduces floating-point imprecision. This solution avoids both problems by using the cross-product formulation:

```
(x_i - x_0) * dy - (y_i - y_0) * dx == 0
```

This is an integer-only comparison (assuming integer coordinates, which LeetCode guarantees), so it's exact — no epsilon needed, no division-by-zero guard.

**Anchor-point strategy.** Rather than comparing consecutive pairs, all points are measured against a single anchor (`coordinates[0]`) and direction (`coordinates[0] → coordinates[1]`). This is simpler and avoids accumulated error.

### Dependencies

**Imports:** `typing.List` — used only for the type annotation on the method signature. No runtime dependencies.

**Imported by:** `check-if-it-is-a-straight-line/test_solution.py` directly. The "Imported By" list in the prompt is misleading — it reflects test files across the entire repo that import `Solution` from their own local `solution.py`, not from this file.

### Flow

1. Extract direction vector `(dx, dy)` from `coordinates[0]` to `coordinates[1]`.
2. For each point `coordinates[i]` where `i >= 2`:
   - Compute the cross-product of the vector from `coordinates[0]` to `coordinates[i]` with `(dx, dy)`.
   - If non-zero, the point is off the line — return `False` immediately.
3. If the loop completes, all points are collinear — return `True`.

### Invariants

- **Minimum two points assumed.** The code indexes `coordinates[0]` and `coordinates[1]` unconditionally. LeetCode guarantees `len(coordinates) >= 2`, so this is safe within the problem constraints but would `IndexError` on shorter inputs.
- **Integer arithmetic.** The cross-product comparison uses `!= 0` with no tolerance, relying on the fact that LeetCode coordinates are integers. This would need an epsilon check for floating-point inputs.

### Error Handling

None. The method trusts its caller to provide valid input per the LeetCode contract. No bounds checking, no type validation, no exception handling.

## Topics to Explore

- [file] `check-if-it-is-a-straight-line/test_solution.py` — See what edge cases the test suite covers (vertical lines, two-point inputs, duplicate points)
- [file] `valid-boomerang/solution.py` — Uses the same cross-product collinearity check but inverted (tests for non-collinearity of exactly 3 points)
- [file] `largest-triangle-area/solution.py` — Another geometry problem using the cross-product — this time to compute area via the shoelace formula
- [general] `cross-product-collinearity` — Why `(x1-x0)*dy - (y1-y0)*dx == 0` is equivalent to the slope test without division

## Beliefs

- `cross-product-avoids-division-by-zero` — The collinearity check uses cross-product multiplication rather than slope division, making it correct for vertical lines without any special case
- `integer-exact-collinearity` — The `!= 0` comparison is exact (no floating-point epsilon) because LeetCode guarantees integer coordinates
- `anchor-point-is-first` — All collinearity checks measure against `coordinates[0]` as the fixed reference point, not against consecutive pairs
- `minimum-input-size-assumed` — The code assumes `len(coordinates) >= 2` without guarding; inputs shorter than 2 would raise `IndexError`

