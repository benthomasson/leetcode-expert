# File: check-if-a-number-is-majority-element-in-a-sorted-array/solution.py

**Date:** 2026-06-06
**Time:** 15:35

## Purpose

This file solves [LeetCode 1150: Check If a Number Is Majority Element in a Sorted Array](https://leetcode.com/problems/check-if-a-number-is-majority-element-in-a-sorted-array/). Given a sorted array and a target value, it determines whether the target appears more than `n/2` times. It owns exactly one responsibility: the `is_majority_element` function.

## Key Components

### `is_majority_element(nums, target) -> bool`

The single exported function. It exploits the sorted order of `nums` to answer the majority question in O(log n) time without counting occurrences.

**Contract**: `nums` must be sorted in non-decreasing order. `target` is the value to check. Returns `True` iff `target` appears strictly more than `len(nums) // 2` times (integer division — so for `n=5`, more than 2, i.e., at least 3).

## Patterns

**Binary search + index arithmetic.** Rather than scanning or even doing two binary searches (for the first and last occurrence), the solution does one `bisect_left` to find the leftmost position of `target`, then checks whether `target` still appears `n//2` positions to the right. This is a well-known trick for sorted-array frequency queries.

The key insight: if `target` occupies at least `n//2 + 1` consecutive slots starting at index `first`, then `nums[first + n//2]` must also equal `target`. The bounds check `first + n // 2 < n` prevents an index-out-of-range.

## Dependencies

**Imports**: `bisect.bisect_left` from the standard library — a C-implemented binary search that returns the leftmost insertion point for `target`.

**Imported by**: `check-if-a-number-is-majority-element-in-a-sorted-array/test_solution.py` directly. The large "Imported By" list in the prompt is an artifact of the test harness structure (shared test infrastructure), not actual runtime dependents.

## Flow

1. Compute `n = len(nums)`.
2. `bisect_left(nums, target)` → `first`: the index where `target` first appears (or would be inserted if absent).
3. Compute `first + n // 2` — the position that must also be `target` if it's a majority element.
4. Guard: `first + n // 2 < n` ensures we don't read past the array.
5. Check: `nums[first + n // 2] == target` confirms the run of `target` values is long enough.
6. Both conditions are combined with `and` (short-circuit), so the index access is safe.

**Example walkthrough**: `nums = [2,4,5,5,5,5,5,6,6]`, `target = 5`, `n = 9`.
- `bisect_left` → `first = 2`
- `first + n//2 = 2 + 4 = 6`, which is `< 9` ✓
- `nums[6] = 5 == target` ✓ → returns `True`

## Invariants

- **Sorted input**: The algorithm is only correct if `nums` is sorted. No runtime check enforces this — it's a precondition from the problem statement.
- **Integer division semantics**: `n // 2` uses floor division. For `n = 4`, majority requires > 2 occurrences (i.e., ≥ 3). For `n = 5`, majority requires > 2 (i.e., ≥ 3). This matches the LeetCode definition.
- **Bounds safety**: The `first + n // 2 < n` guard runs before the array access due to `and` short-circuiting.

## Error Handling

None. The function assumes valid input per the problem constraints. An empty `nums` would have `n = 0`, `first = 0`, and `0 + 0 < 0` is `False`, so it correctly returns `False`. If `target` is absent, `bisect_left` returns an insertion point where `nums[first + n//2] != target` (or the bounds check fails), so it returns `False`.

## Topics to Explore

- [file] `check-if-a-number-is-majority-element-in-a-sorted-array/test_solution.py` — See the edge cases being tested (absent target, single-element arrays, exact threshold)
- [function] `majority-element/solution.py:majorityElement` — The unsorted variant (LeetCode 169), likely uses Boyer-Moore voting instead of binary search
- [general] `bisect-left-vs-bisect-right` — Understanding when to use each; a two-bisect approach (`bisect_right - bisect_left`) gives the exact count but this solution avoids the second call
- [file] `element-appearing-more-than-25-in-sorted-array/solution.py` — Similar sorted-array frequency problem with a different threshold (>25%), likely uses a related technique
- [file] `binary-search/solution.py` — The foundational binary search implementation in this repo

## Beliefs

- `majority-check-single-bisect` — `is_majority_element` uses exactly one binary search call (`bisect_left`), achieving O(log n) time with no linear scan
- `majority-threshold-floor-division` — The majority threshold is `n // 2` (floor division), meaning the target must appear at least `n // 2 + 1` times to qualify
- `majority-check-no-input-validation` — The function does not validate that `nums` is sorted; correctness depends entirely on the caller satisfying this precondition
- `majority-check-bounds-safe` — The short-circuit `and` guarantees `nums[first + n // 2]` is never accessed out of bounds

