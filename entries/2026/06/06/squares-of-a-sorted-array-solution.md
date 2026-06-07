# File: squares-of-a-sorted-array/solution.py

**Date:** 2026-06-06
**Time:** 19:16

## `squares-of-a-sorted-array/solution.py`

### Purpose

This file solves [LeetCode 977 — Squares of a Sorted Array](https://leetcode.com/problems/squares-of-a-sorted-array/). Given an integer array sorted in non-decreasing order (which may contain negatives), it returns a new array of squared values, also in non-decreasing order. It's one of hundreds of self-contained solution modules in the `leetcode-implementations` repo.

### Key Components

**`distinctSubseqII(nums: list[int]) -> list[int]`** — The sole function. Note the name is a copy-paste error; the function name `distinctSubseqII` belongs to a completely different LeetCode problem (#940). The actual behavior is "squares of a sorted array."

Contract:
- **Input**: `nums` — a list of integers sorted in non-decreasing order (e.g., `[-4, -1, 0, 3, 10]`).
- **Output**: A new list of the same length containing `nums[i] ** 2` for each element, sorted in non-decreasing order.

### Patterns

**Two-pointer merge from the extremes.** The key insight is that in a sorted array with negatives, the largest squares are always at the ends (leftmost negatives or rightmost positives). The algorithm uses two pointers (`left` at index 0, `right` at `n-1`) and fills the result array backwards from the last position. At each step, whichever end has the larger absolute value contributes its square to the current (highest unfilled) position. This is the same merge logic you'd use in merge sort's merge step, but applied to a single array folded at its zero-crossing point.

This avoids the naive approach of squaring everything and then sorting (`O(n log n)`), achieving `O(n)` time instead.

### Dependencies

**Imports**: None. Pure standalone function.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files across the entire repo that likely share a common test harness or import utility, not files that actually call `distinctSubseqII`. The real consumer is `squares-of-a-sorted-array/test_solution.py`.

### Flow

1. Compute `n = len(nums)` and allocate a result array of zeros.
2. Set `left = 0`, `right = n - 1`.
3. Iterate `i` from `n-1` down to `0` (filling result from the back):
   - Compare `abs(nums[left])` vs `abs(nums[right])`.
   - The larger absolute value gets squared and placed at `result[i]`.
   - Advance the corresponding pointer inward (`left += 1` or `right -= 1`).
4. Return `result`.

After the loop, `left` and `right` have crossed (or met), and every position in `result` has been filled exactly once.

### Invariants

- **Loop invariant**: At iteration `i`, `result[i+1:]` contains the `n - i - 1` largest squares in sorted order, and the remaining unsquared values are exactly `nums[left..right]`.
- **Pointer convergence**: `left` increases and `right` decreases; the loop runs exactly `n` times, so they always converge. No bounds check is needed inside the loop.
- **Stability on ties**: When `abs(nums[left]) == abs(nums[right])`, the left element is chosen (the `>=` branch). This is correct — both squares are equal so ordering between them doesn't matter.

### Error Handling

None. The function assumes valid input per the LeetCode contract. An empty list (`n=0`) works correctly: the loop body never executes and `[]` is returned. A single-element list also works fine since `left == right == 0`.

---

## Topics to Explore

- [file] `squares-of-a-sorted-array/test_solution.py` — See what edge cases the tests cover (all-negative, all-positive, zeros, single element)
- [file] `squares-of-a-sorted-array/plan.md` — The planning doc may explain why the two-pointer approach was chosen over sort-based alternatives
- [general] `two-pointer-merge-pattern` — This same inward-converging two-pointer pattern appears in many other solutions in the repo (e.g., `two-sum`, `valid-palindrome`, `sort-array-by-parity`)
- [file] `squares-of-a-sorted-array/review.md` — May flag the function name mismatch or other quality issues
- [function] `merge-two-sorted-lists/solution.py:mergeTwoLists` — Compare the merge logic; same principle applied to two separate lists instead of two ends of one list

## Beliefs

- `misnamed-function` — The function is named `distinctSubseqII` but implements LeetCode 977 (Squares of a Sorted Array), not LeetCode 940
- `two-pointer-linear-time` — The algorithm runs in O(n) time and O(n) space by exploiting the fact that largest-magnitude elements are always at the array extremes
- `backward-fill-produces-sorted-output` — Filling the result array from index n-1 down to 0 guarantees the output is in non-decreasing order without a separate sort step
- `empty-input-safe` — The function correctly handles empty input lists, returning `[]` without error

