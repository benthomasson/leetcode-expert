# File: sum-of-all-subset-xor-totals/solution.py

**Date:** 2026-06-06
**Time:** 19:21

## `sum-of-all-subset-xor-totals/solution.py`

### Purpose

Solves [LeetCode 1863 — Sum of All Subset XOR Totals](https://leetcode.com/problems/sum-of-all-subset-xor-totals/). Given an array of positive integers, compute the XOR of every possible subset, then return the sum of all those XOR values.

### Key Components

**`subsetXORSum(nums: List[int]) -> int`** — The single public function. Takes a list of positive integers, returns the aggregate XOR-sum across all 2^n subsets (including the empty subset, which contributes 0).

### Patterns

The solution uses a **closed-form bit-contribution formula** instead of the naive O(n * 2^n) enumeration of all subsets.

The mathematical insight: for any bit position `b`, if *at least one* element in `nums` has bit `b` set, then exactly half of all 2^n subsets will have an odd number of elements with that bit set — and those are precisely the subsets where bit `b` survives the XOR. So bit `b` contributes `2^b * 2^(n-1)` to the total sum.

Summing over all bit positions where at least one element has the bit set gives:

```
(OR of all elements) * 2^(n-1)
```

That's what `reduce(or_, nums) * (1 << (len(nums) - 1))` computes. The `reduce(or_, nums)` bitwise-ORs every element together to find which bit positions are "active" anywhere in the array, then multiplies by `2^(n-1)`.

This reduces the problem from exponential enumeration to **O(n)** time and **O(1)** space.

### Dependencies

**Imports:**
- `functools.reduce` — folds the OR across the list
- `operator.or_` — the bitwise OR function passed to `reduce`
- `typing.List` — type annotation

**Imported by:** `sum-of-all-subset-xor-totals/test_solution.py` (and appears in the shared test import list across the repo, likely through a common test harness pattern).

### Flow

1. Guard: if `nums` is empty, return 0 immediately (avoids `reduce` on an empty sequence).
2. `reduce(or_, nums)` — fold bitwise OR across all elements, producing a single integer whose set bits are the union of all set bits in `nums`.
3. Multiply by `1 << (len(nums) - 1)` — i.e., 2^(n-1), the number of subsets in which any given active bit contributes.
4. Return the product.

### Invariants

- `nums` must be non-empty for the `reduce` call (enforced by the early return).
- All elements are positive integers (per the problem constraints), so the OR is always positive for non-empty input.
- The empty subset always XORs to 0, which is implicitly accounted for by the formula (it doesn't add to the sum).

### Error Handling

Minimal — the only guard is the empty-list check. `reduce(or_, [])` would raise `TypeError` without an initial value; the early return prevents that. No other validation is performed; the function trusts that inputs conform to the LeetCode contract.

## Topics to Explore

- [file] `sum-of-all-subset-xor-totals/test_solution.py` — See what edge cases and examples the tests cover, especially empty input and single-element arrays
- [file] `sum-of-all-subset-xor-totals/plan.md` — Check whether the planning document discusses the naive vs. closed-form approach tradeoff
- [general] `bit-contribution-technique` — The pattern of analyzing each bit position independently appears in many XOR/AND/OR subset problems (e.g., sum of all subset AND totals, bitwise ORs of subarrays)
- [function] `xor-operation-in-an-array/solution.py:subsetXORSum` — Compare with another XOR-based problem in the repo to see if the same bit-manipulation idioms recur
- [file] `sum-of-all-subset-xor-totals/review.md` — See the code review assessment of this approach

## Beliefs

- `subset-xor-closed-form` — The sum of XOR totals over all subsets of `nums` equals `reduce(or_, nums) * 2^(len(nums)-1)`, making this O(n) time and O(1) space
- `empty-input-guard-required` — The empty-list early return is load-bearing; without it, `reduce(or_, [])` raises `TypeError` since no initializer is provided
- `bit-position-independence` — The formula works because each bit position contributes independently to the total sum — a bit is "on" in exactly half of all subsets when at least one element carries it
- `no-subset-enumeration` — Despite the problem asking about all 2^n subsets, this solution never generates or iterates over any subset

