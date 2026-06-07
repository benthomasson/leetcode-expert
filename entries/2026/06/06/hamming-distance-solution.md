# File: hamming-distance/solution.py

**Date:** 2026-06-06
**Time:** 16:58

## `hamming-distance/solution.py`

### Purpose

This file solves [LeetCode #461 — Hamming Distance](https://leetcode.com/problems/hamming-distance/). It owns exactly one responsibility: counting the number of bit positions where two integers differ. This is the canonical definition of Hamming distance in information theory.

### Key Components

**`hammingDistance(x: int, y: int) -> int`** — The sole function. Takes two non-negative integers bounded by `[0, 2^31 - 1]` and returns the count of differing bits.

The implementation is a single expression with two operations chained together:

1. **`x ^ y`** — XOR produces a number where each `1` bit marks a position where `x` and `y` differ.
2. **`bin(...).count('1')`** — Converts to a binary string (e.g., `'0b1010'`) and counts the `'1'` characters.

### Patterns

This follows the **bit manipulation via string conversion** idiom — a Pythonic shortcut that trades theoretical elegance for readability. The alternative would be Brian Kernighan's algorithm (`n &= n - 1` in a loop), which avoids the string allocation but is harder to read and offers no practical speedup for 32-bit integers.

The solution also follows the repo-wide convention: a single module-level function matching the LeetCode method signature, with type hints and a docstring.

### Dependencies

**Imports:** None. Pure Python builtins only (`bin`, `str.count`, `^` operator).

**Imported by:** The `hamming-distance/test_solution.py` file. The massive "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that happen to share a test harness or import pattern, not actual consumers of `hammingDistance`.

### Flow

Entirely linear, no branching:

```
x, y → XOR → int with differing bits set → bin() → "0b..." string → count('1') → return
```

For `hammingDistance(1, 4)`: `1 ^ 4 = 5` → `bin(5) = '0b101'` → `'0b101'.count('1') = 2` → returns `2`.

### Invariants

- Input constraint `0 <= x, y <= 2^31 - 1` is documented but **not enforced** — no validation. Negative inputs would still produce a result in Python (since `bin(-1)` yields `'-0b1'`), but the `1` count would be wrong because Python integers have arbitrary precision and negative XOR results use two's complement conceptually but `bin()` doesn't emit all the leading 1s.
- The return value is always in `[0, 31]` for valid inputs (at most 31 bits can differ).

### Error Handling

None. No input validation, no try/except. Invalid inputs (negative numbers, floats, None) would either produce wrong results silently or raise a `TypeError` from the `^` operator.

---

## Topics to Explore

- [file] `hamming-distance/test_solution.py` — See what edge cases are covered (0 vs 0, max values, identical inputs)
- [file] `minimum-bit-flips-to-convert-number/solution.py` — Same problem under a different name (LeetCode #2220); compare approaches
- [file] `number-of-1-bits/solution.py` — The popcount subproblem that `bin(...).count('1')` solves; may use a different technique
- [general] `brian-kernighan-popcount` — The `n &= n - 1` loop alternative that clears the lowest set bit each iteration, running in O(popcount) instead of O(bits)
- [file] `counting-bits/solution.py` — Extends popcount to an entire range; likely shows dynamic programming over bit structure

## Beliefs

- `hamming-xor-popcount` — `hammingDistance` computes Hamming distance as popcount of XOR; any change to either step would break correctness
- `hamming-no-input-validation` — The function does not validate that inputs are non-negative or within the 32-bit range; callers must ensure valid inputs
- `hamming-pure-builtin` — The solution uses zero imports; it relies entirely on Python's `^` operator and `bin` builtin
- `hamming-string-popcount-idiom` — `bin(n).count('1')` is used as popcount throughout this repo (likely shared with `number-of-1-bits`, `counting-bits`, and `minimum-bit-flips-to-convert-number`)

