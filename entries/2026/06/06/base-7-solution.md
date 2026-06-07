# File: base-7/solution.py

**Date:** 2026-06-06
**Time:** 15:20

## `base-7/solution.py`

### Purpose

This file implements LeetCode problem #504 ("Base 7"). It owns a single responsibility: converting a decimal integer to its base-7 string representation. It's one of many self-contained solution modules in the `leetcode-implementations` repo, each solving a single problem.

### Key Components

**`convert_to_base7(num: int) -> str`** — The sole public function. Contract: given any integer in [-10^7, 10^7], returns its base-7 representation as a string (e.g., `100` → `"202"`, `-7` → `"-10"`).

### Flow

The algorithm is the standard repeated-division approach for base conversion:

1. **Zero short-circuit** (line 12): Returns `"0"` immediately — without this, the while loop would never execute and return an empty string.
2. **Sign extraction** (lines 13–14): Records negativity, then works with the absolute value. This separates sign handling from digit extraction.
3. **Digit extraction loop** (lines 15–17): Repeatedly divides by 7, collecting remainders (least-significant digit first) into a list.
4. **Sign reattachment** (lines 18–19): Appends `"-"` to the end of the reversed-order list so it lands at the front after reversal.
5. **Assembly** (line 20): Reverses and joins. Digits were accumulated LSB-first, so reversal produces the correct MSB-first order.

### Patterns

- **Accumulate-then-reverse**: A common idiom for base conversion — appending to a list is O(1) amortized, and a single reversal at the end is cheaper than prepending each digit.
- **Sign-magnitude decomposition**: Handling sign separately from magnitude avoids dealing with Python's floor-division behavior on negative numbers (where `-7 % 7` is `0` but `-7 // 7` is `-1`, which works but produces a `-0` prefix issue if not careful).

### Dependencies

**Imports**: None — pure arithmetic, no standard library needed.

**Imported by**: The `base-7/test_solution.py` file directly. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that share a common test harness pattern, not actual consumers of this function.

### Invariants

- The function assumes integer input (enforced by type hint, not runtime check).
- The `while num:` loop terminates because `num` is non-negative and `num //= 7` strictly decreases a positive integer toward zero.
- Digits collected are always in `[0, 6]` — valid base-7 digits.

### Error Handling

None. The function trusts its caller to pass an integer. Passing a float or string would produce a runtime error from `%` or `//=`. This is appropriate for a LeetCode solution where input constraints are guaranteed.

## Topics to Explore

- [file] `base-7/test_solution.py` — See what edge cases are tested (zero, negative, single-digit, powers of 7)
- [function] `convert-a-number-to-hexadecimal/solution.py:toHex` — Same base-conversion pattern adapted for base 16 with two's complement handling
- [function] `sum-of-digits-in-base-k/solution.py` — Related problem that also does modular arithmetic with arbitrary bases
- [general] `python-negative-modulo` — Python's `%` operator returns non-negative results for positive divisors, which is why the sign-magnitude decomposition works but isn't strictly necessary

## Beliefs

- `base7-zero-special-case` — `convert_to_base7` returns `"0"` for input `0` via an explicit early return; removing it would produce an empty string
- `base7-digits-lsb-first` — Digits are accumulated least-significant-bit first in the `digits` list, then reversed at the end to produce the correct string
- `base7-sign-magnitude` — Negative inputs are handled by converting to absolute value and prepending `"-"`, not by relying on Python's negative integer division semantics
- `base7-no-dependencies` — The module has zero imports; it uses only built-in arithmetic operators

