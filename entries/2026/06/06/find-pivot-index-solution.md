# File: find-pivot-index/solution.py

**Date:** 2026-06-06
**Time:** 16:40

## Purpose

This file implements the solution to [LeetCode 724 - Find Pivot Index](https://leetcode.com/problems/find-pivot-index/). It finds the leftmost index in an array where the sum of elements to the left equals the sum of elements to the right. The pivot element itself is excluded from both sums.

## Key Components

**`Solution.pivotIndex(nums: List[int]) -> int`** — The sole method. Takes an integer array and returns the leftmost pivot index, or `-1` if no pivot exists.

## Patterns

**Prefix sum with running accumulator.** Rather than computing left and right sums from scratch at each index (which would be O(n^2)), the solution precomputes `total = sum(nums)` once, then maintains a running `left_sum`. At each index `i`, the right sum is derived algebraically:

```
right_sum = total - left_sum - nums[i]
```

This avoids a second pass or auxiliary array. The check `left_sum == total - left_sum - num` is equivalent to `left_sum == right_sum`. After checking, `left_sum` is updated by adding `num` — the order matters because the pivot element must be excluded from both sides.

This is the canonical single-pass prefix sum pattern: O(n) time, O(1) space.

## Dependencies

**Imports:** Only `typing.List` for the type annotation — no external or project dependencies.

**Imported by:** The `find-pivot-index/test_solution.py` file. The massive "Imported By" list in the prompt is an artifact of shared test infrastructure across the repo, not direct consumers of this solution.

## Flow

1. Compute `total` — the sum of all elements.
2. Initialize `left_sum = 0`.
3. Iterate with `enumerate(nums)`:
   - Check if `left_sum == total - left_sum - num` (left sum equals right sum).
   - If yes, return `i` immediately (guarantees *leftmost*).
   - Otherwise, add `num` to `left_sum`.
4. If the loop completes without returning, return `-1`.

## Invariants

- **Left-sum accumulation happens after the check.** This ensures `nums[i]` is excluded from both the left and right sums when comparing.
- **First match wins.** The early return on the first valid index satisfies the "leftmost pivot" requirement.
- **Empty left/right sums are implicitly zero.** When `i == 0`, `left_sum` is 0 (the sum of nothing). When `i == len(nums) - 1`, `total - left_sum - num` is 0 if all preceding elements sum to `left_sum`. This handles edge cases at both array boundaries without special-casing.

## Error Handling

None. The method assumes a valid list of integers per LeetCode constraints. It returns `-1` as the sentinel for "no pivot found" — the standard LeetCode convention. An empty list would simply skip the loop and return `-1`.

## Topics to Explore

- [file] `find-pivot-index/test_solution.py` — Test cases that validate edge behavior (single-element arrays, all-zero arrays, negative numbers)
- [file] `find-pivot-index/plan.md` — Planning notes showing how the approach was chosen
- [file] `find-the-highest-altitude/solution.py` — Another prefix-sum problem in this repo; compare how the same pattern is adapted
- [general] `prefix-sum-vs-two-pointer` — When to use running prefix sums versus two-pointer approaches for array balance problems
- [file] `left-and-right-sum-differences/solution.py` — A related problem that also decomposes arrays into left/right sums

## Beliefs

- `pivot-index-single-pass` — `pivotIndex` solves the problem in a single pass with O(1) extra space by deriving right sum from total and left sum
- `pivot-index-leftmost-guarantee` — The early return on first match guarantees the leftmost pivot index is returned, not just any valid one
- `pivot-index-boundary-handling` — Index 0 and index n-1 are valid pivot positions without special-case code because `left_sum` starts at 0 and right sum is computed algebraically
- `pivot-index-accumulate-after-check` — `left_sum += num` occurs after the equality check, ensuring the pivot element is excluded from both sums

