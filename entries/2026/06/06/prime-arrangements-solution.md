# File: prime-arrangements/solution.py

**Date:** 2026-06-06
**Time:** 18:35

## Purpose

This file solves [LeetCode 1175: Prime Arrangements](https://leetcode.com/problems/prime-arrangements/). Given an integer `n`, it counts the number of permutations of `[1, n]` where every prime number lands on a prime-valued index (1-indexed), modulo 10^9 + 7. It owns both the solution and its unit tests in a single file.

## Key Components

**`MOD = 10**9 + 7`** (line 5) — Standard modular arithmetic constant used across competitive programming to keep results in 32-bit range.

**`numPrimeArrangements(n: int) -> int`** (line 8) — The main solver. Contract: accepts `n >= 1`, returns the count of valid permutations mod 10^9 + 7.

**`is_prime(k: int) -> bool`** (line 17) — Inner helper using trial division up to sqrt(k). Handles the `k < 2` edge case. O(sqrt(k)) per call.

**`TestNumPrimeArrangements`** (line 33) — Six test cases covering boundary values (`n=1, 2, 3`), a mid-range case (`n=5, 10`), and the upper constraint boundary (`n=100`).

## Patterns

**Combinatorial decomposition**: The key insight is that primes must occupy prime indices and non-primes must occupy non-prime indices — these are independent groups. The answer is `prime_count! * non_prime_count!`, since each group can be internally permuted freely.

**Incremental modular factorial**: Rather than computing factorials then taking mod, it folds `% MOD` into each multiplication step (lines 27-30), preventing integer overflow in languages where that matters. In Python this is unnecessary for correctness (arbitrary precision ints), but it mirrors the canonical pattern and keeps intermediate values small.

**Self-contained file**: Solution and tests coexist in one module, runnable via `python -m unittest` or `python solution.py`.

## Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The `test_solution.py` files listed in the "Imported By" section are unrelated to this solution — that list appears to be a repo-wide cross-reference artifact (hundreds of test files), not actual importers of this module's code. The sibling `prime-arrangements/test_solution.py` is the only real consumer.

## Flow

1. Count how many integers in `[1, n]` are prime → `prime_count`
2. Derive `non_prime_count = n - prime_count`
3. Compute `prime_count! mod MOD`
4. Multiply by `non_prime_count! mod MOD`
5. Return the product

The time complexity is O(n * sqrt(n)) — n primality checks, each up to O(sqrt(n)). For the constraint `n <= 100`, this is trivially fast.

## Invariants

- `prime_count + non_prime_count == n` always holds (line 24)
- The modular reduction happens at every multiplication, so `result` never exceeds `MOD * n` between steps
- `is_prime` correctly classifies 0 and 1 as non-prime via the `k < 2` guard

## Error Handling

None. The function assumes valid input (`n >= 1`). No exceptions are raised or caught. For `n = 0` or negative values, `prime_count` would be 0 and the function would return 1 (empty factorial), which is mathematically reasonable but outside the problem's constraints.

## Topics to Explore

- [file] `prime-arrangements/plan.md` — Design rationale and alternative approaches considered before implementation
- [file] `prime-arrangements/review.md` — Code review notes, potential improvements or edge case discussion
- [function] `prime-number-of-set-bits-in-binary-representation/solution.py:countPrimeSetBits` — Another solution that relies on primality testing, worth comparing the prime-checking approach
- [general] `modular-arithmetic-patterns` — How other solutions in this repo handle MOD, whether there's a shared factorial utility
- [general] `sieve-vs-trial-division` — For larger `n`, a Sieve of Eratosthenes would reduce complexity from O(n*sqrt(n)) to O(n log log n); worth understanding when each is appropriate

## Beliefs

- `prime-arrangements-factorial-decomposition` — The answer equals `factorial(prime_count) * factorial(non_prime_count) mod 10^9+7`, because primes and non-primes form two independent permutation groups
- `is-prime-trial-division-bound` — `is_prime` checks divisors only up to `int(k**0.5) + 1`, making it O(sqrt(k)) per call
- `mod-applied-per-multiply` — The modular reduction is applied at each multiplication step rather than once at the end, keeping intermediate values bounded by roughly `MOD * n`
- `n100-yields-682289015` — For `n=100` (25 primes, 75 non-primes), the expected output is 682289015, serving as a regression test for the full computation chain

