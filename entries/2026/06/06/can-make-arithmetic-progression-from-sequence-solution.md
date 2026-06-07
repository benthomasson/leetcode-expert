# File: can-make-arithmetic-progression-from-sequence/solution.py

**Date:** 2026-06-06
**Time:** 15:30

## Purpose

This file solves [LeetCode 1502: Can Make Arithmetic Progression From Sequence](https://leetcode.com/problems/can-make-arithmetic-progression-from-sequence/). It determines whether a given list of integers can be rearranged into an arithmetic progression — a sequence where the difference between consecutive terms is constant.

It lives in the standard per-problem directory structure (`<problem-slug>/solution.py`) and exports a single function consumed by the co-located test file and, notably, by the test files of hundreds of other problems (see "Dependencies" below).

## Key Components

### `can_construct(arr: list[int]) -> bool`

The sole public function. Contract:

- **Input**: A list of at least 2 integers (per LeetCode constraints).
- **Output**: `True` if some permutation of `arr` forms an arithmetic progression, `False` otherwise.
- **Side effect**: Mutates `arr` in-place via `sort()`. Callers passing a list they still need in original order should pass a copy.

## Patterns

**Sort-then-scan**: The canonical O(n log n) approach for this problem. Sort the array so the only valid arithmetic progression arrangement is the sorted order itself, then verify the constant-difference property in a single linear pass. This avoids the O(n) math-based alternative (compute expected diff from min/max, check membership via a set) which requires handling duplicates and division edge cases.

**Early exit**: The loop returns `False` on the first violation, short-circuiting the scan.

## Dependencies

**Imports**: None — pure stdlib Python.

**Imported by**: The "Imported By" list in the prompt shows 400+ test files referencing this module. That's a repo-level artifact: the test harness likely imports every solution module uniformly (e.g., via a shared conftest or dynamic import pattern), not because those other problems depend on `can_construct` at runtime.

## Flow

1. `arr.sort()` — in-place ascending sort.
2. Compute `diff = arr[1] - arr[0]` — the expected common difference.
3. Iterate `i` from 2 to `len(arr) - 1`. For each element, check whether `arr[i] - arr[i-1] == diff`.
4. If any pair violates the constant difference, return `False` immediately.
5. If the loop completes, return `True`.

## Invariants

- **Sorted order is the only candidate**: After sorting, there is exactly one possible arithmetic progression arrangement (up to reversal, which doesn't affect difference-checking since reversal just negates the diff but consecutive differences remain equal in absolute terms — and here the sorted order forces a non-decreasing sequence, so the diff is fixed).
- **Length >= 2**: The function indexes `arr[0]` and `arr[1]` unconditionally. Arrays of length 0 or 1 would raise `IndexError`. The LeetCode constraint guarantees length >= 2.
- **All-equal arrays**: Handled correctly — diff is 0, and every consecutive pair also has difference 0.

## Error Handling

None. The function trusts its caller to provide a list of at least 2 integers, matching the LeetCode problem constraints. No try/except, no input validation. An empty list or single-element list would crash with `IndexError` at `arr[1] - arr[0]`.

## Topics to Explore

- [file] `can-make-arithmetic-progression-from-sequence/test_solution.py` — See the test cases and how `can_construct` is exercised, including edge cases
- [file] `missing-number-in-arithmetic-progression/solution.py` — A related problem that finds the missing element in an AP; likely uses a similar sort-then-scan pattern
- [file] `check-if-it-is-a-straight-line/solution.py` — Another "verify a mathematical property across a sequence" problem with analogous structure (constant slope instead of constant difference)
- [general] `o(n)-arithmetic-progression-check` — An alternative approach using `min`, `max`, and a `set` to verify AP membership in O(n) time without sorting
- [file] `run_tests.py` — Explains the cross-cutting test import pattern that causes 400+ test files to list this module as a dependency

## Beliefs

- `sort-then-linear-scan` — `can_construct` sorts the input then verifies constant consecutive difference in one pass, making it O(n log n) time and O(1) extra space (beyond the sort)
- `in-place-mutation` — `can_construct` mutates the input list via `arr.sort()` rather than creating a sorted copy
- `no-input-validation` — The function assumes `len(arr) >= 2` and will raise `IndexError` on shorter inputs
- `early-exit-on-violation` — The loop returns `False` on the first pair whose difference doesn't match `arr[1] - arr[0]`, avoiding unnecessary iteration

