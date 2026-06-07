# File: number-of-students-doing-homework-at-a-given-time/solution.py

**Date:** 2026-06-06
**Time:** 18:22

## Purpose

This file implements LeetCode problem #1450, "Number of Students Doing Homework at a Given Time." It's a self-contained solution + test module — one of hundreds in the `leetcode-implementations` repo, each following the same `solution.py` + `test_solution.py` structure (though here both are combined in a single file).

The responsibility is narrow: given parallel arrays of student start/end times, count how many students are actively working at a specific query time.

## Key Components

**`Solution.busyStudent`** (line 9) — The core method. Takes three arguments:
- `startTime: List[int]` — per-student homework start times
- `endTime: List[int]` — per-student homework end times (parallel to `startTime`)
- `queryTime: int` — the instant to check

Returns the count of students where `startTime[i] <= queryTime <= endTime[i]`. The contract assumes `startTime` and `endTime` are the same length (LeetCode guarantees this).

**`TestBusyStudent`** (line 22) — Seven test cases covering the standard examples, all-busy, none-busy, and boundary conditions (query exactly at start, exactly at end, just outside both ends).

## Patterns

- **Generator-expression counting**: `sum(1 for ... if ...)` is a common Python idiom for counting matches without materializing a list. O(n) time, O(1) auxiliary space.
- **Chained comparison**: `s <= queryTime <= e` uses Python's chained comparison syntax — equivalent to `s <= queryTime and queryTime <= e` but more readable and evaluated left-to-right with short-circuit.
- **Parallel array iteration via `zip`**: The problem gives two parallel lists; `zip(startTime, endTime)` pairs them element-wise, which is the idiomatic way to traverse correlated sequences.
- **Combined solution + test file**: The module includes both the `Solution` class and `unittest.TestCase` subclass, guarded by `if __name__ == "__main__"`. A separate `test_solution.py` exists alongside it for the test harness.

## Dependencies

**Imports**: `unittest` (stdlib), `typing.List` (type annotation only — no runtime effect).

**Imported by**: The "Imported By" list is misleadingly large — those 300+ `test_solution.py` files likely share a common test runner (`run_tests.py` at the repo root) rather than directly importing this module. The actual dependent is `number-of-students-doing-homework-at-a-given-time/test_solution.py`.

## Flow

1. Caller passes two equal-length lists and a scalar query time.
2. `zip` pairs the i-th start with the i-th end time.
3. The generator checks each pair against the chained inequality.
4. `sum` counts the `1`s (truthy matches), returning the total.

Single pass, no intermediate data structures.

## Invariants

- `startTime` and `endTime` must be equal length — the code doesn't validate this; it relies on LeetCode's problem constraints.
- The range check is **inclusive** on both ends: a student doing homework from time 5 to 10 is counted at both `queryTime=5` and `queryTime=10`. The boundary tests at lines 37-41 verify this explicitly.

## Error Handling

None. Empty inputs produce 0 naturally (`sum` of an empty generator is 0). Mismatched list lengths would silently truncate to the shorter list via `zip` behavior — no error raised.

## Topics to Explore

- [file] `number-of-students-doing-homework-at-a-given-time/test_solution.py` — The separate test file; compare how it differs from the inline tests here
- [file] `run_tests.py` — The repo-wide test harness that drives all solution tests
- [function] `determine-if-two-events-have-conflict/solution.py:Solution` — Another interval-overlap problem; compare the range-check pattern
- [file] `number-of-students-doing-homework-at-a-given-time/review.md` — The code review notes for this solution
- [general] `zip-truncation-behavior` — Python's `zip` silently drops excess elements from the longer iterable; relevant if input invariants ever break

## Beliefs

- `busyStudent-inclusive-boundaries` — `busyStudent` counts a student as busy when `queryTime` equals exactly `startTime[i]` or exactly `endTime[i]` (inclusive on both ends)
- `busyStudent-linear-constant-space` — The solution runs in O(n) time and O(1) auxiliary space via a generator expression, never materializing an intermediate list
- `busyStudent-empty-input-safe` — Passing empty lists for `startTime` and `endTime` returns 0 without error, because `sum` of an empty generator is 0
- `busyStudent-no-input-validation` — The method does not validate that `startTime` and `endTime` have equal length; mismatched lengths silently truncate via `zip`

