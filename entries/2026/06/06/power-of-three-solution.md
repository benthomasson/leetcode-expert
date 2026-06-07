# File: power-of-three/solution.py

**Date:** 2026-06-06
**Time:** 18:34

## `power-of-three/solution.py`

### Purpose

This file solves [LeetCode 326 — Power of Three](https://leetcode.com/problems/power-of-three/). It determines whether a given integer is a power of three (i.e., 3^0, 3^1, 3^2, ...). It's one of hundreds of self-contained solution modules in the `leetcode-implementations` repo, each owning exactly one problem.

### Key Components

**`is_power_of_three(n: int) -> bool`** — The sole function. It uses a constant-time, loop-free approach based on a number-theoretic trick rather than the naive "keep dividing by 3" strategy.

The magic constant `1162261467` is 3^19, the largest power of 3 that fits in a 32-bit signed integer (max 2^31 - 1 = 2,147,483,647). Because 3 is prime, the only divisors of 3^19 are 3^0, 3^1, ..., 3^19. So `1162261467 % n == 0` is true if and only if `n` is a power of three.

The `n > 0` guard rejects zero and negatives — no negative integer or zero is a power of three, and `% 0` would be a `ZeroDivisionError`.

### Patterns

- **Mathematical shortcut over iteration**: Instead of a loop (`while n % 3 == 0: n //= 3`) which is O(log n), this is O(1) time and space. The tradeoff is readability — the magic number requires the docstring to make sense.
- **Problem-scoped constraint exploitation**: The solution assumes 32-bit signed integer range, which is the constraint LeetCode specifies. If `n` could exceed 2^31, this approach breaks — you'd need a larger maximal power of 3.

### Dependencies

**Imports**: None. Pure arithmetic, no standard library needed.

**Imported by**: The `power-of-three/test_solution.py` file imports this function directly. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that likely share a common test harness import pattern, not actual consumers of `is_power_of_three`.

### Flow

1. Caller passes an integer `n`.
2. Check `n > 0` — short-circuits to `False` for non-positive inputs.
3. Compute `1162261467 % n` — if the remainder is 0, `n` divides 3^19, meaning `n` is itself a power of 3.
4. Return the boolean result.

### Invariants

- **Domain constraint**: Only valid for inputs in the 32-bit signed integer range. For larger inputs, 3^19 is no longer the correct ceiling.
- **Primality dependency**: The trick works because 3 is prime. For composite bases (e.g., "power of 6"), the largest power of the base would have divisors that aren't themselves powers of the base, and this approach would produce false positives.

### Error Handling

None needed. The `n > 0` guard prevents the only runtime error (`ZeroDivisionError` when `n == 0`). All other inputs produce a valid boolean. No exceptions are raised or caught.

---

## Topics to Explore

- [file] `power-of-three/test_solution.py` — See what edge cases are tested (0, 1, negative numbers, large powers)
- [file] `power-of-two/solution.py` — Compare with the bit-manipulation approach for power-of-two (likely `n & (n-1) == 0`), a different class of mathematical shortcut
- [file] `power-of-four/solution.py` — Power-of-four requires a combined bit-manipulation + modular arithmetic approach; shows how the strategy shifts for composite-like constraints
- [general] `divisibility-vs-iteration-tradeoffs` — When constant-time modular tricks apply (prime bases, bounded input range) versus when iterative division is necessary
- [file] `ugly-number/solution.py` — Generalizes the "repeatedly divide by allowed primes" pattern to multiple bases (2, 3, 5)

## Beliefs

- `power-of-three-constant-time` — `is_power_of_three` runs in O(1) time and space with no loops or recursion
- `power-of-three-magic-constant` — The constant 1162261467 equals 3^19, the largest power of 3 below 2^31, and this is load-bearing for correctness
- `power-of-three-32bit-assumption` — The solution is only correct for inputs in [-2^31, 2^31-1]; inputs above 3^19 that are powers of 3 (e.g., 3^20) would return `False`
- `power-of-three-prime-dependency` — The divisibility trick is valid because 3 is prime; applying the same pattern to a composite base would produce false positives

