# File: find-subsequence-of-length-k-with-the-largest-sum/solution.py

**Date:** 2026-06-06
**Time:** 16:43

## Purpose

This file solves [LeetCode 2099: Find Subsequence of Length K With the Largest Sum](https://leetcode.com/problems/find-subsequence-of-length-k-with-the-largest-sum/). It owns the core algorithm for selecting the `k` elements with the largest values from an array while preserving their original relative order — the defining constraint that separates "subsequence" from "subset."

## Key Components

### `count_patterns_in_word(nums, k) -> List[int]`

**Note: the function name is a misnomer.** It has nothing to do with counting patterns in words — this is clearly a copy-paste artifact from another solution. The docstring correctly describes the actual behavior: return a length-k subsequence with the largest sum.

**Contract:**
- **Input:** `nums` (list of ints), `k` (int, how many elements to select)
- **Output:** A list of `k` integers from `nums` in their original order, maximizing total sum
- **Assumes:** `1 <= k <= len(nums)` (no guard for invalid `k`)

## Patterns

**Sort-select-restore idiom.** The algorithm uses a two-sort approach common in subsequence selection problems:

1. **Tag with position** — `enumerate(nums)` pairs each value with its index.
2. **Sort by value** — pick the top-k elements by descending value.
3. **Sort by position** — re-sort the selected elements by their original index to restore input order.
4. **Strip metadata** — extract just the values.

This is O(n log n) time, O(n) space. It avoids a heap only because Python's `sorted` is convenient and the constant factors are similar at LeetCode scale.

## Dependencies

**Imports:** Only `typing.List` — no external libraries.

**Imported by:** The massive `Imported By` list in the context is misleading. Those are test files from *other* problems that happen to share a common test harness import pattern. The real consumer is `find-subsequence-of-length-k-with-the-largest-sum/test_solution.py`.

## Flow

```
nums = [2, 1, 3, 3], k = 2

1. enumerate:        [(0,2), (1,1), (2,3), (3,3)]
2. sort desc by val: [(2,3), (3,3), (0,2), (1,1)]
3. slice [:k]:       [(2,3), (3,3)]
4. sort by index:    [(2,3), (3,3)]         # already ordered here
5. extract values:   [3, 3]
```

The key insight: step 2 selects *which* elements maximize the sum, and step 4 restores the subsequence ordering invariant.

## Invariants

- The output always has exactly `k` elements (assuming valid input).
- Output elements appear in the same relative order as in `nums`.
- When multiple elements share the same value, `sorted` is stable, but the `[:k]` slice takes whichever appears first in the descending-value sort. Since we later re-sort by index, the final order is always correct regardless of tie-breaking.

## Error Handling

None. If `k > len(nums)`, the function silently returns fewer than `k` elements (the slice just takes everything). If `k <= 0`, it returns an empty list. No exceptions are raised.

## Topics to Explore

- [file] `find-subsequence-of-length-k-with-the-largest-sum/test_solution.py` — See what edge cases the tests cover (ties, negatives, k=n)
- [file] `minimum-subsequence-in-non-increasing-order/solution.py` — Related problem that also selects elements by value but with a different ordering constraint
- [file] `find-subsequence-of-length-k-with-the-largest-sum/plan.md` — Original approach reasoning before implementation
- [general] `function-name-mismatch-pattern` — Whether other solutions in this repo share the `count_patterns_in_word` naming bug, suggesting a batch-generation artifact
- [file] `largest-subarray-length-k/solution.py` — Compare: contiguous subarray vs. subsequence selection for a similar "pick k elements" problem

## Beliefs

- `misnamed-function` — The function `count_patterns_in_word` does not count patterns; it selects a max-sum subsequence. The name is a copy-paste error from another solution.
- `two-sort-preserves-order` — Sorting selected elements by their original index after value-based selection guarantees subsequence ordering without tracking insertion order.
- `no-input-validation` — The function performs no bounds checking on `k`; callers must ensure `1 <= k <= len(nums)`.
- `stable-sort-irrelevant` — Although Python's sort is stable, the algorithm's correctness does not depend on stability — any top-k selection followed by index-sort produces a valid answer.

