# File: palindrome-number/solution.py

**Date:** 2026-06-06
**Time:** 18:27

## Palindrome Number — `palindrome-number/solution.py`

### Purpose

This file implements LeetCode problem #9 (Palindrome Number). It determines whether an integer reads the same forwards and backwards, using a math-only approach — no string conversion. It's one of the foundational solutions in this repo, and based on the `imported_by` list, its test file is imported by hundreds of other test modules (likely via a shared test infrastructure pattern, not because those modules use `is_palindrome` directly).

### Key Components

**`is_palindrome(x: int) -> bool`** — The sole public function. Contract: given any integer, returns `True` if it's a palindrome, `False` otherwise.

### Patterns

**Half-reversal technique.** Rather than reversing the entire number and comparing (which risks integer overflow in languages with fixed-width integers), this reverses only the second half of the digits and compares it to the first half. The loop `while x > reversed_half` naturally stops at the midpoint — when the remaining digits (`x`) are fewer than or equal to the reversed digits.

This is the canonical O(log₁₀ n) time, O(1) space solution for this problem.

### Dependencies

**Imports:** None — pure function with no dependencies.

**Imported by:** `palindrome-number/test_solution.py` directly. The massive `imported_by` list in the prompt reflects the test infrastructure — those test files likely import a shared helper or conftest that references this module indirectly, not `is_palindrome` itself.

### Flow

1. **Early rejection** (line 12): Negative numbers are never palindromes. Numbers ending in 0 (except 0 itself) can't be palindromes because no number starts with 0.

2. **Half-reversal loop** (lines 14–16): Peel digits off the right side of `x` and build `reversed_half` from them. Each iteration, `reversed_half` grows by one digit (multiply by 10, add the last digit of `x`) while `x` shrinks by one digit (integer divide by 10). The loop exits when `x <= reversed_half`, meaning we've reached or passed the midpoint.

3. **Midpoint comparison** (line 18): Two cases:
   - **Even digit count** (e.g., 1221): `x == reversed_half` — both halves are identical (12 == 12).
   - **Odd digit count** (e.g., 12321): `x == reversed_half // 10` — the middle digit ends up in `reversed_half`, so we discard it before comparing (12 == 123 // 10).

### Invariants

- **Negative → False.** No negative integer is ever considered a palindrome.
- **Trailing-zero → False** (except 0). A number like 10, 120, etc. is immediately rejected because a palindrome with a trailing zero would need a leading zero, which is impossible.
- **No string allocation.** The constraint (implicit from the LeetCode problem) is to solve this without converting to a string. The solution satisfies this — all operations are arithmetic.
- **Loop termination.** The loop always terminates: `x` strictly decreases and `reversed_half` strictly increases each iteration, so `x > reversed_half` eventually becomes false.

### Error Handling

None needed. The function is total — it handles every integer input and always returns a bool. No exceptions are raised or caught.

## Topics to Explore

- [file] `palindrome-number/test_solution.py` — See what edge cases are tested (negative, single digit, trailing zeros, even/odd length)
- [file] `palindrome-number/plan.md` — Read the planning document to see if alternative approaches (string conversion, full reversal) were considered
- [function] `a-number-after-a-double-reversal/solution.py` — Related digit-reversal problem that may share the mod/divide pattern
- [file] `palindrome-linked-list/solution.py` — Same palindrome concept applied to a linked list, requiring a different structural approach
- [general] `half-reversal-vs-full-reversal` — Why reversing only half the digits is preferred: avoids overflow in typed languages, and halves the iteration count

## Beliefs

- `palindrome-negative-always-false` — `is_palindrome` returns `False` for all negative integers without entering the reversal loop
- `palindrome-trailing-zero-rejected` — Any non-zero integer ending in 0 is rejected in O(1) by the early-exit guard on line 12
- `palindrome-no-string-conversion` — The solution uses only integer arithmetic (mod, division, multiplication) — no `str()`, slicing, or string comparison
- `palindrome-half-reversal-loop-invariant` — At loop exit, `reversed_half` contains the reversed second half of the digits (plus the middle digit for odd-length numbers), and `x` contains the first half
- `palindrome-zero-is-palindrome` — The input `0` passes both guards (not negative, the trailing-zero guard explicitly excludes 0) and returns `True`

