# File: mean-of-array-after-removing-some-elements/solution.py

**Date:** 2026-06-06
**Time:** 17:45

## `mean-of-array-after-removing-some-elements/solution.py`

### Purpose

This file solves [LeetCode 1619: Mean of Array After Removing Some Elements](https://leetcode.com/problems/mean-of-array-after-removing-some-elements/). It computes a **5% trimmed mean** — the arithmetic mean of an integer array after discarding the smallest 5% and largest 5% of elements. The file is self-contained: solution class and test suite live in the same module.

### Key Components

**`Solution.trimMean(arr: List[int]) -> float`** — The core algorithm. Given an array guaranteed to have length divisible by 20 (per the problem constraints), it:
1. Sorts the array in-place.
2. Computes `k = len(arr) // 20` — the count of elements to remove from each end (5% of the total).
3. Slices the sorted array to `arr[k : len(arr) - k]`, removing the bottom and top `k` elements.
4. Returns the mean of the remaining elements.

**`TestTrimMean`** — Six test cases covering the LeetCode examples, a uniform-value array, a 1000-element sequential array, and a boundary case with only two distinct values.

### Patterns

- **Sort-and-slice trimming**: Rather than using a partial sort (e.g., `heapq.nsmallest`), the solution fully sorts then slices. This is idiomatic for problems where the trim percentage is symmetric and the array is small (problem constraint: `20 <= len(arr) <= 1000`).
- **In-place mutation**: `arr.sort()` mutates the input. This is fine for LeetCode's single-call contract but worth noting — callers lose the original ordering.
- **Colocated tests**: Solution and tests share a file, consistent with the rest of this repository.

### Dependencies

**Imports**: `typing.List` (type annotation) and `unittest` (test framework). No project-internal dependencies.

**Imported by**: The `test_solution.py` file in this same directory, plus the massive list of cross-referencing test files in the repository (likely an artifact of the code-expert tooling indexing — those files don't actually import *this* solution, they follow the same structural pattern).

### Flow

```
Input arr
  → sort in-place (ascending)
  → compute k = len(arr) // 20
  → slice arr[k : len(arr)-k]   # remove bottom/top 5%
  → sum(trimmed) / len(trimmed)
  → return float
```

The entire operation is O(n log n) dominated by the sort. The slice and sum are O(n).

### Invariants

- **`len(arr)` must be divisible by 20** — the problem guarantees this, and the code relies on it for `k = len(arr) // 20` to produce an integer trim count that represents exactly 5%. If `len(arr)` is not divisible by 20, `k` silently rounds down via integer division, trimming fewer than 5%.
- **`len(trimmed) > 0`** — since `k = len(arr) // 20` and `len(arr) >= 20`, we trim `k` from each end leaving `len(arr) - 2k` elements. For `len(arr) = 20`, `k = 1`, leaving 18 elements. Division by zero is impossible under problem constraints.

### Error Handling

None. The code trusts LeetCode's input guarantees (non-empty array, length divisible by 20, integer elements in `[0, 10^5]`). An empty input would cause a `ZeroDivisionError` at the final division.

## Topics to Explore

- [file] `average-salary-excluding-the-minimum-and-maximum-salary/solution.py` — A related trimming problem that removes exactly one min and one max instead of a percentage; compare the trim strategies
- [general] `trimmed-mean-statistics` — How trimmed means are used in statistics (e.g., Olympic judging) and why symmetric trimming is robust to outliers
- [function] `mean-of-array-after-removing-some-elements/solution.py:trimMean` — Consider whether `statistics.mean` or `numpy.mean` with masking would be cleaner alternatives
- [file] `diet-plan-performance/solution.py` — Another sliding-window / array-reduction problem in the repo; compare the array manipulation patterns

## Beliefs

- `trim-mean-removes-exactly-5-percent-each-end` — `trimMean` removes `len(arr) // 20` elements from both the low and high ends, which equals exactly 5% when `len(arr)` is a multiple of 20.
- `trim-mean-mutates-input` — `arr.sort()` modifies the caller's list in-place; the original element ordering is destroyed.
- `trim-mean-safe-under-constraints` — Division by zero cannot occur when `len(arr) >= 20`, since the trimmed slice always retains at least `len(arr) - 2*(len(arr)//20)` elements (minimum 18 for a 20-element input).
- `trim-mean-time-complexity-is-sort-dominated` — The algorithm is O(n log n) due to the sort; the subsequent slice and sum are O(n).

