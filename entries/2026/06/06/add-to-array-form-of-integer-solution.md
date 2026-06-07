# File: add-to-array-form-of-integer/solution.py

**Date:** 2026-06-06
**Time:** 15:13

## Purpose

This file solves [LeetCode 989: Add to Array-Form of Integer](https://leetcode.com/problems/add-to-array-form-of-integer/). It takes a number represented as an array of digits (`num`) and adds an integer `k` to it, returning the result as an array of digits. The file is self-contained: solution class + unit tests in one module.

## Key Components

### `Solution.addToArrayForm(num, k) -> List[int]`

The core method. It performs digit-by-digit addition from right to left, using `k` itself as both the addend and the carry accumulator.

**Contract**: `num` is a non-empty list of single digits representing a non-negative integer (most significant digit first). `k` is a non-negative integer. Returns a list of digits representing `num + k`.

### `TestAddToArrayForm`

Seven test cases covering: basic addition, carry propagation, single-digit arrays, full carry overflow (`999 + 1 = 1000`), zero array, and `k` being much larger than `num`.

## Patterns

**In-place mutation with extension**: The algorithm modifies `num` in place for existing positions, and uses `list.insert(0, ...)` to prepend digits when `k` has more digits than `num`. This avoids allocating a separate result array for the common case where no new digits are needed.

**Carry absorption into `k`**: Instead of maintaining a separate `carry` variable, the algorithm folds the carry into `k` via `k //= 10`. This is the key trick — `k` starts as the number to add, and after each iteration it becomes the remaining value plus any carry. The loop condition `while i >= 0 or k` naturally handles both traversing `num` and draining any remaining carry/digits from `k`.

## Flow

1. Start at the least significant digit (`i = len(num) - 1`).
2. Each iteration:
   - If `i >= 0`: add `num[i]` into `k`, then write `k % 10` back to `num[i]`.
   - If `i < 0` (past the front of the array): prepend `k % 10` to `num`.
   - Integer-divide `k` by 10 to shift to the next digit / consume carry.
   - Decrement `i`.
3. Loop exits when both `i < 0` (array exhausted) and `k == 0` (no remaining digits/carry).
4. Return the modified `num`.

## Invariants

- At the start of each iteration, `k` holds the sum of all unprocessed higher-order contributions plus any carry from the previous digit.
- `num[j]` for `j > i` already contains the correct final digit.
- The loop terminates because `k` strictly decreases each iteration (via `k //= 10`) once `i < 0`, and `i` always decreases.

## Error Handling

None. The solution trusts LeetCode's input constraints (valid digit array, non-negative `k`). No validation, no exceptions. The tests use `assertEqual` assertions — failures surface as `unittest` errors.

## Dependencies

**Imports**: `typing.List` (type annotation), `unittest` (tests).

**Imported by**: The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that happen to import `unittest`, not files that import this solution. The actual dependent is `add-to-array-form-of-integer/test_solution.py`.

## Topics to Explore

- [file] `add-strings/solution.py` — Same digit-by-digit addition pattern but between two string-encoded numbers; compare how carry is handled
- [file] `add-to-array-form-of-integer/review.md` — Review notes on this solution's tradeoffs and complexity analysis
- [general] `list-insert-0-cost` — `num.insert(0, ...)` is O(n) per call; when `k` has d extra digits this makes the prepend phase O(d*n) — worth understanding when this matters vs. appending and reversing
- [function] `add-digits/solution.py:addDigits` — Related digit-manipulation problem using the digital root formula, a very different approach to working with digits

## Beliefs

- `add-to-array-form-uses-k-as-carry` — The algorithm uses the input integer `k` as both the addend and the carry accumulator, eliminating the need for a separate carry variable
- `add-to-array-form-modifies-num-in-place` — The method mutates and returns the input list `num` rather than allocating a new result list
- `add-to-array-form-prepend-is-quadratic-worst-case` — When `k` has more digits than `num`, each extra digit triggers an O(n) `list.insert(0, ...)`, making the overflow phase O(d*n) where d is the number of extra digits
- `add-to-array-form-loop-terminates-on-both-conditions` — The while loop requires both the array to be fully traversed (`i < 0`) and `k` to be zero (no remaining value or carry) before exiting

