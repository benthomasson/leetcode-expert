# File: maximum-product-of-two-elements-in-an-array/solution.py

**Date:** 2026-06-06
**Time:** 17:42

## Purpose

This file is a self-contained solution to [LeetCode 1464: Maximum Product of Two Elements in an Array](https://leetcode.com/problems/maximum-product-of-two-elements-in-an-array/). It owns the algorithm implementation and its unit tests. In the broader `leetcode-implementations` repo, it follows the standard per-problem directory structure (`solution.py` + `test_solution.py` + optional `plan.md`/`review.md`).

## Key Components

### `max_product(nums: List[int]) -> int`

The sole algorithm function. Given an array of non-negative integers with at least two elements, it returns the maximum value of `(nums[i] - 1) * (nums[j] - 1)` where `i != j`.

The implementation uses a **single-pass two-max tracker** rather than sorting:

```python
max1 = max2 = 0
for n in nums:
    if n >= max1:
        max2 = max1
        max1 = n
    elif n > max2:
        max2 = n
```

`max1` holds the largest value seen, `max2` holds the second largest. The final result is `(max1 - 1) * (max2 - 1)`.

### `TestMaxProduct`

Eight test cases covering examples from the problem statement, edge cases (all ones, identical values, max constraint values), and ordering variants (ascending, descending input).

## Patterns

- **O(n) time, O(1) space**: Avoids the O(n log n) sort approach by tracking only the top two values. This is the optimal approach for this problem.
- **Greedy two-max tracking**: A common idiom for "find the two largest elements." The `>=` in `if n >= max1` is important — it correctly handles duplicates by promoting the current `max1` to `max2` before overwriting.
- **Self-contained module**: Algorithm + tests in one file, runnable via `python solution.py` or `pytest`.

## Dependencies

**Imports**: `unittest` (stdlib) and `typing.List` (type annotation only — no runtime dependency).

**Imported by**: The `test_solution.py` file in this same directory imports from it. The massive "Imported By" list in the prompt is misleading — those are *other problems'* test files that happen to share the same import pattern (`from solution import ...`), not actual cross-problem dependencies.

## Flow

1. Initialize `max1` and `max2` to 0 (safe because the problem guarantees `nums[i] >= 1`).
2. Single pass through `nums`:
   - If current value `>= max1`: demote `max1` to `max2`, promote current to `max1`.
   - Else if current value `> max2`: update `max2`.
3. Return `(max1 - 1) * (max2 - 1)`.

## Invariants

- **Loop invariant**: After processing element `i`, `max1 >= max2` and both are the two largest values seen so far.
- **Precondition**: `len(nums) >= 2` and all elements are non-negative integers. The code initializes to 0, so negative inputs would break the tracker (a value of -5 would never beat the initial 0).
- **The `>=` vs `>` distinction matters**: `if n >= max1` ensures that when `max1 == max2 == 0` and the first element arrives, `max2` gets 0 (demoted from `max1`) and `max1` gets the element. If this were `>` instead, an array of identical values would leave `max2` at 0.

## Error Handling

None. The function trusts its caller to provide valid input per the LeetCode constraints (`2 <= len(nums) <= 500`, `1 <= nums[i] <= 10^3`). No validation, no exceptions. This is appropriate for a competitive-programming solution.

## Topics to Explore

- [file] `maximum-product-of-two-elements-in-an-array/review.md` — The code review may document alternative approaches (sorting, heap) and why single-pass was chosen
- [function] `maximum-product-of-three-numbers/solution.py:max_product` — Extends the two-max pattern to three elements, adding complexity for negative numbers
- [function] `maximum-product-difference-between-two-pairs/solution.py:max_product_difference` — Similar two-max/two-min tracking pattern for a related product problem
- [general] `single-pass-extrema-tracking` — The two-max idiom generalizes to k-max via a min-heap of size k; compare with solutions that use `heapq.nlargest`

## Beliefs

- `two-max-tracker-handles-duplicates` — The `>=` comparison (not `>`) in the primary branch ensures identical values correctly populate both `max1` and `max2`
- `zero-initialization-assumes-nonnegative` — Initializing `max1 = max2 = 0` is only correct because the problem guarantees all elements are >= 1; negative inputs would silently produce wrong results
- `single-pass-optimal-complexity` — The algorithm is O(n) time and O(1) space, which is optimal since every element must be inspected at least once
- `no-cross-problem-dependencies` — Despite the large "Imported By" list, this module has no actual runtime dependents outside its own directory; each problem's `test_solution.py` imports from its own `solution.py`

