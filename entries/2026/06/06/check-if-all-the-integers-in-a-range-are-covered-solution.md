# File: check-if-all-the-integers-in-a-range-are-covered/solution.py

**Date:** 2026-06-06
**Time:** 15:37

## Purpose

This file implements [LeetCode 1893: Check if All the Integers in a Range Are Covered](https://leetcode.com/problems/check-if-all-the-integers-in-a-range-are-covered/). It provides a single `Solution` class with one method that determines whether every integer in a query range `[left, right]` is contained in at least one of the given intervals.

## Key Components

### `Solution.isCovered`

**Signature:** `(ranges: list[list[int]], left: int, right: int) -> bool`

Takes a list of inclusive intervals and a query range, returns whether every integer in the query range is "covered" by at least one interval.

The approach is a **boolean marking array**: allocate a fixed-size array of 51 booleans (indices 0–50), mark every integer that falls within any interval as `True`, then check that every integer in `[left, right]` is marked.

## Patterns

**Fixed-size universe.** The problem constrains values to `[1, 50]`, so the solution uses a hardcoded array of size 51 (index 0 unused but harmless). This avoids sets or sorting — it's a direct-address table.

**Two-pass sweep.** Pass 1 marks all covered positions. Pass 2 checks the query range. This cleanly separates data ingestion from the query, even though it could be fused.

## Dependencies

**Imports:** None — pure stdlib, no external dependencies.

**Imported by:** The `test_solution.py` in this same directory. The large "Imported By" list in the prompt is an artifact of the test harness structure — those other test files import their own `solution.py`, not this one.

## Flow

1. Allocate `covered`, a 51-element `False` array.
2. For each `[start, end]` in `ranges`, iterate `start..end` inclusive and set `covered[i] = True`.
3. Return `all(covered[i] for i in range(left, right + 1))` — short-circuits on the first uncovered integer.

**Time complexity:** O(N * R + Q) where N = number of ranges, R = max range span (at most 50), Q = query range size. With the constraint that all values are in [1, 50], this is effectively O(1).

**Space complexity:** O(1) — the array is always size 51.

## Invariants

- The array is sized to 51, which assumes all values in `ranges`, `left`, and `right` are in `[1, 50]`. Values outside this range would cause an `IndexError` (if > 50) or silently mark negative indices (if < 0).
- `left <= right` is assumed by the problem constraints. If `left > right`, `range(left, right + 1)` is empty, so `all()` returns `True` vacuously.

## Error Handling

None. The solution trusts LeetCode's guarantees on input bounds. Out-of-range values would raise an unhandled `IndexError`.

## Topics to Explore

- [file] `check-if-all-the-integers-in-a-range-are-covered/test_solution.py` — See what edge cases the test suite covers (empty ranges, single-element query, full overlap)
- [general] `difference-array-technique` — An alternative O(N + U) approach using a diff array with prefix sums, which generalizes better when the universe is large
- [file] `check-if-all-the-integers-in-a-range-are-covered/review.md` — The code review may discuss tradeoffs of this approach vs. sorting or set-based solutions
- [function] `maximum-population-year/solution.py:Solution` — Another problem that uses a similar fixed-size marking/sweep pattern over a bounded integer domain

## Beliefs

- `covered-array-size-assumes-constraint` — The hardcoded size 51 relies on the problem constraint that all values are in [1, 50]; inputs outside this range cause incorrect behavior or crashes
- `all-short-circuits-on-first-uncovered` — The `all()` call in the return statement stops iteration at the first `False` entry, making best-case query time O(1)
- `time-is-constant-under-constraints` — With values bounded to [1, 50], both marking and querying are O(1) regardless of input shape
- `no-deduplication-needed` — Overlapping ranges simply re-mark already-True positions, which is idempotent and correct without any merging step

