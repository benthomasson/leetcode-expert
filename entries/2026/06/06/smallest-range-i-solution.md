# File: smallest-range-i/solution.py

**Date:** 2026-06-06
**Time:** 19:09

## `smallest-range-i/solution.py`

### Purpose

This file solves [LeetCode 908 — Smallest Range I](https://leetcode.com/problems/smallest-range-i/). Given an integer array `nums` and an integer `k`, you can add any value in `[-k, k]` to each element (independently). The goal is to minimize the **score**, defined as `max(nums) - min(nums)` after adjustments.

### Key Components

**`Solution.smallestRangeI(nums, k)`** — The only method. It computes the answer in a single expression:

```python
return max(0, max(nums) - min(nums) - 2 * k)
```

The contract: given a non-empty list of integers and a non-negative integer `k`, return the minimum possible difference between the largest and smallest elements after each element is independently adjusted by at most `k`.

### Patterns

**Closed-form math instead of simulation.** The solution skips any actual adjustment of array elements. The key insight: you can shrink the gap between `max(nums)` and `min(nums)` by at most `2*k` — push the minimum up by `k` and pull the maximum down by `k`. If `2*k` exceeds the original gap, the gap collapses to zero (you can make all elements equal), hence the `max(0, ...)` clamp.

This is characteristic of "greedy insight" problems where the optimal strategy has a direct formula.

### Dependencies

**Imports:** `typing.List` — used only for the type annotation. No algorithmic dependencies.

**Imported by:** The `test_solution.py` in the same directory. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure importing a shared test harness, not this specific solution.

### Flow

1. Compute `max(nums)` and `min(nums)` — two linear scans (or one fused pass internally).
2. Subtract `2 * k` from the spread.
3. Clamp to zero if negative.

Total: O(n) time, O(1) space.

### Invariants

- The result is always non-negative (enforced by `max(0, ...)`).
- The function assumes `nums` is non-empty (as guaranteed by the LeetCode constraint `1 <= nums.length`). No explicit guard.
- `k` is assumed non-negative per problem constraints.

### Error Handling

None. The function trusts its inputs match LeetCode constraints. An empty `nums` would raise `ValueError` from `max()`/`min()` on an empty sequence — this is the correct Python behavior and no guard is needed given the problem contract.

## Topics to Explore

- [file] `smallest-range-i/test_solution.py` — Verify which edge cases are covered (single element, k larger than spread, k=0)
- [file] `smallest-range-i/plan.md` — See the reasoning process that led to the closed-form formula
- [general] `smallest-range-ii` — The harder variant (LeetCode 910) where you must add exactly +k or -k to each element, which doesn't reduce to a one-liner
- [function] `best-time-to-buy-and-sell-stock/solution.py:maxProfit` — Another O(n) single-pass problem that uses min/max tracking with a similar "greedy insight" pattern

## Beliefs

- `smallest-range-i-is-O-n` — `smallestRangeI` runs in O(n) time and O(1) space, making two linear passes for max and min
- `smallest-range-i-closed-form` — The minimum score equals `max(0, max(nums) - min(nums) - 2*k)` because the optimal strategy always pushes the min up by k and the max down by k
- `smallest-range-i-no-mutation` — The solution never modifies the input array; it computes the answer purely from aggregate statistics
- `smallest-range-i-assumes-nonempty` — The function has no empty-list guard and will raise `ValueError` if `nums` is empty, relying on the LeetCode constraint `1 <= nums.length`

