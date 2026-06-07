# File: sign-of-the-product-of-an-array/solution.py

**Date:** 2026-06-06
**Time:** 19:06

## Purpose

This file solves [LeetCode 1822 — Sign of the Product of an Array](https://leetcode.com/problems/sign-of-the-product-of-an-array/). It determines whether the product of all elements in an integer array is positive, negative, or zero — without actually computing the product. This avoids overflow concerns and reduces the problem to pure sign tracking.

## Key Components

### `signFunc(nums: list[int]) -> int`

The sole public function. Contract:

| Input | Output |
|-------|--------|
| Product is positive | `1` |
| Product is negative | `-1` |
| Product is zero | `0` |

The function counts negative numbers and short-circuits on zero. It never computes the actual product.

## Patterns

**Parity counting.** Instead of multiplying values and checking the result's sign, the solution counts negatives. An even count means the negatives cancel; odd means one survives. This is the canonical approach for sign-of-product problems — it sidesteps overflow entirely and runs in O(n) time with O(1) space.

**Early exit.** The `return 0` inside the loop is a short-circuit: if any element is zero, the entire product is zero regardless of remaining elements. This is both a correctness guarantee and a minor performance optimization.

## Dependencies

**Imports:** None. The solution is self-contained with no standard library or third-party dependencies.

**Imported by:** The `test_solution.py` in the same directory imports this function. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a common test harness pattern (likely via `sys.path` manipulation or a shared conftest), not actual consumers of `signFunc`.

## Flow

1. Initialize `neg_count = 0`.
2. Iterate through `nums`:
   - If element is `0` → return `0` immediately.
   - If element is negative → increment `neg_count`.
   - Positive elements are implicitly skipped (they don't affect sign).
3. After the loop, return `-1` if `neg_count` is odd, else `1`.

## Invariants

- **Zero dominance**: A single zero in the array forces a `0` return, regardless of all other values.
- **Sign parity**: The sign of a product depends only on the count of negative factors mod 2.
- **No mutation**: The input list is never modified.
- **Total function**: Every possible `list[int]` input produces one of `{-1, 0, 1}`. The function assumes `nums` is non-empty (per the LeetCode constraint `1 <= nums.length`).

## Error Handling

None. The function assumes valid input per the problem constraints. An empty list would fall through to the final return and produce `1` (since `neg_count` would be 0) — arguably wrong, but the problem guarantees non-empty input.

## Topics to Explore

- [file] `sign-of-the-product-of-an-array/test_solution.py` — See what edge cases the tests cover (all-positive, all-negative, contains zero, single element)
- [file] `sign-of-the-product-of-an-array/review.md` — Read the code review for any noted trade-offs or alternative approaches
- [function] `subtract-the-product-and-sum-of-digits-of-an-integer/solution.py:subtractProductAndSum` — A related problem that does compute the actual product, showing the contrast in approach
- [general] `parity-counting-pattern` — Other solutions in this repo that use odd/even counting instead of computing a value directly (e.g., bit-counting problems)

## Beliefs

- `sign-func-returns-ternary` — `signFunc` returns exactly one of `{-1, 0, 1}` for any non-empty integer list
- `sign-func-never-computes-product` — The function determines sign via negative-count parity, never multiplying elements together
- `sign-func-zero-short-circuit` — If any element is zero, the function returns `0` immediately without examining remaining elements
- `sign-func-o1-space` — The function uses constant extra space (a single integer counter) regardless of input size

