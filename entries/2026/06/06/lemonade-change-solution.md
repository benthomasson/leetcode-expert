# File: lemonade-change/solution.py

**Date:** 2026-06-06
**Time:** 17:21

## Purpose

This file solves [LeetCode 860 — Lemonade Change](https://leetcode.com/problems/lemonade-change/). It simulates a cashier selling lemonade at $5 per cup, processing a queue of customers who each pay with a $5, $10, or $20 bill. The sole responsibility is determining whether you can make correct change for every customer using only the bills you've collected so far.

## Key Components

**`Solution.lemonadeChange(self, bills: List[int]) -> bool`** — The single method. Takes a list of bill denominations (each 5, 10, or 20), returns `True` if every customer receives correct change, `False` at the first failure.

Two local counters track inventory:
- `fives` — count of $5 bills on hand
- `tens` — count of $10 bills on hand

$20 bills are never tracked because they're never useful as change (no item costs more than $20).

## Patterns

**Greedy simulation.** The algorithm processes bills left-to-right, making the locally optimal change decision at each step. For the $20 case, it prefers spending one $10 + one $5 over three $5s. This greedy preference is correct because $10 bills are less flexible than $5 bills — a $10 can only help with $20 change, while a $5 helps with both $10 and $20 change. Preserving $5s maximizes future options.

**Early return on failure.** The moment change can't be made, the method short-circuits with `False` rather than continuing to process the remaining queue.

## Dependencies

**Imports:** `typing.List` — used only for the type annotation on `bills`.

**Imported by:** `lemonade-change/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those are unrelated test files, not actual consumers of this module.

## Flow

For each bill in the input:

1. **$5 bill** — No change needed. Increment `fives`.
2. **$10 bill** — Owe $5 change. If no $5 bills available, return `False`. Otherwise decrement `fives`, increment `tens`.
3. **$20 bill** — Owe $15 change. Try $10+$5 first (greedy preference). Fall back to $5+$5+$5. If neither works, return `False`.

If the entire list is processed without hitting a `False`, return `True`.

## Invariants

- `fives >= 0` and `tens >= 0` at all times — the code checks before decrementing and returns `False` rather than going negative.
- The greedy order for $20 change ($10+$5 before $5+$5+$5) is load-bearing for correctness. Reversing it would cause wrong answers on inputs like `[5,5,5,10,20]` where you need the $10 to avoid exhausting $5s.
- The input is assumed to contain only values in {5, 10, 20}. No validation is performed — any other value falls into the `else` branch and is treated as a $20.

## Error Handling

None. Invalid inputs (negative numbers, non-standard denominations) are silently treated as $20 bills via the `else` branch. This follows LeetCode convention where inputs are guaranteed to meet the problem's constraints.

## Topics to Explore

- [file] `lemonade-change/test_solution.py` — See which edge cases are covered (all-fives, immediate $20, mixed sequences)
- [file] `lemonade-change/plan.md` — The planning document may capture alternative approaches considered (e.g., backtracking vs greedy)
- [file] `assign-cookies/solution.py` — Another greedy simulation problem in this repo; compare the greedy strategy structure
- [general] `greedy-change-proof` — Why the $10-before-$5 preference is provably optimal, not just heuristically good
- [file] `lemonade-change/review.md` — Post-implementation review notes for this solution

## Beliefs

- `lemonade-greedy-order-is-critical` — For $20 bills, preferring $10+$5 over $5×3 is necessary for correctness, not just an optimization
- `twenty-dollar-bills-never-tracked` — $20 bills are never stored because they can never be used as change, keeping state to two counters
- `else-branch-assumes-twenty` — Any bill value that isn't 5 or 10 is treated as 20 with no validation, relying on LeetCode's input guarantees
- `time-linear-space-constant` — The algorithm is O(n) time and O(1) space, using only two integer counters regardless of input size

