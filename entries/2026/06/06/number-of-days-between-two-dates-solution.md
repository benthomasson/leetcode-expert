# File: number-of-days-between-two-dates/solution.py

**Date:** 2026-06-06
**Time:** 18:15

## `number-of-days-between-two-dates/solution.py`

### Purpose

This file solves [LeetCode 1360](https://leetcode.com/problems/number-of-days-between-two-dates/): compute the absolute number of days between two dates given as `YYYY-MM-DD` strings. It contains both the solution and its unit tests in a single module, following the repo's standard layout.

### Key Components

**`Solution.daysBetweenDates(date1, date2) -> int`** — The public API matching LeetCode's expected signature. Converts both dates to an absolute day count from a fixed epoch (day 0 = January 1 of year 0), then returns the absolute difference. The `abs()` call makes argument order irrelevant.

**`Solution._days_from_epoch(date: str) -> int`** — The core computation. Converts a `YYYY-MM-DD` string into the total number of days since an implicit epoch. This is a static method because it needs no instance state — it's pure date arithmetic.

The calculation has three phases:
1. **Year contribution** (line ~30): `365 * (y - 1)` gives the base day count, then corrects for leap years using the inclusion-exclusion formula: `+ (y-1)//4 - (y-1)//100 + (y-1)//400`. This counts all leap days before year `y`. The `(y - 1)` offset matters — it counts completed years, not the current one.
2. **Month contribution** (lines ~31-32): Sums days from the `days_in_month` lookup table for months `1..m-1`. February is hardcoded as 28 in the table.
3. **Leap correction** (lines ~33-34): If the current year is a leap year and the month is past February, adds 1 day. This is cleaner than modifying the table in place.

**`Solution._is_leap(year: int) -> bool`** — Standard Gregorian leap year test. Divisible by 4, but not by 100, unless also by 400. Used only by `_days_from_epoch`.

**`TestDaysBetweenDates`** — 12 test cases covering: same day, adjacent days, cross-month, leap/non-leap February, century leap rules (1900 vs 2000), full year spans, the problem's max range, and reversed argument order.

### Patterns

- **Epoch-based date comparison**: Rather than computing deltas directly (which requires case-splitting on month lengths and year boundaries), both dates are projected onto a single integer axis. This reduces the comparison to subtraction — a classic technique.
- **Inclusion-exclusion for leap years**: The `+//4 - //100 + //400` pattern mirrors the Gregorian calendar's layered divisibility rules.
- **Static table with conditional correction**: `days_in_month` uses a fixed 28 for February, with leap adjustment applied separately. This avoids mutating the table or passing extra state.
- **Self-contained test module**: Tests live alongside the solution, runnable via `python -m unittest` or `python solution.py`.

### Dependencies

**Imports**: Only `unittest` from the standard library. No external packages, no datetime module — the entire calendar calculation is from scratch, which is the point of the problem.

**Imported by**: The `test_solution.py` file in the same directory. The "Imported By" list in the prompt is misleading — it lists test files from *other* problems that import `unittest`, not files that import this module.

### Flow

```
daysBetweenDates("2020-01-15", "2019-12-31")
  → _days_from_epoch("2020-01-15")  → 737,439 (approx)
  → _days_from_epoch("2019-12-31")  → 737,424 (approx)
  → abs(737439 - 737424) = 15
```

Date parsing is done by slicing: `date[:4]`, `date[5:7]`, `date[8:10]`. No `split("-")` — slightly more rigid but avoids allocation.

### Invariants

- **Input format**: Assumes exactly `YYYY-MM-DD` with zero-padded fields. No validation; malformed input produces garbage silently.
- **Gregorian calendar**: The leap year formula is Gregorian. It produces incorrect results for dates before the Gregorian reform (1582), but LeetCode constrains inputs to 1971–2100.
- **Epoch consistency**: Both dates use the same epoch, so the absolute epoch value doesn't matter — only the difference.
- **`days_in_month[0] = 0`**: A sentinel so months can be 1-indexed naturally. The loop `range(1, m)` never touches index 0 when `m >= 1`.

### Error Handling

None. The code trusts its caller to provide valid date strings in the correct format. This is appropriate for a LeetCode solution where inputs are guaranteed by the problem constraints.

---

## Topics to Explore

- [file] `day-of-the-week/solution.py` — Uses similar epoch-based date math to compute weekday, likely shares the same `_days_from_epoch` pattern
- [file] `day-of-the-year/solution.py` — Computes day-of-year ordinal, another variant of Gregorian month/day accumulation
- [file] `count-days-spent-together/solution.py` — Date interval overlap problem that may reuse or reimplement day-counting logic
- [general] `gregorian-leap-year-formula` — The `+//4 - //100 + //400` inclusion-exclusion and why `(y-1)` is used instead of `y`
- [file] `number-of-days-in-a-month/solution.py` — Complementary problem focused on single-month day counts with leap year handling

## Beliefs

- `days-from-epoch-uses-y-minus-1` — `_days_from_epoch` counts leap days for years `1..(y-1)`, not `1..y`, because the current year's leap day is handled separately via the `m > 2` correction
- `argument-order-irrelevant` — `daysBetweenDates` returns the same result regardless of which date is earlier, guaranteed by the `abs()` wrapper
- `no-stdlib-date-usage` — The solution implements Gregorian calendar arithmetic from scratch without importing `datetime` or `calendar`, which is the intended constraint of the problem
- `days-in-month-table-is-1-indexed` — Index 0 of `days_in_month` is a dummy value (0); months 1–12 map directly to their natural positions

