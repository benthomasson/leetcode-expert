# File: delete-greatest-value-in-each-row/solution.py

**Date:** 2026-06-06
**Time:** 16:15

## Purpose

This file solves [LeetCode 2500: Delete Greatest Value in Each Row](https://leetcode.com/problems/delete-greatest-value-in-each-row/). It implements the simulation where you repeatedly delete the maximum value from each row of a matrix, take the max of those deleted values, and sum those maxima across all rounds. The file owns both the solution and its unit tests.

## Key Components

### `maxValueAfterOperations(grid: List[List[int]]) -> int`

The core function. It exploits an insight that avoids actually simulating deletions: if you sort each row, then column `j` across all rows contains exactly the values that would be deleted together in operation `j` (from smallest to largest). The answer is just the sum of column-wise maximums over the sorted grid.

**Contract**: Takes an `m x n` grid of positive integers, returns an integer. Mutates `grid` in place (sorts each row).

### `TestMaxValueAfterOperations`

Seven test cases covering: the two LeetCode examples, single-row, single-column, uniform values, descending rows, and a 50x50 uniform grid for scale.

## Patterns

**Sort-then-reduce**: Rather than simulating O(n) deletion rounds with O(m) max-finding each, the solution sorts each row once and reduces to column-max summation. This is a common LeetCode idiom — transform the structure so the answer falls out of a simpler traversal.

**In-place mutation**: `row.sort()` modifies the input grid. This is fine for LeetCode but worth noting — callers lose the original ordering.

**Generator inside `sum`**: The return statement uses a nested generator expression: the outer iterates columns, the inner finds the max across rows for that column. No intermediate lists are allocated.

## Dependencies

**Imports**: `unittest` (test harness), `typing.List` (type annotation). No external dependencies.

**Imported by**: The `test_solution.py` in the same directory imports this. The massive "Imported By" list in the prompt is misleading — those are unrelated test files across different problem directories that happen to share a similar import structure, not actual consumers of this function.

## Flow

1. Sort every row of `grid` in ascending order — O(m * n log n)
2. For each column index `j` from 0 to n-1, compute `max(grid[i][j] for i in range(m))`
3. Sum those column maxima and return

**Why this works**: Sorting aligns the k-th smallest element of each row into column k. The problem asks you to delete the largest remaining element from each row simultaneously, which after sorting is column n-1 first, then n-2, etc. Since we sum all column maxima regardless of order, the traversal direction doesn't matter.

## Invariants

- After sorting, `grid[i][j] <= grid[i][j+1]` for all valid i, j
- The function assumes `grid` is non-empty and rectangular (all rows have equal length) — no validation
- Each "operation" corresponds exactly to one column of the sorted grid

## Error Handling

None. An empty grid or jagged rows would raise `IndexError` or `ValueError` from `range(len(grid[0]))` or `max()`. This is standard for LeetCode solutions where input constraints guarantee well-formed data.

## Topics to Explore

- [file] `delete-greatest-value-in-each-row/review.md` — The code review may document alternative approaches or edge-case analysis
- [function] `array-partition/solution.py:arrayPairSum` — Uses the same sort-then-sum-by-position pattern for a related greedy problem
- [general] `sort-as-simulation-substitute` — Across this repo, many solutions replace an iterative simulation with a single sort; identifying which problems admit this is a key skill
- [file] `lucky-numbers-in-a-matrix/solution.py` — Another matrix problem that combines row and column extrema, worth comparing the reduction approach

## Beliefs

- `sort-then-column-max-equivalence` — Sorting each row and summing column-wise maxima produces the same result as simulating repeated deletion of row maxima
- `in-place-grid-mutation` — `maxValueAfterOperations` mutates the input grid by sorting each row; the original order is destroyed
- `no-input-validation` — The function assumes a non-empty rectangular grid and will raise on empty or jagged input
- `time-complexity-n-log-n` — The dominant cost is sorting m rows of length n, giving O(m * n log n) total time

