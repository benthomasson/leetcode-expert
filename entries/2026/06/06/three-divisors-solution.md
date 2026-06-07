# File: three-divisors/solution.py

**Date:** 2026-06-06
**Time:** 19:29

## `three-divisors/solution.py`

### Purpose

Solves [LeetCode 1952 — Three Divisors](https://leetcode.com/problems/three-divisors/): given a positive integer `n`, return whether it has exactly three positive divisors.

### Key Components

**`Solution.isThreeDivisors(n: int) -> bool`** — The single method. It exploits a number-theory insight rather than brute-forcing divisor counts: a number has exactly three divisors if and only if it is the square of a prime.

Why: if `n = p²` for prime `p`, its divisors are exactly `{1, p, p²}` — three of them. Any other perfect square `n = (ab)²` with `a,b > 1` picks up extra divisors. Non-squares always have divisors in pairs, giving an even count, so they can never have exactly three.

### Flow

1. **Perfect-square check** — Compute `sqrt = isqrt(n)`. If `sqrt² != n`, return `False` immediately. This eliminates all non-squares in O(1).
2. **Trivial rejection** — If `sqrt < 2`, the only candidate is `n = 1` (where `sqrt = 1`), which has exactly one divisor. Return `False`.
3. **Primality test on sqrt** — Trial division up to `isqrt(sqrt)`. If any factor divides `sqrt`, it's composite → `n` has more than three divisors → return `False`. Otherwise return `True`.

### Patterns

- **Mathematical reduction**: Converts a "count divisors" problem into "is perfect square of a prime," avoiding an O(√n) divisor-counting loop in favor of an O(n^(1/4)) primality check.
- **Standard LeetCode class convention**: Solution class with a single public method matching the problem signature.

### Dependencies

**Imports**: `math` — uses `math.isqrt` for integer square root (exact, no floating-point error).

**Imported by**: `three-divisors/test_solution.py` (directly). The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those test files import a shared test runner or solution loader, not this file specifically.

### Invariants

- `n ≥ 1` (per problem constraints, `1 <= n <= 10^4`). The code handles `n = 1` correctly via the `sqrt < 2` guard.
- `math.isqrt` returns the exact integer square root — no floating-point rounding issues. This is critical; using `int(math.sqrt(n))` could give wrong results for large perfect squares.

### Error Handling

None. The method assumes valid input per the problem constraints. No exceptions are raised or caught.

### Complexity

- **Time**: O(n^(1/4)) — the primality check on `sqrt(n)` iterates up to `isqrt(sqrt(n))`.
- **Space**: O(1).

---

## Topics to Explore

- [file] `three-divisors/test_solution.py` — Edge cases tested (n=1, n=4, n=9, primes, non-square composites)
- [function] `prime-arrangements/solution.py:Solution` — Another problem that hinges on prime detection; compare primality approaches
- [general] `isqrt-vs-sqrt` — Why `math.isqrt` is preferred over `int(math.sqrt(n))` for exact integer arithmetic
- [file] `three-divisors/plan.md` — The planning doc may capture alternative approaches considered (e.g., brute-force divisor counting)
- [general] `perfect-square-prime-equivalence` — The theorem that τ(n)=3 ⟺ n=p² for prime p; generalizes to τ(n)=k for prime-power structure

## Beliefs

- `three-divisors-perfect-square-prime` — A number has exactly three divisors iff it is the square of a prime; the solution encodes this as two sequential checks (perfect square, then primality of the root).
- `isqrt-exact-arithmetic` — The solution uses `math.isqrt` rather than `math.sqrt` to avoid floating-point precision errors in the perfect-square test.
- `primality-trial-division-bound` — The primality check on `sqrt(n)` only iterates up to `isqrt(sqrt(n))`, giving O(n^(1/4)) overall time complexity.
- `no-input-validation` — The method performs no bounds checking on `n`; it relies on the LeetCode constraint `1 <= n <= 10^4`.

