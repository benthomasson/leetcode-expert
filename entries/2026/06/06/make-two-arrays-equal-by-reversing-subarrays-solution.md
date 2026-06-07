# File: make-two-arrays-equal-by-reversing-subarrays/solution.py

**Date:** 2026-06-06
**Time:** 17:31

## Purpose

This file solves [LeetCode 1460: Make Two Arrays Equal by Reversing Subarrays](https://leetcode.com/problems/make-two-arrays-equal-by-reversing-subarrays/). It determines whether `arr` can be transformed into `target` using any number of subarray reversals.

The key insight is that reversing subarrays is equivalent to arbitrary reordering — you can sort any array using a sequence of subarray reversals (this is essentially selection sort). So the problem reduces to: do the two arrays contain the same elements with the same frequencies?

## Key Components

**`Solution.makeTwoArraysEqualByReversingSubarrays`** — Takes two integer lists, returns a bool. The entire logic is a single-line multiset equality check via sorting.

## Patterns

- **Reduction to simpler problem**: The solution recognizes that "can we rearrange via reversals" is equivalent to "are these multisets equal," collapsing an apparently complex combinatorial question into a comparison.
- **Sort-and-compare idiom**: `sorted(a) == sorted(b)` is the standard Python one-liner for multiset equality. An alternative would be `Counter(target) == Counter(arr)`, which is O(n) instead of O(n log n) but has higher constant factors for small inputs.

## Dependencies

**Imports**: `typing.List` — used only for type annotations in the LeetCode function signature.

**Imported by**: The massive `imported_by` list is misleading — it reflects the test runner infrastructure, not actual code coupling. Only `make-two-arrays-equal-by-reversing-subarrays/test_solution.py` actually tests this solution. The other test files import the same `Solution` pattern from their own directories.

## Flow

1. Both `target` and `arr` are sorted independently (producing new lists, not mutating the originals).
2. The sorted lists are compared element-by-element via `==`.
3. The boolean result is returned directly.

No iteration, no branching, no mutation.

## Invariants

- Both inputs must be lists of integers of the same length (guaranteed by the problem constraints; not validated here).
- The original arrays are not modified — `sorted()` returns new lists.

## Error Handling

None. The function trusts the caller to provide valid inputs per LeetCode's contract. Passing arrays of different lengths returns `False` naturally (sorted lists of different lengths aren't equal).

## Topics to Explore

- [file] `make-two-arrays-equal-by-reversing-subarrays/test_solution.py` — See what edge cases the test suite covers (empty arrays, single elements, duplicates)
- [file] `make-two-arrays-equal-by-reversing-subarrays/review.md` — The code review likely discusses the sort-vs-Counter tradeoff
- [general] `subarray-reversal-sorting-equivalence` — Why arbitrary subarray reversals give you full permutation power (pancake sorting theorem)
- [function] `check-array-formation-through-concatenation/solution.py:Solution` — A related array rearrangement problem with stricter constraints where sorting alone doesn't work

## Beliefs

- `reversal-equals-reorder` — Any permutation of an array is reachable via a sequence of subarray reversals, so the problem reduces to multiset equality
- `sorted-comparison-correctness` — `sorted(a) == sorted(b)` returns True iff `a` and `b` contain the same elements with the same multiplicities
- `no-mutation` — The solution never modifies the input arrays; `sorted()` allocates new lists
- `time-complexity-nlogn` — The solution runs in O(n log n) due to two sorts; an O(n) Counter-based approach exists but isn't used

