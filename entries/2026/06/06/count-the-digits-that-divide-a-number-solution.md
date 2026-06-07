# File: count-the-digits-that-divide-a-number/solution.py

**Date:** 2026-06-06
**Time:** 16:05

## Purpose

This file solves [LeetCode 2520 — Count the Digits That Divide a Number](https://leetcode.com/problems/count-the-digits-that-divide-a-number/). It owns a single responsibility: given a positive integer, count how many of its decimal digits evenly divide it. The file is self-contained — implementation and tests live together.

## Key Components

### `digits_dividing_num(num: int) -> int`

The sole public function. Contract:

- **Input**: A positive integer `num` where `1 <= num <= 10^9` and `num` contains no zero digits (per problem constraints).
- **Output**: The count of digits in `num` where `num % digit == 0`.
- **Side effects**: None — pure function.

### `TestDigitsDividingNum`

Seven unit tests covering:

| Test | Input | Expected | What it validates |
|------|-------|----------|-------------------|
| `test_single_digit` | 7 | 1 | Base case — one digit always divides itself |
| `test_repeated_digit_partial` | 121 | 2 | Not all digits need to divide (2 does not divide 121) |
| `test_all_divide` | 1248 | 4 | Every digit divides the number |
| `test_single_digit_one` | 1 | 1 | Edge: smallest input |
| `test_large_number` | 111111111 | 9 | Edge: max digit count (9 ones) |
| `test_no_digit_divides_except_one` | 13 | 1 | Only digit 1 divides |
| `test_all_same_digit` | 555 | 3 | Repeated digit that divides |

## Patterns

**Digit extraction via modular arithmetic** — the standard `n % 10` / `n //= 10` loop. This avoids string conversion, keeping the solution in O(d) time and O(1) space where d is the digit count. This is a recurring idiom across this repo's digit-manipulation problems (see `self-dividing-numbers`, `alternating-digit-sum`, `add-digits`).

**Collocated tests** — the `unittest.TestCase` subclass lives in the same file as the implementation, with a `__main__` guard. The repo also has separate `test_solution.py` files that import from these solution modules.

## Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The `test_solution.py` in this same directory imports from this file. The massive "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that happen to share the same `import unittest` line, not actual importers of `digits_dividing_num`.

## Flow

1. Save the original `num` (needed for divisibility checks).
2. Copy `num` into `n` as the working variable for digit extraction.
3. Loop: extract the rightmost digit with `n % 10`, check if `num % digit == 0`, increment `count` if so, then drop the digit with `n //= 10`.
4. The loop terminates when `n` reaches 0 (all digits consumed).
5. Return the accumulated `count`.

The digits are processed right-to-left, but order doesn't matter — divisibility is checked against the original number regardless of digit position.

## Invariants

- **No zero digits**: The function assumes `num` contains no zero digits (per the LeetCode constraint). If a zero digit appeared, `num % digit` would raise `ZeroDivisionError`. The code does not guard against this.
- **Positive input**: The `while n:` loop relies on `num >= 1`. Passing 0 would skip the loop entirely and return 0 (arguably wrong but not in the problem domain).
- **Original value preserved**: `num` is never mutated; `n` is the variable that gets consumed by the extraction loop.

## Error Handling

None. The function trusts its caller to satisfy the documented precondition (`1 <= num <= 10^9`, no zero digits). A zero digit would surface as an unhandled `ZeroDivisionError` from the `num % digit` expression. This is appropriate for a LeetCode solution where inputs are guaranteed valid.

## Topics to Explore

- [file] `self-dividing-numbers/solution.py` — Same digit-extraction-and-divisibility pattern, but must also handle zero digits explicitly
- [file] `alternating-digit-sum/solution.py` — Digit extraction where position (odd/even) matters, unlike here
- [function] `count-the-digits-that-divide-a-number/test_solution.py` — External test harness that imports this module; shows how the repo's test infrastructure layers on top
- [general] `digit-extraction-idiom` — The `n % 10` / `n //= 10` loop appears in dozens of solutions in this repo; worth cataloguing which problems use it vs. string conversion
- [file] `subtract-the-product-and-sum-of-digits-of-an-integer/solution.py` — Same loop structure but accumulates product and sum instead of a divisibility count

## Beliefs

- `digits-dividing-num-no-zero-guard` — `digits_dividing_num` will raise `ZeroDivisionError` if any digit of the input is zero, since there is no guard before `num % digit`
- `digits-dividing-num-constant-space` — The function uses O(1) auxiliary space and O(d) time where d is the number of digits
- `digits-dividing-num-order-independent` — Digits are processed right-to-left but the result is order-independent since each digit's divisibility is checked against the unchanged original `num`
- `digits-dividing-num-preserves-input` — The original `num` parameter is never modified; a separate variable `n` is consumed during digit extraction

