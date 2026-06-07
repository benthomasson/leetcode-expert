# File: partition-array-into-three-parts-with-equal-sum/solution.py

**Date:** 2026-06-06
**Time:** 18:28

## Partition Array Into Three Parts With Equal Sum

### Purpose

This file solves [LeetCode 1013](https://leetcode.com/problems/partition-array-into-three-parts-with-equal-sum/). It determines whether an integer array can be split into three contiguous, non-empty subarrays that each sum to the same value. It's a single-class, single-method solution following the standard LeetCode `Solution` class convention used across this repository.

### Key Components

**`Solution.canThreePartsEqualSum(self, arr: List[int]) -> bool`**

The only method. Contract: given a list of integers, return `True` iff there exist indices `i < j` such that `arr[0:i+1]`, `arr[i+1:j+1]`, and `arr[j+1:]` all have the same sum.

### Patterns

**Prefix-sum with early exit.** Rather than materializing a prefix-sum array, the code maintains a running sum and checks whether it has hit `target`, then `2 * target`. This is O(n) time, O(1) space — a greedy single-pass approach.

The key insight: if the total is `S` and divisible by 3, then `target = S/3`. The code scans left-to-right accumulating `running_sum`. When `running_sum == target`, that's the end of part 1. When `running_sum == 2 * target`, that's the end of part 2, and everything remaining is part 3. The check `running_sum == target * (parts_found + 1)` elegantly unifies both boundary checks into one expression.

### Dependencies

**Imports:** Only `typing.List` — no external or project dependencies.

**Imported by:** `partition-array-into-three-parts-with-equal-sum/test_solution.py` (the "Imported By" list in the prompt is the full test suite across the repo, which all share a common test runner pattern, not actual imports of this specific module).

### Flow

1. Compute `total = sum(arr)`. If not divisible by 3, return `False` immediately.
2. Set `target = total // 3`. Initialize `running_sum = 0`, `parts_found = 0`.
3. Iterate indices `0` through `len(arr) - 2` (inclusive). The upper bound ensures the third partition is non-empty.
4. Accumulate `running_sum += arr[i]`. When `running_sum` equals `target * (parts_found + 1)`, increment `parts_found`.
5. If `parts_found` reaches 2, return `True` — the remaining elements form the third part.
6. If the loop completes without finding 2 partition boundaries, return `False`.

### Invariants

- **Divisibility guard:** The total must be divisible by 3; otherwise no valid partition exists.
- **Non-empty parts:** The loop stops at `len(arr) - 2` (i.e., `range(len(arr) - 1)`), guaranteeing at least one element remains for the third partition after finding two boundaries.
- **Cumulative boundary check:** `running_sum == target * (parts_found + 1)` only fires in order — part 1's boundary at `target`, then part 2's boundary at `2 * target`. This works because `parts_found` increments sequentially.

### Error Handling

None. The method assumes valid input per the LeetCode contract (non-empty array of integers). No exceptions are raised or caught.

### Subtle point

When `total == 0`, `target == 0`. The cumulative check still works: it finds the first prefix summing to 0 (part 1), then the first prefix summing to 0 again (part 2). The remaining elements must also sum to 0 since the total is 0. The `range(len(arr) - 1)` bound still correctly ensures part 3 is non-empty.

---

## Topics to Explore

- [file] `partition-array-into-three-parts-with-equal-sum/test_solution.py` — See which edge cases are covered (zero-sum arrays, negative numbers, minimal-length arrays)
- [function] `find-pivot-index/solution.py:pivotIndex` — Another prefix-sum problem; compare how running sums are used to find partition points
- [file] `partition-array-into-three-parts-with-equal-sum/review.md` — Review notes may document known edge cases or alternative approaches considered
- [general] `greedy-prefix-sum-pattern` — This pattern of scanning a prefix sum for sequential thresholds appears in several partition/subarray-sum problems across the repo

## Beliefs

- `three-parts-divisibility-precondition` — The method returns False immediately when the array sum is not divisible by 3, before scanning any elements
- `three-parts-nonempty-guarantee` — The loop bound `range(len(arr) - 1)` ensures the third partition always contains at least one element when True is returned
- `three-parts-linear-complexity` — The algorithm performs exactly one pass over the array after the initial sum, achieving O(n) time and O(1) auxiliary space
- `three-parts-cumulative-boundary` — Partition boundaries are detected via `running_sum == target * (parts_found + 1)`, which relies on parts_found incrementing sequentially from 0 to 1 to 2

