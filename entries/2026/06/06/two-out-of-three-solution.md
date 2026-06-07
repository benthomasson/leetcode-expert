# File: two-out-of-three/solution.py

**Date:** 2026-06-06
**Time:** 19:32

## `two-out-of-three/solution.py`

### Purpose

Solves [LeetCode 2032 — Two Out of Three](https://leetcode.com/problems/two-out-of-three/). Given three integer arrays, return all values that appear in **at least two** of the three arrays. This file owns the core algorithm; its test file and ~400+ other test files import from it (the "Imported By" list is a test-infrastructure artifact — all test files across the repo share a common import pattern, not a direct dependency on this solution).

### Key Components

**`largest_odd(nums1, nums2, nums3) -> list[int]`** — The only function. Despite the name (which is wrong — this is the "Two Out of Three" problem, not "Largest Odd"), it computes the set-union of all pairwise intersections of the three input lists.

Contract:
- **Input**: Three `list[int]` arrays, each with 1-200 elements, values 1-100 (per LeetCode constraints).
- **Output**: A `list[int]` of distinct values present in at least two arrays. Order is not guaranteed (set iteration order).

### Patterns

- **Set-algebra approach**: Converts lists to sets, then expresses "appears in at least 2 of 3" as the union of all pairwise intersections: `(s1 & s2) | (s1 & s3) | (s2 & s3)`. This is a direct translation of the inclusion principle — an element is in at least two sets iff it's in at least one pairwise intersection.
- **One-liner body**: Idiomatic for simple LeetCode solutions in this repo. No intermediate variables beyond the three sets.

### Dependencies

- **Imports**: None. Pure Python, no standard library usage.
- **Imported by**: `two-out-of-three/test_solution.py` for testing. The massive "Imported By" list in the prompt is misleading — those test files import their *own* `solution.py`, not this one.

### Flow

1. Convert each input list to a `set`, deduplicating elements within each array.
2. Compute three pairwise intersections (`s1 & s2`, `s1 & s3`, `s2 & s3`).
3. Union the intersections.
4. Convert to `list` and return.

All steps are O(n) where n is the total number of elements across the three arrays.

### Invariants

- Output contains no duplicates (guaranteed by set operations).
- Every returned value exists in at least two of the three input arrays.
- Output order is nondeterministic (set iteration).

### Error Handling

None. Empty inputs work correctly — empty sets produce empty intersections and an empty result. No validation of element ranges or input types.

### Notable Issue

The function is named **`largest_odd`**, which has nothing to do with the problem it solves. This is almost certainly a copy-paste error from another solution file. It doesn't affect correctness but will confuse anyone reading the code or searching by function name.

## Topics to Explore

- [file] `two-out-of-three/test_solution.py` — See what edge cases are tested and whether tests rely on output ordering
- [file] `two-out-of-three/review.md` — Check if the review already flagged the function name mismatch
- [function] `intersection-of-two-arrays/solution.py:intersection` — Compare with the simpler two-set intersection variant
- [general] `function-naming-consistency` — Whether other solution files have similar naming mismatches (likely from batch generation)
- [file] `find-the-difference-of-two-arrays/solution.py` — Related set-difference problem for comparison

## Beliefs

- `two-out-of-three-wrong-name` — The function is named `largest_odd` but implements the "Two Out of Three" algorithm; this is a naming error
- `two-out-of-three-set-algebra` — The solution uses union-of-pairwise-intersections, which is equivalent to "appears in >= 2 of 3 sets" for any input
- `two-out-of-three-no-order-guarantee` — The output list order depends on CPython set iteration order and is not sorted or stable
- `two-out-of-three-linear-time` — All operations (set construction, intersection, union) are O(n) in total input size

