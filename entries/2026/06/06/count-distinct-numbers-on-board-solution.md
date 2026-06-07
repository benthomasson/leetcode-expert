# File: count-distinct-numbers-on-board/solution.py

**Date:** 2026-06-06
**Time:** 15:56

## Purpose

This file solves [LeetCode 2549: Count Distinct Numbers on Board](https://leetcode.com/problems/count-distinct-numbers-on-board/). The problem places a number `n` on a board; every day for 10^9 days, for every `x` on the board, any `i` in `[1, n]` where `x % i == 1` is also placed on the board. The function returns how many distinct numbers end up on the board.

## Key Components

**`distinct_numbers(n: int) -> int`** — The sole function. Returns `1` if `n == 1`, otherwise `n - 1`.

## Patterns

**Mathematical reduction.** This is a pure-math O(1) solution that avoids simulating 10^9 days. The insight:

- For any `n >= 2`: `n % (n-1) == 1`, so `n-1` appears on the board. Then `(n-1) % (n-2) == 1`, so `n-2` appears. This cascades all the way down to `2` (since `3 % 2 == 1`). But `2 % 1 == 0 != 1`, so `1` is never added. The board stabilizes at `{2, 3, ..., n}` — exactly `n - 1` values.
- For `n == 1`: no `i` satisfies `1 % i == 1`, so the board stays `{1}` — exactly `1` value.

The entire simulation collapses to a ternary expression. This pattern of recognizing steady-state behavior without simulation is common in competitive programming.

## Dependencies

**Imports:** None — pure arithmetic, no standard library needed.

**Imported by:** `count-distinct-numbers-on-board/test_solution.py` (the "Imported By" list in the prompt is an artifact of the repo's shared test harness; only the co-located test file actually imports this solution's function).

## Flow

Single expression evaluation: check `n == 1`, branch to `1` or `n - 1`. No loops, no data structures, no state.

## Invariants

- **Precondition:** `n` is a positive integer (`1 <= n <= 100` per the LeetCode constraint).
- **Postcondition:** Return value is always in `[1, n-1]` for `n >= 2`, or exactly `1` for `n == 1`.

## Error Handling

None. The function trusts the caller to provide valid input per the problem constraints. No validation, no exceptions.

## Topics to Explore

- [file] `count-distinct-numbers-on-board/test_solution.py` — Verify which edge cases (n=1, n=2, large n) are covered by tests
- [file] `count-distinct-numbers-on-board/plan.md` — See whether the plan documents the mathematical derivation or considered simulation first
- [file] `count-distinct-numbers-on-board/review.md` — Check if the review flagged the O(1) insight or discussed alternative approaches
- [general] `modular-arithmetic-reductions` — Other problems in this repo where modular arithmetic collapses a simulation into a closed-form answer (e.g., `nim-game`, `divisor-game`)

## Beliefs

- `distinct-numbers-o1-time-space` — `distinct_numbers` runs in O(1) time and O(1) space with no loops or recursion
- `distinct-numbers-base-case` — `n == 1` is the only input that returns `1`; all `n >= 2` return `n - 1`
- `distinct-numbers-no-deps` — The solution has zero imports and depends on no external modules or data structures
- `distinct-numbers-steady-state` — The board stabilizes to `{2, 3, ..., n}` for `n >= 2` because `x % (x-1) == 1` cascades downward and halts at `2`

