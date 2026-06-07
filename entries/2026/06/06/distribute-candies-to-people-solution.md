# File: distribute-candies-to-people/solution.py

**Date:** 2026-06-06
**Time:** 16:24

## Purpose

This file implements the solution to [LeetCode 1103 — Distribute Candies to People](https://leetcode.com/problems/distribute-candies-to-people/). It owns exactly one responsibility: given a total candy count and a number of people, distribute candies in rounds of increasing amounts, wrapping around the row until all candies are exhausted.

## Key Components

### `distribute_candies(candies: int, num_people: int) -> list[int]`

The sole function. Contract:

- **Input**: `candies` (total to distribute, non-negative), `num_people` (row length, positive).
- **Output**: A list of length `num_people` where each element is the total candies that person received across all rounds.
- The last person to receive candies in a round may get fewer than expected if the remaining supply runs out.

## Patterns

**Simulation pattern** — rather than deriving a closed-form formula (which is possible via quadratic math), this solves the problem by directly simulating the distribution process. The `give` counter tracks how many candies the current turn *wants* to give (1, 2, 3, ...), and `(give - 1) % num_people` maps that 1-based turn number to a 0-based person index, achieving the circular wrap-around.

The `min(give, candies)` idiom handles the partial-last-give edge case in one expression — no separate "last round" branch needed.

## Dependencies

**Imports**: None. Pure stdlib Python, no external dependencies.

**Imported by**: The `distribute-candies-to-people/test_solution.py` file imports this function. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those other test files don't actually import *this* function; they follow the same import pattern for their own solutions.

## Flow

1. Initialize `result` as a zero-filled list of length `num_people`.
2. Start `give = 1` (first person gets 1 candy).
3. Loop while `candies > 0`:
   - Compute person index: `(give - 1) % num_people` — turn 1 → index 0, turn `num_people` → index `num_people - 1`, turn `num_people + 1` → index 0 again.
   - Add `min(give, candies)` to that person's accumulator.
   - Subtract `give` from `candies` (may go negative — the loop guard catches it next iteration).
   - Increment `give`.
4. Return the accumulated result.

## Invariants

- **Candy conservation**: `sum(result) == original_candies` — every candy is distributed exactly once. The `min(give, candies)` ensures we never distribute more than what's left, while the loop ensures we keep going until nothing remains.
- **Non-negative entries**: Every person gets `>= 0` candies.
- **1-based give mapping**: The `(give - 1) % num_people` expression relies on `give` starting at 1 and incrementing by 1 each turn. If `give` started at 0, person indexing would be off-by-one.

## Error Handling

None. The function trusts its caller to provide valid inputs (non-negative `candies`, positive `num_people`). Passing `num_people = 0` would cause a `ZeroDivisionError` from the modulo. Passing negative `candies` returns an all-zeros list (the while loop never enters).

## Topics to Explore

- [file] `distribute-candies-to-people/test_solution.py` — See the edge cases being tested (zero candies, single person, partial last round)
- [file] `distribute-candies-to-people/plan.md` — The planning doc may discuss the closed-form alternative and why simulation was chosen
- [file] `distribute-candies/solution.py` — A different "distribute candies" problem; comparing the two shows how similar names map to very different algorithms
- [general] `simulation-vs-closed-form` — This problem has a O(1) solution using the quadratic formula to find how many full rounds complete; worth comparing the tradeoff of clarity vs. speed
- [file] `distribute-money-to-maximum-children/solution.py` — Another distribution problem with different constraints, showing how greedy vs. simulation approaches diverge

## Beliefs

- `distribute-candies-simulation-correctness` — The while loop terminates because `give >= 1` on every iteration, so `candies` strictly decreases each iteration, guaranteeing `candies <= 0` is eventually reached.
- `distribute-candies-time-complexity` — The loop runs O(sqrt(candies)) iterations because the sum 1+2+...+k = k(k+1)/2 reaches `candies` when k is approximately sqrt(2*candies).
- `distribute-candies-no-overcounting` — `min(give, candies)` ensures the total distributed never exceeds the original candy count, even though `candies -= give` can drive `candies` negative.
- `distribute-candies-index-mapping` — The expression `(give - 1) % num_people` is the only way the circular assignment works correctly with a 1-based `give` counter; changing `give` to start at 0 would require dropping the `- 1`.

