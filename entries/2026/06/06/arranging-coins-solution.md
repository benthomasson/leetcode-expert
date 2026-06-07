# File: arranging-coins/solution.py

**Date:** 2026-06-06
**Time:** 15:15

## `arranging-coins/solution.py`

### Purpose

Solves [LeetCode 441 — Arranging Coins](https://leetcode.com/problems/arranging-coins/). Given `n` coins, you build a staircase where row `k` requires exactly `k` coins. The function returns how many complete rows you can fill.

### Key Components

**`arrange_coins(n: int) -> int`** — The sole public function. Takes a coin count and returns the number of complete staircase rows.

The implementation is a closed-form O(1) solution using the quadratic formula. The number of complete rows `k` satisfies:

```
k * (k + 1) / 2 <= n
```

Rearranging into a quadratic `k^2 + k - 2n <= 0` and solving gives:

```
k = floor((-1 + sqrt(1 + 8n)) / 2)
```

Which is exactly what `(isqrt(8 * n + 1) - 1) // 2` computes using integer arithmetic.

### Patterns

- **Direct math over simulation**: Instead of iterating row-by-row and subtracting (O(sqrt(n))), or binary searching (O(log n)), this uses the closed-form solution for O(1) time. This is the canonical "recognize the triangular number" pattern.
- **Integer square root for exactness**: Uses `math.isqrt` instead of `int(math.sqrt(...))` to avoid floating-point precision issues. `isqrt` is exact for arbitrarily large integers — critical since `n` can be up to 2^31 - 1.

### Dependencies

**Imports**: `math.isqrt` (Python 3.8+) — computes the integer square root without floating-point intermediate.

**Imported by**: `arranging-coins/test_solution.py` directly. The "Imported By" list in the prompt is the full test suite across all problems — those files import their own respective solutions, not this one.

### Flow

1. Compute `8 * n + 1` (the discriminant of the quadratic).
2. Take the integer square root.
3. Subtract 1 and integer-divide by 2.
4. Return the result.

Single expression, no branching, no allocation.

### Invariants

- **Input constraint**: `1 <= n <= 2^31 - 1`. The function doesn't validate this — it trusts the caller (LeetCode guarantees it).
- **No overflow concern in Python**: `8 * n + 1` can reach ~1.7 * 10^10, which is fine since Python integers are arbitrary precision.
- **`isqrt` correctness**: For any non-negative integer `m`, `isqrt(m)` returns the largest integer `k` such that `k^2 <= m`. This guarantees the floor behavior needed by the formula.

### Error Handling

None. The function assumes valid input per the problem constraints. Passing `n < 0` would cause `isqrt` to raise a `ValueError`.

## Topics to Explore

- [file] `arranging-coins/test_solution.py` — Verify which edge cases are covered (n=1, n=2, large n near 2^31-1)
- [function] `arranging-coins/solution.py:arrange_coins` — Compare against a binary search implementation to understand the tradeoff between mathematical insight and algorithmic generality
- [general] `triangular-number-problems` — Other LeetCode problems that reduce to triangular number formulas (e.g., 1281 — Subtract the Product and Sum, find-the-pivot-integer)
- [file] `arranging-coins/plan.md` — See what alternative approaches were considered before settling on the closed-form

## Beliefs

- `arranging-coins-uses-closed-form` — `arrange_coins` solves the staircase problem in O(1) time via the quadratic formula for triangular numbers, not iteration or binary search
- `arranging-coins-exact-integer-arithmetic` — Uses `math.isqrt` to avoid floating-point precision errors that `int(math.sqrt(...))` would introduce for large inputs near 2^31-1
- `arranging-coins-no-input-validation` — The function performs no bounds checking on `n`; passing negative values will raise `ValueError` from `isqrt`
- `arranging-coins-formula-equivalence` — The expression `(isqrt(8*n+1) - 1) // 2` is mathematically equivalent to `floor((-1 + sqrt(1 + 8n)) / 2)`, the positive root of `k^2 + k - 2n = 0`

