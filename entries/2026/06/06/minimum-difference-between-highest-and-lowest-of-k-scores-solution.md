# File: minimum-difference-between-highest-and-lowest-of-k-scores/solution.py

**Date:** 2026-06-06
**Time:** 17:56

## `minimum-difference-between-highest-and-lowest-of-k-scores/solution.py`

### Purpose

This file solves [LeetCode 1984](https://leetcode.com/problems/minimum-difference-between-highest-and-lowest-of-k-scores/): given an array of student scores and an integer `k`, pick `k` scores such that the difference between the highest and lowest picked score is minimized. It's a self-contained module — solution and tests live in the same file.

### Key Components

**`max_distance(nums, k) -> int`** — the solver. Despite its name (which mirrors LeetCode's original naming), it returns the *minimum* difference, not a maximum. Contract: `nums` has at least `k` elements, `k >= 1`. Mutates `nums` in-place via sort.

**`TestMaxDistance`** — eight unit tests covering edge cases: single element, `k == len(nums)`, `k == 1`, all-identical values, pre-sorted input, large spread, and the basic example.

### Patterns

**Sort-then-slide.** This is the classic sliding window on sorted data pattern. Once sorted, any optimal subset of `k` elements must be contiguous — because inserting a gap would only increase the max-min spread. So the problem reduces to finding the window of size `k` with the smallest `nums[i+k-1] - nums[i]`.

The generator expression inside `min()` is idiomatic Python for scanning all valid window positions in a single pass.

### Dependencies

**Imports:** `typing.List` (type hint), `unittest` (tests).

**Imported by:** The "Imported By" list in the prompt is misleading — those are test files from *other* problems that happen to share the same test runner infrastructure, not files that actually import `max_distance`. The real dependent is `minimum-difference-between-highest-and-lowest-of-k-scores/test_solution.py`.

### Flow

1. Sort `nums` in-place — O(n log n).
2. Generate all differences `nums[i+k-1] - nums[i]` for `i` in `[0, len(nums)-k]` — O(n) values.
3. Return the minimum of those differences.

Total: O(n log n) time, O(1) extra space (sort is in-place, generator doesn't materialize a list).

### Invariants

- After sorting, any contiguous subarray of length `k` has its min at the left end and max at the right end — this is what makes the sliding window correct.
- `range(len(nums) - k + 1)` produces at least one value (since `len(nums) >= k`), so `min()` never receives an empty sequence.
- The function mutates its input. Callers who need the original order must copy first.

### Error Handling

None. If `k > len(nums)`, `range()` produces an empty sequence and `min()` raises `ValueError`. If `k <= 0`, the index `i + k - 1` can be less than `i`, producing negative (meaningless) differences. Both are precondition violations that LeetCode's constraints guarantee won't happen.

---

## Topics to Explore

- [file] `minimum-difference-between-highest-and-lowest-of-k-scores/plan.md` — Planning notes that may explain why this approach was chosen over alternatives (e.g., heap-based)
- [general] `sliding-window-on-sorted-data` — A recurring pattern across this repo; compare with `diet-plan-performance` and `maximum-average-subarray-i` which use fixed-size sliding windows on unsorted data
- [function] `minimum-absolute-difference/solution.py:minimumAbsoluteDifference` — Another sort-then-scan problem with a similar structure but different objective (all pairs with min difference, not a window)
- [file] `minimum-difference-between-highest-and-lowest-of-k-scores/review.md` — Code review notes that may flag the in-place mutation or naming quirk

## Beliefs

- `sort-then-slide-correctness` — The minimum max-min difference over all size-k subsets equals the minimum `nums[i+k-1] - nums[i]` over the sorted array, because optimal subsets are always contiguous after sorting.
- `max-distance-mutates-input` — `max_distance` sorts `nums` in-place; callers cannot rely on original ordering after the call.
- `min-on-empty-is-unguarded` — If `k > len(nums)`, the function crashes with `ValueError` from `min()` on an empty generator — no explicit validation exists.
- `time-complexity-is-n-log-n` — The sort dominates; the sliding window scan is O(n), and no auxiliary data structure is allocated.

