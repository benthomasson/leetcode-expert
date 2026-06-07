# File: intersection-of-multiple-arrays/solution.py

**Date:** 2026-06-06
**Time:** 17:05

## Purpose

This file solves [LeetCode 2248: Intersection of Multiple Arrays](https://leetcode.com/problems/intersection-of-multiple-arrays/). It finds all integers that appear in every sub-array of a 2D list and returns them sorted. It's a standalone solution module following the repo's convention of one problem per directory with `solution.py`, `test_solution.py`, `plan.md`, and `review.md`.

## Key Components

**`intersection(nums: List[List[int]]) -> List[int]`** — The sole public function. Takes a list of lists of distinct positive integers, returns a sorted list of integers common to all sub-arrays.

## Patterns

**Set-intersection reduction**: Seeds `result` with `set(nums[0])`, then iteratively intersects (`&=`) with each remaining sub-array. This is the canonical Python idiom for multi-set intersection — equivalent to `set.intersection(*map(set, nums))` but written as an explicit loop.

**Separate-then-sort**: Computes the unordered result via sets, then applies `sorted()` at the end. This cleanly separates the membership logic from the ordering requirement.

## Dependencies

- **Imports**: `typing.List` only — no external or internal dependencies.
- **Imported by**: `intersection-of-multiple-arrays/test_solution.py` (the "Imported By" list in the prompt is misleading — it shows every test file in the repo because they all import `List` from `typing`, not because they import this module).

## Flow

1. Convert `nums[0]` to a set → `result`
2. For each subsequent array in `nums[1:]`, intersect `result` with `set(arr)` in-place
3. Sort the remaining elements and return

The set shrinks monotonically on each iteration — elements can only be removed, never added.

## Invariants

- **Precondition**: `nums` must be non-empty (accessing `nums[0]` without a guard would raise `IndexError` on an empty list). The LeetCode constraint guarantees `1 <= len(nums)`.
- **Distinct elements**: The docstring notes each sub-array contains distinct positive integers, which means converting to a set loses no information.
- **Output ordering**: The result is always ascending (guaranteed by `sorted()`).

## Error Handling

None. The function trusts its input matches the LeetCode contract. An empty `nums` would crash on line `result = set(nums[0])`. This is appropriate — the problem guarantees at least one sub-array.

## Topics to Explore

- [file] `intersection-of-two-arrays/solution.py` — Simpler two-array variant; compare the approach (likely uses a single `&` rather than a loop)
- [file] `intersection-of-three-sorted-arrays/solution.py` — Sorted-input variant that may use a two-pointer technique instead of sets
- [file] `intersection-of-two-arrays-ii/solution.py` — Handles duplicate elements (multiset intersection), which changes the data structure choice
- [file] `find-common-characters/solution.py` — Character-level intersection across strings, likely uses `Counter` instead of `set`
- [general] `set-vs-counter-intersection` — When to use `set.intersection` vs `Counter &` depends on whether duplicates carry meaning

## Beliefs

- `intersection-returns-sorted` — `intersection()` always returns elements in ascending order, enforced by `sorted()` on the final line
- `intersection-assumes-nonempty-input` — `intersection()` accesses `nums[0]` unconditionally; passing an empty list raises `IndexError`
- `intersection-uses-in-place-narrowing` — The result set only shrinks across iterations via `&=`; no element can appear in the output that wasn't in `nums[0]`
- `intersection-distinct-elements-assumed` — The solution relies on each sub-array having distinct elements; duplicate values within a sub-array would be collapsed by `set()` but wouldn't affect correctness since intersection is idempotent

