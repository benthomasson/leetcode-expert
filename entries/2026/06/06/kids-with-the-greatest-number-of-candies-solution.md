# File: kids-with-the-greatest-number-of-candies/solution.py

**Date:** 2026-06-06
**Time:** 17:11

## `kids-with-the-greatest-number-of-candies/solution.py`

### Purpose

Solves [LeetCode 1431 — Kids With the Greatest Number of Candies](https://leetcode.com/problems/kids-with-the-greatest-number-of-candies/). Given a list of candy counts per kid and a number of extra candies, determine which kids would have the maximum (or tied-for-maximum) count if they alone received all the extra candies.

### Key Components

**`Solution.kidsWithCandies(candies, extraCandies) -> List[bool]`** — the single method. Contract:

- **Input**: `candies` is a non-empty list of non-negative ints; `extraCandies` is a non-negative int.
- **Output**: A boolean list of the same length, where `result[i]` is `True` iff `candies[i] + extraCandies >= max(candies)`.

### Patterns

- **Precompute-then-sweep**: Computes `max_candies` once in O(n), then builds the result in a single list comprehension — also O(n). This avoids the naive O(n^2) approach of calling `max()` inside the loop.
- **LeetCode class convention**: Wraps the solution in a `Solution` class with a specifically-named method, matching the LeetCode submission interface used across this entire repo.

### Dependencies

- **Imports**: `List` from `typing` — used only for the type annotation. No runtime dependency beyond the standard library.
- **Imported by**: `kids-with-the-greatest-number-of-candies/test_solution.py` imports this `Solution` class. The long "Imported By" list in the prompt is an artifact of the tooling — those test files import their own local `Solution`, not this one.

### Flow

1. `max(candies)` scans the full list to find the current global maximum.
2. The list comprehension iterates each kid's count `c`, checks if `c + extraCandies` meets or exceeds that maximum, and collects the booleans.
3. Returns the result directly — no mutation of input.

### Invariants

- `len(result) == len(candies)` — output is always index-aligned with input.
- The comparison is `>=`, not `>` — a kid who already has the max (without extra candies) always gets `True`.
- `max(candies)` will raise `ValueError` on an empty list; the problem guarantees `n >= 2`, so this is never hit under valid input.

### Error Handling

None. The function trusts its caller to provide valid input per the problem constraints. An empty `candies` list would propagate a `ValueError` from `max()`.

## Topics to Explore

- [file] `kids-with-the-greatest-number-of-candies/test_solution.py` — See which edge cases the tests cover (all-equal, single kid at max, etc.)
- [file] `kids-with-the-greatest-number-of-candies/review.md` — Code review notes may flag alternative approaches or complexity analysis
- [function] `distribute-candies/solution.py:Solution.distributeCandies` — Another candy-themed problem; compare how a set-based approach differs from this threshold check
- [general] `list-comprehension-vs-map` — Whether the repo consistently uses comprehensions or mixes in `map()`/`filter()` across solutions

## Beliefs

- `kids-candies-linear-time` — `kidsWithCandies` runs in O(n) time and O(n) space, making exactly two passes over the input (one for `max`, one for the comprehension).
- `kids-candies-gte-not-gt` — The comparison uses `>=`, so a kid already at the global max always returns `True` regardless of `extraCandies`.
- `kids-candies-no-mutation` — The function never modifies the input `candies` list; it returns a new list.
- `kids-candies-empty-input-crashes` — Passing an empty list raises `ValueError` from `max()`; the problem constraints prevent this.

