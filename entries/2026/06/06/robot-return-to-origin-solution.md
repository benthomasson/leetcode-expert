# File: robot-return-to-origin/solution.py

**Date:** 2026-06-06
**Time:** 18:56

## `robot-return-to-origin/solution.py`

### Purpose

This file solves [LeetCode #657 — Robot Return to Origin](https://leetcode.com/problems/robot-return-to-origin/). It determines whether a sequence of moves (`U`/`D`/`L`/`R`) on a 2D grid returns a robot to its starting position `(0, 0)`. It's a standalone solution module following the repo's convention of one problem per directory.

### Key Components

**`judgeCircle(moves: str) -> bool`** — The sole function. It checks whether the robot ends at the origin by verifying two independent conditions:

1. Horizontal balance: `count('L') == count('R')`
2. Vertical balance: `count('U') == count('D')`

Both must hold for the robot to return. The function is a pure expression with no mutation or side effects.

### Patterns

- **Counting-based reduction**: Instead of simulating the walk with `x, y` coordinate tracking, it exploits the insight that net displacement is zero iff opposing moves cancel exactly. This avoids mutable state entirely.
- **Repo convention**: Bare function (not wrapped in a `Solution` class), typed signature, docstring with Args/Returns. Matches the project's standard layout where each problem gets `solution.py`, `test_solution.py`, `plan.md`, and `review.md`.

### Dependencies

**Imports**: None — pure stdlib, no external dependencies.

**Imported by**: `robot-return-to-origin/test_solution.py` directly. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that share the same test harness infrastructure, not actual consumers of `judgeCircle`.

### Flow

1. `str.count('L')` scans the full string — O(n).
2. `str.count('R')` scans again — O(n).
3. If counts differ, short-circuit returns `False` (Python `and`).
4. Otherwise, `str.count('U')` and `str.count('D')` are compared — two more O(n) scans.

Total: 2–4 linear passes over `moves`. Worst case is 4n character comparisons. No allocations beyond the integer counts.

### Invariants

- **Input contract**: Assumes `moves` contains only `U`, `D`, `L`, `R`. No validation — the problem guarantees this.
- **Mathematical invariant**: The robot returns to origin iff horizontal and vertical displacements are both zero. These axes are independent, so checking them separately is correct and complete.

### Error Handling

None. Invalid characters (e.g., `'X'`) are silently ignored by `str.count` — they simply don't match any of the four counted characters. An empty string returns `True` (0 == 0 for all pairs), which is correct: no moves means the robot stays at the origin.

## Topics to Explore

- [file] `robot-return-to-origin/test_solution.py` — See which edge cases are covered (empty string, single direction, long balanced strings)
- [file] `robot-return-to-origin/plan.md` — Understand whether the counting approach was chosen deliberately over coordinate simulation
- [function] `path-crossing/solution.py:isPathCrossing` — A harder variant where you track whether any position is *revisited*, requiring coordinate simulation that this problem avoids
- [general] `counting-vs-simulation` — When character counting suffices vs. when you need to track intermediate state (e.g., path crossing, bounded grid problems)

## Beliefs

- `judge-circle-no-simulation` — `judgeCircle` determines origin return by counting opposing moves rather than simulating coordinates, which is correct because horizontal and vertical axes are independent
- `judge-circle-four-pass-worst-case` — The implementation makes up to 4 linear passes over the input string (short-circuits to 2 if L/R counts differ)
- `judge-circle-empty-returns-true` — An empty `moves` string returns `True`, correctly reflecting that zero moves leave the robot at the origin
- `judge-circle-no-input-validation` — The function does not validate that `moves` contains only valid characters; extraneous characters are silently ignored by `str.count`

