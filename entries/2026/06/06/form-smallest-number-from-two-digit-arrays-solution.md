# File: form-smallest-number-from-two-digit-arrays/solution.py

**Date:** 2026-06-06
**Time:** 16:54

## `form-smallest-number-from-two-digit-arrays/solution.py`

### Purpose

This file solves [LeetCode 2605: Form Smallest Number From Two Digit Arrays](https://leetcode.com/problems/form-smallest-number-from-two-digit-arrays/). Given two arrays of unique single digits (1-9), it finds the smallest integer that contains at least one digit from each array. The file is self-contained: solution function + inline unit tests.

### Key Components

**`smallest_number_with_at_least_one_digit_from_each_array(nums1, nums2) -> int`** — The core solver. It handles two distinct cases:

1. **Common digit exists**: If the arrays share any digit, the answer is simply the smallest shared digit (a single-digit number always beats a two-digit number).
2. **No common digit**: The answer is a two-digit number formed from the minimum of each array, with the smaller digit in the tens place.

**`TestSmallestNumber`** — Seven test cases covering the key partitions: no common digit, common digit, single-element arrays, ordering when the smaller minimum is in `nums2`, multiple common digits, and fully overlapping arrays.

### Patterns

- **Set intersection for common-element detection** — `set(nums1) & set(nums2)` is the idiomatic Python approach, O(n+m).
- **Greedy construction** — When no common digit exists, the two-digit number is built by placing `min(a, b)` in the tens place and `max(a, b)` in the ones place: `min(a,b) * 10 + max(a,b)`.
- **Inline tests** — Tests live in the same file as the solution rather than in a separate test module, with `unittest.main()` guarded by `__name__`.

### Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The `test_solution.py` file in the same directory, plus hundreds of other test files across the repo import `unittest` (the "Imported By" list in the prompt is actually listing files that import `unittest`, not this solution directly).

### Flow

1. Compute the set intersection of `nums1` and `nums2`.
2. If non-empty, return `min(common)` — the smallest shared digit.
3. Otherwise, find `a = min(nums1)` and `b = min(nums2)`.
4. Return the two-digit number `min(a,b) * 10 + max(a,b)`.

The entire function is branchless after the initial `if` — no loops beyond what `min()` and set operations do internally.

### Invariants

- **Digits are 1-9** — The problem guarantees no zeros, so `min(a,b) * 10 + max(a,b)` always produces a valid two-digit number (11-99). A zero in either array would break the tens-place assumption.
- **Uniqueness within each array** — Each array contains unique digits, so set conversion is lossless.
- **Common digit always wins** — Any single-digit number (1-9) is smaller than any two-digit number (11-99), so checking for a common digit first is correct and sufficient.

### Error Handling

None. The function trusts its inputs match the problem constraints (non-empty arrays of unique digits 1-9). Empty arrays would cause `min()` to raise `ValueError`.

---

## Topics to Explore

- [file] `form-smallest-number-from-two-digit-arrays/test_solution.py` — How the separate test file imports and exercises this solution
- [file] `form-smallest-number-from-two-digit-arrays/plan.md` — The problem decomposition and approach reasoning before implementation
- [function] `intersection-of-two-arrays/solution.py:intersection` — Another set-intersection problem for comparison of approach
- [general] `greedy-digit-construction` — The pattern of building optimal numbers digit-by-digit appears in several problems (e.g., `split-with-minimum-sum`, `minimum-sum-of-four-digit-number-after-splitting-digits`)
- [file] `form-smallest-number-from-two-digit-arrays/review.md` — Code review notes on this solution's correctness and style

## Beliefs

- `common-digit-always-optimal` — When both arrays share a digit, the answer is always that single shared digit, because any single-digit value (1-9) is less than any two-digit value (11-99)
- `no-zero-invariant` — The solution assumes digits are 1-9; a zero in either array would produce an incorrect result (e.g., `min(0,5)*10 + max(0,5) = 5` instead of the two-digit number `50`)
- `two-digit-construction-is-commutative` — The `min(a,b)*10 + max(a,b)` formula produces the same result regardless of which array contributes the smaller minimum
- `set-intersection-dominates-runtime` — The function runs in O(n+m) time where n and m are array lengths, dominated by the set construction and intersection

