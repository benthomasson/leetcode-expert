# File: find-the-difference-of-two-arrays/solution.py

**Date:** 2026-06-06
**Time:** 16:44

## `find-the-difference-of-two-arrays/solution.py`

### Purpose

This file implements [LeetCode 2215 — Find the Difference of Two Arrays](https://leetcode.com/problems/find-the-difference-of-two-arrays/). It owns the sole responsibility of computing the symmetric set difference between two integer arrays: elements unique to `nums1` and elements unique to `nums2`, returned as two separate lists.

### Key Components

**`Solution.findDifference(nums1, nums2) -> List[List[int]]`**

The only method. Contract:
- **Input**: Two lists of integers (may contain duplicates).
- **Output**: A list of exactly two lists — `[unique_to_nums1, unique_to_nums2]`. Each sub-list contains distinct values only.
- **Side effects**: None.

### Patterns

**Set-difference idiom.** The solution converts both arrays to sets, then uses Python's `-` operator for set difference. This is the canonical Python approach — it's both the most readable and the most efficient way to express this operation.

**Single-expression body.** The entire logic fits in two lines: one for conversion, one for the result. This is representative of a pattern across the repo where solutions favor concise, idiomatic Python over verbose imperative loops.

### Dependencies

**Imports**: `List` from `typing` — used only for the type annotation matching LeetCode's method signature.

**Imported by**: The `test_solution.py` in the same directory. The massive "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share the same `Solution` class name pattern, not actual imports of this file.

### Flow

1. `set(nums1)` and `set(nums2)` — O(n + m) conversion that deduplicates both inputs.
2. `set1 - set2` — O(min(len(set1), len(set2))) set difference: elements in `set1` not present in `set2`.
3. `set2 - set1` — same, reversed direction.
4. Both differences are wrapped with `list()` and returned as a two-element list.

Total time complexity: **O(n + m)**. Space: **O(n + m)** for the two sets.

### Invariants

- The output always contains exactly two sub-lists.
- Each sub-list contains only distinct values (guaranteed by set operations).
- The union of both output lists plus the intersection of the inputs reconstructs the full set of distinct values across both arrays.
- Output order within each sub-list is undefined (set iteration order is arbitrary).

### Error Handling

None. The function trusts its inputs match the LeetCode contract (integer lists). No validation, no exceptions. This is appropriate — it's called only from the test harness and LeetCode's runtime, both of which guarantee valid inputs.

## Topics to Explore

- [file] `find-the-difference-of-two-arrays/test_solution.py` — See what edge cases the test suite covers (empty arrays, full overlap, no overlap, duplicates)
- [file] `intersection-of-two-arrays/solution.py` — The complement problem: computing `set1 & set2` instead of the symmetric difference
- [file] `two-out-of-three/solution.py` — Generalizes set membership tests to three arrays
- [general] `set-vs-sorting-tradeoffs` — When a sorting-based approach (O(n log n), O(1) space) beats set-based (O(n), O(n) space) for difference problems

## Beliefs

- `find-difference-output-length` — `findDifference` always returns a list of exactly two sub-lists, regardless of input
- `find-difference-deduplicates` — Output sub-lists contain no duplicates, even when input arrays contain repeated values
- `find-difference-linear-time` — The solution runs in O(n + m) time due to set conversion and set difference operations
- `find-difference-no-order-guarantee` — The order of elements within each output sub-list is not deterministic

