# File: number-of-common-factors/solution.py

**Date:** 2026-06-06
**Time:** 18:15

## Purpose

This file solves [LeetCode 2427: Number of Common Factors](https://leetcode.com/problems/number-of-common-factors/). Given two positive integers `a` and `b`, it counts how many integers evenly divide both. It's a single-function module following the repo's convention of one solution per problem directory.

## Key Components

### `common_factors(a: int, b: int) -> int`

The sole public function. Instead of the naive approach (iterate 1 to `min(a, b)` and test divisibility against both), it reduces the problem: any common factor of `a` and `b` must also be a factor of `gcd(a, b)`. So it computes the GCD once, then counts divisors of that single number.

## Patterns

**GCD reduction** — The key insight is that `{d : d | a and d | b} == {d : d | gcd(a, b)}`. This converts a two-variable problem into a single-variable divisor-counting problem.

**Square-root divisor enumeration** — Rather than checking every integer from 1 to `g`, the loop only runs while `i * i <= g`. Each divisor `i` found below the square root implies a paired divisor `g // i` above it, so both are counted in one step. The `i != g // i` guard avoids double-counting when `i` is exactly the square root (i.e., `g` is a perfect square).

This is a standard number-theory idiom that drops the divisor-counting cost from O(g) to O(sqrt(g)).

## Dependencies

**Imports:** `math.gcd` — the only external dependency, from the standard library.

**Imported by:** The `test_solution.py` in the same directory. The large "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those are other problem directories whose test files share a common test harness, not actual consumers of this function.

## Flow

1. Compute `g = gcd(a, b)`.
2. Initialize `count = 0`, `i = 1`.
3. While `i * i <= g`:
   - If `g % i == 0`: increment `count`. If the paired divisor `g // i` differs from `i`, increment again.
   - Increment `i`.
4. Return `count`.

For example, `common_factors(12, 6)`: `gcd(12, 6) = 6`. Divisors of 6 are {1, 2, 3, 6} → returns 4.

## Invariants

- `a` and `b` are assumed positive (per the LeetCode constraint). No validation is performed — `math.gcd` handles zero but the problem guarantees positive inputs.
- The loop invariant: after processing iteration `i`, `count` holds the number of divisors of `g` that are ≤ `i` or are the paired divisor of some `j ≤ i`.

## Error Handling

None. The function trusts its inputs match the LeetCode contract (1 ≤ a, b ≤ 1000). Passing zero or negative values would still produce a result via `math.gcd`'s behavior, but correctness isn't guaranteed outside the stated domain.

## Topics to Explore

- [file] `number-of-common-factors/test_solution.py` — See what edge cases are covered (e.g., coprime inputs, equal inputs, one divides the other)
- [function] `find-greatest-common-divisor-of-array/solution.py:findGCD` — Another GCD-based solution in the repo; compare how GCD is applied differently
- [general] `sqrt-divisor-enumeration` — The O(sqrt(n)) divisor-counting technique reappears in problems like three-divisors and perfect-number; worth understanding as a reusable primitive
- [file] `number-of-common-factors/plan.md` — The planning doc may capture alternative approaches that were considered and rejected

## Beliefs

- `gcd-reduces-common-factor-counting` — The set of common factors of (a, b) equals the set of divisors of gcd(a, b), so the function only enumerates divisors of the GCD
- `sqrt-loop-gives-sublinear-complexity` — The divisor enumeration runs in O(sqrt(gcd(a,b))) time, not O(min(a,b)), by pairing divisors above and below the square root
- `perfect-square-guard-prevents-double-count` — The `i != g // i` check ensures that when g is a perfect square, its square root is counted exactly once
- `no-input-validation` — The function performs no bounds checking; it relies on the caller (LeetCode harness) to satisfy 1 ≤ a, b ≤ 1000

