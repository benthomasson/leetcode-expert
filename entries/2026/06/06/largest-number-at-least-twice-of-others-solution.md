# File: largest-number-at-least-twice-of-others/solution.py

**Date:** 2026-06-06
**Time:** 17:15



## Purpose

This file solves [LeetCode 747 — Largest Number At Least Twice of Others](https://leetcode.com/problems/largest-number-at-least-twice-of-others/). Given an integer array where the largest value is unique, it returns the index of that largest value if it is at least twice as large as every other element; otherwise it returns -1.

## Key Components

**`Solution.largestNumberAtLeastTwiceOfOthers(self, nums: List[int]) -> int`**

The sole method. It takes a list of integers and returns either the index of the dominant element or -1.

The contract: the caller guarantees the largest integer is unique (per the problem constraints). The method doesn't validate this — it trusts the input.

## Patterns

**Single-pass max/second-max tracking.** Rather than sorting (O(n log n)) or doing two passes (one to find max, one to verify), the code tracks both `max_val` and `second_max` in a single enumeration. The dominance check then reduces to a single comparison: `max_val >= 2 * second_max`.

This is idiomatic for problems where you need the top-two elements — it avoids allocating any extra data structures and runs in O(n) time with O(1) space.

**Initialization with -1.** Both `max_val` and `second_max` start at -1. This works because the problem guarantees `0 <= nums[i] <= 1000`, so any real element will be strictly greater than -1. It also means a single-element array (e.g., `[3]`) will have `second_max = -1`, and `3 >= 2 * (-1)` is true, correctly returning index 0.

## Dependencies

**Imports:** Only `List` from `typing` — no external libraries.

**Imported by:** The `largest-number-at-least-twice-of-others/test_solution.py` file imports this solution for testing. The massive "Imported By" list in the prompt is misleading — those are test files for *other* problems that share a common test harness importing from their own `solution.py`, not from this file.

## Flow

1. Initialize `max_val = -1`, `second_max = -1`, `max_idx = 0`.
2. Iterate over `nums` with index `i` and value `n`:
   - If `n > max_val`: demote current max to second_max, update max_val and max_idx.
   - Else if `n > second_max`: update second_max only.
3. Return `max_idx` if `max_val >= 2 * second_max`, else -1.

The `elif` branch is important — without it, the second-largest would never be tracked, and the dominance check would compare against -1 every time.

## Invariants

- After the loop, `max_val` is the largest value in `nums` and `max_idx` is its index.
- `second_max` is the second-largest value, or -1 if the array has a single element.
- The dominance condition (`>= 2 *`) is checked against only the second-largest element. This is sufficient because if `max >= 2 * second_max`, then `max >= 2 * x` for all `x <= second_max`.

## Error Handling

None. The method assumes valid input per LeetCode constraints (non-empty array, unique maximum, values in `[0, 1000]`). An empty list would return `0` with `max_val = -1`, which is silently wrong — but that's outside the problem's contract.

## Topics to Explore

- [file] `largest-number-at-least-twice-of-others/test_solution.py` — See what edge cases the tests cover (single element, two elements, no dominant)
- [file] `largest-number-at-least-twice-of-others/review.md` — The code review may note alternative approaches or edge case concerns
- [function] `third-maximum-number/solution.py:Solution.thirdMax` — Similar top-k tracking pattern, but for three values instead of two
- [general] `single-pass-extrema-tracking` — The max/second-max pattern recurs across problems like "maximum product difference" and "second minimum node"

## Beliefs

- `single-pass-max-second-max` — The solution finds the dominant element in O(n) time and O(1) space by tracking only the top two values.
- `negative-one-sentinel-safe` — Initializing max and second_max to -1 is safe because problem constraints guarantee all values are in [0, 1000].
- `dominance-check-sufficiency` — Comparing max_val against 2 * second_max is sufficient to verify dominance over all elements, not just the second-largest.
- `single-element-correct` — For a single-element array, second_max stays -1, so the check `max_val >= 2 * (-1)` always passes, correctly returning index 0.

