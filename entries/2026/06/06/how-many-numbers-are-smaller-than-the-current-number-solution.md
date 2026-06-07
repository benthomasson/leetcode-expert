# File: how-many-numbers-are-smaller-than-the-current-number/solution.py

**Date:** 2026-06-06
**Time:** 17:01

## Purpose

This file solves [LeetCode 1365: How Many Numbers Are Smaller Than the Current Number](https://leetcode.com/problems/how-many-numbers-are-smaller-than-the-current-number/). Given an array `nums`, it returns a new array where each element at index `i` is the count of elements in `nums` that are strictly less than `nums[i]`.

It owns a single responsibility: the `smallerNumbersThanCurrent` method on the `Solution` class.

## Key Components

**`Solution.smallerNumbersThanCurrent(nums: List[int]) -> List[int]`**

Contract: accepts a list of integers in range `[0, 100]` with length `[2, 500]`, returns a list of the same length where each position holds the count of strictly smaller elements across the entire input.

## Patterns

**Counting sort + prefix sum** — The solution avoids the naive O(n^2) pairwise comparison. Instead it exploits the constrained value range (0-100) to achieve O(n + k) time, where k=101:

1. **Frequency table** (`count`): a 101-element array tallying how many times each value appears.
2. **Prefix sum** (`prefix`): `prefix[v]` accumulates `count[0] + count[1] + ... + count[v-1]`, which is exactly the number of elements strictly less than `v`.
3. **Lookup**: the final list comprehension maps each `nums[i]` through `prefix` in O(1).

This is a textbook application of the counting sort principle — when the value domain is small and known, you can replace comparison-based work with array indexing.

## Dependencies

**Imports**: `List` from `typing` (type annotation only — no runtime dependency).

**Imported by**: `how-many-numbers-are-smaller-than-the-current-number/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the test harness importing a shared test utility, not this solution specifically.

## Flow

```
nums = [8, 1, 2, 2, 3]

Step 1 — Build frequency:
  count[1]=1, count[2]=2, count[3]=1, count[8]=1

Step 2 — Prefix sums:
  prefix[0]=0, prefix[1]=0, prefix[2]=1, prefix[3]=3, prefix[8]=4, ...

Step 3 — Lookup:
  [prefix[8], prefix[1], prefix[2], prefix[2], prefix[3]]
  = [4, 0, 1, 1, 3]
```

Both `count` and `prefix` are fixed-size (101 elements), so memory is O(k) regardless of input size.

## Invariants

- `prefix[v] == sum(count[0:v])` — the number of input elements with value strictly less than `v`.
- The output list preserves the original index ordering of `nums`.
- Duplicate values get identical counts (both `2`s map to `prefix[2] = 1`).

## Error Handling

None. The solution assumes valid input per the LeetCode constraints. No bounds checking, no empty-list guard. This is standard for LeetCode solutions where the problem guarantees `len(nums) >= 2` and `0 <= nums[i] <= 100`.

## Topics to Explore

- [file] `how-many-numbers-are-smaller-than-the-current-number/test_solution.py` — See what edge cases the test suite covers (all-equal, boundary values, duplicates)
- [file] `how-many-numbers-are-smaller-than-the-current-number/review.md` — The code review may note alternative approaches (sorting-based, bisect) and their tradeoffs
- [function] `rank-transform-of-an-array/solution.py:Solution.arrayRankTransform` — A closely related problem that also maps values to their rank via sorting; compare the approach
- [general] `counting-sort-vs-comparison-sort` — When value-range-bounded techniques (counting sort, radix sort) beat comparison-based O(n log n) approaches in LeetCode problems
- [function] `count-negative-numbers-in-a-sorted-matrix/solution.py:Solution.countNegatives` — Another counting problem that exploits sorted structure for sub-quadratic performance

## Beliefs

- `prefix-sum-correctness` — `prefix[v]` equals exactly the number of elements in `nums` with value strictly less than `v`, for all `v` in `[0, 100]`
- `linear-time-complexity` — The algorithm runs in O(n + 101) time, making two passes over `nums` and one pass over the 101-element arrays
- `constant-space-overhead` — Memory usage beyond the output is O(101) = O(1) regardless of input size, due to the fixed value range
- `duplicate-handling` — Elements with the same value always receive the same count, since they index into the same `prefix` slot

