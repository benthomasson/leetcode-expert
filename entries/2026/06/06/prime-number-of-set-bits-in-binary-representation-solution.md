# File: prime-number-of-set-bits-in-binary-representation/solution.py

**Date:** 2026-06-06
**Time:** 18:35

## `prime-number-of-set-bits-in-binary-representation/solution.py`

### Purpose

This file solves [LeetCode 762: Prime Number of Set Bits in Binary Representation](https://leetcode.com/problems/prime-number-of-set-bits-in-binary-representation/). Given a range `[left, right]`, it counts how many integers in that range have a prime number of 1-bits in their binary representation.

### Key Components

**`is_prime(n: int) -> bool`** — Primality check via set membership rather than computation. The set `{2, 3, 5, 7, 11, 13, 17, 19}` is hardcoded because the problem constrains `left` and `right` to at most `10^6`, which is less than `2^20`. A 20-bit number has at most 20 set bits, and all primes up to 20 are covered by this set.

**`countPrimeSetBits(left: int, right: int) -> int`** — The main entry point, following LeetCode's camelCase naming convention. It iterates every integer in `[left, right]`, counts its set bits via `bin(n).count('1')`, checks primality, and sums the results.

### Patterns

- **Lookup table over computation**: `is_prime` uses a frozen set instead of trial division. This is the right call — the domain is bounded (0–20), so enumeration is both faster and more readable than a general primality algorithm.
- **Generator expression inside `sum()`**: The entire solution is a single expression, avoiding explicit loops and accumulators. Idiomatic Python for count-with-predicate problems.
- **`bin().count('1')` for popcount**: Python's standard way to count set bits. No bit-manipulation tricks needed.

### Dependencies

**Imports**: None — the solution uses only Python builtins (`bin`, `sum`, `range`, `set`).

**Imported by**: The `test_solution.py` in the same directory. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a common test harness import pattern, not actual consumers of this module's functions.

### Flow

1. `countPrimeSetBits(left, right)` is called with the range bounds.
2. A generator iterates `n` from `left` to `right` inclusive.
3. For each `n`: `bin(n)` produces a string like `'0b1101'`, `.count('1')` returns the popcount (3 in this case).
4. `is_prime(popcount)` checks membership in the hardcoded set → `True` or `False`.
5. `sum()` counts the `True` values (each coerces to 1).

### Invariants

- The hardcoded prime set is complete for inputs up to `2^20 - 1` (1,048,575). If the problem constraints changed to allow larger inputs (e.g., 64-bit integers), the set would need primes up to 64 — specifically adding `23, 29, 31, 37, 41, 43, 47, 53, 59, 61`.
- `right + 1` in `range()` ensures the upper bound is inclusive, matching the problem statement.

### Error Handling

None. The function assumes valid inputs per LeetCode's guarantees (`1 ≤ left ≤ right ≤ 10^6`). No bounds checking, no type validation. If `left > right`, the range is empty and the function returns 0 — a harmless no-op rather than an error.

---

## Topics to Explore

- [file] `prime-number-of-set-bits-in-binary-representation/test_solution.py` — See the test cases and edge conditions exercised against this solution
- [function] `counting-bits/solution.py:countBits` — Related problem that also builds on popcount, but computes set bits for every number 0..n using DP
- [function] `number-of-1-bits/solution.py:hammingWeight` — The underlying popcount primitive this solution delegates to `bin().count('1')`
- [file] `prime-arrangements/solution.py` — Another prime-dependent problem; compare how it handles primality (likely similar bounded-set approach)
- [general] `python-popcount-alternatives` — Compare `bin(n).count('1')` vs `n.bit_count()` (Python 3.10+) vs Kernighan's bit trick for performance tradeoffs

---

## Beliefs

- `is-prime-covers-0-to-20` — `is_prime` returns correct results for all integers 0–20 and is sufficient for inputs up to `2^20 - 1`
- `set-membership-over-trial-division` — Primality is checked via O(1) set lookup, not computed, because the domain is bounded by problem constraints
- `no-external-dependencies` — The solution uses only Python builtins and imports nothing
- `inclusive-range-contract` — `countPrimeSetBits` treats both `left` and `right` as inclusive bounds, matching the LeetCode problem specification

