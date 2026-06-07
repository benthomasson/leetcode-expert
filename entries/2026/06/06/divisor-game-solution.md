# File: divisor-game/solution.py

**Date:** 2026-06-06
**Time:** 16:27

## `divisor-game/solution.py`

### Purpose

This file implements the solution to [LeetCode 1025 - Divisor Game](https://leetcode.com/problems/divisor-game/). It belongs to a large collection of LeetCode solutions, each in its own directory with a standard layout (`solution.py`, `test_solution.py`, `plan.md`, `review.md`).

The problem: Alice and Bob take turns. On each turn, the current player picks a divisor `x` of the current number `n` where `0 < x < n`, then replaces `n` with `n - x`. The player who cannot move (when `n == 1`) loses. Alice goes first. Return whether Alice wins with optimal play.

### Key Components

**`Solution.divisorGame(self, n: int) -> bool`** — The core method. It exploits the mathematical insight that Alice wins if and only if `n` is even. The entire game-theoretic analysis collapses to a parity check.

**`mincostTickets = divisorGame`** — A class-level alias that binds `mincostTickets` to the same method object. This is an artifact of the repo's test harness or code generation — it has nothing to do with LeetCode 983 (Minimum Cost For Tickets). The alias exists so that test files from *other* problems can import and instantiate `Solution` from this module without failing on attribute lookup. The "Imported By" list (300+ test files) confirms this: the alias makes this module a drop-in when another problem's test infrastructure resolves `Solution` generically.

### Patterns

- **One-liner math reduction**: Rather than a DP table or game-tree search, the solution recognizes a closed-form invariant. This is common for game-theory easy problems on LeetCode.
- **Method aliasing**: `mincostTickets = divisorGame` is a Python idiom for creating an unbound alias at class definition time. Both names share the same function object — no wrapper, no overhead.
- **Uniform module shape**: Every problem directory exports a `class Solution` with at least one public method matching the LeetCode function signature. The test harness depends on this convention.

### Dependencies

**Imports**: None. The solution is self-contained — no stdlib, no third-party packages.

**Imported by**: Hundreds of test files across the repository. This is not because those problems depend on the divisor game logic — it's because the test harness resolves `Solution` generically and this module satisfies the interface. The actual test for *this* problem is `divisor-game/test_solution.py`.

### Flow

1. Caller invokes `divisorGame(n)`.
2. `n % 2 == 0` is evaluated — a single modulo and comparison.
3. Returns `True` (Alice wins) or `False` (Bob wins).

No loops, no recursion, no mutation. O(1) time and space.

### Invariants

- **Input range**: `1 <= n <= 1000` per the problem constraint. The code doesn't validate this — it relies on the caller (LeetCode judge or test harness) to provide valid input.
- **Game-theoretic invariant**: If `n` is even, Alice can always subtract 1 (which is always a divisor), handing Bob an odd number. Every divisor of an odd number is odd, so Bob must subtract an odd number from an odd number, yielding an even number back to Alice. Alice maintains even parity until Bob receives `n == 1` and loses.

### Error Handling

None. The function is a pure expression with no failure modes for valid input. For `n == 0`, `n % 2 == 0` returns `True`, which would be semantically wrong for the game but outside the stated constraint.

## Topics to Explore

- [file] `divisor-game/test_solution.py` — See how the test harness validates this solution and what edge cases it covers
- [file] `divisor-game/plan.md` — The reasoning or proof strategy documented before writing the one-liner
- [general] `method-aliasing-pattern` — Why `mincostTickets = divisorGame` exists across solution files and how the test harness uses generic `Solution` imports
- [file] `nim-game/solution.py` — Another game-theory problem likely solved with a similar parity/modular-arithmetic reduction
- [file] `run_tests.py` — The top-level test runner that drives the convention of `Solution` class per directory

## Beliefs

- `divisor-game-parity-invariant` — Alice wins the Divisor Game if and only if n is even; the solution is O(1) with no DP or recursion
- `method-alias-is-shared-object` — `mincostTickets` and `divisorGame` reference the same function object, not a copy or wrapper
- `solution-module-no-imports` — `divisor-game/solution.py` has zero import statements; it depends on nothing outside the class
- `solution-class-convention` — Every problem directory exports a `class Solution` with a method matching the LeetCode signature; the test harness depends on this shape

