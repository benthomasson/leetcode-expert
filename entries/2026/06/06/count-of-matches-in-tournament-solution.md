# File: count-of-matches-in-tournament/solution.py

**Date:** 2026-06-06
**Time:** 16:02

## Purpose

This file solves [LeetCode 1688: Count of Matches in Tournament](https://leetcode.com/problems/count-of-matches-in-tournament/). It belongs to a large collection of LeetCode solutions, each in its own directory with a standardized structure (`solution.py`, `test_solution.py`, `plan.md`, `review.md`).

The problem asks: given `n` teams in a single-elimination tournament, how many total matches are played before a winner is decided? In each round, if the team count is even, `n/2` matches are played; if odd, `(n-1)/2` matches are played and one team gets a bye. This repeats until one team remains.

## Key Components

**`Solution.numberOfMatches(self, n: int) -> int`** — The only method. Takes the number of teams and returns the total match count.

The implementation is `return n - 1` — a closed-form solution rather than a simulation. This works because every match eliminates exactly one team, and you must eliminate `n - 1` teams to crown a single winner. The total number of matches is always `n - 1` regardless of how byes are distributed across rounds.

## Patterns

- **Mathematical reduction over simulation**: Instead of looping through rounds (halving `n` each time and accumulating matches), the code recognizes the invariant and collapses the entire computation to O(1). This is a common pattern in this repo's easier problems — `add-two-integers`, `smallest-even-multiple`, `nim-game` all use similar one-liner math shortcuts.
- **LeetCode `Solution` class convention**: Standard class wrapper that LeetCode's judge expects.

## Dependencies

**Imports**: None. The solution is self-contained — no standard library, no helper modules.

**Imported by**: The `test_solution.py` in the same directory imports this `Solution` class. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that import their *own* `solution.py`, not this one.

## Flow

Trivial: single arithmetic operation, no branching, no iteration.

## Invariants

- `n >= 1` (guaranteed by the problem constraints: `1 <= n <= 200`)
- The return value is always non-negative (`n - 1 >= 0` given the constraint)

## Error Handling

None. The function trusts its input per LeetCode convention — no validation of `n`.

## Topics to Explore

- [file] `count-of-matches-in-tournament/test_solution.py` — See what edge cases are tested (n=1 returning 0, odd vs even team counts)
- [file] `count-of-matches-in-tournament/review.md` — The code review may discuss the simulation vs. closed-form tradeoff
- [function] `nim-game/solution.py:canWinNim` — Another problem where game-theoretic reasoning collapses to a one-liner (`n % 4 != 0`)
- [general] `elimination-tournament-math` — The pigeonhole-style argument (each match removes exactly one team) generalizes to many counting problems

## Beliefs

- `matches-equals-n-minus-1` — In any single-elimination tournament with `n` teams, exactly `n - 1` matches are played, regardless of even/odd round handling
- `no-simulation-needed` — The solution avoids iterating through rounds; the O(1) closed form is mathematically equivalent to the round-by-round simulation
- `no-external-dependencies` — This solution module imports nothing and depends only on Python builtins

