# File: array-partition/solution.py

**Date:** 2026-06-06
**Time:** 15:16

## `array-partition/solution.py`

### Purpose

This file solves [LeetCode 561 - Array Partition](https://leetcode.com/problems/array-partition/). Given an array of `2n` integers, it forms `n` pairs and maximizes the sum of `min(a_i, b_i)` across all pairs. It's a greedy problem where the optimal strategy is to pair adjacent elements after sorting.

### Key Components

**`array_pair_sum(nums: list[int]) -> int`** — The sole function. Takes a list of `2n` integers, returns the maximum possible sum of pair minimums.

The implementation is two lines:
1. **`nums.sort()`** — In-place sort, ascending. This mutates the input.
2. **`sum(nums[::2])`** — Sum every even-indexed element (0, 2, 4, ...).

### Patterns

**Greedy via sorting.** The insight: after sorting, pairing adjacent elements `(nums[0], nums[1])`, `(nums[2], nums[3])`, ... guarantees each `min()` is as large as possible. The minimum of each pair is always the left (even-indexed) element. This avoids "wasting" large values by pairing them with small ones.

**Slice-based aggregation.** `nums[::2]` uses Python's step-slice to extract every other element, which is idiomatic for this kind of structured traversal over sorted data.

### Dependencies

**Imports:** None — pure Python, no external or standard library imports.

**Imported by:** `array-partition/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those hundreds of test files don't import *this* solution; they reflect the repo's test infrastructure importing from their own respective `solution.py` files.

### Flow

1. Sort `nums` in-place (O(n log n)).
2. Take every even-indexed element — these are the smaller of each adjacent pair.
3. Sum them and return.

For input `[1, 4, 3, 2]`: sort → `[1, 2, 3, 4]`, pairs are `(1,2)` and `(3,4)`, minimums are `1 + 3 = 4`.

### Invariants

- **Input length must be even** — the problem guarantees `2n` elements. The code doesn't validate this; it trusts the caller.
- **Mutation** — `nums.sort()` modifies the caller's list. This is a LeetCode convention (input arrays are disposable), but worth noting if the function were reused in a context where the original order matters.
- **Greedy correctness** — relies on the proof that sorting and pairing adjacently is optimal. Any other pairing strategy yields a sum ≤ this one.

### Error Handling

None. Empty list returns `0` (from `sum([])`). Odd-length input silently produces a wrong answer rather than raising. This is fine for LeetCode's constrained input guarantees.

## Topics to Explore

- [file] `array-partition/test_solution.py` — Verify which edge cases are covered (empty list, two elements, negatives, duplicates)
- [file] `array-partition/plan.md` — See the reasoning/proof for why the greedy sort approach is optimal
- [general] `greedy-sort-pattern` — Many LeetCode problems (assign cookies, boats to save people, pair minimums) share this "sort then greedily pair" structure
- [function] `fair-candy-swap/solution.py:fairCandySwap` — Another problem using sorted-array reasoning for optimal pairing
- [file] `array-partition/review.md` — Check if the review flagged the input mutation or discussed `sorted()` vs `.sort()`

## Beliefs

- `array-partition-sort-greedy` — `array_pair_sum` uses sort + even-index sum as its greedy strategy; no dynamic programming or enumeration
- `array-partition-mutates-input` — `nums.sort()` mutates the caller's list in-place rather than using `sorted()` to preserve the original
- `array-partition-no-validation` — The function assumes even-length input and performs no length or type checking
- `array-partition-linear-after-sort` — The aggregation step (`sum(nums[::2])`) is O(n); total complexity is dominated by the O(n log n) sort

