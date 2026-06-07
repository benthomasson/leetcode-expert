# File: check-if-matrix-is-x-matrix/solution.py

**Date:** 2026-06-06
**Time:** 15:39

## Purpose

This file solves [LeetCode 2319: Check if Matrix Is X-Matrix](https://leetcode.com/problems/check-if-matrix-is-x-matrix/). An X-Matrix is a square matrix where every element on both diagonals is non-zero and every element *not* on a diagonal is zero. The file's sole responsibility is implementing and exposing that check.

## Key Components

### `Solution.checkXMatrix(grid) -> bool`

The main logic. Takes an `n x n` grid and returns whether it satisfies the X-Matrix property. The contract is simple: the grid must be square (guaranteed by the problem), and the method performs a single pass over all cells.

### `check_if_matrix_is_x_matrix` (module-level lambda)

A thin wrapper that instantiates `Solution` and delegates. This exists to match the project's naming convention — test files import a snake_case function named after the problem directory.

## Patterns

- **LeetCode `Solution` class idiom**: The method lives on a `Solution` class with no state, matching LeetCode's submission format.
- **Module-level alias**: Every solution in this repo exposes a snake_case callable so the test harness can import uniformly without knowing the class/method name.
- **Single-pass matrix scan**: Iterates every `(i, j)` once, classifying each cell as diagonal or off-diagonal, then checking the corresponding invariant. No early optimization (e.g., only walking diagonals) — the off-diagonal zeros must also be verified, so a full scan is necessary.

## Dependencies

**Imports**: None — pure stdlib types (`list[int]`).

**Imported by**: `check-if-matrix-is-x-matrix/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those hundreds of test files each import their *own* solution module, not this one. Only this problem's test file imports this file.

## Flow

1. Read `n` from `len(grid)`.
2. For each cell `(i, j)`:
   - Compute `on_diag = (i == j) or (i + j == n - 1)`. This covers both the primary diagonal (`i == j`) and the anti-diagonal (`i + j == n - 1`).
   - If on a diagonal and the value is `0` → fail immediately.
   - If off a diagonal and the value is not `0` → fail immediately.
3. If no cell violated, return `True`.

The two diagonal conditions share the center cell when `n` is odd (where `i == j == n // 2` and `i + j == n - 1` are both true). This is fine — it's checked once and the non-zero constraint applies either way.

## Invariants

- **Square matrix assumed**: `n` is derived from `len(grid)` alone; no check that each row has length `n`. This is safe given the LeetCode constraint.
- **Diagonal membership is exact**: `on_diag` captures precisely the "X" shape. The center element of an odd-dimension matrix belongs to both diagonals, but the boolean short-circuits correctly.
- **Non-zero means any non-zero value**: The check is `grid[i][j] == 0`, not `grid[i][j] > 0`. Negative diagonal values would pass, which matches the problem spec (diagonal elements just need to be non-zero).

## Error Handling

None. The function assumes valid input per the problem constraints. An empty grid (`n == 0`) would skip the loops and return `True`, which is arguably correct (vacuously an X-Matrix).

## Topics to Explore

- [file] `check-if-matrix-is-x-matrix/test_solution.py` — See what edge cases (odd vs even `n`, single-element grid) the test suite covers
- [file] `matrix-diagonal-sum/solution.py` — Related diagonal-traversal problem; compare how diagonals are identified
- [file] `special-positions-in-a-binary-matrix/solution.py` — Another matrix problem with position-based classification logic
- [general] `x-matrix-diagonal-overlap` — Whether the center cell in odd-dimension matrices needs special handling (it doesn't here, but worth understanding why)

## Beliefs

- `x-matrix-full-scan-required` — The solution must visit all `n*n` cells because off-diagonal zeros must be verified, not just diagonal non-zeros
- `x-matrix-diagonal-condition` — A cell `(i,j)` is on the X-diagonal iff `i == j` or `i + j == n - 1`; the center cell of odd-`n` matrices satisfies both
- `x-matrix-early-return` — The function short-circuits on the first violating cell, making best-case O(1) and worst-case O(n^2)
- `solution-alias-convention` — Every solution module exposes a module-level snake_case callable that wraps `Solution().methodName` for uniform test imports

