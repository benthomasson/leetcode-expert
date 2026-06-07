# File: count-equal-and-divisible-pairs-in-an-array/solution.py

**Date:** 2026-06-06
**Time:** 15:57

## Purpose

This file solves [LeetCode 2176: Count Equal and Divisible Pairs in an Array](https://leetcode.com/problems/count-equal-and-divisible-pairs-in-an-array/). It counts pairs of indices `(i, j)` where `i < j`, the elements at those indices are equal, and the product `i * j` is divisible by `k`. It follows the repo's standard layout: a `Solution` class with the LeetCode method signature, plus a module-level wrapper function.

## Key Components

**`Solution.countPairs(nums, k) -> int`** — The core algorithm. Takes a list of integers and a divisor `k`, returns the count of valid `(i, j)` pairs. The pair validity requires two conditions simultaneously: `nums[i] == nums[j]` and `(i * j) % k == 0`.

**`min_months(nums, k) -> int`** — A thin wrapper that delegates to `Solution().countPairs`. The name `min_months` is a misnomer — it doesn't relate to the problem semantics. This is likely an artifact of the code generation pipeline that assigns wrapper names, and the test harness imports through it.

## Patterns

- **Brute-force enumeration**: The solution uses the canonical O(n²) nested loop over all `(i, j)` pairs with `i < j`. For this problem's constraints (n ≤ 100), this is the expected approach — there's no need for a more clever solution.
- **LeetCode class convention**: The `Solution` class with typed method signature matches LeetCode's submission format.
- **Wrapper function pattern**: The `min_months` function adapts the class-based interface to a plain function call, consistent with how the repo's test infrastructure invokes solutions.

## Dependencies

**Imports**: Only `typing.List` — no external libraries, no project-internal imports. This is typical for LeetCode solutions that are self-contained.

**Imported by**: The `Imported By` list in the provided context is misleading — it lists hundreds of test files from *other* problems. This is almost certainly a tooling artifact (e.g., a shared test runner or import resolution that traces `from typing import List` globally). The real dependent is `count-equal-and-divisible-pairs-in-an-array/test_solution.py`, which imports `min_months` or `Solution` to run tests.

## Flow

1. Initialize `count = 0` and get array length `n`.
2. Outer loop: `i` from `0` to `n-1`.
3. Inner loop: `j` from `i+1` to `n-1` — ensures `i < j` without double-counting.
4. For each pair, check both conditions with short-circuit `and`: value equality first (cheap comparison), then divisibility of the index product.
5. Increment `count` when both hold. Return the total.

The value-equality check before the modulo is a minor optimization — if the values differ, the modulo is never computed.

## Invariants

- The loop structure guarantees `i < j` for every tested pair, satisfying the problem's strict ordering requirement.
- Every pair is tested exactly once — no duplicates, no missed pairs.
- The algorithm is deterministic with O(n²) time and O(1) space.

## Error Handling

None. The function assumes valid inputs per LeetCode constraints (1 ≤ n ≤ 100, 1 ≤ k). No bounds checking, no input validation. An empty `nums` list would return 0 correctly since neither loop body executes.

## Topics to Explore

- [file] `count-equal-and-divisible-pairs-in-an-array/test_solution.py` — See what test cases exercise this solution and whether edge cases (single element, all equal, k=1) are covered
- [file] `count-equal-and-divisible-pairs-in-an-array/review.md` — Check if the review flagged the `min_months` naming issue or suggested optimizations
- [general] `grouping-by-value-optimization` — A HashMap grouping equal values could reduce to O(n + Σ(gᵢ²)) where gᵢ is group size, skipping pairs with different values entirely
- [function] `number-of-good-pairs/solution.py:countPairs` — Similar pair-counting pattern without the divisibility constraint, useful comparison

## Beliefs

- `brute-force-is-optimal-for-constraints` — With n ≤ 100, the O(n²) brute force checks at most 4,950 pairs, well within time limits; no algorithmic optimization is necessary
- `wrapper-name-mismatch` — The `min_months` wrapper name has no semantic relationship to the "count equal and divisible pairs" problem, suggesting automated generation rather than manual authoring
- `loop-ordering-guarantees-no-duplicates` — The `j in range(i + 1, n)` inner loop ensures each unordered pair is visited exactly once and `i < j` is always satisfied
- `value-check-short-circuits-modulo` — Python's `and` short-circuits, so the `(i * j) % k == 0` modulo is only evaluated when `nums[i] == nums[j]`

