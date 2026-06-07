# File: sort-array-by-parity-ii/solution.py

**Date:** 2026-06-06
**Time:** 19:10

## `sort-array-by-parity-ii/solution.py`

### Purpose

This file solves [LeetCode 922 — Sort Array By Parity II](https://leetcode.com/problems/sort-array-by-parity-ii/). Given an array where exactly half the elements are even and half are odd, it rearranges the array in-place so that `nums[i]` is even when `i` is even, and odd when `i` is odd.

### Key Components

**`Solution.possible_bipartition(self, nums: list[int]) -> list[int]`**

The sole method. Note the name `possible_bipartition` doesn't match the LeetCode canonical name (`sortArrayByParityII`) — likely a naming artifact from the repo's generation tooling.

**Contract:** Accepts an array where exactly `len(nums) / 2` elements are even and `len(nums) / 2` are odd. Returns the same list object, modified in-place.

### Patterns

**Two-pointer with stride-2 scanning.** Instead of using a single-pass or sorting approach, this uses two independent pointers that each skip by 2:

- `i` walks even indices (0, 2, 4, …) looking for misplaced odd numbers
- `j` walks odd indices (1, 3, 5, …) looking for misplaced even numbers

When both find a violation simultaneously, a swap fixes both positions at once. This is the classic O(n) time, O(1) space solution for this problem.

### Dependencies

**Imports:** None — pure standalone solution.

**Imported by:** `sort-array-by-parity-ii/test_solution.py` (and the massive list of test files in the "Imported By" section appears to be a repo-wide cross-reference artifact, not actual imports of this specific module).

### Flow

1. Initialize `i = 0` (first even index), `j = 1` (first odd index).
2. Loop while both pointers are in bounds:
   - If `nums[i]` is already even → advance `i` by 2.
   - Else if `nums[j]` is already odd → advance `j` by 2.
   - Else both are wrong → swap them, advance both by 2.
3. Return `nums`.

The key insight: a misplaced odd at an even index *must* have a corresponding misplaced even at an odd index (since the counts are balanced). So the algorithm never gets stuck — when `i` finds a violation, `j` will eventually find the matching one.

### Invariants

- **Precondition:** Exactly half the elements are even, half odd. If violated, the algorithm still terminates but may leave some positions unsatisfied.
- **Loop invariant:** All even indices before `i` contain even numbers; all odd indices before `j` contain odd numbers.
- **Termination:** Each iteration advances at least one pointer by 2, so the loop terminates in at most `n` iterations.
- **In-place:** The return value is the same list object passed in — no new allocation.

### Error Handling

None. No validation of the input constraint. If the array has unequal even/odd counts, one pointer will go out of bounds while the other still has violations, silently leaving those positions wrong.

---

## Topics to Explore

- [file] `sort-array-by-parity/solution.py` — The simpler variant (LeetCode 905) where evens just need to come before odds, no index-parity constraint
- [file] `sort-array-by-parity-ii/test_solution.py` — See what edge cases the test suite covers (empty array, length 2, all-same-parity inputs)
- [function] `sort-even-and-odd-indices-independently/solution.py` — Related problem that sorts even-indexed and odd-indexed elements separately
- [general] `two-pointer-stride-patterns` — How stride-2 two-pointer differs from the classic converging two-pointer (e.g., in `squares-of-a-sorted-array`)

## Beliefs

- `parity-ii-linear-time` — The algorithm runs in O(n) time and O(1) extra space via two stride-2 pointers that each traverse at most n/2 elements
- `parity-ii-swap-correctness` — A swap only occurs when `nums[i]` is odd and `nums[j]` is even, guaranteeing both positions are fixed simultaneously
- `parity-ii-in-place-mutation` — The method mutates and returns the input list; callers holding a reference to the original list see the changes
- `parity-ii-method-name-mismatch` — The method is named `possible_bipartition` rather than the LeetCode canonical `sortArrayByParityII`, which may affect discoverability

