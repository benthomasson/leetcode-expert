# File: two-sum-less-than-k/solution.py

**Date:** 2026-06-06
**Time:** 19:34

## `two-sum-less-than-k/solution.py`

### Purpose

This file solves [LeetCode 1099 — Two Sum Less Than K](https://leetcode.com/problems/two-sum-less-than-k/). Given an array of positive integers and a threshold `k`, it finds the maximum sum of any two distinct-index elements that is strictly less than `k`. It returns `-1` if no valid pair exists.

This is the canonical solution file for this problem in the `leetcode-implementations` repo — one of hundreds of problem directories that each contain a `solution.py`, `test_solution.py`, and optionally `plan.md`/`review.md`.

### Key Components

**`max_sum_under_k(nums, k)`** — The single exported function. Contract:
- **Input**: `nums` (list of positive ints), `k` (int, exclusive upper bound)
- **Output**: int — the largest `nums[i] + nums[j]` (where `i != j`) that is `< k`, or `-1` if none exists
- **Side effect**: mutates `nums` via in-place sort

### Patterns

**Sort + two-pointer squeeze** — the classic O(n log n) approach for optimizing over pairs with a sum constraint. After sorting, the left pointer starts at the smallest element and the right at the largest. The two pointers converge based on whether the current pair sum is under or over the threshold. This avoids the O(n^2) brute-force scan.

The pattern is the same one used in the original Two Sum II (sorted input) problem, adapted to maximize a sum below a ceiling rather than find an exact target.

### Dependencies

**Imports**: None — pure stdlib Python, no external or internal imports.

**Imported by**: The `test_solution.py` files listed in the "Imported By" section are an artifact of the test runner's shared infrastructure — they don't actually import this specific solution. Only `two-sum-less-than-k/test_solution.py` directly imports and tests `max_sum_under_k`.

### Flow

1. **Sort** `nums` in-place (ascending). This is the precondition for the two-pointer technique.
2. **Initialize** `left = 0`, `right = len(nums) - 1`, `result = -1`.
3. **Loop** while `left < right`:
   - Compute `s = nums[left] + nums[right]`.
   - If `s < k`: this is a valid pair. Update `result` if `s` is larger, then advance `left` (try a bigger small element to see if we can get closer to `k`).
   - If `s >= k`: the sum is too large, so shrink by decrementing `right`.
4. **Return** `result` — either the best valid sum found, or `-1` if no pair qualified.

### Invariants

- **Pointer ordering**: `left < right` is maintained throughout — the function never considers a pair of the same index.
- **Monotonic convergence**: each iteration moves exactly one pointer inward, guaranteeing termination in at most `n - 1` steps.
- **Optimality**: when `s < k`, moving `left` right is correct because any pair with `right` decremented would produce a smaller sum (already dominated). When `s >= k`, decrementing `right` is correct because any pair with `left` incremented would produce an even larger sum.
- **`result` sentinel**: starts at `-1` and is only overwritten by valid sums, so the return value is correct even when no pair qualifies.

### Error Handling

None. The function assumes valid input per the LeetCode contract (at least 2 elements, positive integers). For edge cases like `len(nums) < 2`, the while loop simply never executes and `-1` is returned, which happens to be the correct answer. No exceptions are raised or caught.

### Complexity

- **Time**: O(n log n) dominated by the sort; the two-pointer scan is O(n).
- **Space**: O(1) auxiliary (sort is in-place in CPython's Timsort, ignoring its internal O(n) buffer).

## Topics to Explore

- [file] `two-sum/solution.py` — Compare with the classic Two Sum (exact target, hash map approach) to see how the problem variant changes the algorithm choice
- [file] `two-sum-iv-input-is-a-bst/solution.py` — Another Two Sum variant that operates on a BST instead of an array, showing how data structure choice affects the two-pointer pattern
- [general] `sort-then-two-pointer` — This pattern recurs across many solutions in this repo (e.g., `squares-of-a-sorted-array`, `two-furthest-houses-with-different-colors`); understanding when sorting enables O(n) scans is a key LeetCode skill
- [file] `two-sum-iii-data-structure-design/solution.py` — The design variant that must support repeated `add`/`find` calls, showing the time-space tradeoff when the two-pointer approach can't amortize sorting

## Beliefs

- `two-sum-less-than-k-sort-mutates` — `max_sum_under_k` mutates the input list via in-place sort; callers that need the original order must copy first
- `two-sum-less-than-k-returns-neg-one` — The function returns `-1` (not `None` or an exception) when no pair sum is strictly less than `k`
- `two-sum-less-than-k-strict-inequality` — The comparison is `s < k` (strict), not `s <= k`; a pair summing exactly to `k` is excluded
- `two-sum-less-than-k-time-complexity` — The algorithm runs in O(n log n) time and O(1) auxiliary space via sort + two-pointer

