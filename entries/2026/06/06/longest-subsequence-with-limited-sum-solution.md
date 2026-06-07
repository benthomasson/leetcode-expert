# File: longest-subsequence-with-limited-sum/solution.py

**Date:** 2026-06-06
**Time:** 17:28

## Purpose

This file solves [LeetCode 2389: Longest Subsequence With Limited Sum](https://leetcode.com/problems/longest-subsequence-with-limited-sum/). Given an array `nums` and an array `queries`, for each query it finds the maximum number of elements you can pick from `nums` (in any order, non-contiguous) such that their sum doesn't exceed the query value.

It's one solution module in a large repository of LeetCode solutions, each following the same directory convention: `problem-slug/solution.py`.

## Key Components

**`maxSizeSubsequenceSumQueries(nums, queries)`** — the sole public function. Takes the input arrays and returns a list of answers, one per query.

## Patterns

The solution uses a **greedy + prefix sum + binary search** pattern, which is the canonical O(n log n + m log n) approach for this problem class:

1. **Greedy sort**: To maximize the count of elements fitting under a sum budget, always pick the smallest elements first. Sorting enables this.
2. **Prefix sum via `accumulate`**: After sorting, `prefix[i]` is the minimum possible sum when picking `i+1` elements.
3. **Binary search via `bisect_right`**: For each query `q`, `bisect_right(prefix, q)` returns how many elements fit — the position where `q` would be inserted, which equals the count of prefix sums ≤ `q`.

The entire solution is a one-liner pipeline after building the prefix array, which is idiomatic Python for this kind of problem.

## Dependencies

**Imports:**
- `bisect.bisect_right` — binary search for the insertion point (right side)
- `itertools.accumulate` — running prefix sum without manual loop
- `typing.List` — type annotation

**Imported by:** The `test_solution.py` in the same directory, plus the "Imported By" list in the prompt appears to be a test-runner artifact listing all test files in the repo (likely from a shared test harness that discovers solution modules).

## Flow

```
nums = [4, 5, 2, 1], queries = [3, 10, 21]

1. sorted(nums)        → [1, 2, 4, 5]
2. accumulate(...)     → [1, 3, 7, 12]     (prefix sums)
3. bisect_right(_, 3)  → 2                  (elements 1,2 fit under 3)
   bisect_right(_, 10) → 3                  (elements 1,2,4 fit under 10)
   bisect_right(_, 21) → 4                  (all 4 elements fit under 21)

result: [2, 3, 4]
```

Each query is independent — the prefix array is built once, then each query is a O(log n) binary search.

## Invariants

- The prefix array is **strictly non-decreasing** (all `nums` values are positive integers per the problem constraints), which is required for `bisect_right` to work correctly.
- **Subsequence, not subarray**: ordering doesn't matter, only the multiset of chosen elements — sorting is valid because subsequences can pick any elements regardless of position.
- Queries are answered independently; the order of `queries` is preserved in the output.

## Error Handling

None. The function assumes valid inputs per LeetCode constraints (non-empty arrays, positive integers). No bounds checking or exception handling — appropriate for a competitive programming solution.

## Topics to Explore

- [file] `longest-subsequence-with-limited-sum/test_solution.py` — Verify edge cases and understand what inputs are tested
- [file] `longest-subsequence-with-limited-sum/plan.md` — See the planning rationale for choosing this approach over alternatives
- [function] `assign-cookies/solution.py:findContentChildren` — Another greedy+sort problem with a similar "maximize count under a budget" structure
- [general] `prefix-sum-binary-search-pattern` — This combination recurs across many problems in the repo (e.g., `find-subsequence-of-length-k-with-the-largest-sum`); understanding it as a pattern accelerates reading similar solutions
- [file] `longest-subsequence-with-limited-sum/review.md` — Check if the review noted any alternative approaches (e.g., sorting queries too for offline processing)

## Beliefs

- `greedy-sort-optimality` — Sorting `nums` ascending and taking the smallest elements first guarantees the maximum count for any given sum budget
- `bisect-right-counts-fitting-elements` — `bisect_right(prefix, q)` returns exactly the number of sorted elements whose cumulative sum is ≤ `q`, because prefix sums are strictly non-decreasing for positive inputs
- `query-independence` — Each query is answered in O(log n) via binary search against a shared prefix array, with no interaction between queries
- `positive-input-assumption` — The solution relies on all values in `nums` being positive; zero or negative values would break the monotonicity invariant that `bisect_right` depends on

