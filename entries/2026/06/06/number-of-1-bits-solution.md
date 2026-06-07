# File: number-of-1-bits/solution.py

**Date:** 2026-06-06
**Time:** 18:14

## `number-of-1-bits/solution.py`

### Purpose

This file implements LeetCode problem #191 "Number of 1 Bits" (also known as the Hamming weight problem). It provides a single function that counts set bits in a 32-bit unsigned integer. Despite being scoped to one problem, the "Imported By" list shows it's referenced by hundreds of test files across the repo — likely because the test harness uses a shared import pattern, not because other solutions call `hamming_weight` directly.

### Key Components

**`hamming_weight(n: int) -> int`** — The sole export. Takes an integer, returns the count of `1` bits in its binary representation.

### Patterns

The implementation uses **Brian Kernighan's bit-clearing algorithm** rather than the naive approach of shifting and checking each bit. The key insight is the expression `n &= n - 1`, which clears the lowest set bit in each iteration.

How it works for `n = 12` (binary `1100`):
1. `n - 1` = `1011`. `n & (n-1)` = `1000`. count = 1.
2. `n - 1` = `0111`. `n & (n-1)` = `0000`. count = 2.
3. `n` is 0, loop exits. Return 2.

This is strictly better than a 32-iteration shift-and-mask loop: it iterates exactly *k* times where *k* is the number of set bits. For sparse inputs (few 1s), it terminates much faster.

### Dependencies

**Imports:** None — pure computation with no external dependencies.

**Imported by:** The massive "Imported By" list (300+ test files) is an artifact of the repo's test scaffolding structure, not an indication that other solutions depend on this function. The test runner or test template likely imports all solution modules uniformly.

### Flow

1. Initialize `count = 0`.
2. While `n` is nonzero: clear the lowest set bit with `n &= n - 1`, increment `count`.
3. Return `count`.

The loop body is two operations per iteration with no branches, making it cache-friendly and branch-predictor-friendly.

### Invariants

- **Loop invariant:** At each iteration start, `count` equals the number of set bits already cleared from the original `n`.
- **Termination guarantee:** Each iteration strictly reduces the number of set bits by exactly one, so the loop always terminates in at most 32 iterations (for a 32-bit input).
- **Input assumption:** The docstring says "unsigned 32-bit integer," but Python integers are arbitrary-precision. The algorithm works correctly for any non-negative integer — it just isn't bounded to 32 iterations for values above 2^32.

### Error Handling

None. Negative inputs would cause an infinite loop in CPython (Python integers are arbitrary-width, so `-1 & -2` is still negative), but the contract states the input is unsigned.

## Topics to Explore

- [file] `number-of-1-bits/test_solution.py` — See how the function is tested and what edge cases are covered (0, all-ones, single bit)
- [function] `counting-bits/solution.py:countBits` — Related problem that computes Hamming weight for every integer 0..n, likely using this same bit trick or DP on it
- [function] `hamming-distance/solution.py:hammingDistance` — XORs two numbers then counts set bits — a direct consumer of the same algorithm
- [general] `brian-kernighan-bit-trick` — The `n & (n-1)` pattern appears in several solutions (power-of-two, number-complement); understanding it once unlocks them all
- [file] `sort-integers-by-the-number-of-1-bits/solution.py` — Uses popcount as a sort key, showing how Hamming weight composes into higher-level problems

## Beliefs

- `kernighan-loop-count` — `hamming_weight` iterates exactly *k* times where *k* is the number of set bits, not a fixed 32 iterations
- `no-negative-input-guard` — The function has no guard against negative inputs, which would cause non-termination on arbitrary-precision Python ints
- `zero-dependency-module` — `solution.py` has no imports; it is a self-contained pure function
- `mass-import-is-scaffolding` — The 300+ "Imported By" entries are from the test harness structure, not from other solutions calling `hamming_weight`

