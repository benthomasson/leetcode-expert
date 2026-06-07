# File: minimum-cuts-to-divide-a-circle/solution.py

**Date:** 2026-06-06
**Time:** 17:55

## Purpose

This file implements [LeetCode 2481: Minimum Cuts to Divide a Circle](https://leetcode.com/problems/minimum-cuts-to-divide-a-circle/). It contains both the solution function and its unit tests in a single module. Its responsibility is to compute the minimum number of straight cuts needed to divide a circle into `n` equal slices.

## Key Components

### `min_cuts(n: int) -> int`

The core solver. It exploits a geometric insight with three cases:

- **`n == 1`**: No cuts needed — the circle is already one "slice." Returns `0`.
- **`n` is even**: Each cut through the center creates two slices. A diameter produces 2 slices, two perpendicular diameters produce 4, etc. So `n // 2` cuts suffice. Returns `n // 2`.
- **`n` is odd (and > 1)**: You can't reuse any cut as a shared diameter for two slices. Each cut produces exactly one new slice boundary, so you need `n` cuts. Returns `n`.

### `TestMinCuts`

A `unittest.TestCase` covering all three branches: the `n == 1` base case, several even values (2, 4, 6, 100), and several odd values (3, 5, 99). The boundary value `n = 100` (the constraint maximum) is explicitly tested.

## Patterns

- **Single-file solution + test**: Follows the repo convention of colocating implementation and tests in `solution.py`, with a separate `test_solution.py` that imports from it (visible in the `imported_by` list).
- **Pure math, no iteration**: The function is O(1) — a closed-form formula with no loops or data structures, which is the hallmark of a "math trick" LeetCode problem.
- **Guard-clause style**: The three cases are handled as early returns rather than if/elif/else, keeping the function flat.

## Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The `test_solution.py` in this same directory imports it. The massive `imported_by` list in the prompt is an artifact of the repo's cross-referencing structure — those other test files don't actually import *this* solution; they follow the same structural pattern.

## Flow

1. Caller passes an integer `n` (1 ≤ n ≤ 100).
2. The function checks `n == 1` → returns 0.
3. Otherwise checks `n % 2 == 0` → returns `n // 2`.
4. Falls through to the odd case → returns `n`.

No state, no mutation, no side effects.

## Invariants

- **Domain constraint**: `n` must be ≥ 1. The function doesn't validate this — it relies on LeetCode's guarantee that `1 <= n <= 100`.
- **Return value relationship**: For even `n > 1`, the result is always exactly half of `n`. For odd `n > 1`, the result equals `n` itself. This means odd inputs always require more cuts than even inputs of similar magnitude.

## Error Handling

None. Invalid inputs (n ≤ 0, non-integer) would produce silently wrong results rather than exceptions. This is typical for LeetCode solutions where the problem statement guarantees valid input.

## Topics to Explore

- [file] `minimum-cuts-to-divide-a-circle/test_solution.py` — The external test file that imports this solution; may contain additional edge cases or a different test harness
- [file] `minimum-cuts-to-divide-a-circle/plan.md` — The planning document explaining the approach considered before implementation
- [file] `minimum-cuts-to-divide-a-circle/review.md` — Post-implementation review notes on correctness and alternatives
- [general] `even-odd-geometry-insight` — Why even-numbered slices allow diameter reuse (each cut passes through the center and creates two boundaries) while odd-numbered slices don't
- [general] `o1-math-solutions` — Other LeetCode solutions in this repo that reduce to closed-form math (e.g., `count-of-matches-in-tournament`, `nim-game`, `divisor-game`)

## Beliefs

- `min-cuts-three-branches` — `min_cuts` has exactly three code paths: n==1 (returns 0), n even (returns n//2), n odd (returns n), covering all valid inputs
- `min-cuts-constant-time` — The function runs in O(1) time and space with no loops, recursion, or data structures
- `min-cuts-no-input-validation` — The function does not validate that n >= 1; it trusts the caller to satisfy the LeetCode constraint
- `even-cuts-half-odd-cuts-full` — For any even n > 1 the cut count is strictly less than n, while for any odd n > 1 the cut count equals n

