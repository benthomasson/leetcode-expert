# File: special-array-with-x-elements-greater-than-or-equal-x/solution.py

**Date:** 2026-06-06
**Time:** 19:13

## Purpose

This file solves [LeetCode 1608: Special Array With X Elements Greater Than or Equal to X](https://leetcode.com/problems/special-array-with-x-elements-greater-than-or-equal-to-x/). It determines whether there exists a value `x` such that exactly `x` elements in the array are greater than or equal to `x`. If such a value exists, it returns `x`; otherwise it returns `-1`.

It follows the repo's convention: one `solution.py` per problem directory, exporting a single function matching the LeetCode signature.

## Key Components

### `specialArray(nums: list[int]) -> int`

**Contract**: Given a list of non-negative integers, return the unique special value `x` or `-1` if none exists.

The function uses a **sort-then-scan** approach rather than brute-force counting:

1. **Sort descending** — `nums.sort(reverse=True)` places the largest values first.
2. **Iterate candidate values** — `x` ranges from `1` to `n` (inclusive). For each `x`, the element at index `x-1` is the `x`-th largest value.
3. **Two-condition check**:
   - `nums[x - 1] >= x` — the `x`-th largest element is at least `x`, so at least `x` elements are `>= x`.
   - `x == n or nums[x] < x` — either we've exhausted the array (all `n` elements qualify), or the `(x+1)`-th largest element is strictly less than `x`, so *exactly* `x` elements qualify (not more).

## Patterns

- **Sorted-array positional reasoning**: Instead of counting `>= x` elements for each candidate (O(n) per candidate), sorting once lets you read the count from index position. The `x`-th element in descending order tells you whether at least `x` values meet the threshold.
- **Boundary guard with short-circuit**: The `x == n` check prevents an out-of-bounds access on `nums[x]` when `x` equals the array length.

## Dependencies

**Imports**: None — pure stdlib, no external dependencies.

**Imported by**: The corresponding `test_solution.py` in the same directory. The "Imported By" list in the prompt is misleading — those are test files for *other* problems that share a common test harness importing from their own `solution.py`, not from this file.

## Flow

```
Input: [3, 5]

1. Sort descending:  [5, 3]
2. x=1: nums[0]=5 >= 1 ✓, nums[1]=3 >= 1 → not < 1 ✗ → skip
3. x=2: nums[1]=3 >= 2 ✓, x==n (2==2) ✓ → return 2

Output: 2
```

The key insight: after descending sort, `nums[x-1] >= x` means "the x-th largest value is big enough," and `nums[x] < x` means "the (x+1)-th largest value is too small," so exactly `x` values qualify.

## Invariants

- **x is bounded by [1, n]**: A special value of 0 would mean zero elements are `>= 0`, which is impossible for non-negative inputs. A value above `n` is impossible since the array only has `n` elements.
- **At most one special value exists**: The problem guarantees uniqueness if it exists — the function returns the first match found.
- **In-place mutation**: The input list is sorted in place. Callers should be aware their list is modified.

## Error Handling

None. The function assumes valid input per LeetCode constraints (non-negative integers, non-empty list). Returns `-1` as the "not found" sentinel — no exceptions are raised.

## Topics to Explore

- [file] `special-array-with-x-elements-greater-than-or-equal-x/test_solution.py` — See the edge cases being tested (empty-ish arrays, all-same values, no valid x)
- [file] `special-array-with-x-elements-greater-than-or-equal-x/plan.md` — The planning document showing how the approach was chosen
- [general] `sort-then-index-pattern` — Several solutions in this repo use descending sort + index reasoning (e.g., `find-subsequence-of-length-k-with-the-largest-sum`, `height-checker`) — worth comparing approaches
- [function] `special-array-with-x-elements-greater-than-or-equal-x/solution.py:specialArray` — Consider the alternative O(n) counting-sort approach that avoids sorting entirely

## Beliefs

- `special-array-sorts-descending` — The solution sorts the input array in descending order in-place, mutating the caller's list
- `special-array-time-complexity` — The algorithm runs in O(n log n) time, dominated by the sort; the scan is O(n)
- `special-array-boundary-guard` — The `x == n` check on line 9 prevents index-out-of-bounds when x equals the array length
- `special-array-no-zero-candidate` — The candidate range starts at 1, not 0, because x=0 is impossible for arrays of non-negative integers

