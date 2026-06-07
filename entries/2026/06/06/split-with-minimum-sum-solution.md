# File: split-with-minimum-sum/solution.py

**Date:** 2026-06-06
**Time:** 19:15

## Purpose

This file solves [LeetCode 2578: Split With Minimum Sum](https://leetcode.com/problems/split-with-minimum-sum/). Given a positive integer, split its digits into two new numbers such that their sum is minimized. The file owns both the solution implementation and its unit tests, following the repo's convention of colocating solution + tests in a single `solution.py`.

## Key Components

### `min_sum_of_two_numbers(num: int) -> int`

The core solver. Contract: accepts a positive integer (10 <= num <= 10^9), returns the minimum possible sum after splitting its digits into exactly two numbers.

**Algorithm** (greedy, sort-and-deal):

1. Convert `num` to its digit characters and sort them ascending.
2. Deal digits round-robin into two accumulators (`parts[0]` and `parts[1]`), alternating by index.
3. Convert both strings back to integers and return their sum.

This works because the greedy optimal strategy is: place the smallest digits in the highest-significance positions, and distribute evenly across both numbers so neither accumulates disproportionate magnitude. Sorting ensures smallest-first; round-robin ensures balanced length (differ by at most 1 digit).

### `TestMinSumOfTwoNumbers`

Six test cases covering: the two LeetCode examples, the minimum-length input (2 digits), repeated digits, a large 9-digit input, and a number with embedded zeros (verifying that leading zeros in string parts are handled correctly by `int()` conversion).

## Patterns

- **Sort-and-deal greedy**: A common idiom for "minimize sum by distributing digits." The same pattern appears in the sibling problem `minimum-sum-of-four-digit-number-after-splitting-digits/`.
- **String-as-accumulator**: Digits are concatenated as strings rather than computed arithmetically (`parts[i % 2] += d`). This avoids manual place-value math at the cost of a string-to-int conversion at the end.
- **Self-contained solution file**: Solution + tests in one module, runnable via `python solution.py` or `pytest`.

## Dependencies

**Imports**: Only `unittest` from stdlib — no external dependencies.

**Imported by**: The `test_solution.py` files listed in the "Imported By" section don't actually import *this* file — that list appears to be a repo-wide cross-reference artifact. The real consumer is `split-with-minimum-sum/test_solution.py`, which likely imports `min_sum_of_two_numbers` from this module.

## Flow

```
num=4325
  → str(num) = "4325"
  → sorted("4325") = ['2', '3', '4', '5']
  → deal: i=0 → parts[0]="2", i=1 → parts[1]="3", i=2 → parts[0]="24", i=3 → parts[1]="35"
  → int("24") + int("35") = 59
```

The round-robin assignment `parts[i % 2]` means even-indexed (0th, 2nd, ...) sorted digits go to `parts[0]` and odd-indexed go to `parts[1]`. Since digits are sorted ascending, the smallest digit becomes the leading digit of `parts[0]`, second-smallest leads `parts[1]`, and so on — minimizing place-value contribution.

## Invariants

- **Sorted ascending**: The digit sort is ascending, so smallest digits land in highest-significance positions (leftmost in the string accumulators).
- **Balanced split**: Round-robin guarantees `len(parts[0]) - len(parts[1])` is 0 or 1. This prevents one number from having significantly more digits (and thus magnitude) than the other.
- **Leading zeros are safe**: `int("02")` yields `2` in Python, so inputs like `2030` (digits `[0,0,2,3]`) produce correct results without special handling.

## Error Handling

None. The function trusts its caller to provide a valid positive integer per the LeetCode constraint (10 <= num <= 10^9). No validation, no exception handling. Invalid inputs (negative, zero, single-digit) would produce silently wrong results or crash on `int("")` if `num` had fewer than 2 digits.

## Topics to Explore

- [file] `minimum-sum-of-four-digit-number-after-splitting-digits/solution.py` — Closely related problem (restricted to exactly 4 digits); compare whether it uses the same greedy approach or a specialized one
- [function] `split-with-minimum-sum/solution.py:min_sum_of_two_numbers` — Test whether the round-robin strategy remains optimal for the 3-way split variant (LeetCode 2160)
- [file] `split-with-minimum-sum/test_solution.py` — Check how the external test file imports and exercises this solution, versus the inline tests
- [general] `greedy-digit-distribution` — Explore the proof that sort-and-deal minimizes the sum: it follows from the fact that minimizing total place-value contribution requires smallest digits at highest significance, distributed evenly

## Beliefs

- `split-min-sum-round-robin-optimal` — Round-robin dealing of ascending-sorted digits into two accumulators produces the minimum possible sum for any digit count
- `split-min-sum-leading-zeros-safe` — Python's `int()` conversion silently drops leading zeros in the string accumulators, so inputs containing 0 digits (e.g., 2030) produce correct results without special-casing
- `split-min-sum-no-input-validation` — The function performs no input validation; single-digit inputs would cause `int("")` on the empty accumulator
- `split-min-sum-string-accumulator-pattern` — Digits are concatenated as strings and converted to int at the end, rather than computed via arithmetic place-value multiplication

