# File: maximum-number-of-pairs-in-array/solution.py

**Date:** 2026-06-06
**Time:** 17:39

## `maximum-number-of-pairs-in-array/solution.py`

### Purpose

This file solves [LeetCode 2341 — Maximum Number of Pairs in Array](https://leetcode.com/problems/maximum-number-of-pairs-in-array/). Given an array of integers, it counts how many pairs of equal values can be formed and how many elements are left over. It exports a single function that serves as the solution entry point.

### Key Components

**`count_pairs_leftovers(nums: list[int]) -> list[int]`** — The sole function. Takes a list of integers, returns a two-element list `[pairs, leftovers]` where `pairs` is the total number of matching pairs and `leftovers` is the count of unmatched elements.

The contract: every element in `nums` is accounted for exactly once — either as part of a pair or as a leftover. This means `pairs * 2 + leftovers == len(nums)` always holds.

### Patterns

**Frequency counting via `Counter`** — Rather than simulating the pair-removal process described in the problem (repeatedly find two equal elements and remove them), the solution jumps straight to the closed-form answer: for any value appearing `c` times, it contributes `c // 2` pairs and `c % 2` leftovers. This is the standard idiom for "count pairs" problems — avoid simulation, count frequencies, do integer division.

**Accumulator loop** — The function accumulates `pairs` and `leftovers` independently across all frequency values. No intermediate data structures beyond the `Counter`.

### Dependencies

**Imports:** `collections.Counter` — the only dependency. No custom data structures or helpers.

**Imported by:** The corresponding `maximum-number-of-pairs-in-array/test_solution.py`. The large "Imported By" list in the provided context is an artifact of the repo's test infrastructure — those test files import a shared test runner or utility, not this solution directly.

### Flow

1. `Counter(nums)` builds a frequency map in O(n).
2. The loop iterates over each unique value's count — O(k) where k is the number of distinct values.
3. Integer division (`// 2`) extracts pairs; modulo (`% 2`) extracts leftovers.
4. Returns the accumulated `[pairs, leftovers]`.

Total: O(n) time, O(k) space.

### Invariants

- **Conservation:** `pairs * 2 + leftovers == len(nums)` — every element is either paired or left over.
- **Leftover per value is 0 or 1:** Since `count % 2` is always 0 or 1, `leftovers` equals the number of values with odd frequency.
- **Non-negative outputs:** Both `pairs` and `leftovers` are always >= 0.

### Error Handling

None. The function trusts its input — no validation of types, empty lists, or negative values. An empty `nums` returns `[0, 0]` naturally since `Counter({}).values()` is empty and the accumulators start at zero.

---

## Topics to Explore

- [file] `maximum-number-of-pairs-in-array/test_solution.py` — See what edge cases are tested (empty array, all identical, all unique)
- [file] `divide-array-into-equal-pairs/solution.py` — Related problem that also uses frequency parity to determine if the array can be fully paired
- [function] `number-of-good-pairs/solution.py:count_good_pairs` — Similar frequency-counting pattern but computes C(n,2) = n*(n-1)/2 per value instead of n//2
- [general] `counter-based-solutions` — Across this repo, `Counter` is the dominant tool for pair/frequency problems — compare how different problems extract different information from the same frequency map

## Beliefs

- `pairs-leftovers-conservation` — `count_pairs_leftovers` guarantees `pairs * 2 + leftovers == len(nums)` for any input list
- `leftovers-equals-odd-frequency-count` — The returned `leftovers` value equals the number of distinct values in `nums` that appear an odd number of times
- `empty-input-returns-zeros` — Passing an empty list returns `[0, 0]` without error, as a natural consequence of the accumulator initialization
- `linear-time-no-simulation` — The solution avoids the O(n^2) simulation described in the problem statement and runs in O(n) via frequency counting

