# File: alternating-digit-sum/solution.py

**Date:** 2026-06-06
**Time:** 15:14

## `alternating-digit-sum/solution.py`

### Purpose

This file solves [LeetCode 2544: Alternating Digit Sum](https://leetcode.com/problems/alternating-digit-sum/). It computes the alternating sum of a positive integer's digits, where the most significant digit gets a positive sign, the next gets negative, and so on. For example, `521` → `+5 - 2 + 1 = 4`.

### Key Components

**`sum_of_digits(n: int) -> int`** — The sole function. Takes a positive integer `n` (1 ≤ n ≤ 10⁹) and returns the alternating digit sum.

The contract is simple: the first (leftmost) digit is always added, the second subtracted, third added, etc.

### Flow

1. Convert `n` to its string representation `s`, which naturally gives digits in most-significant-first order.
2. Use a generator expression that iterates over `enumerate(s)`, producing `(index, digit_char)` pairs.
3. For each pair, compute `int(d) * (-1) ** i` — when `i` is even the sign is `+1`, when odd it's `-1`.
4. `sum()` accumulates the result.

The `(-1) ** i` trick is the core idiom: it maps even indices to `+1` and odd indices to `-1` without branching.

### Patterns

- **String-as-digit-iterator**: Converting to `str` to walk digits left-to-right avoids the common pitfall of extracting digits via `% 10` (which yields them in reverse order and would require tracking the total digit count to assign signs correctly).
- **Exponentiation for alternating sign**: `(-1) ** i` is idiomatic Python for alternating-sign sequences. It's concise but performs an exponentiation per digit — for a max 10-digit number this is negligible.

### Dependencies

**Imports**: None — pure standard Python.

**Imported by**: The `test_solution.py` in the same directory, plus ~350+ test files across other problem directories. The "Imported By" list in the prompt is misleading — those other test files don't actually depend on *this* solution's logic. That list reflects how the test harness resolves imports across the monorepo (likely a shared test runner pattern), not true logical coupling.

### Invariants

- `n` must be a positive integer. The function doesn't validate this — passing `0` yields `0` (technically correct since `str(0)` is `"0"`), but negative numbers would include a `-` character and `int("-")` would raise `ValueError`.
- The first digit always receives a positive sign (`(-1)**0 = 1`).

### Error Handling

None. Invalid input (negative numbers, non-integers) will raise exceptions from `str()`/`int()` — this is appropriate for a LeetCode solution where input constraints are guaranteed.

## Topics to Explore

- [file] `alternating-digit-sum/test_solution.py` — See which edge cases are covered (single digit, large numbers, etc.)
- [file] `alternating-digit-sum/review.md` — Check if the review flagged the `(-1)**i` approach vs. a conditional or multiplier toggle
- [function] `difference-between-element-sum-and-digit-sum-of-an-array/solution.py:sum_of_digits` — Compare digit-extraction approach in a related digit-sum problem
- [general] `digit-extraction-patterns` — Compare `str(n)` iteration vs. `divmod` loop vs. `math.log10` across the repo's digit-manipulation problems

## Beliefs

- `alternating-sign-via-exponentiation` — `(-1) ** i` produces +1 for even i and -1 for odd i, giving the most-significant digit a positive sign
- `str-conversion-for-left-to-right-digits` — Converting to string yields digits in most-significant-first order, which is essential since the sign assignment depends on position from the left
- `no-input-validation` — The function assumes `n ≥ 1` per LeetCode constraints; passing negative integers would raise `ValueError` on the `-` character
- `o-d-time-and-space` — Where d is the number of digits (at most 10); the string allocation and generator are both O(d)

