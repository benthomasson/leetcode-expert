# File: minimum-hours-of-training-to-win-a-competition/solution.py

**Date:** 2026-06-07
**Time:** 04:52

## Purpose

This file solves [LeetCode 2383: Minimum Hours of Training to Win a Competition](https://leetcode.com/problems/minimum-hours-of-training-to-win-a-competition/). It computes the minimum number of training hours (each hour adds +1 to either energy or experience) needed so a player can defeat every opponent in sequence. The player must have **strictly greater** energy and experience than each opponent at the time of the fight.

## Key Components

### `min_training_hours(initialEnergy, initialExperience, energy, experience) -> int`

The single exported function. It splits the problem into two independent subproblems and sums the results:

**Energy subproblem (line 22):** Energy is consumed additively — every fight costs `energy[i]` and the player must survive all fights. This reduces to a single arithmetic check: total energy needed is `sum(energy) + 1`, and the training gap is `max(0, sum(energy) + 1 - initialEnergy)`.

**Experience subproblem (lines 25–31):** Experience is gained after each win — the player gets `experience[i]` added after defeating opponent `i`. Because gains compound, the deficit must be resolved opponent-by-opponent via simulation. When `cur_exp <= exp`, the function computes the exact gap (`exp + 1 - cur_exp`), adds it to both the running total and the current experience, then adds the opponent's experience as the win reward.

## Patterns

- **Greedy simulation**: The experience loop trains just enough to beat each opponent, never over-training. This is optimal because training hours spent on experience are only useful if the player would otherwise lose at that specific opponent.
- **Decomposition**: Energy and experience are handled independently. This works because training hours for energy and experience are separate resources (each hour goes to one or the other), and energy costs don't depend on experience or vice versa.

## Dependencies

**Imports:** `typing.List` — used only for type annotations.

**Imported by:** `minimum-hours-of-training-to-win-a-competition/test_solution.py` (the "Imported By" list in the prompt is misleading — it lists all test files across the repo that import from their own `solution.py`, not files that import from *this* solution).

## Flow

1. Compute total energy cost in O(n), derive energy training hours in O(1).
2. Walk the `experience` array left-to-right, tracking `cur_exp`. At each opponent, if `cur_exp <= exp`, bridge the gap with training hours. After each opponent, gain their experience.
3. Return the sum of energy and experience training hours.

**Time complexity:** O(n) — one pass for `sum(energy)`, one pass for the experience simulation.  
**Space complexity:** O(1) — only scalar accumulators.

## Invariants

- **Strict inequality**: The player must be **strictly greater** than the opponent in both stats. This is enforced by the `+ 1` in both `sum(energy) + 1` (line 22) and `exp + 1 - cur_exp` (line 28).
- **Non-negative training**: `max(0, ...)` on line 22 and the `if cur_exp <= exp` guard on line 27 ensure training hours are never negative.
- **Sequential ordering**: Opponents are fought in array order. The experience simulation depends on this — reordering opponents would change the result.

## Error Handling

None. The function trusts its inputs match the LeetCode contract (equal-length lists, non-negative values). No validation, no exceptions.

## Topics to Explore

- [file] `minimum-hours-of-training-to-win-a-competition/test_solution.py` — See what edge cases (zero initial stats, single opponent, already-sufficient stats) are tested
- [file] `minimum-hours-of-training-to-win-a-competition/review.md` — Read the code review for quality observations and potential issues
- [general] `greedy-simulation-pattern` — Many LeetCode solutions in this repo use greedy single-pass simulation; compare with `diet-plan-performance` or `lemonade-change`
- [function] `best-time-to-buy-and-sell-stock/solution.py:maxProfit` — Another example of decomposing a sequential problem into a single-pass greedy scan

## Beliefs

- `energy-experience-independence` — Energy and experience training hours are computed independently and summed; no interaction between the two subproblems
- `experience-requires-simulation` — Unlike energy (which reduces to a sum), experience must be simulated sequentially because wins compound the player's experience
- `strict-greater-than-enforced` — The `+ 1` in both the energy and experience calculations enforces the strict-greater-than requirement from the problem statement
- `linear-time-constant-space` — The solution runs in O(n) time and O(1) space with no auxiliary data structures

