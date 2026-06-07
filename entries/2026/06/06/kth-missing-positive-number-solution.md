# File: kth-missing-positive-number/solution.py

**Date:** 2026-06-06
**Time:** 17:13

## Kth Missing Positive Number — `solution.py`

### Purpose

This file solves [LeetCode #1539](https://leetcode.com/problems/kth-missing-positive-number/): given a sorted array of strictly increasing positive integers, find the kth positive integer that is missing from the array. It owns both the solution and its unit tests in a single module.

### Key Components

**`Solution.findKthPositive(arr, k) -> int`** — The sole method. Takes a sorted array of positive integers and an integer `k`, returns the kth missing positive number. Uses binary search to achieve O(log n) time instead of the naive O(n) linear scan.

### Patterns

**Binary search on a derived quantity.** The code doesn't binary search for a value *in* the array — it binary searches on the *count of missing numbers* before each index. The key insight is:

```
missing_before(i) = arr[i] - (i + 1)
```

If `arr = [2, 3, 4, 7, 11]`, then at index 0, `arr[0] - 1 = 1` number is missing (the number 1). At index 3, `arr[3] - 4 = 3` numbers are missing (1, 5, 6). This derived sequence is monotonically non-decreasing, which is what makes binary search valid.

The search finds the first index where `missing_before(i) >= k` — i.e., the boundary where enough numbers have been skipped. The search space is `[0, len(arr))` with the right boundary initialized to `len(arr)` (not `len(arr) - 1`) to handle the case where all missing numbers come *after* the entire array.

**Left-biased binary search template.** The `while left < right` / `right = mid` / `left = mid + 1` pattern finds the leftmost position satisfying a predicate, which is the standard template for this kind of boundary search.

### Dependencies

**Imports:** `typing.List` (type annotation), `unittest` (test harness). No project-internal dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — those are test files across the entire repo that import `unittest`, not files that import *this* module. This solution is self-contained.

### Flow

1. Initialize `left = 0`, `right = len(arr)`.
2. Compute `mid`, check if the count of missing positives before `arr[mid]` is less than `k`.
3. If yes, the answer lies to the right — set `left = mid + 1`.
4. If no, the answer lies to the left (or at `mid`) — set `right = mid`.
5. When the loop terminates, `left` equals the index of the first element where `missing_before >= k`. The answer is `k + left`.

**Why `k + left` works:** At the end, `left` is the number of array elements that come before the answer. If no elements existed, the kth missing positive would just be `k`. Each array element that falls before the answer "pushes" it forward by 1, so the result is `k + left`.

### Invariants

- `arr` must be sorted in strictly increasing order (no duplicates). The missing-count formula breaks with duplicates.
- `arr` contains only positive integers (>= 1). The formula `arr[mid] - (mid + 1)` assumes 1-indexed positive integers.
- `k >= 1`. The problem guarantees this.
- The search space `[0, len(arr))` never accesses out-of-bounds because `mid` is always `< right <= len(arr)`, and `right` only shrinks. When `left == len(arr)`, the loop has exited.

### Error Handling

None. The method trusts its inputs match the LeetCode contract. No bounds checking, no validation. This is appropriate for a competitive-programming solution where the problem statement guarantees valid input.

---

## Topics to Explore

- [file] `kth-missing-positive-number/plan.md` — The planning document likely describes the approach selection (binary search vs. linear) and complexity analysis
- [file] `kth-missing-positive-number/review.md` — Post-implementation review may flag edge cases or alternative approaches
- [general] `binary-search-on-derived-quantities` — This pattern (searching on missing-count, not values) recurs in problems like "kth smallest in sorted matrix" and "find the duplicate number"
- [function] `binary-search/solution.py:Solution.search` — Compare the vanilla binary search template with this adapted version to see how the predicate changes while the skeleton stays the same
- [file] `first-bad-version/solution.py` — Another left-biased binary search on a predicate (isBadVersion), structurally identical loop with a different condition

## Beliefs

- `kth-missing-binary-search-ologn` — `findKthPositive` runs in O(log n) time via binary search on the missing-count function, not O(n) linear scan
- `kth-missing-formula-k-plus-left` — The final answer `k + left` works because `left` counts how many array elements appear before the kth missing number, each shifting the answer up by one
- `kth-missing-right-bound-len-arr` — The right boundary is `len(arr)` (not `len(arr) - 1`) so the search correctly handles cases where all k missing numbers fall after every element in the array
- `kth-missing-monotonic-invariant` — The binary search is valid because `arr[i] - (i + 1)` (count of missing positives before index i) is monotonically non-decreasing for a strictly increasing array of positive integers

