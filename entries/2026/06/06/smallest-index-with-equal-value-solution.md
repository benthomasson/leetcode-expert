# File: smallest-index-with-equal-value/solution.py

**Date:** 2026-06-06
**Time:** 19:09

## Purpose

This file solves [LeetCode 2057 — Smallest Index With Equal Value](https://leetcode.com/problems/smallest-index-with-equal-value/). It owns the single responsibility of finding the smallest index `i` in a list where `i % 10 == nums[i]`.

## Key Components

### `smallest_index(nums: list[int]) -> int`

The sole public function. Contract:

- **Input**: A list of integers, each in range `[0, 9]`, representing a 0-indexed array.
- **Output**: The smallest index `i` such that `i % 10 == nums[i]`, or `-1` if no such index exists.
- **Guarantee**: Returns the *first* match due to left-to-right iteration with early return.

## Patterns

**Linear scan with early exit** — the simplest possible approach for a "find first match" problem. No preprocessing, no data structures. `enumerate` gives both index and value in a single pass, and the function returns immediately on the first hit. This is idiomatic Python for problems where you need the first element satisfying a predicate.

The `% 10` operation extracts the ones digit of the index, which is the only digit that matters since `nums[i]` is constrained to `[0, 9]`. For indices 0–9, `i % 10 == i`. For indices 10+, only the last digit of the index is compared.

## Dependencies

**Imports**: None — pure standard library Python.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share a common test harness import pattern. The actual consumer is `smallest-index-with-equal-value/test_solution.py`.

## Flow

1. Iterate over `nums` with `enumerate`, yielding `(i, val)` pairs starting from index 0.
2. For each pair, check if `i % 10 == val`.
3. On the first match, return `i` immediately.
4. If the loop exhausts without a match, return `-1`.

Time complexity: O(n) worst case, O(1) best case (match at index 0). Space complexity: O(1).

## Invariants

- The function always returns a deterministic result for a given input — no randomness, no state.
- The return value is either a valid index into `nums` or exactly `-1`.
- If a non-negative value is returned, `return_value % 10 == nums[return_value]` holds.
- No index smaller than the returned value satisfies the condition (guaranteed by left-to-right scan with early return).

## Error Handling

None. The function trusts its caller to provide a valid `list[int]`. An empty list produces `-1` (the `for` loop simply doesn't execute). No exceptions are raised or caught.

## Topics to Explore

- [file] `smallest-index-with-equal-value/test_solution.py` — See which edge cases the test suite covers (empty list, all matches, no matches, large indices)
- [file] `smallest-index-with-equal-value/plan.md` — The approach reasoning and alternative strategies considered before implementation
- [function] `fixed-point/solution.py:fixed_point` — A structurally similar problem (find `i` where `nums[i] == i`) that uses binary search on a sorted array instead of linear scan
- [general] `modular-arithmetic-in-index-problems` — How `% 10` constrains the search space: only indices ending in digit `d` can match `nums[i] == d`, which means at most 1 in 10 indices can match any given value

## Beliefs

- `smallest-index-returns-first-match` — `smallest_index` returns the leftmost index satisfying `i % 10 == nums[i]`, guaranteed by sequential iteration with early return
- `smallest-index-sentinel-is-negative-one` — The function returns `-1` (not `None` or an exception) when no valid index exists, matching LeetCode's expected contract
- `smallest-index-is-pure` — The function has no side effects, no mutable state, and no dependencies beyond its input argument
- `smallest-index-linear-time` — Worst-case time complexity is O(n) with a single pass; no sorting or auxiliary data structures are used

