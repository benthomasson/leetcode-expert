# File: maximum-product-of-three-numbers/solution.py

**Date:** 2026-06-06
**Time:** 17:42

## `maximum-product-of-three-numbers/solution.py`

### Purpose

This file solves [LeetCode 628: Maximum Product of Three Numbers](https://leetcode.com/problems/maximum-product-of-three-numbers/). It owns the solution implementation and its test suite in a single module — the standard layout across this repo.

### Key Components

**`maximumProduct(nums: List[int]) -> int`** — The sole public function. Contract: given a list of at least 3 integers (positive, negative, or zero), return the largest product achievable by choosing exactly three elements.

**`TestMaximumProduct`** — 10 unit tests covering the meaningful equivalence classes: all positive, all negative, mixed signs, zeros, duplicates, and the critical case where two large negatives times a positive beats three positives.

### Patterns

**Sort-then-inspect.** Rather than tracking running extremes, the solution sorts in O(n log n) and reads fixed positions. This trades optimal O(n) time for simpler code — a common choice in this repo's easy-level solutions.

**Single-file solution+test.** Matches the repo convention: `solution.py` contains both implementation and `unittest` tests, runnable via `python -m unittest` or `python solution.py`.

### Dependencies

**Imports:** `typing.List` (type annotation), `unittest` (test framework). No project-internal dependencies.

**Imported by:** The "Imported By" list is misleading — those 400+ test files don't actually import this module. That list reflects a repo-wide cross-reference artifact, not real import edges. This file is self-contained.

### Flow

1. **Sort** `nums` in-place (ascending).
2. **Compute two candidate products:**
   - `nums[-1] * nums[-2] * nums[-3]` — the three largest values.
   - `nums[0] * nums[1] * nums[-1]` — the two smallest (most negative) values times the largest positive.
3. **Return the max** of those two candidates.

The key insight: when the array contains large-magnitude negatives, multiplying two negatives yields a positive that, combined with the largest element, can exceed the product of the three largest. These are the only two candidates that can ever win — no other combination of three indices from a sorted array can produce a larger product.

### Invariants

- **Precondition:** `len(nums) >= 3`. Not validated; the function trusts the caller (matches LeetCode's guarantee).
- **Mutation:** `nums.sort()` modifies the input list in place. Callers who need the original order must copy first.
- **Completeness of candidates:** Exactly two products are compared. This is sufficient because in a sorted array, the maximum product of three elements is always either the top-3 or the bottom-2-times-top-1. The bottom-3 product is always <= bottom-2 * top-1 when the largest element is non-negative, and when all elements are negative, top-3 is the correct answer.

### Error Handling

None. The function assumes valid input per the problem constraints. Passing fewer than 3 elements raises an `IndexError` from the list access — no custom error handling.

---

## Topics to Explore

- [file] `maximum-product-of-three-numbers/review.md` — The code review may discuss the sort-vs-linear-scan tradeoff and whether the in-place mutation is flagged
- [file] `maximum-product-of-three-numbers/plan.md` — Shows the reasoning that led to choosing sort over a single-pass O(n) approach tracking min1/min2/max1/max2/max3
- [general] `two-candidate-sufficiency-proof` — Why exactly two products cover all cases: worth working through with a 4-element signed example
- [function] `maximum-product-difference-between-two-pairs/solution.py:maxProductDifference` — A sibling problem that uses the same sort-and-read-extremes pattern, good for comparing approaches
- [general] `in-place-sort-mutation` — Several solutions in this repo sort in-place; understanding which callers are affected matters for test isolation

## Beliefs

- `max-product-two-candidates` — The maximum product of three numbers from a sorted array is always `max(top3_product, bottom2_times_top1)` — no other combination can win
- `sort-mutates-input` — `maximumProduct` sorts `nums` in place, so the caller's list is modified as a side effect
- `solution-is-o-nlogn` — The sort dominates at O(n log n); an O(n) single-pass solution tracking five extremes is possible but not used here
- `no-input-validation` — The function does not guard against `len(nums) < 3`; it relies on the LeetCode problem guarantee

