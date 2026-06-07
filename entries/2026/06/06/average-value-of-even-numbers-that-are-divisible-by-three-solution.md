# File: average-value-of-even-numbers-that-are-divisible-by-three/solution.py

**Date:** 2026-06-06
**Time:** 15:19

## Purpose

This file solves [LeetCode 2455: Average Value of Even Numbers That Are Divisible by Three](https://leetcode.com/problems/average-value-of-even-numbers-that-are-divisible-by-three/). It owns exactly one responsibility: given a list of positive integers, compute the floor-average of elements that are both even and divisible by 3, returning 0 if no such elements exist.

## Key Components

### `average_even_divisible_by_three(nums: list[int]) -> int`

The sole exported function. Contract:

- **Input**: a list of positive integers
- **Output**: integer — the floor-divided average of qualifying elements, or 0 if none qualify
- **Side effects**: none

## Patterns

**The `n % 6 == 0` collapse.** The problem title says "even numbers divisible by three," which means `n % 2 == 0 and n % 3 == 0`. The solution collapses both checks into `n % 6 == 0` — since `lcm(2, 3) = 6`, a number is divisible by both 2 and 3 if and only if it's divisible by 6. This is a standard number-theory simplification seen across many solutions in this repo.

**Single-pass accumulation.** Instead of filtering into a list and then computing the average (which would allocate O(k) memory for qualifying elements), the code accumulates `total` and `count` in a single pass. This is O(1) auxiliary space, O(n) time.

**Integer division via `//`.** The problem specifies rounding down, which Python's `//` operator handles correctly for non-negative values.

## Dependencies

- **Imports**: none — pure Python, no standard library or third-party dependencies.
- **Imported by**: `test_solution.py` in the same directory, plus the massive list of test files shown in the "Imported By" section. That import list is an artifact of the test harness structure, not actual cross-problem coupling — each test file likely imports a shared test runner or conftest that transitively references all solutions.

## Flow

1. Initialize `total` and `count` to 0.
2. Iterate over every element `n` in `nums`.
3. If `n % 6 == 0`, add `n` to `total` and increment `count`.
4. After the loop, return `total // count` if `count > 0`, else `0`.

No early exits, no branching beyond the single modulo check.

## Invariants

- **`count` tracks exactly how many multiples of 6 have been seen.** It's never negative and never exceeds `len(nums)`.
- **`total` is the sum of all multiples of 6 in `nums`.** Since all inputs are positive integers, `total >= 0` always holds.
- **Division-by-zero is guarded** by the `if count` ternary. The function never raises `ZeroDivisionError`.

## Error Handling

There is none — and intentionally so. This is a LeetCode solution operating under the problem's guarantees (`1 <= nums.length <= 1000`, `1 <= nums[i] <= 1000`). The function trusts its caller to provide a non-empty list of positive integers. Empty lists produce `0` (the fallback), but no explicit validation or exception raising exists.

## Topics to Explore

- [file] `average-value-of-even-numbers-that-are-divisible-by-three/test_solution.py` — See what edge cases the test suite covers (empty qualifying set, all-qualifying, single element)
- [file] `average-value-of-even-numbers-that-are-divisible-by-three/review.md` — Check if the review noted the `% 6` optimization or flagged alternatives
- [general] `lcm-modular-collapse` — The `% 6` idiom recurs across problems involving coprime divisibility checks; worth recognizing as a pattern
- [file] `mean-of-array-after-removing-some-elements/solution.py` — Another averaging problem that likely uses similar accumulation but with different filtering logic
- [file] `average-salary-excluding-the-minimum-and-maximum-salary/solution.py` — Contrast how a different averaging problem handles exclusion criteria

## Beliefs

- `mod-6-equivalence` — `n % 6 == 0` is equivalent to `n % 2 == 0 and n % 3 == 0` for all integers, making the single-check optimization correct
- `zero-on-empty-qualifying-set` — The function returns 0 (not an error) when no elements in `nums` are divisible by 6
- `single-pass-o1-space` — The function uses O(1) auxiliary space regardless of input size, accumulating sum and count without allocating a filtered list
- `floor-division-semantics` — Python's `//` operator provides the floor division required by the problem spec, which is correct here because `total` and `count` are both non-negative

