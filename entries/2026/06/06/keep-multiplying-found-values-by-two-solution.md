# File: keep-multiplying-found-values-by-two/solution.py

**Date:** 2026-06-06
**Time:** 17:10

## Purpose

This file solves [LeetCode 2154: Keep Multiplying Found Values by Two](https://leetcode.com/problems/keep-multiplying-found-values-by-two/). It owns a single responsibility: given an array of integers and a starting value, repeatedly double the value as long as it exists in the array, then return the final result.

## Key Components

### `find_final_value(nums, original) -> int`

The sole public function. Contract:

- **Input**: `nums` (list of ints), `original` (int starting value)
- **Output**: The value of `original` after doubling it every time it appears in `nums`
- **Mutation**: None — `nums` is not modified (a separate set is built)

## Patterns

**Set-based lookup optimization.** The list is converted to a `set` on line 12 before the search loop. This is the standard idiom in this repo for turning repeated O(n) membership checks into O(1) amortized lookups. Without it, the while loop would scan the full list on every iteration.

**In-place accumulation.** Rather than introducing a new variable, the function mutates the `original` parameter directly (`original *= 2`). This is idiomatic Python for simple accumulator patterns where the parameter name still reads clearly.

## Dependencies

**Imports**: None — pure stdlib, no external or internal dependencies.

**Imported by**: The `test_solution.py` in the same directory imports `find_final_value`. The massive "Imported By" list in the prompt is misleading — those are *other* problems' test files, likely an artifact of the analysis tool picking up a shared test harness or runner, not direct imports of this function.

## Flow

1. Build `num_set` from `nums` — O(n) time, O(n) space.
2. Enter a while loop: if `original` is in `num_set`, double it.
3. The loop terminates when `original` is no longer in the set.
4. Return the final value.

The key insight is that `original` only ever increases (doubles), and the set is finite, so the loop **always terminates**. In the worst case, `original` doubles at most O(log(max(nums))) times before exceeding every element in the set.

## Invariants

- **Termination guarantee**: Since `original` strictly increases each iteration and the set is fixed and finite, the loop must terminate.
- **No duplicates matter**: Converting to a set discards duplicate values, but duplicates are irrelevant — the problem only asks whether the current value *exists* in the array, not how many times.

## Error Handling

None. The function assumes valid inputs per LeetCode constraints (non-empty list, positive integers). No validation, no exceptions raised.

## Topics to Explore

- [file] `keep-multiplying-found-values-by-two/test_solution.py` — See which edge cases are covered (e.g., original not in nums, original at max value)
- [file] `keep-multiplying-found-values-by-two/review.md` — Read the code review for any noted improvements or alternative approaches
- [general] `set-vs-sort-for-repeated-lookup` — Compare this set-based O(n) approach against sorting the array first and doing binary search, which trades space for a different time profile
- [function] `counting-elements/solution.py:countElements` — Another solution that uses the same set-membership-in-a-loop pattern for a closely related problem

## Beliefs

- `set-lookup-guarantees-linear-preprocessing` — `find_final_value` builds the set once in O(n) and performs each membership test in O(1), making the total complexity O(n + log(max(nums)))
- `doubling-loop-always-terminates` — The while loop terminates because `original` strictly increases on every iteration and the set has a finite maximum value
- `no-mutation-of-input` — The input list `nums` is never modified; a separate `set` is constructed for lookups
- `duplicates-are-irrelevant` — Converting `nums` to a set loses count information, which is correct because the problem only cares about existence, not frequency

