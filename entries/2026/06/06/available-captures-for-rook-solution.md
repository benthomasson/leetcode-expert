# File: available-captures-for-rook/solution.py

**Date:** 2026-06-06
**Time:** 15:17

## Available Captures for Rook — `solution.py`

### Purpose

Solves [LeetCode 999: Available Captures for Rook](https://leetcode.com/problems/available-captures-for-rook/). Given an 8x8 chessboard, find the white rook (`'R'`) and count how many black pawns (`'p'`) it can capture by moving in the four cardinal directions, where white bishops (`'B'`) block its path.

### Key Components

**`Solution.regionsBySlashes`** — The method name is wrong; it belongs to LeetCode 999 (rook captures), not problem 959 (regions by slashes). The docstring is correct, the name isn't. This likely resulted from a code-generation or copy-paste error. The LeetCode judge doesn't care about method names in Python submissions, but it will confuse anyone reading the code.

**Parameters**: `board: List[List[str]]` — an 8x8 grid where cells are one of `'R'`, `'B'`, `'p'`, or `'.'`.

**Returns**: `int` — number of capturable pawns (0 to 4).

### Flow

1. **Locate the rook** (lines 12-15): Brute-force scan of all 64 cells. Stores position in `(rr, rc)`. If no rook exists, `rr` and `rc` default to `(0, 0)` — no explicit guard.

2. **Probe four directions** (lines 17-24): For each cardinal direction `(dr, dc)`, walk outward from the rook one cell at a time:
   - Hit a bishop `'B'` → stop (blocked, no capture).
   - Hit a pawn `'p'` → increment `captures`, stop (rook captures then stops).
   - Hit `'.'` → keep walking.
   - Walk off the board → stop (bounds check in the `while`).

### Patterns

- **Direction vector iteration**: The `[(-1,0), (1,0), (0,-1), (0,1)]` pattern is the standard idiom for cardinal-direction grid traversal. Each direction is independent, so the loop body is the same for all four.
- **Ray casting with early termination**: The inner `while` loop acts as a ray cast — it moves along one axis until it hits an obstacle or the board edge. Two distinct `break` conditions (bishop vs. pawn) keep the logic flat rather than nested.

### Dependencies

- **Imports**: `typing.List` (type hint only).
- **Imported by**: `available-captures-for-rook/test_solution.py` directly, and the `Solution` class is part of the project-wide pattern where each problem folder's test imports its own `solution.py`.

### Invariants

- The board is assumed to be exactly 8x8. The hardcoded `range(8)` and `0 <= r < 8` bounds enforce this implicitly.
- Exactly one rook exists on the board (per the problem constraints). The code finds the first one and uses it; if none exists, `(0, 0)` is silently used as the rook position.
- A pawn capture terminates that direction's ray — the rook doesn't "see through" captured pieces.

### Error Handling

None. The code trusts the input matches the problem constraints. No validation of board dimensions, piece characters, or rook existence.

## Topics to Explore

- [file] `available-captures-for-rook/test_solution.py` — See what edge cases the tests cover (e.g., rook surrounded by bishops, rook in a corner)
- [function] `island-perimeter/solution.py:Solution` — Another grid-walk problem using the same direction-vector pattern, good comparison
- [general] `method-name-mismatch` — The `regionsBySlashes` naming error may exist in other solutions; worth auditing whether method names match their problem
- [file] `available-captures-for-rook/review.md` — The code review may already flag the naming issue or discuss alternative approaches

## Beliefs

- `rook-captures-wrong-method-name` — `regionsBySlashes` is the wrong method name for this problem; it should be `numRookCaptures` to match the LeetCode API
- `rook-captures-max-four` — The return value is bounded [0, 4] because the rook probes exactly four cardinal directions with at most one capture each
- `rook-captures-linear-time` — The algorithm runs in O(1) time (at most 64 cells scanned to find the rook + at most 28 cells across all four rays) since the board is fixed at 8x8
- `rook-position-default-zero` — If no rook is present on the board, the code silently treats cell (0, 0) as the rook position rather than raising an error

