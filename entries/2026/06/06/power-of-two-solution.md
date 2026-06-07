# File: power-of-two/solution.py

**Date:** 2026-06-06
**Time:** 18:34

## `power-of-two/solution.py`

### Purpose

This file solves [LeetCode #231 — Power of Two](https://leetcode.com/problems/power-of-two/). It provides a single function `is_power_of_two` that determines whether a given integer is an exact power of two (1, 2, 4, 8, 16, ...). It's one of ~500 solutions in the repo, following the standard one-file-per-problem layout.

### Key Components

**`is_power_of_two(n: int) -> bool`** — The sole function. Takes an integer and returns whether it's a power of two.

### Patterns

The implementation uses the classic **bit-manipulation trick**: `n & (n - 1) == 0`.

Why this works: a power of two in binary has exactly one bit set (e.g., `8 = 1000`). Subtracting 1 flips that bit and sets all lower bits (`7 = 0111`). ANDing the two produces zero — and this *only* happens when there's exactly one set bit.

The `n > 0` guard is essential because `n = 0` would pass the bit test (`0 & -1` is `0`), and negative numbers are never powers of two.

This is O(1) time and space — no loops, no division, just two arithmetic operations and a comparison.

### Dependencies

**Imports:** None. Pure standalone function with no external dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — those ~500 test files don't import *this* solution. They import their *own* `solution.py` files. The actual consumer is `power-of-two/test_solution.py`.

This function is also a building block for the related problems `power-of-four` and `power-of-three` in the repo, which use different techniques but share the same structural pattern.

### Flow

1. Check `n > 0` — reject zero and negatives immediately (short-circuit).
2. Compute `n & (n - 1)` — clear the lowest set bit.
3. Return whether the result is zero (meaning `n` had exactly one set bit).

### Invariants

- **Positivity requirement**: Only positive integers can be powers of two. The function enforces this with `n > 0`.
- **Single set bit**: The mathematical invariant is that a positive integer is a power of two if and only if its binary representation contains exactly one `1` bit.

### Error Handling

None. The function is total — it handles all integer inputs by returning `False` for anything that isn't a positive power of two. No exceptions raised.

## Topics to Explore

- [file] `power-of-four/solution.py` — Likely extends the bit-trick pattern; powers of four are powers of two where the single set bit is at an even position
- [file] `power-of-three/solution.py` — No clean bit trick exists for base 3; compare approach (likely loop or log-based)
- [file] `number-of-1-bits/solution.py` — Uses the same `n & (n - 1)` kernel in a loop to count set bits (Brian Kernighan's algorithm)
- [general] `bit-manipulation-patterns` — The `n & (n-1)` trick appears across multiple problems in this repo (counting bits, complement, hamming distance)
- [file] `power-of-two/test_solution.py` — Edge cases tested: 0, 1, negative numbers, large powers of two

## Beliefs

- `power-of-two-bit-trick` — `n & (n - 1) == 0` is true for all positive integers with exactly one set bit, which are exactly the powers of two
- `power-of-two-rejects-zero` — The `n > 0` guard is necessary because `0 & (0 - 1)` equals `0`, which would incorrectly pass the bit test
- `power-of-two-constant-time` — The solution runs in O(1) time and space with no loops or recursion
- `power-of-two-no-imports` — The function is self-contained with zero dependencies, relying only on Python's built-in integer arithmetic

