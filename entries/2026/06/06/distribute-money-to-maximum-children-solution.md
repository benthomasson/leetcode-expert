# File: distribute-money-to-maximum-children/solution.py

**Date:** 2026-06-06
**Time:** 16:25

## Purpose

This file implements [LeetCode 2591: Distribute Money to Maximum Children](https://leetcode.com/problems/distribute-money-to-maximum-children/). It solves a greedy distribution problem: given `money` dollars and `children` recipients, maximize the number of children who receive exactly $8, subject to two constraints — every child must get at least $1, and no child can receive exactly $4.

The file is self-contained: solution function, test suite, and entrypoint all live in one module. It follows the repo-wide convention of `solution.py` per problem directory.

## Key Components

### `maximum_children_with_eight_dollars(money, children) -> int`

The core solver. Contract:

- **Input**: `money >= 1`, `children >= 1` (per LeetCode constraints)
- **Output**: max count of children receiving exactly $8, or `-1` if distribution is impossible (not enough money to give each child at least $1)

### `TestMaximumChildrenWithEightDollars`

11 unit tests covering the impossible case, exact-fit cases, and both special edge-case corrections.

## Flow

The algorithm works in four steps:

1. **Feasibility check** (line 16): if `money < children`, return `-1` — can't give everyone the minimum $1.

2. **Baseline allocation** (line 18): give every child $1, leaving `remaining = money - children`. Each "$8 child" now needs $7 more (since they already have $1).

3. **Greedy assignment** (line 19): `eights = min(remaining // 7, children)` — as many $8 recipients as the budget allows, capped by child count.

4. **Correction for two forbidden states**:
   - **Lines 24–25**: All children got $8 but there's leftover money. Since every dollar must be distributed and no new child exists to absorb it, one child must take the surplus — reducing `eights` by 1.
   - **Lines 28–29**: Exactly one child remains un-eighted and they'd receive exactly $1 + $3 = $4, which is forbidden. Sacrifice one $8-child to redistribute and avoid $4.

## Patterns

- **Greedy with post-hoc correction**: compute the optimistic answer, then fix constraint violations. This is idiomatic for LeetCode distribution problems — cheaper than enumerating allocations.
- **Baseline-then-upgrade**: giving $1 to everyone first reduces the problem to distributing `remaining` in increments of $7.

## Dependencies

- **Imports**: only `unittest` (stdlib).
- **Imported by**: `distribute-money-to-maximum-children/test_solution.py` (and the "Imported By" list in the prompt is the repo's test harness cross-import graph, not direct consumers of this function).

## Invariants

1. Every child receives at least $1 — enforced by the `money < children` guard.
2. No child receives exactly $4 — enforced by the `others == 1 and leftover == 3` correction.
3. All money is distributed — enforced by the `eights == children and leftover > 0` correction (surplus can't vanish; someone must absorb it).
4. The return value is in `[-1, children]`.

## Error Handling

No exceptions. The single error state (impossible distribution) is signaled by the `-1` return value, matching LeetCode's API contract.

---

## Topics to Explore

- [file] `distribute-money-to-maximum-children/test_solution.py` — The companion test file; check whether it covers the $4-avoidance edge case differently from the inline tests
- [file] `distribute-candies-to-people/solution.py` — Another distribution problem in the repo; compare the greedy strategy used there
- [general] `greedy-correction-pattern` — How the "compute optimistic, then fix violations" pattern recurs across LeetCode distribution and assignment problems
- [function] `distribute-money-to-maximum-children/solution.py:maximum_children_with_eight_dollars` — Trace through with `money=12, children=2` to see both corrections interact (eights=1, leftover=3, others=1 triggers the $4 fix)

## Beliefs

- `no-child-gets-four-dollars` — The `others == 1 and leftover == 3` branch specifically prevents the remaining child from receiving exactly $4, which the problem forbids
- `eights-capped-by-children-and-budget` — `eights` never exceeds `min(remaining // 7, children)`, ensuring neither over-allocation nor phantom children
- `surplus-forces-sacrifice` — When all children would get $8 but leftover money remains, exactly one child is demoted to absorb the surplus, because the problem requires distributing all money
- `minus-one-means-infeasible` — The function returns `-1` if and only if `money < children`, the sole condition where giving every child at least $1 is impossible

