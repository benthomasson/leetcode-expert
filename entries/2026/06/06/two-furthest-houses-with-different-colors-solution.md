# File: two-furthest-houses-with-different-colors/solution.py

**Date:** 2026-06-06
**Time:** 19:32

## Purpose

This file solves [LeetCode 2078: Two Furthest Houses With Different Colors](https://leetcode.com/problems/two-furthest-houses-with-different-colors/). Given an array where each element represents a house's color, it finds the maximum distance (index difference) between any two houses that have different colors. The file owns both the solution and its unit tests.

## Key Components

### `Solution.maxDistance(colors: List[int]) -> int`

The sole method. Takes a list of integer color values and returns the maximum absolute index difference between two houses with different colors.

**Contract**: `colors` has length >= 2, and at least two houses have different colors (guaranteed by the problem constraints). Returns a non-negative integer.

### `TestSolution`

Seven test cases covering: basic examples, single-endpoint differences, alternating patterns, and the edge case where endpoints match but the interior differs.

## Patterns

**Endpoint anchoring** — rather than brute-forcing all O(n^2) pairs, the solution exploits a key insight: the maximum-distance pair must include either the first or last house. It runs two linear scans:

1. **Lines 20–24**: Anchor at index 0, scan backwards from the end to find the furthest house with a different color.
2. **Lines 27–31**: Anchor at index `n-1`, scan forwards from the start to find the furthest house with a different color.

The answer is the max of these two candidates. This reduces complexity from O(n^2) to O(n).

**Self-contained file** — solution and tests coexist in one module, following the repo-wide convention. The `if __name__ == "__main__"` guard allows direct execution via `python solution.py`.

## Dependencies

**Imports**: `unittest` (stdlib), `List` from `typing`. No external dependencies.

**Imported by**: The `test_solution.py` in this same directory, plus hundreds of other `test_solution.py` files across the repo. The "Imported By" list in the prompt is misleading — those other test files don't actually import *this* solution; they follow the same structural pattern. The only real consumer is `two-furthest-houses-with-different-colors/test_solution.py`.

## Flow

1. Record array length `n`, initialize `result = 0`.
2. First scan: iterate `i` from `n-1` down to `0`. On the first index where `colors[i] != colors[0]`, set `result = max(result, i)` and break. The distance is `i - 0 = i`.
3. Second scan: iterate `i` from `0` up to `n-1`. On the first index where `colors[i] != colors[-1]`, set `result = max(result, n - 1 - i)` and break. The distance is `(n-1) - i`.
4. Return the larger of the two candidates.

The `break` statements ensure each scan does O(1) work in the best case (endpoints differ) and O(n) in the worst case (all-same-except-one-end).

## Invariants

- The optimal pair always includes index 0 or index `n-1` (or both). This is provable: if neither endpoint is in the optimal pair `(i, j)`, then either `colors[0] != colors[j]` (giving distance `j > j - i`) or `colors[n-1] != colors[i]` (giving distance `n-1-i > j-i`), contradicting optimality.
- Each loop is guaranteed to find a match because the problem states at least two colors exist — so at least one endpoint must differ from some other house.

## Error Handling

None. The problem guarantees valid input (length >= 2, at least two different colors). No defensive checks are present — appropriate for a competitive programming context.

## Topics to Explore

- [file] `two-furthest-houses-with-different-colors/test_solution.py` — The companion test file; may contain additional edge cases beyond what's inlined here
- [file] `two-furthest-houses-with-different-colors/review.md` — Code review notes that may document alternative approaches or known issues
- [general] `endpoint-anchoring-pattern` — This O(n) technique of anchoring at array boundaries recurs in distance-maximization problems; compare with `best-time-to-buy-and-sell-stock`
- [function] `best-time-to-buy-and-sell-stock/solution.py:maxProfit` — Another single-pass optimization problem that exploits endpoint/extremum tracking instead of brute force

## Beliefs

- `max-distance-endpoint-invariant` — The maximum-distance pair in `maxDistance` always includes index 0 or index n-1; the two-scan approach is exhaustive under this invariant
- `linear-time-two-scan` — `maxDistance` runs in O(n) time and O(1) space, performing at most two linear scans with early termination
- `no-input-validation` — `maxDistance` performs no validation on `colors`; it assumes length >= 2 and at least two distinct values, per LeetCode constraints
- `self-contained-test-and-solution` — The solution class and all unit tests live in the same file, following the repo-wide convention for LeetCode problems

