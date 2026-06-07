# File: binary-search/solution.py

**Date:** 2026-06-06
**Time:** 15:24

## `binary-search/solution.py`

### Purpose

This implements [LeetCode 704 — Binary Search](https://leetcode.com/problems/binary-search/), the canonical binary search on a sorted array. It's one of ~400+ solutions in the `leetcode-implementations` repo, each following the same convention: a `Solution` class with one public method matching LeetCode's expected signature.

### Key Components

**`Solution.search(nums, target) -> int`** — The only method. Given a sorted array of unique integers and a target value, returns the index of the target or `-1` if absent.

### Patterns

**Overflow-safe midpoint**: `mid = left + (right - left) // 2` instead of `(left + right) // 2`. In Python this doesn't matter (arbitrary-precision ints), but it's the standard idiom borrowed from C/Java where `left + right` can overflow. The repo consistently uses this form across its binary search variants.

**Closed-interval search**: Both `left` and `right` are inclusive bounds (`left, right = 0, len(nums) - 1`), and the loop runs `while left <= right`. This is the classic formulation where every iteration either finds the target or shrinks the search space by at least one element.

**Three-way branch**: The `if/elif/else` partitions the comparison into equal, less-than, and greater-than — clean and easy to reason about for an exact-match search.

### Dependencies

**Imports**: None. The solution is self-contained with no standard library or third-party imports.

**Imported by**: The "Imported By" list in the prompt is misleading — those ~400 test files aren't importing *this* solution. They're importing their own `solution.py` via a shared test harness pattern. The actual consumer is `binary-search/test_solution.py`.

### Flow

1. Initialize `left = 0`, `right = len(nums) - 1` — the entire array.
2. Loop while `left <= right` (at least one candidate remains):
   - Compute `mid`, the floor-midpoint of the current window.
   - If `nums[mid] == target`: return `mid` immediately.
   - If `nums[mid] < target`: discard the left half by setting `left = mid + 1`.
   - Otherwise: discard the right half by setting `right = mid - 1`.
3. If the loop exits, the target doesn't exist — return `-1`.

Each iteration halves the search space, giving O(log n) time and O(1) space.

### Invariants

- **Precondition**: `nums` is sorted in ascending order with unique elements. The code does not verify this — it trusts the caller (LeetCode's contract).
- **Loop invariant**: If the target exists in `nums`, it lies within `nums[left..right]` inclusive.
- **Termination**: The interval `[left, right]` strictly shrinks every iteration (`left` increases or `right` decreases), so the loop terminates in at most ~log2(n) steps.

### Error Handling

None. An empty array (`len(nums) == 0`) is handled implicitly: `right = -1`, the `while left <= right` condition is immediately false, and `-1` is returned. No exceptions are raised or caught.

## Topics to Explore

- [file] `binary-search/test_solution.py` — See which edge cases (empty array, single element, target at boundaries) the test suite covers
- [file] `first-bad-version/solution.py` — A binary search variant that uses a predicate instead of exact match — compare the loop structure
- [file] `search-insert-position/solution.py` — Binary search for insertion point rather than exact index — shows how the return value changes when the target is absent
- [function] `find-smallest-letter-greater-than-target/solution.py:Solution.nextGreatestLetter` — Binary search on a circular/wrapping sorted array, a twist on the standard template
- [general] `binary-search-boundary-styles` — Compare closed-interval `[left, right]` vs half-open `[left, right)` formulations across the repo's search problems

## Beliefs

- `binary-search-returns-neg-one-on-miss` — `search()` returns `-1` when the target is not in the array; it never raises an exception
- `binary-search-closed-interval` — The implementation uses a closed interval `[left, right]` with `while left <= right`, not a half-open interval
- `binary-search-overflow-safe-midpoint` — Midpoint is computed as `left + (right - left) // 2`, not `(left + right) // 2`
- `binary-search-no-input-validation` — The method assumes `nums` is sorted with unique elements and does not validate this precondition
- `binary-search-log-n-time-constant-space` — The algorithm runs in O(log n) time and O(1) space with no recursion or auxiliary data structures

