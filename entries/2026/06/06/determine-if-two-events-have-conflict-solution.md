# File: determine-if-two-events-have-conflict/solution.py

**Date:** 2026-06-06
**Time:** 16:21

## Purpose

This file solves [LeetCode 2446: Determine if Two Events Have Conflict](https://leetcode.com/problems/determine-if-two-events-have-conflict/). It owns the single responsibility of checking whether two time intervals on the same day overlap.

## Key Components

### `has_event_conflict(event1, event2) -> bool`

Takes two events, each represented as a `[startTime, endTime]` pair in `"HH:MM"` string format, and returns whether they overlap.

The implementation is a single expression:

```python
return event1[0] <= event2[1] and event2[0] <= event1[1]
```

This is the standard interval overlap test: two intervals `[a, b]` and `[c, d]` overlap if and only if `a <= d` and `c <= b`. It's the negation of the non-overlap condition (`a > d or c > b`).

## Patterns

**Lexicographic string comparison as time comparison.** The code compares `"HH:MM"` strings directly with `<=` instead of parsing them into integers or `datetime` objects. This works because `"HH:MM"` is a fixed-width, zero-padded format where lexicographic order equals chronological order (e.g., `"09:30" < "10:00" < "23:59"`). This is a common idiom in LeetCode solutions for time-formatted strings.

**Closed-interval overlap formula.** Both endpoints are inclusive — events sharing an exact boundary time (e.g., one ends at `"10:00"` and the other starts at `"10:00"`) are considered conflicting. The `<=` (not `<`) enforces this.

## Dependencies

- **Imports:** `List` from `typing` — used only for the type annotation. No runtime dependency.
- **Imported by:** `determine-if-two-events-have-conflict/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the test harness structure — those other test files import from their own solutions, not from this one.

## Flow

1. Caller passes two lists of two `"HH:MM"` strings each.
2. The function performs two string comparisons and returns their conjunction.
3. No mutation, no side effects, no iteration.

Constant time and space: O(1).

## Invariants

- Input strings must be in `"HH:MM"` zero-padded 24-hour format for the lexicographic comparison to be valid. `"9:30"` instead of `"09:30"` would break correctness.
- Each event list must have exactly two elements `[start, end]` with `start <= end`.
- Both events are assumed to be on the same day (no midnight-crossing logic).

## Error Handling

None. The function trusts its inputs per LeetCode conventions — no validation of format, length, or ordering. An `IndexError` would propagate naturally if a list had fewer than two elements.

## Topics to Explore

- [file] `determine-if-two-events-have-conflict/test_solution.py` — See what edge cases the tests cover (boundary overlap, identical events, no overlap)
- [file] `determine-if-two-events-have-conflict/plan.md` — The approach reasoning and any alternatives considered before implementation
- [file] `meeting-rooms/solution.py` — A related interval-overlap problem that extends to N intervals and requires sorting
- [general] `interval-overlap-patterns` — The closed vs. open interval distinction and how it affects the comparison operators used
- [file] `count-days-spent-together/solution.py` — Another date/time overlap problem that likely uses a similar interval intersection technique

## Beliefs

- `lexicographic-hhmm-is-chronological` — Comparing `"HH:MM"` strings with `<=` produces correct chronological ordering because the format is fixed-width and zero-padded
- `overlap-test-is-inclusive` — Two events that share only a single boundary moment (e.g., `["10:00","10:00"]` and `["10:00","11:00"]`) are reported as conflicting
- `no-input-validation` — The function performs no validation on input format, list length, or start-before-end ordering; it trusts the caller
- `constant-time-complexity` — The function executes exactly two string comparisons regardless of input, making it O(1) time and space

