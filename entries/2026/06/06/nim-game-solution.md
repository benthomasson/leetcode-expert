# File: nim-game/solution.py

**Date:** 2026-06-06
**Time:** 18:13

## `nim-game/solution.py`

### Purpose

This file solves [LeetCode 292 - Nim Game](https://leetcode.com/problems/nim-game/). It implements the optimal strategy for a two-player game where players alternate removing 1-3 stones from a heap, and the player who takes the last stone wins. The file's sole responsibility is providing the `canWinNim` function that determines whether the first player wins given `n` stones and both players playing optimally.

### Key Components

**`canWinNim(n: int) -> bool`** — The only function. Takes the heap size and returns whether the first player has a winning strategy. The entire solution is `n % 4 != 0`.

### Patterns

**Mathematical reduction over simulation.** Rather than building a game tree or running dynamic programming, this solution recognizes the closed-form pattern in the game's Sprague-Grundy values. The game-theoretic insight: if `n` is a multiple of 4, every move you make (removing 1, 2, or 3) leaves a non-multiple-of-4 for your opponent, who can then always respond to leave you at the next multiple of 4 down. You'll eventually face `n=4` and lose. If `n` is *not* a multiple of 4, you can always take `n % 4` stones to put your opponent on a multiple of 4 — a losing position for them.

This is O(1) time and O(1) space, which matters here because `n` can be up to 2^31 - 1. A DP table of that size would exceed memory limits.

### Dependencies

**Imports:** None. Pure arithmetic — no standard library or third-party dependencies.

**Imported by:** The `nim-game/test_solution.py` file imports this function for testing. The massive "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share the same test harness structure. Each `test_solution.py` imports from its own sibling `solution.py`, not from this file.

### Flow

1. Receive integer `n`.
2. Compute `n % 4`.
3. Return `True` if the remainder is nonzero, `False` otherwise.

No branching, no loops, no allocation.

### Invariants

- **Input constraint:** `1 <= n <= 2^31 - 1` (per the problem spec). The function doesn't validate this — it relies on LeetCode's guarantees. For `n=0` (outside the valid range), it would return `False`, which happens to be semantically correct (no stones to take = you lose).
- **Optimal play assumption:** The result is only correct under the assumption that both players play optimally. The function doesn't model suboptimal play.

### Error Handling

None. The function is a pure arithmetic expression with no failure modes for valid inputs. No exceptions, no edge-case guards.

## Topics to Explore

- [file] `nim-game/test_solution.py` — See which edge cases are tested (n=1,2,3,4 and beyond)
- [file] `nim-game/plan.md` — How the mathematical insight was derived during the solving process
- [file] `divisor-game/solution.py` — Another game-theory problem with a similar modular-arithmetic closed form (even/odd)
- [general] `sprague-grundy-theorem` — The combinatorial game theory framework that explains why the mod-4 pattern holds for Nim variants
- [file] `nim-game/review.md` — Any recorded observations about alternative approaches or complexity analysis

## Beliefs

- `nim-game-mod4-characterization` — The first player wins Nim (1-3 stones per turn) if and only if `n % 4 != 0`; this is a complete characterization for all valid inputs.
- `nim-game-constant-complexity` — `canWinNim` runs in O(1) time and O(1) space regardless of input size, making it optimal for the constraint `n <= 2^31 - 1`.
- `nim-game-no-dependencies` — The solution has zero imports and depends only on Python's built-in modulo operator.
- `nim-game-no-input-validation` — The function performs no bounds checking; it trusts the caller to provide `n >= 1`.

