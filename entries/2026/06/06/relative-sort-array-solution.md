# File: relative-sort-array/solution.py

**Date:** 2026-06-06
**Time:** 18:44

## Purpose

This file solves [LeetCode 1122 — Relative Sort Array](https://leetcode.com/problems/relative-sort-array/). It reorders `arr1` such that elements present in `arr2` appear first, in the order they appear in `arr2`, followed by any remaining elements in ascending order.

## Key Components

### `Solution.relativeSortArray(arr1, arr2) -> List[int]`

**Contract**: Given `arr1` (the array to sort) and `arr2` (a distinct-element array defining relative order), return a new list where:
1. Elements found in `arr2` appear first, in `arr2`'s order, preserving multiplicity from `arr1`.
2. Elements not in `arr2` appear after, sorted ascending.

## Patterns

**Count-and-reconstruct**: Rather than defining a custom comparator (which would be O(n log n) and awkward), this uses a frequency map to deconstruct `arr1` into counts, then reconstructs the output in the desired order. This is a common idiom for problems where the sort key is defined by an external ordering rather than a natural comparison.

**`Counter.pop` for partitioning**: `count.pop(x)` serves double duty — it retrieves the count for reconstruction *and* removes the key so that `count.elements()` afterward yields only the leftover (non-`arr2`) elements. This is the crux of the algorithm's elegance.

## Dependencies

**Imports**:
- `collections.Counter` — frequency counting of `arr1`
- `typing.List` — type annotation

**Imported by**: The `test_solution.py` in this directory, plus hundreds of other test files across the repo (the "Imported By" list in the prompt is the test harness importing `Solution` classes repo-wide via a shared pattern).

## Flow

1. **Count**: `Counter(arr1)` builds `{element: frequency}` for every element in `arr1`. O(n).
2. **Ordered emit**: For each `x` in `arr2`, emit `x` repeated `count[x]` times into `result`, then remove `x` from `count` via `pop`. O(m) where m = len(arr2), with each `extend` proportional to the element's frequency.
3. **Remainder**: `count.elements()` yields all remaining elements (those not in `arr2`) — each repeated by its count. `sorted()` sorts them ascending. O(r log r) where r = number of remaining elements.
4. **Return**: The concatenated `result`.

**Overall complexity**: O(n + m + r log r), which simplifies to O(n log n) worst case (when `arr2` is empty). Space is O(n) for the counter and result list.

## Invariants

- `arr2` elements are assumed to be a subset of `arr1` — `count.pop(x)` would raise `KeyError` if `x` is in `arr2` but not `arr1`.
- `arr2` contains distinct elements (per problem constraints), so each `pop` hits a unique key.
- After the `for x in arr2` loop, `count` contains exactly the elements of `arr1` that are *not* in `arr2`, with correct multiplicities.

## Error Handling

None. The solution assumes valid inputs per LeetCode constraints. A `KeyError` from `count.pop(x)` would propagate uncaught if `arr2` contained an element absent from `arr1`.

## Topics to Explore

- [file] `relative-sort-array/test_solution.py` — See what edge cases (empty arr2, all elements in arr2, duplicates) are tested
- [file] `relative-sort-array/review.md` — Read the code review for quality notes and alternative approaches
- [file] `height-checker/solution.py` — Another counting-sort-flavored problem; compare the reconstruction pattern
- [function] `sort-array-by-increasing-frequency/solution.py:relativeSortArray` — Custom sort key approach to a related ordering problem
- [general] `counter-pop-as-partition` — The `pop`-during-iteration idiom used here to split counted elements into two groups cleanly

## Beliefs

- `relative-sort-uses-counter-pop-partition` — `Counter.pop` during the `arr2` loop partitions elements into "ordered" and "remainder" groups without a second pass or set lookup.
- `relative-sort-linear-for-full-coverage` — When `arr2` covers all elements of `arr1`, the algorithm runs in O(n) since the `sorted()` call receives an empty iterator.
- `relative-sort-assumes-arr2-subset-of-arr1` — If `arr2` contains a value absent from `arr1`, `count.pop(x)` raises `KeyError` with no fallback.
- `relative-sort-preserves-multiplicity` — Each element from `arr1` appears in the output exactly as many times as it appeared in the input; the Counter guarantees no loss or duplication.

