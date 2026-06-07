# File: path-crossing/solution.py

**Date:** 2026-06-06
**Time:** 18:30

## Purpose

This file solves [LeetCode 1496 - Path Crossing](https://leetcode.com/problems/path-crossing/). It determines whether a walker on a 2D grid, starting at the origin and following a sequence of cardinal directions, ever revisits a coordinate. It's the single solution module for this problem, consumed by `path-crossing/test_solution.py`.

## Key Components

### `path_crossing(path: str) -> bool`

The sole public function. Takes a string of direction characters (`N`, `S`, `E`, `W`) and returns `True` if any coordinate is visited more than once (including the origin).

**Contract**: `path` must consist only of characters in `{N, S, E, W}`. Any other character will raise `KeyError` from the `directions` dict lookup.

### `directions` dict (line 14)

Maps each direction character to its `(dx, dy)` displacement vector. This is a local variable, not a module-level constant — it's rebuilt on every call. For a LeetCode solution this is fine; in production code you'd hoist it.

## Patterns

**Set-based visited tracking** — the classic O(1)-lookup approach for cycle/revisit detection on grids. The set stores coordinate tuples, which are hashable and equality-comparable by value.

**Incremental position update** — rather than computing positions from scratch, the solution accumulates deltas. This is the standard idiom for path-walking problems.

**Early return** — the function returns `True` as soon as a revisit is detected, avoiding unnecessary traversal of the remaining path.

## Dependencies

**Imports**: None — pure stdlib, no external dependencies.

**Imported by**: `path-crossing/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those hundreds of test files don't actually import `path_crossing`. That list appears to be an artifact of the repo's test infrastructure (likely a shared test runner or conftest pattern), not real import dependencies.

## Flow

1. Build the direction-to-delta mapping.
2. Initialize position at `(0, 0)` and seed the `visited` set with the origin.
3. For each character in `path`:
   - Look up the displacement vector.
   - Update `(x, y)`.
   - If the new position is already in `visited`, return `True`.
   - Otherwise, add it to `visited`.
4. If the loop completes without a revisit, return `False`.

**Time complexity**: O(n) where n = len(path). Each step does O(1) set lookup and insertion.

**Space complexity**: O(n) for the visited set.

## Invariants

- The `visited` set always contains every coordinate reached so far, including the origin.
- Position `(x, y)` is checked *before* being added to `visited`, so the check is "have we been here before this step."
- The origin `(0, 0)` is pre-seeded, so returning to the origin counts as a crossing.

## Error Handling

None explicit. An invalid direction character (anything not in `N/S/E/W`) causes a `KeyError` to propagate uncaught from `directions[char]`. This is appropriate for LeetCode where input is guaranteed valid.

---

## Topics to Explore

- [file] `path-crossing/test_solution.py` — See what edge cases the tests cover (empty string, immediate return to origin, long non-crossing paths)
- [file] `path-crossing/review.md` — Read the code review notes for any flagged issues or alternative approaches
- [function] `robot-return-to-origin/solution.py:judge_circle` — A simpler variant of the same grid-walking pattern (only checks if you return to origin, not any revisit)
- [general] `set-vs-dict-visited-tracking` — When you'd use a dict (storing step count or distance) instead of a set for visited tracking
- [file] `flood-fill/solution.py` — Another grid problem that uses visited tracking but with BFS/DFS instead of linear path walking

## Beliefs

- `path-crossing-origin-seeded` — The origin (0,0) is in the visited set before any steps are taken, so returning to the start counts as a path crossing
- `path-crossing-early-exit` — The function returns True on the first revisited coordinate without processing the remaining path
- `path-crossing-linear-time` — Time and space are both O(n) in path length; no nested loops or repeated scans
- `path-crossing-no-validation` — Invalid direction characters raise an uncaught KeyError; the function assumes well-formed input

