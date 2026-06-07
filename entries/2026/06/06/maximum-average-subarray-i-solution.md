# File: maximum-average-subarray-i/solution.py

**Date:** 2026-06-06
**Time:** 17:34

## `maximum-average-subarray-i/solution.py`

### Purpose

Solves [LeetCode 643 — Maximum Average Subarray I](https://leetcode.com/problems/maximum-average-subarray-i/). Given an integer array `nums` and an integer `k`, finds the contiguous subarray of length `k` with the highest average value and returns that average.

### Key Components

**`Solution.findMaxAverage(nums, k) -> float`** — The single method. Takes a list of integers and a window size, returns the maximum average as a float.

### Patterns

**Sliding window.** This is a textbook fixed-size sliding window implementation. Rather than recomputing `sum(nums[i:i+k])` for every position (O(n*k)), it maintains a running sum and updates it incrementally:

1. **Initialize**: compute `sum(nums[:k])` for the first window.
2. **Slide**: for each new element entering the window (`nums[i]`), add it and subtract the element leaving (`nums[i - k]`).
3. **Track max**: compare after each slide, keeping the best sum seen.
4. **Divide once**: only divides by `k` at the very end, avoiding repeated floating-point division.

The comparison `if window_sum > max_sum` instead of `max_sum = max(max_sum, window_sum)` is a minor optimization — avoids function call overhead on `max()` in a tight loop.

### Dependencies

**Imports**: `typing.List` — used only for the type annotation on the `nums` parameter.

**Imported by**: `maximum-average-subarray-i/test_solution.py` (its direct test file). The large "Imported By" list in the prompt is an artifact of the repo's test infrastructure importing from a shared `Solution` pattern — those tests import their own local `solution.py`, not this one.

### Flow

```
nums = [1, 12, -5, -6, 50, 3], k = 4

1. window_sum = sum([1, 12, -5, -6]) = 2,  max_sum = 2
2. i=4: window_sum = 2 + 50 - 1 = 51,      max_sum = 51
3. i=5: window_sum = 51 + 3 - 12 = 42,     max_sum = 51
4. return 51 / 4 = 12.75
```

The loop runs from index `k` to `len(nums) - 1`, so it executes `n - k` iterations. Total work: O(n) time, O(1) space.

### Invariants

- **`k <= len(nums)`**: assumed by the problem constraints. If violated, `sum(nums[:k])` still works but the loop may not execute, returning the sum of the entire array divided by `k`.
- **`k >= 1`**: if `k == 0`, division by zero occurs on the return line.
- **Max-sum tracking defers division**: `max_sum` tracks the raw sum, not the average. Since `k` is constant and positive, maximizing the sum is equivalent to maximizing the average. This avoids floating-point accumulation errors.

### Error Handling

None. The solution trusts LeetCode's constraints (`1 <= k <= nums.length <= 10^5`). No guards on empty input, `k > len(nums)`, or `k == 0`.

---

## Topics to Explore

- [file] `maximum-average-subarray-i/test_solution.py` — See what edge cases the test suite covers (single-element arrays, all-negative values, k equals array length)
- [file] `diet-plan-performance/solution.py` — Another fixed-size sliding window problem in this repo; compare the window mechanics and how the result is derived differently (threshold comparison vs. max tracking)
- [file] `minimum-recolors-to-get-k-consecutive-black-blocks/solution.py` — Sliding window variant that tracks a minimum instead of a maximum; useful for seeing how the same pattern adapts
- [file] `minimum-difference-between-highest-and-lowest-of-k-scores/solution.py` — A different approach to fixed-size-k subarray problems using sorting instead of sliding window
- [general] `sliding-window-vs-prefix-sum` — This problem can also be solved with a prefix sum array; understanding when each approach is preferable

## Beliefs

- `max-avg-tracks-sum-not-average` — `findMaxAverage` tracks the maximum window sum during iteration and only divides by `k` once at the end, avoiding repeated floating-point division
- `max-avg-sliding-window-o-n` — The solution runs in O(n) time and O(1) extra space by sliding a fixed-size window rather than recomputing subarray sums
- `max-avg-no-input-validation` — `findMaxAverage` performs no validation on inputs; it will divide by zero if `k == 0` and may return incorrect results if `k > len(nums)`
- `max-avg-uses-comparison-not-max-builtin` — The inner loop uses an `if` comparison instead of the `max()` builtin to update `max_sum`, avoiding per-iteration function call overhead

