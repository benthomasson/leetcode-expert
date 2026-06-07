# File: day-of-the-week/solution.py

**Date:** 2026-06-06
**Time:** 16:09

## `day-of-the-week/solution.py`

### Purpose

This file solves [LeetCode 1185 — Day of the Week](https://leetcode.com/problems/day-of-the-week/). Given a date as three integers (day, month, year), it returns the English name of that weekday. It's a thin wrapper around Python's `datetime.date.weekday()`.

### Key Components

**`day_of_the_week(day, month, year) -> str`** — The sole function. Takes integer date components, constructs a `datetime.date`, and indexes into a lookup table to return the day name.

**`days` list** — Maps `weekday()` return values (0=Monday through 6=Sunday) to their English names. Each string has a **trailing space** (e.g., `"Saturday "`), which is a quirk worth noting — this matches the LeetCode problem's expected output format but would be surprising to a caller expecting clean strings.

### Patterns

- **Standard library delegation**: No manual calendar math (Zeller's congruence, etc.). The entire problem reduces to a `datetime.date` construction + `.weekday()` call. This is the idiomatic Python approach for date problems — let the stdlib handle leap years and calendar edge cases.
- **Lookup table over conditionals**: A list indexed by `weekday()` avoids a chain of if/elif.

### Dependencies

**Imports**: `datetime` (stdlib). No project-internal dependencies.

**Imported by**: `day-of-the-week/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those hundreds of test files import from their own respective `solution.py`, not from this one.

### Flow

1. Caller passes `(day, month, year)` integers.
2. `datetime.date(year, month, day)` constructs a date object — note the argument reordering (`year` first for `datetime.date`).
3. `.weekday()` returns an int 0–6 (Monday–Sunday).
4. That int indexes into `days`, returning the name string.

Single expression, no branching, O(1).

### Invariants

- **Input range**: The docstring states year is 1971–2100, matching the LeetCode constraint. The code itself doesn't validate this — `datetime.date` accepts a wider range and would raise `ValueError` on truly invalid dates (month=13, day=32, etc.).
- **Trailing whitespace contract**: The return value always ends with a space. This is load-bearing for test compatibility.

### Error Handling

None. Invalid dates (e.g., Feb 30) propagate as `ValueError` from `datetime.date()`. There's no try/except — the function assumes valid input per the LeetCode problem constraints.

## Topics to Explore

- [file] `day-of-the-week/test_solution.py` — See what edge cases are tested (leap years, boundary years 1971/2100)
- [file] `day-of-the-year/solution.py` — Another date-arithmetic problem; compare whether it also delegates to `datetime` or uses manual calculation
- [file] `number-of-days-between-two-dates/solution.py` — A harder date problem that may reveal whether the repo consistently uses `datetime` or sometimes implements calendar math manually
- [general] `trailing-whitespace-convention` — Whether other solutions in this repo also return values with trailing spaces, or if this is an anomaly specific to the LeetCode judge's expected output

## Beliefs

- `day-of-week-uses-stdlib` — `day_of_the_week` delegates all calendar logic to `datetime.date.weekday()` with no manual computation
- `day-of-week-trailing-space` — Return values include a trailing space (e.g., `"Monday "` not `"Monday"`), matching the LeetCode expected output
- `day-of-week-weekday-index-order` — The `days` list is ordered Monday-first (index 0) to match `datetime.date.weekday()`'s convention, not `isoweekday()` or `strftime`
- `day-of-week-no-input-validation` — The function performs no bounds checking; invalid dates raise `ValueError` from the `datetime.date` constructor

