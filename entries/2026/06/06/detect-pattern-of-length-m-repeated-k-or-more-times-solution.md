# File: detect-pattern-of-length-m-repeated-k-or-more-times/solution.py

**Date:** 2026-06-06
**Time:** 16:20

## Purpose

This file solves [LeetCode 1566: Detect Pattern of Length M Repeated K or More Times](https://leetcode.com/problems/detect-pattern-of-length-m-repeated-k-or-more-times/). It determines whether any contiguous subarray of length `m` appears `k` or more times consecutively in the input array. It's a standalone solution module following the repo's convention of one problem per directory.

## Key Components

**`contains_pattern(arr, m, k) -> bool`** — The sole function. It takes an integer array, a pattern length `m`, and a repetition count `k`, returning `True` if any length-`m` subarray repeats `k+` times back-to-back.

The contract is straightforward: given valid inputs per the LeetCode constraints (1 <= m*k <= len(arr)), it returns a boolean. No mutation of inputs.

## Patterns

**Brute-force enumeration with slice comparison.** The function tries every possible starting index `i` as the beginning of a repeating pattern, extracts the candidate `pattern = arr[i:i+m]`, then checks whether the next `k-1` consecutive blocks of length `m` are identical via `all()` with a generator.

This is idiomatic Python — using list slicing for pattern extraction and `all()` for short-circuit evaluation. No need for hashing or more complex string-matching algorithms given the problem's small constraints (array length <= 100).

## Dependencies

**Imports:** Only `typing.List` for the type annotation — no external dependencies.

**Imported by:** The massive `Imported By` list is misleading — it reflects test files across the entire repo importing from a shared test harness or common structure, not direct imports of `contains_pattern`. The actual consumer is `detect-pattern-of-length-m-repeated-k-or-more-times/test_solution.py`.

## Flow

1. Compute `n = len(arr)`.
2. Iterate `i` from `0` to `n - m*k` inclusive — this is the last valid start index where `k` repetitions of length `m` could fit.
3. Extract `pattern = arr[i:i+m]`.
4. For each `j` in `range(1, k)`, compare `arr[i + j*m : i + j*m + m]` against `pattern`.
5. `all()` short-circuits on the first mismatch. If all `k-1` subsequent blocks match, return `True`.
6. If no starting index yields a match, return `False`.

The outer loop runs at most `n - m*k + 1` iterations. The inner generator runs at most `k-1` comparisons, each comparing `m` elements. Worst case: O(n * m * k), which is fine for n <= 100.

## Invariants

- The loop bound `n - m * k + 1` ensures every slice `arr[i + j*m : i + j*m + m]` stays within bounds for all `j` in `[0, k)`.
- The comparison starts at `j=1` (not `j=0`), since `j=0` is the pattern itself — comparing it to itself would be redundant.
- List slice equality (`==`) in Python does element-wise comparison, so this works correctly for integer arrays.

## Error Handling

None. The function trusts its caller to provide valid inputs per LeetCode constraints. If `m * k > n`, the `range` in the outer loop is empty and the function returns `False` — a graceful no-op rather than an error.

## Topics to Explore

- [file] `detect-pattern-of-length-m-repeated-k-or-more-times/test_solution.py` — See the test cases and edge cases exercised against this solution
- [file] `detect-pattern-of-length-m-repeated-k-or-more-times/review.md` — Code review notes that may flag alternative approaches or complexity analysis
- [function] `consecutive-characters/solution.py:maxPower` — A related pattern-detection problem that counts max consecutive identical elements rather than repeated subarrays
- [general] `sliding-window-vs-brute-force` — Whether a rolling-hash or sliding-window approach could improve this to O(n) for larger constraints

## Beliefs

- `contains-pattern-brute-force-complexity` — `contains_pattern` runs in O(n * m * k) time worst-case, acceptable for the constraint n <= 100
- `contains-pattern-bounds-safe` — The loop bound `n - m * k + 1` guarantees all array slices are within bounds without explicit bounds checking
- `contains-pattern-short-circuits` — The `all()` generator short-circuits on the first non-matching block, avoiding unnecessary comparisons for non-repeating patterns
- `contains-pattern-no-mutation` — The function is pure: it reads `arr` via slicing and never modifies it

