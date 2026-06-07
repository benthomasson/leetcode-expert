# File: minimum-moves-to-convert-string/solution.py

**Date:** 2026-06-06
**Time:** 17:59

## `minimum-moves-to-convert-string/solution.py`

### Purpose

Solves [LeetCode 2027: Minimum Moves to Convert String](https://leetcode.com/problems/minimum-moves-to-convert-string/). Given a string of `'X'` and `'O'` characters, each move converts any 3 consecutive characters to `'O'`. The function returns the minimum number of moves to eliminate all `'X'`s.

### Key Components

**`Solution.maximumRemovals(self, s: str) -> int`** — The method name is wrong. It should be something like `minimumMoves` to match the problem; `maximumRemovals` is the name of a different LeetCode problem (1898). The docstring is correct, though — it describes the actual behavior.

### Flow

The algorithm is a greedy left-to-right scan:

1. Pointer `i` walks through the string.
2. On `'O'`: advance by 1 — nothing to do.
3. On `'X'`: spend one move, then skip ahead by 3. The move covers positions `i`, `i+1`, `i+2`, so any `'X'`s in those next two positions are handled for free.
4. Return total moves.

This greedy choice is optimal because any `'X'` must be covered by some move, and covering the leftmost uncovered `'X'` as early as possible maximizes the reach of each move (you never waste coverage on positions you've already passed).

### Patterns

**Greedy skip** — a common idiom for interval-covering problems. Instead of tracking which positions are covered, the pointer jump (`i += 3`) implicitly marks the next two positions as "handled." This avoids needing a separate data structure.

### Dependencies

No imports. The class follows the standard LeetCode `Solution` convention for submission compatibility. The `Imported By` list in the prompt is misleading — that's an artifact of the test harness importing `Solution` from each problem's own `solution.py`, not cross-problem imports.

### Invariants

- Every `'X'` in the string is covered by exactly one move's 3-character window.
- The pointer never moves backward — single-pass, O(n) time.
- After `i += 3`, the pointer may land past `len(s)`, which is fine because the `while` condition catches it.

### Error Handling

None. The function assumes valid input (a string of only `'X'` and `'O'`). An empty string returns 0 correctly since the while loop body never executes.

---

## Topics to Explore

- [file] `minimum-moves-to-convert-string/test_solution.py` — Verify what test cases exist and whether the misnamed method is tested under its current name
- [file] `minimum-moves-to-convert-string/review.md` — Check if the review caught the method name mismatch
- [general] `greedy-interval-covering` — The same skip-by-k greedy pattern appears in problems like "Minimum Number of Taps to Open to Water a Garden" and "Jump Game"
- [function] `minimum-recolors-to-get-k-consecutive-black-blocks/solution.py:Solution` — A related sliding-window string problem in this repo for comparison

## Beliefs

- `method-name-mismatch` — `Solution.maximumRemovals` is misnamed; the LeetCode problem expects `minimumMoves` and the method solves "minimum moves to convert string," not "maximum removals"
- `greedy-skip-optimality` — Skipping 3 positions on each `'X'` produces the minimum move count because covering the leftmost uncovered `'X'` first never wastes a move
- `single-pass-linear-time` — The algorithm runs in O(n) time and O(1) space with no auxiliary data structures
- `empty-string-safe` — An empty input returns 0 without any special-case guard

