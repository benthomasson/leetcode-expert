# File: minimum-common-value/solution.py

**Date:** 2026-06-06
**Time:** 17:54

## Purpose

This file solves [LeetCode 2540 — Minimum Common Value](https://leetcode.com/problems/minimum-common-value/). It owns a single responsibility: given two sorted integer arrays, find the smallest integer that appears in both. It returns `-1` if no common element exists.

## Key Components

### `min_common_number(nums1, nums2) -> int`

The sole public function. Contract:

- **Inputs**: Two lists of integers, each sorted in non-decreasing order.
- **Output**: The minimum integer present in both lists, or `-1` if the intersection is empty.
- **Side effects**: None — pure function.

## Patterns

**Two-pointer merge scan.** This is the canonical pattern for finding common elements in two sorted sequences without extra space. Two indices advance through the arrays in lockstep: the pointer on the smaller value advances, because anything behind it can never match anything ahead in the other array. On equality, we return immediately — the first match is guaranteed to be the minimum because both arrays are scanned left to right.

This is the same merge logic used in merge sort's merge step, but short-circuited on the first match instead of producing a full merged output.

## Dependencies

**Imports**: None — the solution is self-contained, using only built-in `list` and `int`.

**Imported by**: The `test_solution.py` in the same directory. The long "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that happen to share a common test harness, not direct consumers of `min_common_number`.

## Flow

1. Initialize two pointers `i = 0`, `j = 0`.
2. While both pointers are in bounds:
   - **Equal**: `nums1[i] == nums2[j]` → return that value (first common, guaranteed minimum).
   - **Left smaller**: `nums1[i] < nums2[j]` → increment `i` to catch up.
   - **Right smaller**: otherwise → increment `j` to catch up.
3. If either pointer runs past the end, no common value exists → return `-1`.

Each iteration advances at least one pointer, so the loop terminates in at most `len(nums1) + len(nums2)` steps.

## Invariants

- **Sorted input required.** The algorithm's correctness depends entirely on both arrays being sorted in non-decreasing order. If violated, the two-pointer scan can skip over valid matches. The function does not validate this precondition.
- **First match = minimum match.** Because both pointers start at index 0 and only move forward, the first equality found is the smallest common value. No need to scan further.
- **At least one pointer advances per iteration.** The three-way branch guarantees progress — no infinite loops.

## Error Handling

None. The function assumes valid input (two sorted lists of integers). Empty lists are handled correctly — the `while` condition fails immediately and `-1` is returned. There are no exceptions raised or caught.

## Topics to Explore

- [file] `minimum-common-value/test_solution.py` — See which edge cases are tested (empty arrays, no overlap, single-element arrays, duplicates)
- [file] `minimum-common-value/plan.md` — Check whether alternative approaches (binary search, set intersection) were considered and why two-pointer was chosen
- [function] `intersection-of-two-arrays/solution.py` — Compare with the set-based approach for unsorted arrays to see when two-pointer vs hashing is preferred
- [general] `two-pointer-on-sorted-arrays` — The same merge-scan pattern appears in problems like merge sorted lists, intersection of sorted arrays, and median of two sorted arrays

## Beliefs

- `two-pointer-linear-time` — `min_common_number` runs in O(n + m) time and O(1) space where n and m are the input lengths
- `sorted-precondition-not-validated` — The function assumes both inputs are sorted but does not check or enforce this; unsorted input produces silently wrong results
- `early-return-guarantees-minimum` — The first equality found by the left-to-right scan is necessarily the smallest common value, so the function returns immediately without scanning the rest
- `empty-input-returns-negative-one` — Passing one or both empty lists correctly returns -1 via the while-loop guard, not via a special case

