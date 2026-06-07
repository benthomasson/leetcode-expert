# File: get-maximum-in-generated-array/solution.py

**Date:** 2026-06-06
**Time:** 16:55

## `get-maximum-in-generated-array/solution.py`

### Purpose

Solves [LeetCode 1646: Get Maximum in Generated Array](https://leetcode.com/problems/get-maximum-in-generated-array/). The file owns the generation of an array defined by a specific recurrence relation and finding its maximum value. It follows the repo's convention of one `Solution` class per problem directory.

### Key Components

**`Solution.getMaximumGenerated(self, n: int) -> int`** — the sole method. Given `n`, it constructs an array `nums` of length `n + 1` using these rules:

| Index `i` | Value |
|-----------|-------|
| 0 | 0 |
| 1 | 1 |
| even `i` (≥ 2) | `nums[i // 2]` |
| odd `i` (≥ 3) | `nums[i // 2] + nums[i // 2 + 1]` |

Then returns `max(nums)`.

### Patterns

**Bottom-up DP.** The array is filled iteratively from index 2 to `n`. Each element depends only on previously computed elements, so a single forward pass suffices. This is the standard approach for recurrence-based problems — no memoization overhead, O(n) time and space.

**Early return for edge case.** The `n == 0` guard at line 13 avoids an out-of-bounds write to `nums[1]` when the array has length 1.

### Dependencies

**Imports:** None — pure Python, no standard library or third-party dependencies.

**Imported by:** `get-maximum-in-generated-array/test_solution.py` directly. The "Imported By" list in the prompt is misleadingly large — those are other problems' test files that share a common test harness pattern importing from their own `solution.py`, not this file.

### Flow

1. If `n == 0`, return 0 immediately.
2. Allocate `nums` as a zero-filled list of size `n + 1`.
3. Set `nums[1] = 1` (base case).
4. Iterate `i` from 2 through `n`:
   - Even `i`: copy from `nums[i // 2]` (the "parent" in the recurrence).
   - Odd `i`: sum `nums[i // 2]` and `nums[i // 2 + 1]` (adjacent pair in the "parent" region).
5. Return `max(nums)`.

The key insight for the odd case: integer division of an odd number `i` gives `(i-1)/2`, so the formula combines two adjacent elements from the first half of the array.

### Invariants

- **`n >= 0`** is assumed by the problem constraints. No negative-input guard exists.
- **At iteration `i`, all indices `< i` are already computed.** This holds because both `i // 2` and `i // 2 + 1` are strictly less than `i` for `i >= 2`.
- **`nums` never shrinks or grows** after allocation — fixed-size array.

### Error Handling

None. The method trusts LeetCode's constraint that `0 <= n <= 100`. Passing `n < 0` would return 0 (the early return checks `n == 0`, but the `range(2, n+1)` would be empty for `n = 1` too, which is fine since `nums[1] = 1` is set and `max([0, 1])` returns 1). Negative `n` would create a zero-length list and then fail at `nums[1] = 1` with an `IndexError`.

### Complexity

- **Time:** O(n) — single pass.
- **Space:** O(n) — the `nums` array. Could be reduced with a sliding window if only the max were needed, but at the cost of clarity for no practical gain given `n <= 100`.

---

## Topics to Explore

- [file] `get-maximum-in-generated-array/test_solution.py` — See which edge cases (n=0, n=1, larger n) the test suite covers
- [file] `get-maximum-in-generated-array/plan.md` — The problem-solving strategy and any alternative approaches considered
- [general] `recurrence-generated-arrays` — How the even/odd splitting pattern here relates to other LeetCode recurrences like Tribonacci (`n-th-tribonacci-number`) and Climbing Stairs
- [function] `counting-bits/solution.py:Solution.countBits` — Another problem that uses the `i // 2` parent relationship in a DP array, worth comparing the structural similarity
- [file] `get-maximum-in-generated-array/review.md` — Post-solve review notes on correctness and optimality

---

## Beliefs

- `generated-array-recurrence-correctness` — For odd index `i`, `nums[i // 2 + 1]` is always in bounds because `i // 2 + 1 <= i - 1` for all `i >= 3`, and the array has length `n + 1`
- `generated-array-n0-guard-required` — The `n == 0` early return is necessary; without it, `nums[1] = 1` would raise `IndexError` on a length-1 list
- `generated-array-single-pass-dp` — The solution computes all values in one forward pass because every dependency index (`i // 2`, `i // 2 + 1`) is strictly less than the current index
- `generated-array-no-external-deps` — The solution uses no imports and depends only on Python built-in `max()` and integer arithmetic

