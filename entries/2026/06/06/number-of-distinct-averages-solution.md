# File: number-of-distinct-averages/solution.py

**Date:** 2026-06-06
**Time:** 18:17

## `number-of-distinct-averages/solution.py`

### Purpose

Solves [LeetCode 2465: Number of Distinct Averages](https://leetcode.com/problems/number-of-distinct-averages/). The problem asks: given an even-length array, repeatedly remove the current min and max, compute their average, and return how many distinct averages you get.

### Key Components

**`distinctAverages(nums: list[int]) -> int`** — The sole function. Takes an even-length list of integers, returns the count of distinct averages formed by pairing the smallest and largest remaining elements.

### Patterns

**Two-pointer on sorted array.** Rather than simulating removal (which would be O(n²) with a list), the solution sorts once and walks inward with `left`/`right` pointers. This is the canonical approach for problems that pair min/max elements.

**Sum-instead-of-average trick.** The function collects `nums[left] + nums[right]` into a set instead of computing the actual average `(nums[left] + nums[right]) / 2`. This works because two averages are distinct if and only if their sums are distinct — dividing by the same constant (2) is a monotonic bijection. This sidesteps floating-point precision issues entirely.

**In-place mutation.** `nums.sort()` sorts the input list in-place. The caller's list is modified — acceptable for LeetCode but worth noting.

### Dependencies

**Imports:** None beyond builtins (`list`, `set`).

**Imported by:** The corresponding `number-of-distinct-averages/test_solution.py`. The "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a common test harness import pattern, not actual importers of this function.

### Flow

1. **Sort** the array in-place — O(n log n).
2. **Initialize** an empty set `sums` and two pointers `left=0`, `right=len(nums)-1`.
3. **Loop** while `left < right`: add `nums[left] + nums[right]` to the set, then move both pointers inward.
4. **Return** `len(sums)` — the number of distinct sums (equivalently, distinct averages).

Each iteration consumes exactly one min-max pair. Since `nums` has even length, the loop runs exactly `len(nums) // 2` times and exhausts all elements.

### Invariants

- **Even-length input** is assumed by the problem constraints. If `len(nums)` were odd, the middle element would be silently skipped — the `left < right` guard excludes it.
- **Sorted order** guarantees `nums[left]` is the current minimum and `nums[right]` is the current maximum at each step.
- **Set deduplication** means the return value is bounded by `len(nums) // 2`.

### Error Handling

None. The function trusts the caller to provide a valid even-length list of integers, consistent with LeetCode's guaranteed constraints. Empty input returns 0 (the while-loop body never executes).

---

## Topics to Explore

- [file] `number-of-distinct-averages/test_solution.py` — See what edge cases the test suite covers (empty list, all-same elements, duplicates producing same averages)
- [function] `two-sum-less-than-k/solution.py:twoSumLessThanK` — Another two-pointer-on-sorted-array solution; compare the structural similarity
- [file] `number-of-distinct-averages/review.md` — The code review may call out the in-place mutation or the sum-vs-average tradeoff
- [general] `two-pointer-sorted-pattern` — Across this repo, many solutions sort then walk inward — worth cataloging which problems reduce to this shape

## Beliefs

- `distinct-averages-sum-equivalence` — `distinctAverages` tracks sums instead of averages; this is correct because dividing all sums by the same constant preserves distinctness.
- `distinct-averages-time-complexity` — The function runs in O(n log n) time, dominated by the sort; the two-pointer pass is O(n).
- `distinct-averages-mutates-input` — `nums.sort()` mutates the caller's list in-place; the function does not make a defensive copy.
- `distinct-averages-no-float` — The solution never computes a floating-point division, avoiding precision issues entirely.

