# File: minimum-subsequence-in-non-increasing-order/solution.py

**Date:** 2026-06-06
**Time:** 18:01

## Purpose

This file implements [LeetCode 1403 — Minimum Subsequence in Non-Increasing Order](https://leetcode.com/problems/minimum-subsequence-in-non-increasing-order/). It's a self-contained solution + test module: the `Solution` class solves the problem, and the inline `TestMinSubsequence` class validates it. Its role in the project is identical to every other problem directory — one solution file, one test file, optionally a plan and review.

## Key Components

### `Solution.min_subsequence(nums: List[int]) -> List[int]`

The only method. Given an array of positive integers, it returns the smallest subsequence (fewest elements) whose sum is strictly greater than the sum of the remaining elements. The result is sorted in non-increasing order.

**Contract:** Input is a non-empty list of positive integers. Output is a sublist in descending order satisfying the sum constraint. The problem guarantees a unique answer.

### `TestMinSubsequence`

Six test cases covering the LeetCode examples, single-element input, equal-valued arrays, two elements, and a pre-sorted array.

## Patterns

**Greedy sort-and-accumulate.** The algorithm follows a classic greedy template used across many problems in this repo:

1. Compute the total sum.
2. Sort descending so the largest elements come first.
3. Greedily take elements until the running sum exceeds half the total.

The in-place `sort(reverse=True)` mutates the input — acceptable for LeetCode but worth noting if the caller expects `nums` to be unchanged.

**Inline tests.** Tests live in the same file alongside the solution (the separate `test_solution.py` imports from here). The `if __name__ == "__main__"` guard lets the file run standalone.

## Dependencies

**Imports:** `typing.List` (type hint), `unittest` (test framework). No project-internal dependencies.

**Imported by:** The file is imported by `minimum-subsequence-in-non-increasing-order/test_solution.py` and (per the metadata) by hundreds of other test files — likely an artifact of the "Imported By" section reflecting shared test infrastructure rather than direct imports of this solution.

## Flow

```
nums = [4, 3, 10, 9, 8]        # total = 34
sort descending → [10, 9, 8, 4, 3]
take 10 → subseq_sum=10, remaining=24  (10 > 24? no)
take 9  → subseq_sum=19, remaining=15  (19 > 15? yes → break)
return [10, 9]
```

The key comparison is `subseq_sum > total - subseq_sum`, which is equivalent to checking `subseq_sum > total / 2` but avoids floating-point division.

## Invariants

- The loop always terminates: each iteration increases `subseq_sum` by a positive integer, so eventually `subseq_sum > total - subseq_sum` must hold (at worst, after taking all elements).
- The result is in non-increasing order because elements are appended in sorted-descending traversal order.
- The result is minimal (fewest elements) because taking the largest elements first reaches the threshold fastest.

## Error Handling

None. The code assumes valid input per the LeetCode constraints (1 <= nums.length <= 500, 1 <= nums[i] <= 100). Empty input would return `[]` without error, which would be incorrect but the problem guarantees it won't happen.

## Topics to Explore

- [file] `minimum-subsequence-in-non-increasing-order/plan.md` — Design rationale and alternative approaches considered before implementation
- [file] `minimum-subsequence-in-non-increasing-order/review.md` — Post-implementation review notes, likely covering complexity analysis
- [function] `find-subsequence-of-length-k-with-the-largest-sum/solution.py:findSubsequence` — Related greedy subsequence selection problem that preserves original index order
- [general] `greedy-sort-threshold` — Pattern shared across problems like largest-perimeter-triangle, maximum-units-on-a-truck where sorting + greedy accumulation solves the problem
- [file] `maximum-units-on-a-truck/solution.py` — Another greedy sort-and-take problem with a capacity threshold instead of a sum threshold

## Beliefs

- `min-subsequence-greedy-optimal` — Sorting descending and greedily taking elements produces the minimum-length subsequence whose sum exceeds the complement; no shorter subsequence can achieve this.
- `min-subsequence-mutates-input` — `min_subsequence` calls `nums.sort(reverse=True)` in-place, so the caller's list is reordered after the call.
- `min-subsequence-integer-comparison` — The threshold check `subseq_sum > total - subseq_sum` uses only integer arithmetic, avoiding any floating-point precision issues.
- `min-subsequence-always-terminates` — The loop terminates in at most `len(nums)` iterations because all elements are positive, guaranteeing `subseq_sum` eventually equals `total`.

