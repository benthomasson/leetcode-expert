# File: remove-duplicates-from-sorted-array/solution.py

**Date:** 2026-06-06
**Time:** 18:45

## Purpose

This file implements LeetCode Problem #26 — "Remove Duplicates from Sorted Array." It owns the in-place deduplication of a sorted integer array, returning the count of unique elements. The solution modifies `nums` so that the first `k` positions contain the unique values in order, and the caller can ignore everything past index `k-1`.

## Key Components

**`Solution.removeDuplicates(self, nums: List[int]) -> int`**

The sole method. Contract:
- **Input**: A sorted (non-decreasing) list of integers, passed by reference.
- **Output**: `k`, the number of unique elements.
- **Side effect**: The first `k` elements of `nums` are overwritten with the unique values in their original sorted order. Elements at index `k` and beyond are don't-care.

## Patterns

**Two-pointer / read-write head pattern.** `k` is the write pointer (also doubles as the count of unique elements found so far). `i` is the read pointer scanning forward through the array. When `nums[i]` differs from the last written value (`nums[k-1]`), it gets written to `nums[k]` and `k` advances.

This is the canonical in-place deduplication idiom — O(n) time, O(1) extra space. The comparison `nums[i] != nums[k - 1]` works because the array is sorted: duplicates are always contiguous, so comparing against the last written value is sufficient.

## Dependencies

- **Imports**: `typing.List` — standard type annotation, no runtime dependency.
- **Imported by**: The "Imported By" list is misleading — it lists test files from *other* problems that happen to share the same `from typing import List` import, not actual consumers of this solution. The real consumer is `remove-duplicates-from-sorted-array/test_solution.py`.

## Flow

1. `k` starts at 1 — the first element is always unique by definition.
2. `i` iterates from index 1 to `len(nums) - 1`.
3. At each step, compare `nums[i]` (current read position) against `nums[k - 1]` (last unique value written).
4. If they differ, copy `nums[i]` to `nums[k]` and increment `k`.
5. Return `k`.

For `[1, 1, 2, 3, 3]`: k=1 → skip 1 → write 2 at [1], k=2 → write 3 at [2], k=3. Result: `[1, 2, 3, *, *]`, returns 3.

## Invariants

- **Sorted input required.** The algorithm silently produces wrong results on unsorted input — it only detects adjacent duplicates via the write-head comparison.
- **Non-empty input assumed.** `k` starts at 1 and the loop starts at index 1, so calling this on an empty list would return 1 incorrectly. (LeetCode's constraints guarantee `1 <= nums.length`.)
- **Stability.** The relative order of unique elements is preserved — the first occurrence of each value is kept.

## Error Handling

None. No bounds checking, no empty-list guard, no type validation. This follows LeetCode convention where inputs are guaranteed to satisfy constraints.

## Topics to Explore

- [file] `remove-duplicates-from-sorted-array/test_solution.py` — See what edge cases the test suite covers (empty list? single element? all duplicates?)
- [file] `remove-element/solution.py` — Same two-pointer pattern applied to value removal instead of deduplication
- [file] `move-zeroes/solution.py` — Another read-write head variant where zeroes are pushed to the end
- [general] `two-pointer-in-place-patterns` — How this idiom generalizes across sorted-array problems (remove element, move zeroes, remove duplicates II)

## Beliefs

- `remove-dupes-is-two-pointer` — `removeDuplicates` uses a single-pass read/write pointer pattern with O(n) time and O(1) space
- `remove-dupes-assumes-sorted` — The algorithm only compares against the last written element, so it produces incorrect results on unsorted input
- `remove-dupes-assumes-nonempty` — Starting `k=1` with no empty-list guard means an empty input returns 1 instead of 0
- `remove-dupes-compare-against-write-head` — Uniqueness is checked via `nums[i] != nums[k-1]` (last written value), not `nums[i] != nums[i-1]` (previous read position) — both work on sorted input but the write-head comparison is the more generalizable form

