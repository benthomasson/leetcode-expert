# File: power-of-four/solution.py

**Date:** 2026-06-06
**Time:** 18:33

## `power-of-four/solution.py`

### Purpose

This file solves [LeetCode 342 — Power of Four](https://leetcode.com/problems/power-of-four/). It determines whether a given integer is an exact power of four (1, 4, 16, 64, 256, ...) using a single-expression bit manipulation approach — no loops, no logarithms, no recursion.

### Key Components

**`isPowerOfFour(n: int) -> bool`** — The sole function. It combines three conditions with short-circuit `and`:

1. **`n > 0`** — Powers of four are strictly positive. Eliminates 0 and all negatives immediately.
2. **`n & (n - 1) == 0`** — The classic power-of-two test. A power of two has exactly one set bit; `n - 1` flips that bit and sets all lower bits, so the AND zeroes out. This eliminates numbers like 6, 12, 24 that have multiple set bits.
3. **`n & 0x55555555 != 0`** — Distinguishes powers of four from other powers of two. `0x55555555` is `0101 0101 ... 0101` in binary — it has bits set at positions 0, 2, 4, 6, 8, ... (the even positions). Powers of four (4^k = 2^(2k)) always have their single set bit at an even position. Powers of two that aren't powers of four (like 2, 8, 32) have their set bit at an odd position and fail this check.

### Patterns

**Bit-mask filtering** — Rather than computing `log4(n)` or looping with division, this uses a constant bitmask to distinguish powers of four from powers of two in O(1) time and space. This is idiomatic for LeetCode "power-of-X" problems.

**Short-circuit conjunction** — The three checks are ordered cheaply: the sign check is trivially fast and eliminates half the integer domain; the power-of-two check eliminates almost everything else; the mask check is the final discriminator.

### Dependencies

**Imports:** None. Pure arithmetic on a single integer.

**Imported by:** `power-of-four/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are test files for *other* problems that share a common test runner, not files that call `isPowerOfFour`.

### Flow

Straight-line: evaluate three boolean sub-expressions left to right with short-circuit `and`. No branching, no state, no mutation. Returns `True` or `False`.

### Invariants

- The function is pure — no side effects, deterministic for any integer input.
- The mask `0x55555555` covers 32 bits. In Python integers are arbitrary-precision, so 4^16 = 2^32 and above would have their set bit beyond position 30 and would AND to zero against this mask. However, the LeetCode constraint for this problem specifies `-2^31 <= n <= 2^31 - 1` (32-bit signed integer range), so the mask is sufficient.

### Error Handling

None. The function handles every integer gracefully — negatives and zero return `False` via the first check. No exceptions are raised or caught.

---

## Topics to Explore

- [file] `power-of-two/solution.py` — Compare the power-of-two solution; the first two conditions here are likely identical, showing how the mask is the only differentiator
- [file] `power-of-three/solution.py` — Power of three can't use the bitmask trick; worth seeing what alternative approach was used
- [file] `number-of-1-bits/solution.py` — Another bit manipulation problem; the `n & (n-1)` trick used here is closely related to Hamming weight counting
- [general] `bitmask-0xAAAAAAAA-vs-0x55555555` — Understanding why even-position bits correspond to powers of four (since 4^k = 2^(2k)) and odd-position bits to non-four powers of two
- [file] `counting-bits/solution.py` — Uses related bit manipulation patterns at scale (DP + bit tricks)

---

## Beliefs

- `power-of-four-mask-32bit` — The mask `0x55555555` only covers bit positions 0–30, so this implementation assumes n fits in a 32-bit signed integer (matching the LeetCode constraint)
- `power-of-four-subset-of-power-of-two` — The first two conditions are exactly the power-of-two check; the third condition narrows the set from powers-of-two to powers-of-four
- `power-of-four-constant-time` — The solution runs in O(1) time and O(1) space with no loops, recursion, or library calls
- `power-of-four-no-imports` — The function has zero dependencies; it uses only built-in integer operators

