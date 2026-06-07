# File: smallest-even-multiple/solution.py

**Date:** 2026-06-06
**Time:** 19:08

## `smallest-even-multiple/solution.py`

### Purpose

This file solves [LeetCode 2413: Smallest Even Multiple](https://leetcode.com/problems/smallest-even-multiple/). Given a positive integer `n`, it returns the smallest positive integer that is a multiple of both 2 and `n` — i.e., the LCM of `n` and 2.

It's a leaf module in the repo: no imports, no dependencies. Its only consumer is `smallest-even-multiple/test_solution.py`.

### Key Components

**`smallest_multiple(n: int) -> int`** — the sole public function.

- **Contract**: accepts an integer in `[1, 150]`, returns the LCM of `n` and 2.
- **Core logic** (line 22): `n if n % 2 == 0 else n * 2`. If `n` is already even, `n` itself is the smallest common multiple. If odd, `n * 2` is.

### Patterns

**Direct mathematical insight over general-purpose algorithms.** The problem is technically "find LCM(n, 2)", but since 2 is prime, the solution collapses to a parity check. No `math.gcd` import needed — the entire solution is a single ternary expression.

**Defensive input validation.** The function checks type (`isinstance`) and range bounds before doing any work, which is a pattern used across this repo's solutions.

**Docstring with examples.** The docstring includes `>>>` examples that double as informal documentation, though they aren't wired into a doctest runner.

### Dependencies

- **Imports**: None.
- **Imported by**: `smallest-even-multiple/test_solution.py` (and listed as imported by ~400+ other test files in the "Imported By" section, but that list appears to be a repo-wide cross-reference artifact — those test files import their own respective solutions, not this one).

### Flow

1. Validate `n` is an `int` in `[1, 150]`. Raise `ValueError` if not.
2. Check parity: even → return `n`; odd → return `n * 2`.

No loops, no recursion, no branching beyond the single ternary. O(1) time and space.

### Invariants

- `n` must be a Python `int` — floats like `6.0` are rejected by the `isinstance` check even though they're mathematically valid.
- The return value is always even (guaranteed by construction: either `n` is already even, or `n * 2` is).
- The return value is always a multiple of `n` (either `n` itself or `2n`).

### Error Handling

A single `ValueError` with a descriptive f-string message is raised for any input outside the valid domain. No try/except, no silent fallbacks. The caller is expected to pass valid input; violations are loud.

---

## Topics to Explore

- [file] `smallest-even-multiple/test_solution.py` — See what edge cases the tests cover (n=1, even vs odd, boundary 150)
- [file] `smallest-even-multiple/review.md` — The code review for this solution may note the type-check strictness or alternative approaches
- [general] `lcm-vs-parity-check` — Why LCM(n, 2) reduces to a parity check: 2 is prime, so gcd(n, 2) is either 1 or 2, making the general LCM formula overkill
- [function] `add-digits/solution.py:add_digits` — Another example of a math problem where a direct formula replaces iteration

## Beliefs

- `smallest-multiple-returns-even` — `smallest_multiple` always returns an even integer for any valid input
- `smallest-multiple-rejects-floats` — `smallest_multiple(6.0)` raises `ValueError` because the `isinstance(n, int)` check excludes floats
- `smallest-multiple-no-imports` — The solution has zero import dependencies, using only built-in arithmetic operators
- `smallest-multiple-is-lcm-of-n-and-2` — The return value equals `lcm(n, 2)` for all valid inputs, computed via parity check rather than `math.gcd`

