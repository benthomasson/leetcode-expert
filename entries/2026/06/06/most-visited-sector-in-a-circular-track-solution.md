# File: most-visited-sector-in-a-circular-track/solution.py

**Date:** 2026-06-06
**Time:** 18:08

## `most-visited-sector-in-a-circular-track/solution.py`

This solves [LeetCode 1560](https://leetcode.com/problems/most-visited-sector-in-a-circular-track/). The problem describes a marathon on a circular track with `n` sectors (labeled 1 to n). A runner completes several rounds described by the `rounds` array, and you must return which sectors were visited the most, in ascending order.

### Key Insight

The solution skips simulating the race entirely. It only looks at `rounds[0]` (start) and `rounds[-1]` (end). This works because every sector traversed during intermediate rounds is visited the same number of times — complete traversals between waypoints contribute uniformly. The only asymmetry is the partial arc from the starting sector to the ending sector, which gets one extra visit compared to sectors outside that arc.

### `most_visited_sector(n, rounds) -> List[int]`

Two cases based on the relative position of start and end on the circular track:

- **`start <= end`**: The most-visited sectors form a contiguous range `[start, end]`. Returns `list(range(start, end + 1))`.
- **`start > end`**: The arc wraps around sector `n` back to sector 1. Returns `[1..end] + [start..n]` — two ranges concatenated, which is still sorted in ascending order.

The output is always in ascending order because `range(1, end+1)` precedes `range(start, n+1)` numerically.

### Complexity

- **Time**: O(n) — building the output list is proportional to the number of sectors returned.
- **Space**: O(n) — for the output list.

### Dependencies

Only imports `List` from `typing` for the type annotation. No internal dependencies. The test file at `most-visited-sector-in-a-circular-track/test_solution.py` imports this function.

### Invariants

- `rounds` has at least 2 elements (guaranteed by problem constraints — start + at least one destination).
- Sector labels are 1-indexed, so ranges start from 1 rather than 0.
- The returned list is always sorted ascending — the wrap-around case concatenates `[1..end]` before `[start..n]`, preserving order since `end < start` in that branch.

### Error Handling

None. The function trusts its inputs match the problem's constraints (1 <= rounds[i] <= n, len(rounds) >= 2). No validation or exception handling.

## Topics to Explore

- [file] `most-visited-sector-in-a-circular-track/test_solution.py` — See which edge cases are covered (wrap-around, single-sector, start == end)
- [file] `most-visited-sector-in-a-circular-track/plan.md` — Check if the plan documents the mathematical reasoning for ignoring intermediate rounds
- [function] `distance-between-bus-stops/solution.py:distanceBetweenBusStops` — Another circular-track problem that may use similar wrap-around logic
- [general] `circular-array-patterns` — Several solutions in this repo deal with circular indexing; compare approaches across problems

## Beliefs

- `most-visited-only-depends-on-endpoints` — The solution's correctness relies on the fact that intermediate rounds contribute uniform visits to all sectors, so only `rounds[0]` and `rounds[-1]` determine the answer.
- `wrap-case-output-is-sorted` — When `start > end`, concatenating `range(1, end+1)` and `range(start, n+1)` produces ascending order because `end < start` is a precondition of that branch.
- `no-simulation-needed` — The function never iterates through the `rounds` array beyond reading the first and last elements, making it O(n) in sectors rather than O(len(rounds) * n).
- `one-indexed-sectors` — All sector labels and range boundaries use 1-based indexing per the problem specification.

