# File: count-integers-with-even-digit-sum/solution.py

**Date:** 2026-06-06
**Time:** 15:59

## Purpose

This file solves [LeetCode 2180: Count Integers With Even Digit Sum](https://leetcode.com/problems/count-integers-with-even-digit-sum/). Given an integer `num`, it counts how many positive integers in `[1, num]` have a digit sum that is even.

It's one of ~400+ solutions in the `leetcode-implementations` repo, following the standard per-problem directory layout (`solution.py`, `test_solution.py`, `plan.md`, `review.md`).

## Key Components

**`max_tasks(num: int) -> int`** — the sole function. Notable: the function name `max_tasks` doesn't match the problem domain ("count integers with even digit sum"). This is likely a template/generation artifact — the LeetCode problem's method signature is `countEven`, and the directory name says `count-integers-with-even-digit-sum`, but the function is named as if it belongs to a different problem.

## Patterns

The implementation is a single-expression brute-force enumerate-and-filter:

```python
sum(1 for n in range(1, num + 1) if sum(int(d) for d in str(n)) % 2 == 0)
```

This chains three idioms:
1. **String-based digit extraction** — `str(n)` then `int(d)` for each character. Avoids modular arithmetic at the cost of string allocation.
2. **Generator-based counting** — `sum(1 for ... if ...)` as a counting pattern instead of `len(list(...))`. Memory-efficient since no intermediate list is materialized.
3. **Even-check via modulo** — `% 2 == 0` on the digit sum.

## Dependencies

**Imports**: None — pure Python, no stdlib or third-party dependencies.

**Imported by**: The `test_solution.py` in this same directory. The massive "Imported By" list in the prompt is a tooling artifact — those hundreds of test files across other problems don't actually import this module. They each import their own `solution.py` via a relative or local import.

## Flow

1. Iterate `n` from 1 through `num` inclusive.
2. For each `n`, convert to string, convert each character back to `int`, sum the digits.
3. If that sum is even, count it (contribute 1 to the outer `sum`).
4. Return the total count.

This is O(n * d) where d is the number of digits in n — at most 4 given the constraint `num <= 1000`. Effectively O(n).

## Invariants

- **Domain constraint**: `1 <= num <= 1000` per the problem spec. The code doesn't validate this — it trusts the caller (appropriate for a LeetCode submission).
- **Range starts at 1**: Zero is excluded, matching the problem statement ("positive integers").

## Error Handling

None. No input validation, no try/except. If `num` is 0 or negative, the generator produces nothing and `sum` returns 0, which happens to be correct (no positive integers to count). If `num` is non-integer, `range()` will raise `TypeError` — standard Python behavior, not caught.

## Topics to Explore

- [file] `count-integers-with-even-digit-sum/test_solution.py` — See what edge cases are tested and whether the `max_tasks` name mismatch causes import issues
- [file] `count-integers-with-even-digit-sum/review.md` — Check if the naming mismatch or the brute-force approach was flagged during review
- [general] `digit-sum-math-approach` — An O(1) closed-form solution exists (every 10 consecutive integers have exactly 5 with even digit sum), worth comparing
- [function] `add-digits/solution.py:addDigits` — Related digit-manipulation problem; compare approaches to digit extraction (string vs modular arithmetic)

## Beliefs

- `max-tasks-name-mismatch` — The function is named `max_tasks` but solves "count integers with even digit sum" — the name doesn't reflect the problem
- `brute-force-linear-scan` — The solution enumerates all integers 1..num rather than using a mathematical shortcut, making it O(n)
- `string-digit-extraction` — Digits are extracted via `str(n)` conversion rather than repeated `% 10` and `// 10`
- `no-input-validation` — The function trusts the caller to provide valid input within the LeetCode constraint `1 <= num <= 1000`

