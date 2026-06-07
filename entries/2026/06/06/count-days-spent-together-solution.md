# File: count-days-spent-together/solution.py

**Date:** 2026-06-06
**Time:** 15:56

## Purpose

This file solves [LeetCode 2409: Count Days Spent Together](https://leetcode.com/problems/count-days-spent-together/). It determines how many days two people (Alice and Bob) are simultaneously in Rome, given their arrival and departure dates as `"MM-DD"` strings within a single non-leap year. The file is self-contained: solution function, helper, and unit tests all in one module.

## Key Components

### `DAYS_IN_MONTH` (constant)
A 12-element list of days per month for a non-leap year. Used as a lookup table to convert month-day strings into absolute day-of-year values. The problem guarantees a non-leap year, so February is always 28.

### `_date_to_day(date: str) -> int`
Converts a `"MM-DD"` string to a 1-indexed day-of-year. It slices the string directly (`date[:2]`, `date[3:5]`) rather than splitting on `"-"`, then sums the days of all preceding months via `DAYS_IN_MONTH[:month - 1]` and adds the day. For example, `"02-05"` becomes `31 + 5 = 36`.

### `days_together(...) -> int`
The main solver. Converts all four date strings to day-of-year integers, then computes the overlap of two closed intervals `[a0, a1]` and `[b0, b1]` using the standard formula:

```
max(0, min(a1, b1) - max(a0, b0) + 1)
```

The `+ 1` accounts for inclusive endpoints (both arrival and departure days count).

### `TestDaysTogether` (unittest.TestCase)
Eight test cases covering: partial overlap, no overlap, identical ranges, single-day overlap, containment, same single day, adjacent-but-disjoint months, and cross-month overlap.

## Patterns

- **Day-of-year normalization**: Reduces a 2D problem (month, day) to a 1D problem (day-of-year), making interval arithmetic straightforward.
- **Interval overlap formula**: The `max(0, min(end1, end2) - max(start1, start2) + 1)` idiom is the canonical way to compute overlap length of two closed intervals. The `max(0, ...)` handles the non-overlapping case, returning 0 instead of a negative number.
- **Self-contained module**: Solution, helper, and tests colocated in one file — consistent with the rest of this repo's convention.

## Dependencies

**Imports**: Only `unittest` from the standard library. No external dependencies.

**Imported by**: The `test_solution.py` in the same directory imports from this file. The massive "Imported By" list in the prompt is an artifact of the repo-wide cross-reference — those are other problems' test files, not actual importers of this module.

## Flow

1. Caller passes four `"MM-DD"` strings to `days_together`.
2. Each string is converted to an integer day-of-year via `_date_to_day`.
3. The overlap of the two date ranges is computed as a single arithmetic expression.
4. Returns 0 if no overlap, otherwise the count of shared days (inclusive).

## Invariants

- **Non-leap year assumed**: `DAYS_IN_MONTH` has February as 28. The problem guarantees this; the code does not validate it.
- **Input format**: Expects exactly `"MM-DD"` with zero-padded two-digit month and day. No validation — malformed input would produce wrong results or raise `ValueError` from `int()`.
- **Arrival <= Departure**: The problem guarantees `arriveAlice <= leaveAlice` and `arriveBob <= leaveBob`. The formula produces correct results under this assumption; swapped inputs would yield negative values clamped to 0.
- **Same calendar year**: All dates are within a single year. No year component exists.

## Error Handling

None. The code trusts its inputs per the LeetCode contract. Invalid date strings would propagate a `ValueError` from `int()`. There are no try/except blocks or defensive checks.

## Topics to Explore

- [file] `count-days-spent-together/plan.md` — The planning doc that preceded this solution, showing the approach selection rationale
- [file] `count-days-spent-together/review.md` — Post-implementation review with quality assessment and alternative approaches
- [function] `number-of-days-between-two-dates/solution.py:_date_to_day` — A related date-conversion helper that likely handles leap years, contrasting with the simpler version here
- [general] `interval-overlap-pattern` — The `max(0, min(e1,e2) - max(s1,s2) + 1)` idiom appears across multiple solutions (e.g., `determine-if-two-events-have-conflict`); worth tracing as a cross-cutting pattern
- [file] `day-of-the-year/solution.py` — Another day-of-year conversion that may handle leap years, showing the fuller version of the same transformation

## Beliefs

- `days-together-non-leap-year` — `DAYS_IN_MONTH` sums to 365 and assumes February has 28 days; leap years are out of scope per the problem contract
- `days-together-inclusive-endpoints` — The `+ 1` in the overlap formula means both arrival and departure days are counted as days spent together
- `date-to-day-string-slicing` — `_date_to_day` relies on fixed-position slicing (`[:2]`, `[3:5]`), not delimiter splitting, so it requires zero-padded `"MM-DD"` format
- `days-together-zero-on-no-overlap` — When intervals don't overlap, `max(0, ...)` ensures the return value is 0 rather than a negative number

