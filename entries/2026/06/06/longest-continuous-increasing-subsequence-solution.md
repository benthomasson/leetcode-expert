# File: longest-continuous-increasing-subsequence/solution.py

**Date:** 2026-06-06
**Time:** 17:26

## Purpose

This file implements **LeetCode #674 — Longest Continuous Increasing Subsequence**. It solves the problem of finding the length of the longest strictly increasing contiguous subarray within a list of integers. It's one of hundreds of solution files in the `leetcode-implementations` repo, each following an identical structure: a `Solution` class with a single method matching the LeetCode interface.

## Key Components

**`Solution.findLengthOfLCIS(self, nums: List[int]) -> int`** — The only method. Takes a list of integers and returns the length of the longest contiguous run where each element is strictly greater than the previous one.

- **`max_len`**: Tracks the global best seen so far. Initialized to 1.
- **`cur_len`**: Tracks the length of the current increasing run. Reset to 1 whenever the streak breaks.

## Patterns

**Single-pass greedy scan** — This is the classic "extend or reset" pattern for contiguous subarray problems. You maintain a running counter for the current window, extend it when the condition holds, and reset it when it doesn't. The global max is updated inline during extension rather than at the end, which avoids a separate post-loop check.

The comparison `if cur_len > max_len` is done inside the `if` branch rather than unconditionally after the `else`. This is a micro-optimization: `max_len` only needs updating when `cur_len` grows, never when it resets to 1.

## Dependencies

**Imports**: `typing.List` — used only for the type annotation on `nums`.

**Imported by**: `longest-continuous-increasing-subsequence/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of how the repo's test harness resolves imports — those other test files don't actually depend on this solution.

## Flow

1. Initialize both `max_len` and `cur_len` to 1 (any non-empty array has at least a length-1 increasing run).
2. Iterate from index 1 through `len(nums) - 1`.
3. At each index, compare `nums[i]` to `nums[i-1]`:
   - **Strictly increasing**: increment `cur_len`, update `max_len` if `cur_len` exceeds it.
   - **Otherwise** (equal or decreasing): reset `cur_len` to 1.
4. Return `max_len`.

Time complexity: O(n). Space complexity: O(1).

## Invariants

- **Strictly increasing**: the condition is `>`, not `>=`. Equal adjacent elements break the streak.
- **Non-empty input assumed**: `max_len` and `cur_len` start at 1 with no empty-array guard. If `nums` is empty, the `range(1, 0)` loop body never executes and the method returns 1 — which is incorrect for empty input. LeetCode's constraints guarantee `1 <= nums.length`, so this is safe within the problem's contract but would be a bug in a general-purpose utility.
- **Contiguous, not subsequence**: despite the problem title saying "subsequence," this finds a contiguous subarray (substring), not a general subsequence. The problem name is historically misleading on LeetCode.

## Error Handling

None. No input validation, no exception handling. The method trusts the caller to provide a non-empty list of integers, matching LeetCode's guaranteed constraints.

## Topics to Explore

- [file] `longest-continuous-increasing-subsequence/test_solution.py` — Verify which edge cases are covered (empty list, single element, all equal, all decreasing)
- [file] `longest-continuous-increasing-subsequence/review.md` — See what the automated review flagged about this solution
- [function] `maximum-ascending-subarray-sum/solution.py:Solution.maxAscendingSum` — Same "extend or reset" pattern but accumulates a sum instead of a count
- [function] `consecutive-characters/solution.py:Solution.maxPower` — Nearly identical algorithm for longest run of the same character
- [general] `contiguous-vs-subsequence-problems` — Understanding when the greedy single-pass approach works vs. when you need DP (e.g., LIS, problem #300)

## Beliefs

- `lcis-strictly-increasing` — The streak breaks on equal elements (`>`, not `>=`), so `[1, 1, 1]` returns 1
- `lcis-assumes-nonempty` — Returns 1 for empty input due to missing guard; correct only under LeetCode's `len >= 1` constraint
- `lcis-linear-time-constant-space` — Single pass with two integer counters, O(n) time and O(1) space
- `lcis-inline-max-update` — `max_len` is updated only when `cur_len` grows, not after every iteration, avoiding redundant comparisons

