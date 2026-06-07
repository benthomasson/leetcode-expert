# File: armstrong-number/solution.py

**Date:** 2026-06-06
**Time:** 15:15

## Purpose

This file implements a solution for the **Armstrong Number** problem (LeetCode #1134). An Armstrong number (also called a narcissistic number) is an integer where the sum of each digit raised to the power of the total number of digits equals the original number. For example, 153 is Armstrong because 1^3 + 5^3 + 3^3 = 153.

The file owns exactly one responsibility: determining whether a given integer satisfies the Armstrong property.

## Key Components

### `is_armstrong(n: int) -> bool`

The sole public function. Contract:
- **Input**: a positive integer `n`
- **Output**: `True` if `n` is an Armstrong number, `False` otherwise

The implementation is a single expression — no intermediate state, no mutation.

## Patterns

**String-based digit extraction**: Converts `n` to a string to iterate over digits and determine the digit count (`k`). This is the idiomatic Python approach — avoids the `math.log10` + modulo loop that you'd see in C/Java, and handles edge cases like `n=0` naturally (single digit, 0^1 == 0).

**Generator expression in `sum()`**: `sum(int(d) ** k for d in digits)` is lazy — it doesn't materialize a list. For single numbers this doesn't matter, but it's a good habit.

## Dependencies

**Imports**: None. Pure function, no external dependencies.

**Imported by**: `armstrong-number/test_solution.py` directly tests this. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a common test infrastructure, not actual importers of `is_armstrong`.

## Flow

1. Convert `n` to its string representation → `digits`
2. Compute `k` = number of digits (length of the string)
3. For each character `d` in `digits`, convert back to `int` and raise to the `k`-th power
4. Sum all those powers and compare to the original `n`

The entire computation is O(k) where k is the number of digits — effectively O(log n).

## Invariants

- The function assumes `n` is a non-negative integer. Negative inputs would produce `digits` starting with `'-'`, and `int('-')` would raise `ValueError`.
- For single-digit numbers (0-9), `k=1`, and any digit raised to the 1st power equals itself, so all single-digit numbers are Armstrong numbers by definition.

## Error Handling

None. The function trusts its caller to pass a valid positive integer, consistent with LeetCode's problem constraints. A negative or non-integer input would propagate a `ValueError` or `TypeError` from `str()` / `int()`.

## Topics to Explore

- [file] `armstrong-number/test_solution.py` — See which edge cases are covered (single digit, large numbers, boundary values)
- [file] `armstrong-number/plan.md` — Understand the planning approach used before implementation
- [general] `digit-decomposition-patterns` — Compare string-based vs arithmetic digit extraction across solutions like `add-digits`, `happy-number`, and `self-dividing-numbers`
- [function] `happy-number/solution.py:isHappy` — Similar digit-power-sum pattern but with cycle detection

## Beliefs

- `armstrong-single-digit-always-true` — All single-digit non-negative integers (0-9) are Armstrong numbers under this implementation because any digit to the 1st power equals itself
- `armstrong-negative-input-raises` — Passing a negative integer to `is_armstrong` raises `ValueError` because `int('-')` fails during the generator expression
- `armstrong-time-complexity` — `is_armstrong` runs in O(log n) time, iterating once over the digits with constant-time exponentiation per digit
- `armstrong-no-dependencies` — The solution uses only Python builtins (`str`, `len`, `sum`, `int`, `**`) with zero imports

