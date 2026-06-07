# File: x-of-a-kind-in-a-deck-of-cards/solution.py

**Date:** 2026-06-06
**Time:** 19:42

## Purpose

This file solves [LeetCode 914: X of a Kind in a Deck of Cards](https://leetcode.com/problems/x-of-a-kind-in-a-deck-of-cards/). It determines whether a deck of cards can be partitioned into groups where every group has the same size `x >= 2` and all cards within each group share the same integer label.

## Key Components

### `Solution.hasGroupsSizeX(self, deck: list[int]) -> bool`

The single method. Its contract: given a list of integer card labels, return `True` if there exists some `x >= 2` such that the deck can be split into groups of exactly `x` cards, each group containing only one distinct value.

## Patterns

**Reduce-to-GCD idiom.** Rather than trying every possible group size, the solution exploits the mathematical insight that a valid `x` exists if and only if the GCD of all card counts is at least 2. This is a common competitive-programming reduction — transforming a search problem into a single arithmetic operation.

The pipeline is functional-style: `Counter` → `.values()` → `reduce(gcd, ...)` → threshold check. No mutation, no intermediate variables.

## Dependencies

**Imports:**
- `collections.Counter` — frequency counting
- `functools.reduce` — fold GCD across all counts
- `math.gcd` — pairwise GCD (the binary function fed to `reduce`)

**Imported by:** The corresponding `x-of-a-kind-in-a-deck-of-cards/test_solution.py` exercises this solution. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those test files don't actually import *this* solution; they share a common test harness pattern.

## Flow

1. `Counter(deck)` counts how many times each integer appears. For `[1,1,2,2,2,2]`, this yields `{1: 2, 2: 4}`.
2. `.values()` extracts just the counts: `[2, 4]`.
3. `reduce(gcd, counts)` folds pairwise GCD across all counts: `gcd(2, 4) = 2`.
4. The result is compared `>= 2`. If the GCD is at least 2, every count is divisible by that GCD, so groups of that size work.

## Invariants

- **`x >= 2` is enforced by the `>= 2` check.** A GCD of 1 means no valid grouping exists (you can't split into groups of 1 — the problem requires `x > 1`).
- **Every count must be divisible by `x`.** The GCD is the largest such `x`, so checking it once is sufficient — if the GCD works, it works for all values.
- **`deck` is assumed non-empty.** `reduce` on an empty iterable raises `TypeError`. The LeetCode constraints guarantee `1 <= deck.length`, so this is safe within the problem's contract.

## Error Handling

None. The solution trusts the LeetCode input contract (non-empty list of integers). An empty `deck` would crash at `reduce` with no initial value. This is appropriate for a competitive-programming solution operating under guaranteed constraints.

## Topics to Explore

- [file] `x-of-a-kind-in-a-deck-of-cards/test_solution.py` — See which edge cases are tested (single-element deck, all identical, coprime counts)
- [file] `x-of-a-kind-in-a-deck-of-cards/review.md` — Review notes may document alternative approaches or complexity analysis
- [function] `divide-array-into-equal-pairs/solution.py:Solution` — Related partitioning problem; likely uses a similar count-parity approach
- [general] `gcd-in-grouping-problems` — The GCD-of-frequencies pattern recurs in problems about equal partitioning and divisibility constraints
- [file] `find-greatest-common-divisor-of-array/solution.py` — Another GCD-based solution; compare how `math.gcd` is applied differently

## Beliefs

- `gcd-determines-valid-partition` — The deck can be partitioned into equal-sized groups of matching values if and only if the GCD of all value frequencies is >= 2
- `reduce-gcd-no-initializer` — `reduce(gcd, counts)` is called without an initial value, meaning it will raise `TypeError` on an empty deck (safe under LeetCode constraints but not defensively coded)
- `solution-is-linear-time` — The algorithm runs in O(n + k log(max_count)) where n is deck length and k is the number of distinct values, dominated by the Counter construction
- `single-pass-no-search` — The solution never iterates over candidate group sizes; it computes the answer in one arithmetic fold

