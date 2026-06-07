# File: find-target-indices-after-sorting-array/solution.py

**Date:** 2026-06-06
**Time:** 16:43

## Purpose

This file solves [LeetCode 2089: Find Target Indices After Sorting Array](https://leetcode.com/problems/find-target-indices-after-sorting-array/). Given an unsorted array `nums` and a `target` value, it returns the indices where `target` would appear if the array were sorted — without actually sorting.

It owns the `Solution.targetIndices` method, which is the standard LeetCode submission interface.

## Key Components

### `Solution.targetIndices(nums, target) -> List[int]`

**Contract**: Given an integer list `nums` and integer `target`, returns a sorted list of indices where `target` appears in the sorted version of `nums`.

The implementation uses a counting approach rather than sorting:

1. **`left`** — counts elements strictly less than `target`. This is exactly the index where the first occurrence of `target` would land in a sorted array.
2. **`count`** — counts elements equal to `target`. Since equal elements are contiguous in a sorted array, the target occupies indices `[left, left + count)`.
3. **`range(left, left + count)`** — generates the consecutive index range directly.

## Patterns

**Counting instead of sorting** — This is the key insight. The naive approach sorts the array (O(n log n)) then scans for the target. This solution counts in two passes (O(n)) and constructs the result from the counts alone. It exploits the fact that in a sorted array, all elements less than `target` precede it, and all equal elements are contiguous.

**Single-expression generators** — Uses generator expressions inside `sum()` for compact counting, a common Python idiom equivalent to `Counter` or manual loops but with lower ceremony.

## Dependencies

**Imports**: `typing.List` — used only for the type annotation in the method signature.

**Imported by**: `find-target-indices-after-sorting-array/test_solution.py` (the "Imported By" list in the prompt is the full repo's test suite importing `Solution` from various problem directories — not all importing *this* file).

## Flow

```
nums = [1, 2, 5, 2, 3], target = 2

Pass 1: count elements < 2  →  left = 1    (only 1 is less than 2)
Pass 2: count elements == 2 →  count = 2   (two 2's in the array)

Result: range(1, 3) → [1, 2]

Sorted array would be [1, 2, 2, 3, 5]
                           ^  ^
                        idx 1  idx 2  ✓
```

Two linear scans over `nums`, then an O(count) range construction. Total: O(n) time, O(count) space for the output.

## Invariants

- The returned list is always sorted (guaranteed by `range` producing consecutive integers).
- If `target` is absent from `nums`, `count` is 0 and the result is an empty list.
- The method does not mutate `nums`.
- `left + count <= len(nums)` always holds, since `left` counts strictly-less elements and `count` counts equal elements — their sum can't exceed the array length.

## Error Handling

None. The method assumes valid inputs per LeetCode constraints (non-empty list, integer target). No validation, no exceptions — failures would surface as standard Python runtime errors (e.g., iterating over `None`).

## Topics to Explore

- [file] `find-target-indices-after-sorting-array/test_solution.py` — Verify which edge cases are covered (empty result, all-equal arrays, single element)
- [file] `find-target-indices-after-sorting-array/review.md` — Read the code review for any noted tradeoffs or alternative approaches
- [function] `binary-search/solution.py:Solution.search` — Compare with the binary search solution pattern, since this problem can also be solved with two binary searches (bisect_left + bisect_right)
- [general] `counting-vs-sorting-tradeoffs` — When counting beats sorting: this O(n) approach wins on time complexity but only works because the problem asks for indices of a *single* target value, not the full sorted order

## Beliefs

- `no-sort-required` — `targetIndices` never sorts the input array; it computes the answer in O(n) using two counting passes
- `output-always-contiguous` — The returned indices are always a contiguous range `[left, left+count)`, never a sparse set, because equal elements are adjacent in sorted order
- `input-not-mutated` — The method is pure: it reads `nums` without modifying it, unlike an in-place sort approach
- `empty-on-missing-target` — When `target` does not appear in `nums`, `count` is 0 and the method returns `[]`

