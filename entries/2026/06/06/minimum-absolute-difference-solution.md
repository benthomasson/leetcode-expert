# File: minimum-absolute-difference/solution.py

**Date:** 2026-06-06
**Time:** 17:51

## Purpose

This file solves [LeetCode 1200 — Minimum Absolute Difference](https://leetcode.com/problems/minimum-absolute-difference/). Given an array of distinct integers, it finds all pairs of elements whose absolute difference equals the minimum absolute difference across the entire array. It's a standalone solution module following the repo's convention of one problem per directory.

## Key Components

### `minimumAbsDifference(arr: List[int]) -> List[List[int]]`

The single exported function. Contract:

- **Input**: A list of distinct integers (length >= 2).
- **Output**: A list of `[a, b]` pairs where `a < b` and `b - a` equals the global minimum difference. Pairs are returned in ascending order of `a`.

## Patterns

**Sort-then-scan**: The solution sorts the array first, which guarantees two things simultaneously: (1) the minimum absolute difference must occur between adjacent elements (no need to check all O(n^2) pairs), and (2) the output pairs are naturally in ascending order without additional sorting.

**Two-pass linear scan**: Pass 1 computes the minimum difference via `min()` over adjacent gaps. Pass 2 collects all adjacent pairs matching that minimum. Both are expressed as generator/list comprehensions — idiomatic Python that avoids explicit loops.

## Dependencies

- **Imports**: Only `typing.List` — no external libraries, no project-internal imports.
- **Imported by**: `minimum-absolute-difference/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those 400+ test files don't import *this* solution; they import their own `solution.py` via the same relative import pattern. Only the co-located test file actually depends on this module.

## Flow

1. **Sort in-place** — `arr.sort()` mutates the input. O(n log n).
2. **Find min difference** — Generator expression iterates adjacent pairs `arr[i+1] - arr[i]` for `i in range(len(arr) - 1)`. Since the array is sorted, all differences are non-negative, so `min()` yields the minimum absolute difference.
3. **Collect matching pairs** — List comprehension filters adjacent pairs whose difference equals `min_diff`, returning them as `[arr[i], arr[i+1]]`. Because the array is sorted, `arr[i] < arr[i+1]` is guaranteed, satisfying the `a < b` output requirement.

**Time**: O(n log n) dominated by the sort. The two linear scans are O(n).
**Space**: O(n) for the output list (O(1) auxiliary beyond that, ignoring sort internals).

## Invariants

- The input array must contain **distinct** integers — the problem statement guarantees this, and the code relies on it (adjacent differences are always > 0 after sorting).
- The input must have at least 2 elements — otherwise `range(len(arr) - 1)` produces an empty range and `min()` raises `ValueError`.
- **Mutates the input**: `arr.sort()` modifies the caller's list. This is standard for LeetCode solutions but worth noting.

## Error Handling

None. The function assumes valid input per the problem constraints. Passing an array with fewer than 2 elements causes an unhandled `ValueError` from `min()` on an empty sequence. Passing non-distinct values won't crash but could return pairs with difference 0, which may or may not match the caller's intent.

## Topics to Explore

- [file] `minimum-absolute-difference/test_solution.py` — See what edge cases the test suite covers (single-pair arrays, negative numbers, large gaps)
- [file] `minimum-absolute-difference/plan.md` — Read the problem breakdown and approach analysis written before implementation
- [file] `minimum-absolute-difference/review.md` — Post-implementation review notes on correctness and style
- [function] `minimum-absolute-difference-in-bst/solution.py:getMinimumDifference` — Same concept applied to a BST (in-order traversal replaces sorting)
- [general] `sort-then-scan-pattern` — This pattern recurs across multiple solutions in the repo (e.g., `array-partition`, `largest-perimeter-triangle`) — worth studying as a family

## Beliefs

- `min-abs-diff-sort-adjacency` — After sorting distinct integers, the minimum absolute difference always occurs between some pair of adjacent elements; non-adjacent pairs always have equal or larger differences.
- `min-abs-diff-output-ordering` — Output pairs are naturally sorted ascending by first element because the input is sorted before collection — no separate output sort is needed.
- `min-abs-diff-mutates-input` — The function mutates the input list via `arr.sort()` rather than working on a copy.
- `min-abs-diff-two-pass` — The algorithm makes exactly two linear passes over the sorted array: one to find the minimum difference, one to collect matching pairs.

