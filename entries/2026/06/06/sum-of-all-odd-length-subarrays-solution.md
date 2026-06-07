# File: sum-of-all-odd-length-subarrays/solution.py

**Date:** 2026-06-06
**Time:** 19:20

## Purpose

This file solves [LeetCode 1588: Sum of All Odd Length Subarrays](https://leetcode.com/problems/sum-of-all-odd-length-subarrays/). It computes the sum of every subarray of odd length (1, 3, 5, ...) from a given array of positive integers. Rather than enumerating subarrays (O(n^2) or O(n^3)), it uses an O(n) closed-form formula based on counting how many odd-length subarrays each element participates in.

## Key Components

**`Solution.sumOddLengthSubarrays(self, arr: List[int]) -> int`**

The sole method. For each index `i`, it multiplies `arr[i]` by the number of odd-length subarrays that include position `i`, then sums the results.

The contribution count formula: `((i + 1) * (n - i) + 1) // 2`

- `(i + 1) * (n - i)` is the **total** number of subarrays (any length) containing index `i`. This is because there are `i + 1` choices for where the subarray can start (indices 0 through i) and `n - i` choices for where it can end (indices i through n-1).
- Of those subarrays, roughly half have odd length and half have even length. The `+ 1` before integer division by 2 rounds up, which correctly handles the case where the total count is odd (there's always one more odd-length subarray than even-length in that case).

## Patterns

- **Contribution counting**: Instead of iterating over all subarrays and summing their elements, the code inverts the problem — it asks "how much does each element contribute to the total?" This is a standard competitive programming technique that reduces complexity from O(n^2) or O(n^3) to O(n).
- **Single-expression return**: The entire computation is a generator expression inside `sum()`, keeping the implementation compact.

## Dependencies

**Imports**: `typing.List` — used only for the type annotation on `arr`.

**Imported by**: The `test_solution.py` in the same directory imports this `Solution` class. The massive "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share the same import pattern, not actual consumers of this specific module.

## Flow

1. Compute `n = len(arr)`.
2. For each index `i` in `[0, n)`:
   - Compute the total subarrays containing `i`: `(i + 1) * (n - i)`
   - Compute odd-length subarrays containing `i`: `(total + 1) // 2`
   - Multiply by `arr[i]` to get element `i`'s total contribution.
3. Sum all contributions and return.

## Invariants

- `arr` contains positive integers (per the LeetCode problem constraints).
- The formula assumes 1-indexed counting internally: `i + 1` converts from 0-indexed to 1-indexed for the "number of start positions" calculation.
- The `+ 1` before `// 2` is load-bearing — without it, the count would be wrong whenever `(i + 1) * (n - i)` is odd.

## Error Handling

None. The method trusts its input matches the LeetCode contract (non-empty array of positive integers). No bounds checking, no empty-array guard.

## Topics to Explore

- [file] `sum-of-all-odd-length-subarrays/test_solution.py` — See what edge cases are tested and whether the O(n) formula is validated against a brute-force reference
- [file] `sum-of-all-odd-length-subarrays/plan.md` — Check whether the plan documents the derivation of the contribution formula or considered alternative approaches
- [general] `contribution-counting-pattern` — This inversion technique (per-element contribution instead of per-subarray enumeration) appears across many LeetCode array problems and is worth recognizing as a pattern family
- [function] `sum-of-all-subset-xor-totals/solution.py:Solution.subsetXORSum` — Another problem in this repo that likely uses a similar per-element contribution technique, worth comparing approaches

## Beliefs

- `odd-subarray-formula-correctness` — For an array of length n, element at index i appears in exactly `((i+1)*(n-i)+1)//2` odd-length subarrays
- `odd-subarray-time-complexity` — `sumOddLengthSubarrays` runs in O(n) time and O(1) extra space, making a single pass over the array
- `odd-subarray-rounding-invariant` — The `+1` before `//2` is necessary because when the total subarray count `(i+1)*(n-i)` is odd, there is exactly one more odd-length subarray than even-length subarray containing that index
- `odd-subarray-no-validation` — The method performs no input validation and will return 0 for an empty array without error

