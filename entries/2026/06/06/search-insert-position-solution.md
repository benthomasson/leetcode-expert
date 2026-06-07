# File: search-insert-position/solution.py

**Date:** 2026-06-06
**Time:** 19:00

## `search-insert-position/solution.py`

### Purpose

This file solves [LeetCode #35 — Search Insert Position](https://leetcode.com/problems/search-insert-position/). It provides a single function that either finds a target value in a sorted array or determines where it should be inserted to maintain sort order. This is the canonical "lower bound" binary search — the same operation as `bisect_left` in Python's standard library.

### Key Components

**`searchInsert(nums, target) -> int`** — The sole public function. Contract:

- **Input**: `nums` is a sorted list of distinct integers; `target` is an integer to locate or place.
- **Output**: The index where `target` exists, or the index where it *would* go to keep `nums` sorted.
- **Guarantee**: The returned index is always in `[0, len(nums)]`.

### Patterns

**Standard binary search with left-biased convergence.** The loop maintains the invariant that the answer lies in `[left, right + 1]`. When the loop exits (`left > right`), `left` has converged to the insertion point. This is the textbook "find leftmost position" variant — no off-by-one post-processing needed because `left` naturally lands at the correct spot.

The function follows LeetCode's method-signature convention (camelCase `searchInsert`, `List[int]` typing) rather than PEP 8, which is standard across this repo.

### Dependencies

- **Imports**: `typing.List` — used only for the type annotation.
- **Imported by**: `search-insert-position/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those hundreds of test files import from their *own* `solution.py`, not this one. Only the co-located test file actually imports `searchInsert`.

### Flow

1. Initialize `left = 0`, `right = len(nums) - 1`.
2. Loop while `left <= right`:
   - Compute `mid = (left + right) // 2`.
   - If `nums[mid] == target`: exact match, return `mid` immediately.
   - If `nums[mid] < target`: target is in the right half, move `left = mid + 1`.
   - If `nums[mid] > target`: target is in the left half, move `right = mid - 1`.
3. If the loop exits without finding `target`, return `left` — the insertion index.

Each iteration halves the search space, giving **O(log n)** time and **O(1)** space.

### Invariants

- **`nums` must be sorted in ascending order** — the binary search produces garbage on unsorted input.
- **`nums` contains distinct values** — the problem guarantees this; with duplicates the function still works but doesn't guarantee returning the *leftmost* occurrence (though `left` convergence means it would for insertion-point semantics).
- **Loop termination**: the search space `[left, right]` shrinks by at least 1 each iteration (`left` increases or `right` decreases), so the loop always terminates.
- **Post-loop `left` value**: when the target is absent, `left` equals the count of elements strictly less than `target` — exactly the correct insertion index.

### Error Handling

None. The function trusts its inputs entirely — no bounds checking, no type validation. An empty `nums` list works correctly: `right` starts at `-1`, the loop never executes, and `left = 0` is returned. This is appropriate for a LeetCode solution where the problem statement guarantees valid input.

## Topics to Explore

- [file] `search-insert-position/test_solution.py` — See what edge cases are covered (empty array, target before/after all elements, exact match)
- [file] `binary-search/solution.py` — Compare with the pure binary search variant (LeetCode #704) which returns `-1` on miss instead of an insertion index
- [file] `first-bad-version/solution.py` — Another binary search variant that searches on a predicate rather than a value — shows how the same `left`-convergence pattern generalizes
- [function] `find-smallest-letter-greater-than-target/solution.py:nextGreatestLetter` — A cyclic binary search variant that wraps around, illustrating how the insertion-point idea extends
- [general] `bisect-left-equivalence` — `searchInsert` is functionally identical to `bisect.bisect_left` from the standard library; understanding this connection clarifies when to use each

## Beliefs

- `search-insert-returns-left-on-miss` — When `target` is not in `nums`, `searchInsert` returns `left`, which equals the number of elements strictly less than `target`.
- `search-insert-handles-empty-input` — For an empty list, the function returns `0` without entering the loop, since `right` initializes to `-1`.
- `search-insert-log-n-time` — The function runs in O(log n) time and O(1) space with no recursion.
- `search-insert-equivalent-to-bisect-left` — `searchInsert(nums, target)` produces the same result as `bisect.bisect_left(nums, target)` for sorted distinct-integer lists.

