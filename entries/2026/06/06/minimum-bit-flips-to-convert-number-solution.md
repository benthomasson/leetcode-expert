# File: minimum-bit-flips-to-convert-number/solution.py

**Date:** 2026-06-06
**Time:** 17:53

## `minimum-bit-flips-to-convert-number/solution.py`

### Purpose

This file solves [LeetCode 2220: Minimum Bit Flips to Convert Number](https://leetcode.com/problems/minimum-bit-flips-to-convert-number/). It owns the single responsibility of computing how many individual bit positions must be toggled to transform one integer into another.

### Key Components

**`Solution.minBitFlips(self, start: int, goal: int) -> int`**

The sole method. Contract: given two non-negative integers, return the count of bit positions where they differ (i.e., their Hamming distance).

The implementation is a one-liner with two operations chained:

1. `start ^ goal` — XOR produces a number whose `1` bits mark exactly the positions where `start` and `goal` differ.
2. `bin(...).count('1')` — converts to a binary string like `'0b1101'` and counts the `1` characters.

### Patterns

**XOR-for-diff idiom.** XOR is the canonical way to isolate differing bits between two integers. This is the same technique used in `hamming-distance/solution.py` — the two problems are mathematically identical.

**String-based popcount.** Python lacks a hardware `popcount` intrinsic. `bin(n).count('1')` is the standard Pythonic substitute. An alternative would be Brian Kernighan's bit-clearing loop (`n &= n - 1`), but the string approach is idiomatic for LeetCode Python solutions and has the same practical performance for 32-bit inputs.

### Dependencies

**Imports:** None — pure stdlib, no external libraries.

**Imported by:** `minimum-bit-flips-to-convert-number/test_solution.py` (directly), plus the "Imported By" list in the prompt appears to be a repo-wide listing of all test files that share a common test harness pattern importing `Solution` from their respective `solution.py`.

### Flow

```
start, goal → XOR → binary string → count '1' chars → return int
```

No branching, no loops, no mutation. A pure function in everything but the `self` parameter.

### Invariants

- XOR guarantees that each bit in the result is `1` if and only if the corresponding bits of `start` and `goal` differ — this is a mathematical invariant, not a code assertion.
- Python integers are arbitrary-precision, so this works for any non-negative integer size without overflow.

### Error Handling

None. Negative inputs would still produce a result (Python XOR handles negative integers via two's complement representation with infinite sign extension), but the LeetCode constraints guarantee `0 <= start, goal <= 10^9`.

---

## Topics to Explore

- [file] `hamming-distance/solution.py` — Same algorithm (XOR + popcount); compare implementations to see if they diverge
- [file] `number-of-1-bits/solution.py` — The popcount subproblem in isolation; may use a different counting technique
- [file] `counting-bits/solution.py` — Extends popcount to an array of integers; likely uses DP rather than per-element `bin().count()`
- [general] `bit-manipulation-patterns` — XOR-diff, Kernighan's trick, mask-and-shift — recurring idioms across the bit manipulation problem set
- [file] `complement-of-base-10-integer/solution.py` — Another XOR-based solution; uses XOR with a bitmask rather than XOR between two inputs

## Beliefs

- `xor-isolates-differing-bits` — `start ^ goal` produces a value whose set bits correspond exactly to the bit positions where `start` and `goal` differ
- `popcount-via-bin-count` — The codebase uses `bin(n).count('1')` as its standard popcount idiom rather than Kernighan's loop or `int.bit_count()`
- `hamming-distance-equivalence` — `minBitFlips` computes the Hamming distance; it is functionally identical to the `hamming-distance` problem solution
- `no-overflow-concern` — Python arbitrary-precision integers mean this solution handles inputs of any magnitude without special casing

