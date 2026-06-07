# File: confusing-number/solution.py

**Date:** 2026-06-06
**Time:** 15:48

## Confusing Number — Solution Explanation

### Purpose

This file implements [LeetCode 1056 - Confusing Number](https://leetcode.com/problems/confusing-number/). It determines whether a number, when rotated 180 degrees, produces a **different valid number**. For example, 6 rotated becomes 9, and 69 rotated becomes 69 — but since 69 equals itself, it's *not* confusing. Meanwhile, 9 becomes 6, which *is* different, so 9 is confusing.

### Key Components

**`Solution.confusingNumber(self, n: int) -> bool`**

The sole method. Contract: given a non-negative integer `n`, return `True` if rotating it 180 degrees yields a different valid number.

**`rotate` dict** — Maps each digit to its 180-degree rotation. Only five digits survive rotation:
- `0 → 0`, `1 → 1`, `8 → 8` (symmetric)
- `6 → 9`, `9 → 6` (swap pair)

Digits 2, 3, 4, 5, 7 have no valid rotated form.

### Flow

1. Save the original value of `n`.
2. Extract digits from `n` right-to-left via `% 10` / `//= 10`.
3. For each digit, check membership in `rotate`. If absent, short-circuit `False` — the number contains an unrotatable digit.
4. Build the rotated number left-to-right: `rotated = rotated * 10 + rotate[digit]`. Because digits are extracted least-significant-first but prepended most-significant-first, this naturally reverses the digit order — which is exactly what 180-degree rotation does (flip each digit *and* reverse their order).
5. Compare `rotated != original`. A confusing number must differ from itself after rotation.

### Patterns

**Digit-by-digit extraction with simultaneous reconstruction** — a common idiom for "reverse a number" problems. Here it does double duty: reversing digit order *and* mapping each digit through the rotation table in a single pass.

**Lookup table for validity + transformation** — the `rotate` dict serves as both a whitelist (membership test) and a mapping function. This avoids separate validation and transformation steps.

### Dependencies

- **Imports**: None — pure arithmetic, no library dependencies.
- **Imported by**: `confusing-number/test_solution.py` (the "Imported By" list in the prompt is misleading — those are all test files for *other* problems that happen to share a common test harness pattern, not actual consumers of this module).

### Invariants

- The input `n` is assumed non-negative. For `n = 0`, the while loop never executes, `rotated` stays 0, and `0 != 0` is `False` — correctly identifying 0 as not confusing (it maps to itself).
- Leading zeros in the rotated result are implicitly dropped by integer arithmetic. For example, `n = 10` would rotate to `01 = 1`, and `1 != 10` returns `True`. This matches the problem's semantics.

### Error Handling

None. The method assumes valid input per LeetCode conventions. No exceptions are raised; invalid digits cause an early `False` return, not an error.

## Topics to Explore

- [file] `strobogrammatic-number/solution.py` — Closely related problem: a strobogrammatic number equals itself after rotation (the complement of "confusing")
- [file] `confusing-number/test_solution.py` — See which edge cases are covered (n=0, single-digit, trailing zeros)
- [general] `digit-rotation-family` — LeetCode 1056 (this), 246 (strobogrammatic), 247 (strobogrammatic II), and 1088 (confusing number II) form a problem family worth studying together
- [function] `palindrome-number/solution.py:isPalindrome` — Uses the same digit-extraction-and-rebuild pattern but compares for equality instead of inequality

## Beliefs

- `confusing-number-zero-handling` — Input 0 returns False because the while loop is skipped and `rotated (0) == original (0)`
- `confusing-number-valid-digits` — Only digits 0, 1, 6, 8, 9 are valid in a confusing number; any other digit causes immediate False
- `confusing-number-single-pass` — The solution reverses digit order and maps each digit in one pass, achieving O(d) time where d is the number of digits
- `confusing-number-leading-zeros` — Rotated numbers with leading zeros (e.g., 10 → 01) are handled correctly by integer arithmetic silently dropping them

