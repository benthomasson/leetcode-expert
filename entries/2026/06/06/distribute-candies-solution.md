# File: distribute-candies/solution.py

**Date:** 2026-06-06
**Time:** 16:25

## `distribute-candies/solution.py`

### Purpose

This file solves [LeetCode 575 - Distribute Candies](https://leetcode.com/problems/distribute-candies/). It determines the maximum number of distinct candy types Alice can eat, given she's allowed exactly half the total candies.

### Key Components

**`maxNumberOfCandies(candyType: list[int]) -> int`** — The sole function. Takes an array where each element represents a candy's type, returns the maximum number of *distinct* types Alice can eat when restricted to `n/2` candies.

The implementation is a single expression: `min(len(candyType) // 2, len(set(candyType)))`.

### Patterns

**Constraint-as-min pattern.** The answer is bounded by two independent constraints — she can eat at most `n/2` candies, and there are at most `k` distinct types. The answer is simply `min(n/2, k)`. This is a common idiom in greedy problems where the answer is the tighter of two upper bounds.

**Standalone function (no class).** Unlike LeetCode's typical `class Solution` wrapper, this exports a bare function. Consistent with the rest of this repo's convention.

### Dependencies

**Imports:** None. Uses only builtins (`len`, `set`, `min`, integer division).

**Imported by:** `distribute-candies/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are *all* test files across the repo, likely an artifact of the test harness importing a shared runner, not this specific module.

### Flow

1. `set(candyType)` — deduplicate to get the count of distinct types, O(n).
2. `len(candyType) // 2` — compute Alice's eating quota (integer division, always valid since the problem guarantees even-length input).
3. `min(...)` — return the tighter bound.

No branching, no iteration beyond what `set()` does internally. Single-pass through the data.

### Invariants

- The problem guarantees `len(candyType)` is even, so `// 2` is exact.
- The problem guarantees `2 <= len(candyType) <= 10^4`, so the list is never empty.
- The function is pure — no mutation of the input.

### Error Handling

None. The function trusts its caller to provide valid input per the problem constraints. An empty list would return 0 (not crash), but odd-length lists would silently floor-divide — acceptable given the problem contract.

---

## Topics to Explore

- [file] `distribute-candies/test_solution.py` — See what edge cases the test suite covers (all same type, all distinct, exactly n/2 types)
- [file] `fair-candy-swap/solution.py` — Another candy-themed problem using set lookups for O(1) membership checks
- [general] `set-based-counting-pattern` — Many solutions in this repo reduce distinct-count problems to `len(set(...))` — worth cataloging which ones
- [file] `divide-array-into-equal-pairs/solution.py` — Related problem about pairing elements, likely also uses set/counter approaches
- [function] `distribute-candies-to-people/solution.py:distributeCandies` — Different problem (sequential distribution), contrasts greedy-min with simulation

## Beliefs

- `distribute-candies-greedy-min` — The answer is always `min(n//2, distinct_count)` because Alice can greedily pick one of each type until she hits either the type limit or the quantity limit.
- `distribute-candies-linear-time` — The solution runs in O(n) time and O(n) space due to the set construction; no sorting needed.
- `distribute-candies-no-class-wrapper` — This solution uses a bare function rather than a `class Solution` wrapper, matching the repo-wide convention.
- `distribute-candies-pure-function` — `maxNumberOfCandies` has no side effects and does not mutate its input list.

