# File: separate-the-digits-in-an-array/solution.py

**Date:** 2026-06-06
**Time:** 19:03

## Purpose

This file solves [LeetCode 2553 — Separate the Digits in an Array](https://leetcode.com/problems/separate-the-digits-in-an-array/). Given a list of positive integers, it returns a flat list of their individual digits in order. For example, `[13, 25, 83, 77]` becomes `[1, 3, 2, 5, 8, 3, 7, 7]`.

It's one of ~500 problem solutions in the `leetcode-implementations` repo, each following the same structure: a `solution.py` with the core logic, a `test_solution.py`, and optional `plan.md`/`review.md`.

## Key Components

**`separate_digits(nums: list[int]) -> list[int]`** — The sole export. Takes a list of positive integers and returns a list of single digits.

## Patterns

The implementation is a single nested list comprehension using the **str-conversion idiom** for digit extraction:

```python
[int(d) for num in nums for d in str(num)]
```

This is a two-level flatten: the outer loop iterates over each number, `str(num)` breaks it into character digits, and `int(d)` converts each character back to an integer. The left-to-right ordering of `for` clauses preserves the original digit order across all numbers.

This pattern — `int(d) for d in str(n)` — is the standard Python idiom for digit decomposition without arithmetic (`% 10`, `// 10`), and it appears across many solutions in this repo (e.g., `add-digits`, `alternating-digit-sum`, `count-the-digits-that-divide-a-number`).

## Dependencies

**Imports:** None — pure Python, no standard library or third-party dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — it lists ~400+ test files across the entire repo. These are almost certainly importing from their *own* `solution.py` (via a shared test harness or relative import), not from this specific file. The actual consumer is `separate-the-digits-in-an-array/test_solution.py`.

## Flow

1. Caller passes `nums`, e.g. `[13, 25]`.
2. Outer generator iterates: `num = 13`, then `num = 25`.
3. `str(13)` yields `"13"` → inner loop produces `int("1")=1`, `int("3")=3`.
4. `str(25)` yields `"25"` → inner loop produces `int("2")=2`, `int("5")=5`.
5. Returns `[1, 3, 2, 5]`.

The entire transformation is eager (list comprehension, not generator), so the full result is materialized in one pass.

## Invariants

- **Input contract:** `nums` contains positive integers (per the LeetCode problem constraints: `1 <= nums[i] <= 10^5`). Negative numbers would produce `"-"` as a character, causing `int("-")` to raise `ValueError`.
- **Output ordering:** Digits appear in the same left-to-right order as they do in the original numbers, and numbers appear in their original list order.
- **Single digits pass through unchanged:** A number like `7` produces `[7]` — `str(7)` is `"7"`, `int("7")` is `7`.

## Error Handling

None. The function trusts its input matches the LeetCode constraints. No validation, no try/except. A `0` in the input works fine (`str(0)` → `"0"` → `[0]`), but negative numbers or non-integers would blow up at `int(d)` or produce wrong results.

## Topics to Explore

- [file] `separate-the-digits-in-an-array/test_solution.py` — See the test cases and edge cases covered for this solution
- [file] `separate-the-digits-in-an-array/review.md` — Code review notes that may discuss alternative approaches (arithmetic vs. string conversion)
- [function] `alternating-digit-sum/solution.py:separate_digits` — Another digit-decomposition problem; compare whether it uses the same str-conversion idiom or arithmetic
- [general] `digit-extraction-patterns` — Survey which solutions use `str(n)` vs. `n % 10` / `n // 10` for digit work and whether there's a performance difference at LeetCode scale

## Beliefs

- `str-conversion-for-digits` — `separate_digits` uses `str(num)` + `int(d)` for digit extraction rather than modular arithmetic, which preserves left-to-right digit order without reversal
- `no-input-validation` — The function performs no validation on `nums`; negative integers would raise `ValueError` on the `"-"` character
- `single-pass-eager` — The list comprehension materializes the full result in a single pass with O(total_digits) time and space
- `zero-dependency` — The module has no imports; it uses only Python builtins (`str`, `int`, list comprehension)

