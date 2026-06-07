# File: sort-even-and-odd-indices-independently/solution.py

**Date:** 2026-06-06
**Time:** 19:11

## Purpose

This file solves [LeetCode 2164: Sort Even and Odd Indices Independently](https://leetcode.com/problems/sort-even-and-odd-indices-independently/). It takes an integer array and returns a new array where values at even indices (0, 2, 4, ...) are sorted in non-decreasing order and values at odd indices (1, 3, 5, ...) are sorted in non-increasing order, then interleaved back into their respective positions.

Note: the function is named `maxValue`, which doesn't match the LeetCode canonical name `sortEvenOdd` — likely a naming artifact from the project's code generation pipeline.

## Key Components

**`maxValue(nums: list[int]) -> list[int]`** — The sole public function. Takes an integer list, returns a new list with the even/odd index sorting applied. Does not mutate the input.

## Patterns

**Slice-and-recombine**: The solution uses Python's slice syntax (`nums[::2]`, `nums[1::2]`) to partition elements by index parity, sorts each partition independently, then zips them back by iterating over the original index range and picking from the appropriate sorted list using `i % 2` and `i // 2`.

This is a common idiom in LeetCode Python solutions — decompose by some property, transform, recompose. It avoids in-place index juggling and is easy to reason about correctness.

## Dependencies

**Imports**: None — uses only built-in `sorted()` and list operations.

**Imported by**: The `test_solution.py` in the same directory, plus hundreds of other test files listed in the "Imported By" section. That massive import list is clearly a project artifact — those test files likely share a common test harness pattern that imports from sibling solution modules, not that they actually use `maxValue`.

## Flow

1. **Extract**: `nums[::2]` pulls elements at indices 0, 2, 4, ... into `evens`. `nums[1::2]` pulls indices 1, 3, 5, ... into `odds`.
2. **Sort**: `evens` sorted ascending (default). `odds` sorted descending (`reverse=True`).
3. **Interleave**: Loop over `range(len(nums))`. For even `i`, pull from `evens[i // 2]`. For odd `i`, pull from `odds[i // 2]`. The `i // 2` mapping works because even indices 0, 2, 4 map to positions 0, 1, 2 in `evens`, and odd indices 1, 3, 5 map to positions 0, 1, 2 in `odds`.

## Invariants

- `len(evens) + len(odds) == len(nums)` — the partition is exhaustive.
- `len(evens) - len(odds)` is 0 or 1 — when `len(nums)` is odd, there's one extra even-indexed element. The `i // 2` indexing handles both cases without special-casing.
- The output preserves the input length exactly.

## Error Handling

None. The function assumes a valid non-empty list as input per LeetCode constraints. An empty list would return `[]` correctly since both slices and the range would be empty.

## Topics to Explore

- [file] `sort-even-and-odd-indices-independently/test_solution.py` — See what edge cases the test suite covers (empty, single element, all-same values)
- [file] `sort-even-and-odd-indices-independently/review.md` — Check if the review flagged the `maxValue` naming mismatch
- [function] `sort-array-by-parity/solution.py:sortArrayByParity` — Related partitioning-by-index-parity problem with a different twist
- [file] `sort-array-by-parity-ii/solution.py` — Another parity-based sorting problem; compare approaches
- [general] `function-naming-convention` — Whether `maxValue` is a one-off or a systematic naming issue across solutions

## Beliefs

- `sort-even-odd-no-mutation` — `maxValue` returns a new list and never mutates the input `nums`
- `sort-even-odd-misnamed` — The function is named `maxValue` but the LeetCode problem's canonical method name is `sortEvenOdd`
- `sort-even-odd-linear-interleave` — The interleave step uses `i // 2` to map original indices back to positions in the sorted partitions, which is correct for both even and odd length inputs
- `sort-even-odd-time-complexity` — Time complexity is O(n log n) dominated by the two `sorted()` calls; space is O(n) for the partition lists and result

