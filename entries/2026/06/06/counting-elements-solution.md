# File: counting-elements/solution.py

**Date:** 2026-06-06
**Time:** 16:07

## `counting-elements/solution.py`

### Purpose

This file solves LeetCode problem "Counting Elements" (problem 1426). It owns exactly one responsibility: given an array of integers, count how many elements `x` have `x + 1` also present in the array. It's one of ~500+ solution files in the `leetcode-implementations` repo, each solving a single problem behind a uniform interface.

### Key Components

**`count_elements(arr: list[int]) -> int`** — The sole public function. Contract: accepts a list of integers, returns the count of elements whose immediate successor exists anywhere in the array. Duplicates are counted independently — if `arr = [1, 1, 2]`, both `1`s contribute to the count because `2` exists.

### Patterns

**Set-based lookup**: The solution converts the array to a set once (`O(n)` space), then iterates the original array checking membership (`O(1)` per check). This is the canonical "trade space for time" idiom for existence queries — total `O(n)` time and space.

**Generator expression with `sum`**: `sum(1 for x in arr if x + 1 in s)` is a Python idiom for conditional counting. It's equivalent to `len([x for x in arr if x + 1 in s])` but avoids materializing the intermediate list.

**Iterating `arr`, not `s`**: This is deliberate. The iteration is over the original list, not the set, so duplicate values are counted multiple times. For `[1, 1, 2]`, iterating the set would yield 1 (just the element `1`), but iterating the list correctly yields 2.

### Dependencies

**Imports**: None — pure standard library, no external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files across the entire repo that import their *own* `solution.py`, not this one. The actual dependent is `counting-elements/test_solution.py`, which imports `count_elements` to verify it.

### Flow

1. Build a set `s` from `arr` — deduplicates values for O(1) lookups.
2. Iterate every element `x` in the original `arr`.
3. For each `x`, check if `x + 1` is in `s`.
4. Sum the count of elements passing the check.

Single-pass over `arr` after the set construction. No mutation of input.

### Invariants

- The function never modifies `arr`.
- Every element in `arr` is evaluated independently — the count reflects multiplicity, not distinct values.
- The successor check is strict: only `x + 1`, not `x - 1` or any other neighbor.

### Error Handling

None. The function assumes valid input per the LeetCode contract (list of integers). An empty list returns 0 naturally since the generator produces nothing. No explicit validation, no exceptions raised.

## Topics to Explore

- [file] `counting-elements/test_solution.py` — See the edge cases tested (empty array, all duplicates, no successors)
- [file] `counting-elements/review.md` — Review notes on this solution's approach and alternatives
- [function] `two-sum/solution.py:twoSum` — Another set/hash-based lookup pattern for comparison
- [general] `set-vs-sort-for-existence` — When sorting + binary search beats set construction (e.g., memory-constrained scenarios)
- [file] `counting-elements/plan.md` — The problem decomposition that led to the set-based approach

## Beliefs

- `counting-elements-counts-with-multiplicity` — `count_elements` counts each array element independently; duplicates contribute separately to the total (iterates `arr`, not the set).
- `counting-elements-linear-complexity` — The solution runs in O(n) time and O(n) space via a single set construction and one pass over the input.
- `counting-elements-no-mutation` — The function never modifies the input list; the set is a separate allocation.
- `counting-elements-successor-only` — The check is strictly `x + 1 in s`; predecessor existence (`x - 1`) does not contribute to the count.

