# File: excel-sheet-column-number/solution.py

**Date:** 2026-06-06
**Time:** 16:29

## `excel-sheet-column-number/solution.py`

### Purpose

This file solves [LeetCode #171 — Excel Sheet Column Number](https://leetcode.com/problems/excel-sheet-column-number/). It converts an Excel-style column label (e.g., `"A"`, `"Z"`, `"AB"`) into its 1-indexed column number (1, 26, 28). It's the inverse of the sibling problem in `excel-sheet-column-title/`.

### Key Components

**`title_to_number(columnTitle: str) -> int`** — The sole function. Takes an uppercase letter string and returns the corresponding column number. Contract: input is a non-empty string of uppercase ASCII letters; output is a positive integer.

### Patterns

The function treats the column title as a **base-26 number with digits A=1 through Z=26** (not 0-25 — there's no zero digit). It uses **Horner's method** to evaluate the polynomial: process characters left-to-right, multiplying the running total by 26 and adding the current digit's value.

For `"AB"`: `0*26 + 1 = 1`, then `1*26 + 2 = 28`.

This is the standard idiom for positional numeral conversion — identical in structure to `int(s, base)` but offset by 1 because Excel columns are 1-indexed per position.

### Dependencies

**Imports**: None. Uses only the built-in `ord()`.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files across the entire repo that share a common test harness import pattern, not files that actually call `title_to_number`. The real direct consumer is `excel-sheet-column-number/test_solution.py`.

### Flow

1. Initialize `result = 0`.
2. For each character `c` in `columnTitle` (left to right):
   - Shift the accumulator left by one base-26 position (`result * 26`).
   - Add the 1-based value of the current letter (`ord(c) - ord('A') + 1`).
3. Return the accumulated integer.

The loop body is a single expression — no branching, no early exit.

### Invariants

- **Input alphabet**: Assumes all characters are uppercase `A`–`Z`. No validation is performed; lowercase or non-alpha input would produce silently wrong results.
- **Non-empty input**: An empty string returns 0, which isn't a valid Excel column. The function doesn't guard against this.
- **No overflow concern**: Python integers are arbitrary-precision, so any length string works.

### Error Handling

None. The function trusts its caller completely — consistent with LeetCode solution conventions where input constraints are guaranteed by the problem.

## Topics to Explore

- [file] `excel-sheet-column-title/solution.py` — The inverse operation (number → title); understanding both directions clarifies the base-26-with-no-zero encoding
- [function] `excel-sheet-column-number/test_solution.py:test_*` — See which edge cases the test suite covers (single letter, multi-letter, boundary values)
- [general] `base-26-vs-standard-bases` — Why Excel columns aren't true base-26 (no zero digit) and how that complicates both conversion directions
- [file] `cells-in-a-range-on-an-excel-sheet/solution.py` — Another Excel-column problem that likely uses similar character arithmetic

## Beliefs

- `excel-column-number-is-horner-method` — `title_to_number` evaluates the column string as a base-26 polynomial using Horner's method, processing left-to-right in a single pass
- `excel-column-number-no-validation` — The function performs no input validation; it assumes a non-empty string of uppercase A–Z as guaranteed by LeetCode constraints
- `excel-column-number-inverse-of-title` — `title_to_number` is the mathematical inverse of the conversion in `excel-sheet-column-title/solution.py`
- `excel-column-number-zero-free-base` — The encoding uses digits 1–26 (A–Z) with no zero, making it a bijective base-26 numeration rather than standard base-26

