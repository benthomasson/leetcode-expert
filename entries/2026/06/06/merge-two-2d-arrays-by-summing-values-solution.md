# File: merge-two-2d-arrays-by-summing-values/solution.py

**Date:** 2026-06-06
**Time:** 17:47

## Purpose

This file solves [LeetCode 2570: Merge Two 2D Arrays by Summing Values](https://leetcode.com/problems/merge-two-2d-arrays-by-summing-values/). It owns a single responsibility: merging two sorted arrays of `[id, value]` pairs into one sorted array, summing values when IDs match. It's the canonical merge step from merge sort, adapted for key-value pairs.

## Key Components

### `merge_nums(nums1, nums2) -> list[list[int]]`

The only function. Contract:

- **Input**: Two lists of `[id, value]` pairs, each sorted by `id` with unique IDs within each list.
- **Output**: A single merged list sorted by `id`. Where both inputs share an ID, the output contains one entry with summed values. Where an ID appears in only one input, it passes through unchanged.

## Patterns

**Two-pointer merge.** This is the textbook sorted-merge pattern: maintain one pointer per input, advance whichever points at the smaller key, and drain the remainder when one input is exhausted. The three-phase structure (main merge loop, drain `nums1`, drain `nums2`) is identical to the merge step in merge sort.

No hash maps, no `defaultdict`, no `Counter` — the solution exploits the sorted precondition to achieve O(n + m) time with O(1) auxiliary space (beyond the output list). This is the optimal approach when inputs are pre-sorted.

## Dependencies

**Imports**: None. Pure Python, no standard library usage.

**Imported by**: Only its own `test_solution.py`. The "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share a test harness or runner, not actual importers of `merge_nums`.

## Flow

1. Initialize `result = []` and two pointers `i, j = 0, 0`.
2. **Main loop** (lines 16–24): while both pointers are in bounds, compare `nums1[i][0]` vs `nums2[j][0]`:
   - Less than: append `nums1[i]` as-is, advance `i`.
   - Greater than: append `nums2[j]` as-is, advance `j`.
   - Equal: append `[id, sum_of_values]`, advance both.
3. **Drain loops** (lines 25–30): append any remaining elements from whichever input wasn't fully consumed.
4. Return the merged result.

Data flows linearly — each element from both inputs is visited exactly once, and the output is built by appending in sorted order.

## Invariants

- **Sorted-input precondition**: The algorithm assumes both inputs are sorted by `id`. If violated, the output won't be sorted and merges will be missed.
- **Unique IDs within each input**: Each ID appears at most once per input list. The algorithm doesn't accumulate — it sums exactly two values on a match.
- **Output ordering**: The result is guaranteed sorted by `id` (given sorted inputs), because the two-pointer merge always picks the smallest unconsumed key.
- **No mutation of inputs**: The function appends references to input sublists for non-matching IDs, and creates new `[id, sum]` lists for matches. It doesn't modify `nums1` or `nums2` in place (though it does alias non-matched entries rather than copying them).

## Error Handling

None. The function trusts its inputs entirely — no bounds checking, no type validation, no handling of empty lists (which work correctly by falling through to the drain loops). This is appropriate for a LeetCode solution where inputs are guaranteed well-formed.

## Topics to Explore

- [file] `merge-two-2d-arrays-by-summing-values/test_solution.py` — See what edge cases are covered (empty inputs, no overlap, full overlap)
- [file] `merge-similar-items/solution.py` — Nearly identical problem (merge by key, sum values) — compare whether it uses the same two-pointer approach or a hash map
- [file] `merge-two-sorted-lists/solution.py` — Same merge pattern applied to linked lists instead of arrays
- [general] `input-aliasing` — The function appends references to input sublists rather than copies; worth checking if any caller mutates the result
- [function] `squares-of-a-sorted-array/solution.py:sortedSquares` — Another two-pointer technique on sorted input, worth comparing the pointer movement logic

## Beliefs

- `merge-nums-linear-time` — `merge_nums` visits each element exactly once, achieving O(n + m) time complexity
- `merge-nums-no-input-mutation` — The function never modifies `nums1` or `nums2`; matched entries produce new lists, unmatched entries are aliased
- `merge-nums-sorted-precondition` — Correctness depends on both inputs being sorted by ID; unsorted inputs produce incorrect results silently
- `merge-nums-aliases-unmatched` — For IDs appearing in only one input, the output list holds a reference to the original `[id, value]` sublist, not a copy

