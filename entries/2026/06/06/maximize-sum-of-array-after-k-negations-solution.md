# File: maximize-sum-of-array-after-k-negations/solution.py

**Date:** 2026-06-06
**Time:** 17:33

## `maximize-sum-of-array-after-k-negations/solution.py`

### Purpose

This file solves [LeetCode 1005 — Maximize Sum of Array After K Negations](https://leetcode.com/problems/maximize-sum-of-array-after-k-negations/). Given an integer array and a count `k`, you must negate exactly `k` elements (with repeats allowed on the same element) to maximize the array's sum. The file exports `largest_sum_after_k_negations` as the solver and aliases it as `is_univalued` for a shared test harness convention.

### Key Components

**`largest_sum_after_k_negations(nums, k)`** — The sole function. Mutates `nums` in-place (sorts it, flips negatives), then returns the maximum achievable sum. Contract:

- **Input**: `nums` is a non-empty list of integers; `k` is a non-negative integer.
- **Output**: integer — the largest possible sum after exactly `k` negations.
- **Side effect**: `nums` is sorted and partially mutated.

**`is_univalued`** — Module-level alias pointing to `largest_sum_after_k_negations`. This is a naming convention used across the repo so every problem's test file can import a uniform symbol. The name `is_univalued` is a misnomer carried over from the harness (it matches the univalued-binary-tree problem's export name, not this problem's semantics).

### Patterns

**Greedy sort-then-consume**: The algorithm sorts to put negatives first, then greedily flips them to positive — each flip of a negative number yields the largest marginal gain. This is the canonical greedy approach for this problem.

**Parity absorption**: After all negatives are flipped (or `k` is exhausted), any remaining operations are absorbed by toggling the smallest-magnitude element. If the leftover `k` is even, the toggles cancel out. If odd, one unavoidable negation hits the current minimum, costing `2 * min(nums)`.

### Dependencies

- **Imports**: None — pure stdlib Python.
- **Imported by**: The `test_solution.py` in this directory, plus ~350+ other test files across the repo (via the `is_univalued` alias in the shared test harness). The massive import list is an artifact of the harness wiring, not actual cross-problem coupling.

### Flow

1. **Sort** `nums` ascending — negatives land at the front.
2. **Flip negatives**: Walk left to right, negating each negative while `k > 0`. The index `i` tracks how far we've consumed.
3. **Sum**: Compute `total = sum(nums)` over the now-partially-flipped array.
4. **Odd-k adjustment**: If `k` remaining is odd, subtract `2 * min(nums)` — this simulates one final forced negation on the smallest element.
5. **Return** `total`.

### Invariants

- After the while-loop, every element in `nums` is non-negative (all original negatives were flipped, or `k` ran out while some negatives remain — but in that case no adjustment is needed since `k == 0`).
- The `k % 2` check is only meaningful when `k > 0` after the loop. When `k == 0`, the branch is a no-op (`0 % 2 == 0`).
- `min(nums)` at line 20 operates on the already-mutated array, so it finds the smallest magnitude element — exactly the right target for the forced negation.

### Error Handling

None. The function assumes valid inputs per the LeetCode contract (`1 <= nums.length`, `1 <= k`). No bounds checking, no type validation. Invalid inputs (empty list, negative `k`) would produce undefined behavior or exceptions from stdlib calls.

---

## Topics to Explore

- [file] `maximize-sum-of-array-after-k-negations/test_solution.py` — See how the alias wiring works and what edge cases are tested
- [file] `maximize-sum-of-array-after-k-negations/review.md` — Check if the review flagged the `is_univalued` misnomer or the in-place mutation
- [general] `greedy-negation-variants` — Compare with problems like "minimum sum after k negations" or approaches using a min-heap for repeated negation without sorting
- [function] `maximize-sum-of-array-after-k-negations/solution.py:largest_sum_after_k_negations` — Trace what happens when all elements are positive and k is large (the parity branch is the entire algorithm)
- [file] `fair-candy-swap/solution.py` — Another greedy array problem in the repo; compare structural patterns

## Beliefs

- `greedy-flip-negatives-first` — The algorithm always flips the most-negative elements first because sorting places them at index 0; this is optimal because flipping a negative yields +2|x| gain versus flipping a positive which yields -2|x| loss.
- `odd-k-residual-cost` — When leftover k is odd after flipping all negatives, the sum penalty is exactly `2 * min(nums)` applied to the already-mutated (all-non-negative) array.
- `in-place-mutation` — `largest_sum_after_k_negations` mutates the input list via `sort()` and element assignment; callers that need the original array must copy before calling.
- `alias-is-misnomer` — The `is_univalued` alias has no semantic relationship to this problem; it exists solely to satisfy the repo's test harness import convention.

