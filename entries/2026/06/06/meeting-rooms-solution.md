# File: meeting-rooms/solution.py

**Date:** 2026-06-06
**Time:** 17:46

## `meeting-rooms/solution.py`

### Purpose

This file solves [LeetCode 252 — Meeting Rooms](https://leetcode.com/problems/meeting-rooms/), a classic interval scheduling problem. Given a list of meeting time intervals `[start, end]`, it determines whether a person can attend all meetings — i.e., whether any two meetings overlap.

This is a premium/easy-tier problem that serves as the foundation for the harder Meeting Rooms II (minimum conference rooms needed).

### Key Components

**`can_attend_meetings(intervals: list[list[int]]) -> bool`** — The single exported function. Contract: takes a list of `[start, end]` pairs, returns `True` if no two intervals overlap, `False` otherwise. Note: it **mutates the input list** via in-place sort.

### Patterns

**Sort-then-scan** — The canonical pattern for interval overlap detection. Sort by start time (the default tuple ordering), then make a single linear pass checking adjacent pairs. This reduces an O(n^2) all-pairs comparison to O(n log n).

The solution relies on Python's default list sorting behavior: `list.sort()` on lists-of-lists sorts lexicographically — first by `intervals[i][0]` (start), then by `intervals[i][1]` (end) on ties. Only the start-time ordering matters here, but the tie-breaking is harmless.

### Dependencies

**Imports**: None — pure standard library Python.

**Imported by**: `meeting-rooms/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that share a common test harness import, not importers of this specific module.

### Flow

1. **Sort** the intervals in-place by start time — O(n log n).
2. **Scan** adjacent pairs: for each `i` in `[0, n-2]`, check if `intervals[i][1] > intervals[i+1][0]`. If the end of meeting `i` exceeds the start of meeting `i+1`, they overlap — return `False`.
3. If the loop completes without finding overlap, return `True`.

For input `[[0,30],[5,10],[15,20]]`: after sorting (already sorted), it checks `30 > 5` → `True` → returns `False`.

### Invariants

- **Strict overlap test**: The comparison is `>`, not `>=`. A meeting ending at time 10 and another starting at time 10 are **not** considered overlapping. This matches the problem's semantics — `[0,10]` and `[10,20]` are attendable.
- **After sorting, overlap can only exist between adjacent intervals.** If interval `i` doesn't overlap `i+1`, then it can't overlap `i+2` either (since `i+2` starts even later). This is the invariant that makes the single-pass correct.
- **Empty and single-element inputs**: The `range(len(intervals) - 1)` produces an empty range, so the function correctly returns `True`.

### Error Handling

None. The function trusts its input — no validation of interval structure, no check for negative times, no handling of empty sub-lists. This is appropriate for a LeetCode solution where input constraints are guaranteed by the judge.

---

## Topics to Explore

- [file] `meeting-rooms/test_solution.py` — See which edge cases (empty list, single meeting, adjacent boundaries) are covered
- [file] `meeting-rooms/plan.md` — The planning document may reveal alternative approaches considered (e.g., event-based sweep line)
- [general] `interval-overlap-patterns` — How this sort-then-scan pattern extends to Meeting Rooms II (min-heap / sweep line), Merge Intervals, and Insert Interval
- [function] `meeting-rooms/solution.py:can_attend_meetings` — Whether the in-place mutation of `intervals` causes issues in any caller
- [file] `meeting-rooms/review.md` — Check if the review flagged the input mutation or the strict-vs-non-strict comparison choice

## Beliefs

- `meeting-rooms-sort-then-scan` — `can_attend_meetings` uses O(n log n) sort + O(n) scan; correctness relies on the invariant that after sorting by start time, overlap can only occur between adjacent intervals
- `meeting-rooms-strict-boundary` — Meetings sharing an endpoint (e.g., `[0,10]` and `[10,20]`) are not considered overlapping; the check uses `>`, not `>=`
- `meeting-rooms-mutates-input` — The function sorts `intervals` in-place, modifying the caller's list
- `meeting-rooms-no-imports` — The solution uses no external dependencies; it is pure Python with no imports

