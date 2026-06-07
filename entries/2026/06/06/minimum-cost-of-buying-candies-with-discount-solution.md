# File: minimum-cost-of-buying-candies-with-discount/solution.py

**Date:** 2026-06-06
**Time:** 17:54

## Purpose

This file solves [LeetCode 2144: Minimum Cost of Buying Candies With Discount](https://leetcode.com/problems/minimum-cost-of-buying-candies-with-discount/). The problem: you buy candies and for every two you pay for, you get one free (the free one must cost no more than the minimum of the two you paid for). The goal is to minimize total spend.

## Key Components

**`Solution.minimumCost(cost: List[int]) -> int`** — The core solver. Takes a list of candy prices, returns the minimum total cost after optimally applying the "buy 2, get 1 free" discount.

**`max_difference`** — A class-level alias pointing to `minimumCost`. The comment says "Task requires this alias," which suggests the test harness or a shared test runner expects this name. This is likely a copy-paste artifact from another solution's scaffolding — `max_difference` has no semantic relationship to this problem.

## Patterns

**Greedy via sort-then-skip.** The algorithm sorts descending and skips every third element (index % 3 == 2). This is the canonical greedy approach: by paying for the two most expensive candies first, you maximize the value of the free candy. The pattern of `sort + enumerate + modular index filter` is a compact idiom for "process in groups of K, skipping some."

**In-place mutation.** `cost.sort(reverse=True)` mutates the caller's list. This is a minor contract concern — the caller's data is reordered after the call.

## Dependencies

**Imports:** Only `typing.List` — no external libraries.

**Imported by:** The test file `minimum-cost-of-buying-candies-with-discount/test_solution.py`. The massive "Imported By" list in the prompt is noise — those are unrelated test files that happen to import a `Solution` class from their own sibling `solution.py`, not this one.

## Flow

1. Sort `cost` in descending order (highest price first).
2. Enumerate the sorted list. For each candy at index `i`:
   - If `i % 3 != 2`: include its cost (you're paying for it).
   - If `i % 3 == 2`: skip it (this is your free candy).
3. Sum and return the included costs.

Concretely, for `cost = [1, 2, 3, 4, 5, 6]`:
- Sorted: `[6, 5, 4, 3, 2, 1]`
- Indices: `0:6, 1:5, 2:4(skip), 3:3, 4:2, 5:1(skip)`
- Total: `6 + 5 + 3 + 2 = 16`

## Invariants

- The greedy strategy is optimal because sorting descending ensures each free candy is as expensive as possible. Every group of 3 consecutive elements in the sorted order represents one "buy 2 get 1 free" transaction, and the cheapest of the three is always the free one.
- Works correctly for `len(cost) < 3` — no candy is ever skipped, since no index reaches `i % 3 == 2`.

## Error Handling

None. The function assumes valid input per LeetCode constraints (`1 <= cost.length <= 100`, `1 <= cost[i] <= 100`). Empty lists would return 0 (correct but not explicitly guarded).

## Topics to Explore

- [file] `minimum-cost-of-buying-candies-with-discount/test_solution.py` — Verify what test cases exercise edge cases (1-2 items, all equal prices)
- [file] `minimum-cost-of-buying-candies-with-discount/plan.md` — See if the plan discusses why greedy is optimal vs. DP alternatives
- [general] `sort-and-skip-greedy-pattern` — This same "sort descending, skip every Kth" pattern appears in problems like array-partition and maximum-units-on-a-truck
- [function] `minimum-cost-of-buying-candies-with-discount/solution.py:max_difference` — Investigate whether this alias is actually exercised by tests or is dead code from scaffolding

## Beliefs

- `greedy-skip-every-third` — Sorting descending and summing all elements where `i % 3 != 2` yields the minimum cost under the "buy 2 get 1 free" rule
- `in-place-sort-mutation` — `minimumCost` mutates the input list via `cost.sort()`; callers cannot assume the list is unchanged after the call
- `max-difference-alias-is-vestigial` — The `max_difference` alias has no semantic connection to this problem and appears to be scaffolding from the test generator
- `no-guard-on-empty-input` — The solution handles empty lists correctly (returns 0) but does not explicitly validate input constraints

