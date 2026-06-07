# File: day-of-the-year/solution.py

**Date:** 2026-06-06
**Time:** 16:10

## `day-of-the-year/solution.py`

### Purpose

This file solves [LeetCode 1154 — Day of the Year](https://leetcode.com/problems/day-of-the-year/): given a date string in `YYYY-MM-DD` format, return which day of the year it is (1-indexed). It's a self-contained module that bundles the solution, a leap-year helper, and a full test suite in one file — the standard layout across this repo.

### Key Components

**`DAYS_IN_MONTH`** (line 5) — A 12-element list of day counts for a non-leap year. February is hardcoded to 28; leap-year adjustment is handled separately in the main function rather than mutating this constant.

**`is_leap_year(year: int) -> bool`** (line 8) — Implements the standard Gregorian leap-year rule: divisible by 4, except centuries unless also divisible by 400. This is extracted as a standalone function rather than inlined, which makes the logic reusable (and it's tested independently in `test_leap_year`).

**`dayOfYear(date: str) -> int`** (line 20) — The core solver. Parses the date string, sums the days from all complete months before the target month via `DAYS_IN_MONTH[:month - 1]`, adds the current day, then conditionally adds 1 for leap years when the month is past February.

**`TestDayOfYear`** (line 33) — 12 test cases covering boundary conditions: Jan 1, Dec 31 (leap and non-leap), the Feb 28/29/Mar 1 boundary on leap years, and the century rules (1900 is not a leap year, 2000 is).

### Patterns

- **Lookup table + conditional adjustment** rather than computing days from scratch or mutating the table. The `DAYS_IN_MONTH` constant stays immutable; the leap-day is a `+1` bolt-on. This is the idiomatic approach for date-of-year calculations.
- **Bundled test suite** — the `unittest.TestCase` lives in the same file, matching the repo-wide convention. A separate `test_solution.py` also exists (and is what other test files reference as an import).
- **`map(int, date.split("-"))`** — standard one-liner for parsing `YYYY-MM-DD` without pulling in `datetime`.

### Dependencies

**Imports:** Only `unittest` from the standard library. No `datetime` — the solution does the calendar math manually.

**Imported by:** The `test_solution.py` in this directory, plus hundreds of other `test_solution.py` files across the repo. The "Imported By" list in the prompt is misleading — those files don't actually import *this* solution. They follow the same structural pattern, and the cross-references reflect the repo's test harness wiring, not real import edges.

### Flow

1. `dayOfYear` receives `"YYYY-MM-DD"`.
2. `split("-")` produces three strings; `map(int, ...)` converts to `(year, month, day)`.
3. `DAYS_IN_MONTH[:month - 1]` slices the lookup table to get only the months that have fully passed. `sum(...)` totals their days.
4. `+ day` adds the current day-of-month.
5. If it's a leap year *and* the month is March or later (`month > 2`), add 1 for the extra Feb 29.

### Invariants

- Input is always a valid `YYYY-MM-DD` string with a real calendar date. No validation is performed — this matches LeetCode's problem constraints.
- `month > 2` is the correct guard: if the date is in January or February, Feb 29 hasn't occurred yet (or the date *is* Feb 29, which is already counted by `day`). The leap-day adjustment only applies to months after February.
- `DAYS_IN_MONTH` is never modified at runtime.

### Error Handling

None. Invalid inputs (malformed strings, out-of-range months, non-dates) will raise `ValueError` from `int()` or produce silently wrong results. This is intentional for a LeetCode solution where inputs are guaranteed valid.

## Topics to Explore

- [file] `day-of-the-year/test_solution.py` — The companion test file that imports this solution; shows how the repo's test harness invokes solutions
- [function] `number-of-days-between-two-dates/solution.py:daysBetweenDates` — Related date-arithmetic problem that likely reuses the same leap-year and day-counting pattern
- [function] `number-of-days-in-a-month/solution.py:numberOfDays` — Another calendar problem; worth comparing whether it shares the `DAYS_IN_MONTH` table approach
- [file] `count-days-spent-together/solution.py` — Date interval overlap problem that likely builds on similar day-of-year conversion logic
- [general] `gregorian-leap-year-edge-cases` — The century rule (divisible by 100 but not 400) is a classic source of bugs; 1900 vs 2000 tests here exercise exactly that

## Beliefs

- `leap-year-adjustment-only-after-feb` — `dayOfYear` only adds 1 for leap years when `month > 2`, correctly handling that Feb 29 itself is counted by the `day` component
- `days-in-month-immutable-constant` — `DAYS_IN_MONTH` is a module-level list that is never mutated; leap-year handling is done via conditional addition, not table modification
- `no-stdlib-datetime-dependency` — The solution performs all calendar math manually using integer arithmetic and a lookup table, with no `datetime` import
- `century-leap-year-rule-tested` — Tests cover both the "century non-leap" case (1900) and the "400-year leap" case (2000), which are the two most commonly missed edge cases in leap-year logic

