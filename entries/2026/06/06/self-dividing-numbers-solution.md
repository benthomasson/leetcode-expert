# File: self-dividing-numbers/solution.py

**Date:** 2026-06-06
**Time:** 19:02

## Purpose

This file solves [LeetCode 728 — Self Dividing Numbers](https://leetcode.com/problems/self-dividing-numbers/). A self-dividing number is one that is divisible by every digit it contains, with the additional constraint that it cannot contain the digit zero (since division by zero is undefined). The file owns the complete solution: the predicate that tests a single number and the range filter that collects all matches.

## Key Components

### `is_self_dividing(n: int) -> bool`

The core predicate. Extracts digits from `n` right-to-left using repeated `% 10` / `//= 10` and checks two conditions per digit:

1. The digit is not zero.
2. The original number `n` is evenly divisible by the digit.

Returns `False` on the first violation (short-circuit). Returns `True` only if every digit passes.

Note the use of two separate variables: `num` (the copy being consumed for digit extraction) and `n` (the original value used for the divisibility test). This is critical — if you tested `num % digit` instead, you'd be testing a shrinking number against its own digits, which is wrong.

### `self_dividing_numbers(left: int, right: int) -> list[int]`

A thin range-filter wrapper. Iterates `[left, right]` inclusive and collects numbers satisfying `is_self_dividing`. Implemented as a single list comprehension — no early termination or optimization, just a linear scan.

## Patterns

- **Digit extraction via modular arithmetic** rather than string conversion (`str(n)` + iteration). This avoids allocation and is the idiomatic numeric approach for LeetCode digit-manipulation problems.
- **Predicate + filter decomposition**: separating the per-element test from the collection logic. Clean separation of concerns.
- **Short-circuit evaluation**: the `if digit == 0 or n % digit != 0` check exits on the first failing digit, skipping remaining work.

## Dependencies

**Imports**: None — pure stdlib, no external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files across the entire repo that likely share a common test harness, not files that actually call `is_self_dividing` or `self_dividing_numbers`. The real consumer is `self-dividing-numbers/test_solution.py`.

## Flow

```
self_dividing_numbers(left=1, right=22)
  → range(1, 23)
  → for each n: is_self_dividing(n)
       n=1:  num=1 → digit=1, 1%1==0 ✓ → num=0 → True
       n=10: num=10 → digit=0 → False (zero digit)
       n=12: num=12 → digit=2, 12%2==0 ✓ → num=1 → digit=1, 12%1==0 ✓ → True
       n=22: num=22 → digit=2, 22%2==0 ✓ → num=2 → digit=2, 22%2==0 ✓ → True
  → [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 15, 22]
```

## Invariants

- `n` must be a positive integer. The `while num:` loop terminates when `num` reaches 0, which works for positive integers but would infinite-loop for negative values (Python's floor division on negatives keeps the value negative).
- Zero itself would return `True` (the while loop body never executes), which is technically incorrect but irrelevant since the LeetCode constraint guarantees `1 ≤ left ≤ right ≤ 10^4`.
- The function checks divisibility against the **original** `n`, not the progressively truncated `num`.

## Error Handling

None. No exceptions are raised or caught. The function trusts its caller to provide valid positive integers. Division by zero is avoided at the logic level by checking `digit == 0` before `n % digit`.

## Topics to Explore

- [file] `self-dividing-numbers/test_solution.py` — See the test cases and edge cases exercised against this solution
- [file] `self-dividing-numbers/review.md` — Code review notes on this solution's quality and alternatives
- [function] `count-the-digits-that-divide-a-number/solution.py:countDigits` — Related digit-divisibility problem with a similar extraction loop
- [general] `digit-extraction-patterns` — Compare modular arithmetic vs string-based digit extraction across the repo's solutions
- [file] `happy-number/solution.py` — Another problem using the same `% 10` / `//= 10` digit-extraction idiom with a cycle-detection twist

## Beliefs

- `self-dividing-zero-guard` — `is_self_dividing` rejects any number containing the digit 0 before attempting modular division, preventing division-by-zero errors
- `self-dividing-original-value-test` — Divisibility is always tested against the original input `n`, not the progressively truncated `num` used for digit extraction
- `self-dividing-short-circuit` — `is_self_dividing` returns `False` on the first non-dividing or zero digit without examining remaining digits
- `self-dividing-no-dependencies` — The solution uses no imports; it is pure arithmetic with no external dependencies

