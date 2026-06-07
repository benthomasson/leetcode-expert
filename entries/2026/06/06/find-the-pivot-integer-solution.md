# File: find-the-pivot-integer/solution.py

**Date:** 2026-06-06
**Time:** 16:48

## Purpose

This file solves [LeetCode 2485: Find the Pivot Integer](https://leetcode.com/problems/find-the-pivot-integer/). It finds an integer `x` in `[1, n]` where the sum of all integers from 1 to `x` equals the sum from `x` to `n`. It exports a single function `find_pivot` used by the corresponding test file.

## Key Components

### `find_pivot(n: int) -> int`

The only function. Takes a positive integer `n` and returns the pivot `x`, or `-1` if none exists.

The key insight is algebraic. The pivot condition is:

```
sum(1..x) == sum(x..n)
```

Both sides include `x`, so expanding:

```
x*(x+1)/2 == x + (x+1) + ... + n = n*(n+1)/2 - x*(x-1)/2
```

Simplifying yields `x^2 = n*(n+1)/2`. So the pivot exists if and only if the triangular number `T(n) = n*(n+1)/2` is a perfect square.

## Patterns

**Closed-form math instead of iteration.** Rather than looping through candidates or maintaining prefix sums, the solution reduces to a single formula evaluation. This is O(1) time and space — the best you can do for this problem.

**`isqrt` for exact integer square root checking.** The pattern `x = isqrt(total); x * x == total` is the canonical way to test perfect squares in Python without floating-point precision issues. `math.isqrt` returns the floor of the exact square root, so the round-trip check is exact.

## Dependencies

**Imports:** `math.isqrt` — Python's integer square root (available since 3.8). No project-internal dependencies.

**Imported by:** `find-the-pivot-integer/test_solution.py` directly. The massive "Imported By" list in the context is noise — those are test files for *other* problems that happen to share a test harness pattern; they don't actually call `find_pivot`.

## Flow

1. Compute `total = n*(n+1) // 2` — the sum of integers 1 through `n`.
2. Compute `x = isqrt(total)` — the largest integer whose square is ≤ `total`.
3. If `x * x == total`, then `x` is the pivot. Return it.
4. Otherwise, no pivot exists. Return `-1`.

No loops, no branching beyond the single `if`.

## Invariants

- **Input range:** `1 <= n <= 1000` per the problem constraints. The function doesn't validate this — it trusts the caller (appropriate for LeetCode).
- **Integer arithmetic throughout.** The `//` in `n * (n + 1) // 2` and the use of `isqrt` (not `sqrt`) ensure no floating-point is involved. This avoids precision bugs that would surface with `int(math.sqrt(...))` for large values.
- **At most one pivot exists.** Since `x^2 = T(n)` has at most one positive solution, the function either returns that unique value or `-1`.

## Error Handling

None. The function assumes valid input and has no failure modes beyond the "not found" case, which it signals with `-1` (the LeetCode convention).

## Topics to Explore

- [file] `find-the-pivot-integer/test_solution.py` — See what test cases validate this solution and how edge cases (n=1, no-pivot cases) are covered
- [file] `find-pivot-index/solution.py` — A related but different problem (pivot index in an array vs. pivot integer in a range) — compare the prefix-sum approach there
- [general] `isqrt-vs-sqrt-precision` — Why `math.isqrt` is correct here but `int(math.sqrt(n))` can fail for large perfect squares due to float rounding
- [function] `arranging-coins/solution.py:arrangeCoins` — Another problem that reduces to solving a quadratic/triangular number equation

## Beliefs

- `pivot-integer-o1-complexity` — `find_pivot` runs in O(1) time and space with no loops or recursion
- `pivot-integer-exact-arithmetic` — The solution uses only integer arithmetic (`//` and `isqrt`), avoiding floating-point precision issues entirely
- `pivot-unique-or-absent` — For any given `n`, there is at most one pivot integer; the function returns it or `-1`
- `pivot-integer-no-input-validation` — The function does not validate that `n` is in `[1, 1000]`; it trusts the caller per LeetCode convention

