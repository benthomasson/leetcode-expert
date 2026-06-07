# File: divide-array-into-equal-pairs/solution.py

**Date:** 2026-06-06
**Time:** 16:26

## Purpose

This file solves [LeetCode 2206 — Divide Array Into Equal Pairs](https://leetcode.com/problems/divide-array-into-equal-pairs/). Given an array `nums` of length `2n`, it determines whether the array can be divided into exactly `n` pairs where each pair consists of two equal elements. It owns the algorithmic logic and exposes it via the standard `Solution` class that the test harness expects.

## Key Components

**`Solution.divideArrayIntoEqualPairs(self, nums: List[int]) -> bool`** — The sole method. It returns `True` if and only if every distinct value in `nums` appears an even number of times. The contract matches LeetCode's signature: takes a list of integers, returns a boolean.

## Patterns

- **Counter + predicate reduction**: Rather than sorting or using a set-based XOR trick, the solution counts occurrences with `Counter` and checks the parity of every count. This is the idiomatic Python approach for frequency-based problems — one-liner generator expression inside `all()`.
- **Standard LeetCode class structure**: `Solution` class with a single method, no `__init__`, no state. This is the convention used across every problem directory in the repo.

## Dependencies

**Imports:**
- `collections.Counter` — frequency counting
- `typing.List` — type annotation for the method signature

**Imported by:** The test file at `divide-array-into-equal-pairs/test_solution.py` (and the "Imported By" list in the prompt is the full cross-repo test suite, which imports from a shared test infrastructure, not from this file specifically).

## Flow

1. `Counter(nums)` builds a frequency map in O(n) time, O(k) space where k = distinct values.
2. The generator `count % 2 == 0 for count in Counter(nums).values()` lazily checks each frequency.
3. `all(...)` short-circuits on the first odd count, returning `False`. If every count is even, returns `True`.

Total: O(n) time, O(k) space. Single pass through the array, single pass through the counter.

## Invariants

- The problem guarantees `len(nums) == 2n`, so the total element count is always even. The solution doesn't validate this — it relies on the LeetCode constraint. If the total count were odd, the solution would still return `False` correctly (at least one value must have an odd count).
- The check `count % 2 == 0` is necessary and sufficient: you can form pairs from a value if and only if it appears an even number of times.

## Error Handling

None. The method assumes valid input per LeetCode constraints (non-empty list of integers with even length). No exceptions are raised or caught.

## Topics to Explore

- [file] `divide-array-into-equal-pairs/test_solution.py` — See what edge cases the test suite covers (empty-ish arrays, all-same elements, single pair)
- [file] `divide-array-into-equal-pairs/review.md` — The code review notes for this solution, likely discussing alternative approaches
- [function] `x-of-a-kind-in-a-deck-of-cards/solution.py:Solution` — A harder variant: instead of pairs, checks if cards can be grouped into sets of size k >= 2 (requires GCD over counts)
- [general] `counter-based-solutions` — Several problems in this repo use the `Counter + all/any` pattern; compare `check-if-all-characters-have-equal-number-of-occurrences` and `distribute-candies`

## Beliefs

- `pairs-iff-even-counts` — An array can be divided into equal pairs if and only if every distinct element has an even frequency
- `counter-solution-linear-time` — The solution runs in O(n) time and O(k) space where k is the number of distinct values
- `all-short-circuits-on-odd` — `all()` returns `False` as soon as it encounters the first element with an odd count, without checking remaining counts
- `no-input-validation` — The solution does not validate that `len(nums)` is even; it relies on the LeetCode constraint

