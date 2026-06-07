# File: number-of-days-in-a-month/solution.py

**Date:** 2026-06-06
**Time:** 18:16

## `number-of-days-in-a-month/solution.py`

### Purpose

This file solves [LeetCode 1118 — Number of Days in a Month](https://leetcode.com/problems/number-of-days-in-a-month/). It provides a single function that, given a year and month, returns how many days that month has. The problem's core challenge is handling February correctly across leap years.

### Key Components

**`number_of_days(year: int, month: int) -> int`** — The sole function. Takes a Gregorian year (1583–2100) and month (1–12), returns the day count (28, 29, 30, or 31).

**`days` list** — A lookup table of base day counts for months 1–12, with February defaulting to 28. Indexed by `month - 1` to convert from 1-based month to 0-based list index.

### Patterns

**Lookup table + special case**: The solution avoids a chain of if/elif by storing the common case in a list and only branching for the one irregular month (February in a leap year). This is the standard idiom for this problem.

**Early return**: The leap-year check short-circuits before the general lookup, so February in a leap year never reaches the `days[month - 1]` fallback.

### Dependencies

**Imports**: None — pure arithmetic and a list literal.

**Imported by**: The `test_solution.py` in this same directory. The "Imported By" list in the prompt is misleading — those hundreds of test files each import their *own* `solution.py`, not this one. The only real consumer is `number-of-days-in-a-month/test_solution.py`.

### Flow

1. Build the 12-element `days` list (February = 28).
2. Check if `month == 2` **and** the year satisfies the Gregorian leap-year rule:
   - Divisible by 4, **and** either not divisible by 100 or divisible by 400.
3. If both conditions hold, return 29.
4. Otherwise, return `days[month - 1]`.

The leap-year predicate `(year % 4 == 0 and (year % 100 != 0 or year % 400 == 0))` is the textbook Gregorian rule. The parenthesization is correct: `%100 != 0` handles the century exception, `%400 == 0` handles the 400-year re-exception.

### Invariants

- The function assumes `month` is in [1, 12] and `year` is in the problem's stated range (1583–2100). No validation is performed; out-of-range months will raise `IndexError` from the list lookup.
- The `days` list is reconstructed on every call (local variable, not module-level constant). Functionally irrelevant for correctness, minor for performance.

### Error Handling

None. Invalid inputs (month 0, month 13, negative years) are not guarded. A month of 0 would return `days[-1]` (31 — December, via Python's negative indexing), which is silently wrong rather than an error. Month 13 would raise `IndexError`.

---

## Topics to Explore

- [file] `number-of-days-in-a-month/test_solution.py` — See what edge cases are tested (century years, 400-year years, non-leap Februaries)
- [file] `number-of-days-between-two-dates/solution.py` — A harder problem that likely builds on the same leap-year logic
- [file] `day-of-the-year/solution.py` — Another date problem that needs cumulative month-day counts
- [general] `gregorian-leap-year-edge-cases` — Years like 1900 (not leap) and 2000 (leap) are the classic traps in this predicate

## Beliefs

- `feb-leap-year-returns-29` — `number_of_days(2000, 2)` returns 29 because 2000 is divisible by 400
- `century-non-leap-returns-28` — `number_of_days(1900, 2)` returns 28 because 1900 is divisible by 100 but not 400
- `no-input-validation` — The function does not validate month or year ranges; month=0 silently returns 31 via negative indexing
- `days-list-is-local` — The 12-element lookup table is allocated inside the function body on every call, not cached at module level

