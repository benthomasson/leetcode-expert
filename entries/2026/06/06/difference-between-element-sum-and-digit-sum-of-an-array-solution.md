# File: difference-between-element-sum-and-digit-sum-of-an-array/solution.py

**Date:** 2026-06-06
**Time:** 16:23

## `difference-between-element-sum-and-digit-sum-of-an-array/solution.py`

### Purpose

This file solves [LeetCode 2535](https://leetcode.com/problems/difference-between-element-sum-and-digit-sum-of-an-array/). It computes two sums over an input array — the element sum (sum of the numbers themselves) and the digit sum (sum of every individual digit across all numbers) — then returns their absolute difference.

It follows the repo's convention: one solution file per problem directory, exporting a single function that encapsulates the algorithm.

### Key Components

**`difference_between_element_and_digit_sum(nums: list[int]) -> int`** — The sole public function. Contract:

- **Input**: a list of positive integers
- **Output**: `abs(element_sum - digit_sum)`, a non-negative integer
- **Side effects**: none; pure function

### Patterns

**Single-pass accumulation.** Both sums are computed in one loop over `nums`, avoiding a second traversal. The digit extraction happens inline via repeated `% 10` / `//= 10` — standard modular arithmetic rather than string conversion. This is the idiomatic numeric approach and avoids allocating intermediate string objects.

**Destructive parameter reuse.** The loop variable `num` is mutated in-place by the `while num > 0` loop. This is safe because `num` is a rebinding of the loop variable, not a mutation of the input list.

### Dependencies

**Imports**: None. The solution is self-contained with no stdlib or third-party dependencies.

**Imported by**: The `test_solution.py` in the same directory imports this function. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a test runner infrastructure, not actual consumers of this function.

### Flow

1. Initialize `element_sum` and `digit_sum` to 0.
2. For each `num` in `nums`:
   - Add `num` to `element_sum` (the whole number).
   - Extract digits via `num % 10`, accumulate into `digit_sum`, then integer-divide `num` by 10. Repeat until `num` reaches 0.
3. Return `abs(element_sum - digit_sum)`.

For input `[1, 15, 6, 3]`: element sum = 25, digit sum = 1+1+5+6+3 = 16, result = 9.

### Invariants

- **Positive integers assumed.** The `while num > 0` guard means `num = 0` contributes zero digits (not even a single "0" digit). This is correct per the LeetCode constraint that `1 <= nums[i] <= 2000`, but would silently skip zeros if the constraint were relaxed.
- **Result is always non-negative** due to the `abs()` call. In practice, for positive integers, element sum >= digit sum always holds (since a multi-digit number is always larger than the sum of its digits), so `abs()` is technically redundant but makes the contract explicit.
- **Input list is not modified.** The `num` variable is a local copy of each element.

### Error Handling

None. The function trusts its caller to provide a valid `list[int]` of positive integers, consistent with LeetCode's constraint-based model. An empty list returns 0 (both sums start at 0).

## Topics to Explore

- [file] `difference-between-element-sum-and-digit-sum-of-an-array/test_solution.py` — See what edge cases the test suite covers (empty list, single-digit numbers, large values)
- [function] `subtract-the-product-and-sum-of-digits-of-an-integer/solution.py:subtractProductAndSum` — A closely related digit-decomposition problem using the same `% 10` / `//= 10` pattern
- [function] `add-digits/solution.py:addDigits` — Another digit-sum problem, likely using the digital root formula instead of explicit extraction
- [file] `difference-between-element-sum-and-digit-sum-of-an-array/review.md` — The code review notes for this solution, may flag the `abs()` redundancy or alternative approaches

## Beliefs

- `element-sum-gte-digit-sum` — For positive integers, element sum is always >= digit sum, making `abs()` a no-op guard rather than a functional requirement
- `zero-input-skipped` — A `0` element contributes nothing to `digit_sum` because the `while num > 0` loop body never executes for zero
- `single-pass-complexity` — Time complexity is O(N * D) where N is array length and D is max digit count per element; space is O(1)
- `no-string-conversion` — Digit extraction uses modular arithmetic exclusively, avoiding `str()` conversion and intermediate allocations

