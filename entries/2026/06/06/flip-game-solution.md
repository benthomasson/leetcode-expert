# File: flip-game/solution.py

**Date:** 2026-06-06
**Time:** 16:52

## Purpose

This file implements the solution to **LeetCode 293 — Flip Game**. It owns the game-move generation logic: given a board state (a string of `+` and `-` characters), it produces every possible next state by flipping exactly one pair of adjacent `++` into `--`.

## Key Components

### `Solution.generate_possible_next_moves(currentState: str) -> List[str]`

The sole public method. Its contract:

- **Input**: A string containing only `+` and `-` characters representing the current board.
- **Output**: A list of all valid next states. Each result is the input string with exactly one `++` pair replaced by `--`. Returns an empty list if no moves exist.

## Patterns

**Sliding window of size 2**: The loop at `for i in range(len(currentState) - 1)` examines every consecutive pair `(i, i+1)`. This is the canonical approach for adjacent-pair scanning — O(n) time, O(n) space for results.

**Immutable string construction via slicing**: Each new state is built with `currentState[:i] + "--" + currentState[i + 2:]`. This avoids mutating the input and produces independent copies in the result list. Each slice-and-concat is O(n), giving O(n^2) total for the method in the worst case (all `+` characters).

## Dependencies

**Imports**: `typing.List` — used only for the return type annotation.

**Imported by**: The `flip-game/test_solution.py` file tests this solution directly. The long list of other test files in `Imported By` is likely an artifact of the repo's shared test infrastructure importing `Solution` generically, not actual runtime dependencies on this specific module.

## Flow

1. Initialize an empty `result` list.
2. Iterate `i` from `0` to `len(currentState) - 2`.
3. At each position, check if both `currentState[i]` and `currentState[i+1]` are `+`.
4. If so, construct a new string with those two characters replaced by `--` and append it.
5. Return the accumulated list.

## Invariants

- Every returned string has the **same length** as the input — slicing preserves length since `"--"` replaces exactly two characters.
- Results are ordered by the **index of the flipped pair** (left to right), a natural consequence of the sequential scan.
- The input string is never mutated.

## Error Handling

None. The method trusts that `currentState` is a valid string. An empty string or single-character string naturally produces an empty result because `range(len(s) - 1)` yields an empty range (or `range(-1)` which is also empty). No exceptions are raised or caught.

## Topics to Explore

- [file] `flip-game/test_solution.py` — See the edge cases tested (empty string, all `-`, single `++`, overlapping pairs)
- [file] `flip-game/plan.md` — Understand the design rationale and any alternative approaches considered
- [file] `flip-game/review.md` — Post-implementation review notes on complexity and correctness
- [general] `flip-game-ii` — The follow-up problem (LeetCode 294) adds minimax game-tree search on top of this move generator
- [general] `string-enumeration-pattern` — Several other solutions in this repo use the same sliding-window + string-slice enumeration idiom

## Beliefs

- `flip-game-linear-scan` — `generate_possible_next_moves` scans every adjacent pair exactly once, making it O(n) in comparisons and O(n^2) worst-case overall due to string copying
- `flip-game-output-ordering` — Results are always ordered by the position of the flipped pair, ascending left to right
- `flip-game-length-invariant` — Every output string has the same length as the input string
- `flip-game-no-mutation` — The input `currentState` is never modified; all results are independent string copies

