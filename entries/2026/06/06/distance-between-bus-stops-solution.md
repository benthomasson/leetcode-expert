# File: distance-between-bus-stops/solution.py

**Date:** 2026-06-06
**Time:** 16:24

## Purpose

This file solves [LeetCode 1184 — Distance Between Bus Stops](https://leetcode.com/problems/distance-between-bus-stops/). It computes the shortest distance between two stops on a circular bus route, where `distance[i]` is the distance from stop `i` to stop `(i+1) % n`. The file owns both the solution and its test suite.

## Key Components

### `Solution.distanceBetweenBusStops`

**Contract**: Given a list of distances between consecutive stops on a circular route, and two stop indices, return the minimum of the clockwise and counterclockwise distances.

**Parameters**:
- `distance: List[int]` — edge weights of the circular graph
- `start: int` — source stop
- `destination: int` — target stop

**Returns**: `int` — minimum distance between the two stops

### `TestDistanceBetweenBusStops`

Nine test cases covering: LeetCode's three examples, same-stop (zero distance), reversed start/destination, single-stop edge case, all-zero weights, uniform weights, and the minimal two-stop case.

## Patterns

**Canonical normalization**: The swap `if start > destination: start, destination = destination, start` normalizes the two indices so that `start < destination` always holds. This lets the solution use a single `distance[start:destination]` slice for the clockwise path without worrying about wrap-around indexing.

**Complement trick**: Instead of computing both directions independently, it computes `clockwise` then derives `counterclockwise = total - clockwise`. This avoids a second slice or modular iteration.

**Self-contained file**: Solution class + unittest in one module — the standard pattern across this repository.

## Dependencies

**Imports**: `typing.List` (type annotation), `unittest` (test framework). No project-internal dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files from *other* problems that happen to share the same `unittest` import, not actual consumers of this module's `Solution` class. Nothing outside `distance-between-bus-stops/` imports this solution.

## Flow

1. Normalize so `start <= destination` (swap if needed).
2. Slice `distance[start:destination]` — these are the edges on the clockwise path from `start` to `destination`.
3. Sum the slice → `clockwise`.
4. Compute `sum(distance) - clockwise` → counterclockwise distance.
5. Return `min(clockwise, counterclockwise)`.

Note: `sum(distance)` recomputes the full total each call. For a single invocation this is fine (O(n) either way), but if called repeatedly on the same route, caching the total would help.

## Invariants

- **Normalization guarantee**: After the swap, `start <= destination`. When they're equal, `distance[start:destination]` is empty → `clockwise = 0`, and `min(0, total)` correctly returns 0.
- **Circular completeness**: `clockwise + counterclockwise == sum(distance)` always holds by construction.
- **Non-negative distances**: The solution assumes all values in `distance` are non-negative (per the problem constraints). Negative weights would break the `min` logic.

## Error Handling

None. The function trusts its inputs conform to the LeetCode contract (valid indices, non-empty list for distinct stops). Out-of-range indices would silently produce wrong results rather than raising — `distance[5:3]` returns `[]`, and slicing beyond list bounds silently truncates.

## Topics to Explore

- [file] `distance-between-bus-stops/plan.md` — Pre-implementation design notes, may document alternative approaches considered
- [file] `distance-between-bus-stops/review.md` — Post-implementation review, likely covers complexity analysis and edge cases
- [function] `most-visited-sector-in-a-circular-track/solution.py:Solution` — Another circular-route problem that likely uses a similar normalization pattern
- [general] `circular-array-normalization` — The swap-to-normalize idiom appears across multiple circular-route/ring problems in this repo; worth cataloging

## Beliefs

- `bus-stops-clockwise-complement` — The counterclockwise distance is always computed as `sum(distance) - clockwise`, never by iterating the reverse path
- `bus-stops-swap-normalization` — The solution normalizes `start > destination` by swapping, guaranteeing `start <= destination` before slicing
- `bus-stops-same-stop-zero` — When `start == destination`, the function returns 0 because the slice `distance[s:s]` is empty
- `bus-stops-no-input-validation` — No bounds checking on `start` or `destination`; out-of-range indices silently produce incorrect results

