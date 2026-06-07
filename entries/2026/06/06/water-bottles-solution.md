# File: water-bottles/solution.py

**Date:** 2026-06-06
**Time:** 19:42

## Purpose

This file solves [LeetCode 1518 — Water Bottles](https://leetcode.com/problems/water-bottles/). It belongs to the `leetcode-implementations` repo, where each problem gets its own directory with `solution.py`, `test_solution.py`, `plan.md`, and `review.md`. This file owns the single algorithm: given an initial count of full bottles and an exchange rate, compute the maximum number of bottles you can drink.

## Key Components

### `numWaterBottles(numBottles: int, numExchange: int) -> int`

A standalone function (no class wrapping) that simulates the bottle-exchange process. Contract:

- **Input**: `numBottles` >= 1 (initial full bottles), `numExchange` >= 2 (empties needed per exchange)
- **Output**: Total bottles drunk (always >= `numBottles`)
- **Side effects**: None — pure function

## Patterns

**Simulation loop with accumulator.** Rather than using a closed-form formula, the solution simulates rounds of drinking and exchanging. Each iteration of the `while` loop represents one exchange round:

1. Integer-divide empties by `numExchange` to get `new_full` bottles
2. Update `empties` to leftover empties + the new bottles (which will themselves become empty after drinking)
3. Accumulate `new_full` into `total`

This is the canonical greedy simulation approach for this problem — drink everything you can, exchange, repeat.

**Flat module function.** No `Solution` class, which diverges from LeetCode's typical class-based template. The function is importable directly.

## Dependencies

**Imports**: None — zero external dependencies, pure standard Python.

**Imported by**: `water-bottles/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those hundreds of test files don't actually import *this* solution. That list appears to be an artifact of the repo's test infrastructure (likely a shared test runner or conftest), not direct imports of `numWaterBottles`.

## Flow

```
total = numBottles        # drink all initial bottles
empties = numBottles      # all become empty

loop while empties >= numExchange:
    new_full  = empties // numExchange    # exchange empties for full
    empties   = empties % numExchange     # leftover empties
              + new_full                  # newly emptied after drinking
    total    += new_full                  # count the drinks
```

Example trace: `numBottles=9, numExchange=3`
- Start: total=9, empties=9
- Round 1: new_full=3, empties=0+3=3, total=12
- Round 2: new_full=1, empties=0+1=1, total=13
- Exit: empties(1) < numExchange(3) → return 13

## Invariants

- **Loop termination**: `empties` strictly decreases each round (you always get back fewer bottles than you put in when `numExchange >= 2`), so the loop always terminates.
- **Conservation**: At every iteration, `total + future_drinks_from_empties` equals the true answer. The accumulator `total` only grows.
- **Integer arithmetic throughout**: No floating point — `//` and `%` keep everything exact.

## Error Handling

None. The function trusts its caller to provide valid inputs per the LeetCode constraints (`1 <= numBottles <= 100`, `2 <= numExchange <= 100`). Passing `numExchange=0` or `numExchange=1` would cause a division-by-zero or infinite loop respectively — but those are outside the problem's contract.

## Topics to Explore

- [file] `water-bottles/test_solution.py` — See what edge cases are covered (e.g., numExchange equals numBottles, numBottles=1)
- [file] `water-bottles/plan.md` — Pre-implementation reasoning: whether a closed-form approach was considered
- [file] `water-bottles/review.md` — Post-implementation review notes on this solution
- [general] `closed-form-alternative` — This problem has an O(1) formula: `numBottles + (numBottles - 1) / (numExchange - 1)` (integer division) — worth comparing against the simulation
- [function] `run_tests.py` — How the shared test runner discovers and executes per-problem test suites

## Beliefs

- `water-bottles-loop-terminates` — The while loop terminates for all valid inputs because `empties` strictly decreases each iteration when `numExchange >= 2`
- `water-bottles-no-dependencies` — The solution has zero imports and is a pure function with no side effects
- `water-bottles-greedy-simulation` — The solution uses iterative simulation (O(log n) rounds) rather than the available O(1) closed-form formula
- `water-bottles-total-lower-bound` — The return value is always >= `numBottles` because you drink all initial bottles before any exchanging

