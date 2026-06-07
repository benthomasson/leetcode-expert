# File: ugly-number/solution.py

**Date:** 2026-06-06
**Time:** 19:34

## `ugly-number/solution.py`

### Purpose

This file implements [LeetCode #263 — Ugly Number](https://leetcode.com/problems/ugly-number/). It owns the single responsibility of determining whether an integer qualifies as an "ugly number" — a positive integer whose only prime factors are 2, 3, and 5. The numbers 1, 2, 3, 4, 5, 6, 8, 10, 12, 15... are ugly; 7, 11, 13, 14... are not.

### Key Components

**`is_ugly(n: int) -> bool`** — The sole public function. Contract:
- **Input**: any integer `n`
- **Output**: `True` if `n` is an ugly number, `False` otherwise
- **Pure function** — no side effects, no mutation of external state

### Patterns

**Trial division with exhaustive factor removal.** Rather than factoring `n` completely and checking the factor set, the code takes the inverse approach: strip away all allowed factors (2, 3, 5) and check if anything remains. If `n` reduces to 1, every prime factor was in {2, 3, 5}. If not, some disallowed prime divides `n`.

This is the canonical pattern for this class of problem — it avoids explicit primality testing or full factorization.

### Dependencies

**Imports**: None. Pure Python, no standard library usage.

**Imported by**: The `ugly-number/test_solution.py` file directly. The "Imported By" list in the prompt is misleadingly long — those are unrelated test files that happen to share the same test runner infrastructure, not actual consumers of `is_ugly`.

### Flow

1. **Guard**: reject non-positive inputs immediately (`n <= 0 → False`). This handles zero and negative numbers in one check.
2. **Factor stripping loop**: iterate over the tuple `(2, 3, 5)`. For each prime `p`, divide `n` by `p` repeatedly until `p` no longer divides `n`. This is an inner `while` loop nested inside a `for` loop — O(log n) total divisions across all three primes.
3. **Residual check**: if `n == 1`, all prime factors were stripped away, so `n` was ugly. Any residual > 1 means a prime factor outside {2, 3, 5} exists.

### Invariants

- **Non-positive integers are never ugly.** The `n <= 0` guard enforces this before any division. This is important because `n = 0` would cause an infinite loop (0 % 2 == 0 forever), and negative numbers don't meet the problem's definition.
- **The factor tuple is exactly `(2, 3, 5)`.** Changing this set changes the definition of "ugly." The order doesn't affect correctness but dividing by 2 first is cheapest (bit shift under the hood).
- **Integer division (`//=`) preserves integrality.** Since the modulo check gates each division, `n` remains a positive integer throughout.

### Error Handling

None. The function handles all edge cases via its return value — there are no exceptions, assertions, or sentinel values. Invalid inputs (non-positive integers) return `False`, which aligns with the LeetCode problem spec.

## Topics to Explore

- [file] `ugly-number/test_solution.py` — See which edge cases are covered (0, 1, negative, large composites)
- [file] `ugly-number/plan.md` — The planning document may capture alternative approaches considered (e.g., precomputation, set membership)
- [general] `ugly-number-ii` — LeetCode #264 extends this to finding the nth ugly number, requiring a fundamentally different algorithm (min-heap or three-pointer merge)
- [function] `power-of-two/solution.py:is_power_of_two` — Same structural pattern (repeated division by a single factor), simpler base case
- [general] `trial-division-pattern` — Several solutions in this repo use the same strip-and-check-residual idiom (power-of-three, power-of-four, three-divisors)

## Beliefs

- `ugly-number-zero-guard` — `is_ugly(0)` returns `False` and never enters the division loop; without the `n <= 0` guard, `0 % 2 == 0` would loop forever
- `ugly-number-one-is-ugly` — `is_ugly(1)` returns `True` because 1 has no prime factors, so the loop body never executes and `n == 1` holds
- `ugly-number-complexity` — The total number of divisions across all three primes is O(log n), since each division at least halves `n`
- `ugly-number-no-imports` — The solution uses no imports; it is entirely self-contained with basic arithmetic operations

