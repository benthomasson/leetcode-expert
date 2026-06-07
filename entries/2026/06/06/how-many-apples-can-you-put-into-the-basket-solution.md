# File: how-many-apples-can-you-put-into-the-basket/solution.py

**Date:** 2026-06-06
**Time:** 17:01

## Purpose

This file solves [LeetCode 1196 — How Many Apples Can You Put into the Basket](https://leetcode.com/problems/how-many-apples-can-you-put-into-the-basket/). It owns both the solution implementation and its unit tests in a single module. The problem: given a list of apple weights, return the maximum number of apples that fit in a basket with a weight capacity of 5000.

## Key Components

### `maxNumberOfApples(weight: list[int]) -> int`

A greedy function that maximizes the count of apples fitting within a 5000-unit capacity. It sorts the input ascending and greedily accumulates the lightest apples first, returning the count when adding the next apple would exceed the limit.

**Contract**: accepts a list of positive integer weights, returns an integer in `[0, len(weight)]`. Mutates the input list via `weight.sort()`.

### `TestMaxNumberOfApples`

Eight test cases covering: all fit, partial fit, single-element edge cases (fits / too heavy), exact capacity, none fit, uniform weights, and a large input of minimal weights.

## Patterns

**Greedy sort-and-accumulate**: The canonical approach for "maximize count under a weight budget" problems. Sorting ascending ensures the lightest items are picked first, which is provably optimal when the objective is to maximize the number of items (not value).

**Inline tests**: Solution and tests colocated in one file, consistent with every other problem directory in this repo. The `if __name__ == "__main__"` guard allows running tests directly.

## Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The `test_solution.py` file in this same directory, plus hundreds of other `test_solution.py` files across the repo reference it (the "Imported By" list in the prompt is likely an artifact of how the repo's test harness discovers modules, not direct imports of this specific function).

## Flow

1. `weight.sort()` — in-place ascending sort, O(n log n)
2. Iterate with `enumerate`, accumulating a running `total`
3. On each iteration, add the current weight to `total`
4. If `total > 5000`, return `i` (the number of apples *before* this one)
5. If the loop completes without exceeding 5000, return `len(weight)` — all apples fit

The early return on line 17 (`return i`) is the key: `i` is zero-indexed, so it equals the count of apples added *before* the one that broke the budget.

## Invariants

- **Capacity is hardcoded at 5000** — not parameterized. This matches the LeetCode problem spec.
- **Greedy correctness**: sorting ascending guarantees that any subset of `k` items starting from the lightest has the minimum possible total weight among all size-`k` subsets. So if the first `k` items exceed capacity, no `k`-item subset fits.
- **Mutation**: the input list is sorted in place. Callers should not rely on the original order being preserved.

## Error Handling

None. The function assumes valid input per LeetCode constraints (non-empty list of positive integers). No bounds checking, no exception handling. Invalid input (empty list, negative weights) would produce silently wrong results rather than errors — `[]` returns `0`, which happens to be reasonable.

## Topics to Explore

- [file] `how-many-apples-can-you-put-into-the-basket/review.md` — The code review may document alternative approaches (e.g., using a heap or partial sort) and complexity tradeoffs
- [file] `maximum-units-on-a-truck/solution.py` — A closely related greedy problem (maximize value under a count/weight constraint) that likely uses a similar sort-and-accumulate pattern but with a different optimization target
- [file] `assign-cookies/solution.py` — Another greedy assignment problem; comparing the two reveals how the greedy criterion changes when both supply and demand are sorted
- [general] `greedy-vs-knapsack` — This problem is a degenerate knapsack where all items have value=1, making greedy optimal; understanding when greedy fails (items have differing values) is the key insight
- [file] `run_tests.py` — The repo-wide test runner that executes tests across all problem directories

## Beliefs

- `apples-greedy-optimality` — Sorting ascending and taking greedily is optimal for maximizing item count under a weight budget because all items have equal value (1 apple = 1 unit of value)
- `apples-mutates-input` — `maxNumberOfApples` mutates the caller's list via `weight.sort()` rather than using `sorted()`
- `apples-capacity-hardcoded` — The basket capacity of 5000 is hardcoded in the function body, not parameterized
- `apples-early-return-index` — The function returns the loop index `i` (not `i+1`) on budget overflow because `enumerate` is zero-based and `i` equals the count of previously accumulated apples

