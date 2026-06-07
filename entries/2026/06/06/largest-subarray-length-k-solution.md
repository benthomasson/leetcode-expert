# File: largest-subarray-length-k/solution.py

**Date:** 2026-06-06
**Time:** 17:17

## `largest-subarray-length-k/solution.py`

### Purpose

This file solves LeetCode problem **1708: Largest Subarray Length K**. Given an array of **distinct** integers and a length `k`, it returns the lexicographically largest contiguous subarray of exactly length `k`. It's a premium/easy-tier problem that tests understanding of lexicographic ordering and the insight that — with distinct elements — only the first element of the subarray matters for comparison.

### Key Components

**`Solution.largestSubarray(nums, k)`** — The single method. Takes a list of distinct integers and an integer `k`, returns a `List[int]`.

**Contract**: `nums` has at least `k` elements; all elements are distinct.

### Patterns

**Greedy scan for maximum starting element.** The key insight: because all elements are distinct, comparing two subarrays of length `k` lexicographically is determined entirely by the first element that differs — and since subarrays are contiguous slices of the same array, that first element is the starting element itself. Two subarrays starting at different positions can't share the same first element (distinctness guarantee), so the lexicographically largest subarray is the one that starts with the largest value among all valid starting positions `[0, n-k]`.

The loop on line 13 scans positions `1` through `n - k` (inclusive), tracking `max_idx`. Line 15 returns the slice `nums[max_idx:max_idx + k]`.

This is O(n) time, O(k) space (for the returned slice) — optimal for this problem.

### Dependencies

**Imports**: `List` from `typing` — standard type hint, no runtime dependency.

**Imported by**: `largest-subarray-length-k/test_solution.py` directly. The "Imported By" list in the prompt is an artifact of the repo structure — those test files import their own local `Solution` class, not this one.

### Flow

1. Compute `n = len(nums)`.
2. Initialize `max_idx = 0` — the first valid starting position.
3. Iterate `i` from `1` to `n - k` (inclusive). If `nums[i] > nums[max_idx]`, update `max_idx = i`.
4. Return the slice `nums[max_idx:max_idx + k]`.

The loop range `range(1, n - k + 1)` ensures we only consider starting indices where a full window of length `k` fits. When `k == n`, the range is empty and the method correctly returns the entire array.

### Invariants

- **Distinct elements**: The algorithm relies on this. If duplicates existed, you'd need to compare subsequent elements to break ties — a simple argmax of the first element wouldn't suffice.
- **Valid window**: The loop bound `n - k + 1` guarantees every candidate index `i` allows a full `k`-length slice.
- **Single-pass**: `max_idx` always points to the position of the maximum value seen so far among valid starting indices.

### Error Handling

None. The method assumes valid inputs per LeetCode constraints (1 <= k <= len(nums) <= 10^5, all elements distinct). No bounds checking, no empty-array guard. This is standard for LeetCode solution files in this repo.

## Topics to Explore

- [file] `largest-subarray-length-k/test_solution.py` — See the test cases to understand edge cases (k=1, k=n, max at different positions)
- [file] `largest-subarray-length-k/review.md` — Code review notes may capture alternative approaches or complexity discussion
- [function] `maximum-average-subarray-i/solution.py:findMaxAverage` — Another fixed-window problem, but uses a sliding window sum instead of argmax — contrast the two approaches
- [general] `lexicographic-subarray-comparison` — When distinct-element shortcuts don't apply, lexicographic comparison of subarrays requires more nuanced algorithms (e.g., suffix arrays)
- [file] `diet-plan-performance/solution.py` — Another fixed-size window problem with different comparison logic (sum thresholds vs. lexicographic order)

## Beliefs

- `distinct-elements-enables-argmax` — With distinct elements, the lexicographically largest subarray of length k always starts at the position of the maximum value in `nums[0:n-k+1]`
- `largest-subarray-is-linear` — The algorithm runs in O(n) time with a single pass over valid starting indices, no sorting or heap needed
- `k-equals-n-returns-whole-array` — When `k == len(nums)`, the loop range is empty and the method returns `nums[0:n]` (the full array), which is correct
- `no-sliding-window-needed` — Unlike sum/average window problems, this problem doesn't need to maintain a running aggregate because only the first element determines the answer under distinctness

