# File: subtract-the-product-and-sum-of-digits-of-an-integer/solution.py

**Date:** 2026-06-06
**Time:** 19:19

## Purpose

This file solves [LeetCode 1281: Subtract the Product and Sum of Digits of an Integer](https://leetcode.com/problems/subtract-the-product-and-sum-of-digits-of-an-integer/). It owns exactly one responsibility: given a positive integer `n`, compute `(product of its digits) - (sum of its digits)`.

## Key Components

### `subtract_product_and_sum(n: int) -> int`

The sole public function. Contract:

- **Input**: a positive integer `n` where `1 <= n <= 10^5`
- **Output**: `product_of_digits - sum_of_digits`
- **Side effects**: none (mutates only local state)

## Patterns

**Digit extraction via modular arithmetic.** Rather than converting to a string and iterating over characters (e.g., `for ch in str(n)`), this uses the classic `n % 10` / `n //= 10` loop. This is the idiomatic numeric approach — it avoids string allocation and is O(d) in time and O(1) in space where d is the digit count.

**Single-pass accumulation.** Both the product and sum are computed in one pass over the digits, updating two accumulators (`product`, `total`) simultaneously. There's no intermediate list of digits.

## Dependencies

**Imports**: None. The solution is self-contained with no standard library or third-party dependencies.

**Imported by**: The `test_solution.py` in the same directory. The "Imported By" list in the prompt is misleading — those ~400+ test files belong to *other* problems and don't actually import this module. They import their own `solution.py` via relative imports. The only real consumer is `subtract-the-product-and-sum-of-digits-of-an-integer/test_solution.py`.

## Flow

1. Initialize `product = 1` (multiplicative identity) and `total = 0` (additive identity).
2. While `n > 0`:
   - Extract the rightmost digit: `digit = n % 10`
   - Multiply it into `product`, add it into `total`
   - Remove the rightmost digit: `n //= 10`
3. Return `product - total`.

For `n = 234`: digits extracted as 4, 3, 2. Product = 24, sum = 9, result = 15.

## Invariants

- **Loop termination**: `n` is strictly decreasing each iteration (integer division by 10), guaranteed to reach 0.
- **Digit order doesn't matter**: both multiplication and addition are commutative, so extracting digits right-to-left produces the same result as left-to-right.
- **`product` starts at 1, not 0**: starting at 0 would make the product always 0.
- **Input constraint**: the function assumes `n >= 1`. If `n = 0`, the loop body never executes and it returns `1 - 0 = 1`, which would be incorrect for a "zero" input — but the problem guarantees `n >= 1`.

## Error Handling

None. The function trusts its caller to satisfy the constraint `1 <= n <= 10^5`. No validation, no exceptions. This is appropriate for a LeetCode solution where the judge guarantees valid input.

## Topics to Explore

- [file] `subtract-the-product-and-sum-of-digits-of-an-integer/test_solution.py` — See what edge cases (single digit, max value, digits containing zero) are tested
- [file] `subtract-the-product-and-sum-of-digits-of-an-integer/review.md` — Read the code review for any noted issues or alternative approaches
- [function] `difference-between-element-sum-and-digit-sum-of-an-array/solution.py:differenceOfSum` — Related problem that also computes digit sums; compare the digit-extraction approach
- [general] `string-vs-modular-digit-extraction` — Several solutions in this repo extract digits; compare which use `str()` conversion vs `% 10` and whether the choice is consistent

## Beliefs

- `single-pass-dual-accumulator` — Product and sum are computed in a single while-loop pass with no intermediate digit storage
- `modular-arithmetic-digit-extraction` — Digits are extracted via `n % 10` and `n //= 10` rather than string conversion
- `no-zero-input-handling` — Passing `n = 0` returns 1 (incorrect), but the problem constraint guarantees `n >= 1`
- `zero-dependency-solution` — The module has no imports; it uses only built-in arithmetic operators

