# File: missing-number/solution.py

**Date:** 2026-06-06
**Time:** 18:05

## `missing-number/solution.py`

### Purpose

This file solves [LeetCode #268 — Missing Number](https://leetcode.com/problems/missing-number/). Given an array of `n` distinct integers drawn from the range `[0, n]`, it finds the one number in that range that's absent. It's a standalone solution module following the repo's convention of one problem per directory.

### Key Components

**`missingNumber(nums: list[int]) -> int`** — The sole function. It exploits the closed-form formula for triangular numbers: the sum of `0` through `n` is `n*(n+1)//2`. Subtracting the actual sum of the input gives the missing value.

### Patterns

**Gauss's summation trick.** Rather than using a set difference, sorting, or XOR, this solution computes the expected sum algebraically and subtracts the observed sum. This is O(n) time, O(1) space — the most space-efficient approach for this problem.

The alternative approaches you'd commonly see:

| Approach | Time | Space |
|----------|------|-------|
| Gauss sum (this) | O(n) | O(1) |
| XOR all indices + values | O(n) | O(1) |
| Hash set | O(n) | O(n) |
| Sort + scan | O(n log n) | O(1) |

The Gauss approach and XOR are both optimal. Gauss is simpler to read but has a theoretical risk of integer overflow in languages with fixed-width integers — not a concern in Python, which has arbitrary-precision ints.

### Dependencies

**Imports:** None. Pure computation with no external dependencies.

**Imported by:** The `missing-number/test_solution.py` file directly. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those are test files for *other* problems that happen to share a common test harness or import pattern, not actual consumers of `missingNumber`.

### Flow

1. Compute `n` as `len(nums)` — the array has `n` elements drawn from `[0, n]`, so one of the `n+1` possible values is missing.
2. Compute the expected sum: `n * (n + 1) // 2`.
3. Compute the actual sum: `sum(nums)`.
4. Return the difference — this is the missing number.

For `nums = [3, 0, 1]`: `n = 3`, expected = `6`, actual = `4`, result = `2`.

### Invariants

- **Input contract:** `nums` contains exactly `n` distinct values from `[0, n]`. If duplicates exist or values fall outside the range, the result is meaningless (but no error is raised).
- **Exactly one missing number.** The formula assumes precisely one value is absent. With zero or multiple missing values, it silently produces a wrong answer.
- **Integer division:** `//` ensures the result is an `int`, not a float. Since `n*(n+1)` is always even (one of two consecutive integers is even), this division is always exact.

### Error Handling

None. The function trusts its input completely — consistent with LeetCode solution conventions where inputs are guaranteed valid by the problem statement. No validation, no exceptions.

## Topics to Explore

- [file] `missing-number/test_solution.py` — See the test cases and edge conditions (empty array, single element, large n)
- [file] `missing-number/review.md` — The code review likely discusses alternative approaches (XOR, set difference) and tradeoffs
- [file] `find-all-numbers-disappeared-in-an-array/solution.py` — Related problem that finds *all* missing numbers in `[1, n]`, requiring a different technique
- [file] `set-mismatch/solution.py` — Closely related: finds one duplicate and one missing number, often solved with similar sum/XOR tricks
- [general] `gauss-sum-vs-xor` — Both are O(n)/O(1) but XOR avoids large intermediate sums and is immune to overflow in fixed-width languages

## Beliefs

- `missing-number-gauss-sum` — `missingNumber` uses Gauss's formula (`n*(n+1)//2 - sum`) rather than XOR, hash set, or sorting
- `missing-number-o1-space` — The solution uses O(1) auxiliary space — no data structures beyond the input
- `missing-number-no-validation` — The function performs no input validation; it assumes exactly one value from `[0, n]` is absent with no duplicates
- `missing-number-python-no-overflow` — The Gauss sum approach has no overflow risk in Python due to arbitrary-precision integers, unlike C++/Java equivalents

