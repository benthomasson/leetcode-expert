# File: valid-word-square/solution.py

**Date:** 2026-06-06
**Time:** 19:41

## Purpose

This file implements the solution to [LeetCode 422 — Valid Word Square](https://leetcode.com/problems/valid-word-square/). It determines whether a list of strings forms a valid word square, meaning the k-th row reads the same as the k-th column. It's one of hundreds of self-contained solution modules in the `leetcode-implementations` repo, each owning exactly one problem's algorithm.

## Key Components

### `valid_word_square(words: list[str]) -> bool`

The sole export. Takes a list of strings and returns whether they form a valid word square — i.e., `words[i][j] == words[j][i]` for all valid `(i, j)`.

The function does **not** require the input to be a square matrix. Words can have different lengths, and there can be fewer words than the length of the longest word. The algorithm handles these ragged cases via boundary checks rather than padding.

## Patterns

**Early-exit falsification.** Rather than building the transpose and comparing, the function iterates character-by-character and returns `False` the moment any mismatch is found. This is the standard pattern across this repo's solutions — minimize work by failing fast.

**Boundary-as-logic.** The three conditions in the `if` on line 14 do double duty: they both prevent index-out-of-range errors *and* encode the semantic rule that a missing character (because a row is shorter or a column index exceeds the number of rows) is a structural violation of the word-square property. If row `i` has a character at column `j`, then row `j` must exist and must have a character at column `i`.

## Dependencies

**Imports:** None. Pure stdlib Python — no external or internal dependencies.

**Imported by:** The test file `valid-word-square/test_solution.py` imports this directly. The "Imported By" list in the prompt shows ~400+ test files, but that's likely an artifact of a shared test harness or fixture pattern — not direct usage of `valid_word_square` itself.

## Flow

1. Outer loop: iterate over each word `words[i]` by index.
2. Inner loop: iterate over each character `words[i][j]` by index.
3. For each `(i, j)`, check three conditions (any triggers `return False`):
   - `j >= len(words)` — column `j` references a row that doesn't exist.
   - `i >= len(words[j])` — row `j` isn't long enough to have column `i`.
   - `words[j][i] != ch` — the transposed character doesn't match.
4. If the entire grid passes, return `True`.

The check is **not symmetric** — it only verifies that every character in every row matches the corresponding transposed position. But that's sufficient: if row `j` had an *extra* character at position `i` that row `i` didn't have at position `j`, that extra character would be caught when `i` and `j` are swapped in the outer/inner loop iteration.

## Invariants

- The function handles ragged input (words of different lengths) without requiring pre-normalization.
- If any word extends beyond the number of rows (`j >= len(words)`), the square is invalid — this prevents a word from claiming a column that has no corresponding row.
- The check is complete: every `(i, j)` where a character exists is validated against `(j, i)`. No positions are skipped.

## Error Handling

None. The function assumes `words` is a valid `list[str]`. No exceptions are raised or caught. Out-of-bounds access is prevented by the explicit boundary checks in the condition, not by try/except.

## Topics to Explore

- [file] `valid-word-square/test_solution.py` — See what edge cases are tested (empty list, single word, ragged lengths, single-char words)
- [file] `valid-word-square/plan.md` — The problem decomposition and approach reasoning before implementation
- [general] `ragged-matrix-transpose-validation` — Why checking only the "forward" direction (row chars against column chars) is sufficient without also iterating columns explicitly
- [function] `valid-word-square/solution.py:valid_word_square` — Try tracing through `["abc", "b"]` to see how the boundary check catches that column 2 (`"c"`) has no corresponding row 2

## Beliefs

- `valid-word-square-handles-ragged-input` — The function correctly handles words of different lengths without padding; a missing character position is treated as a mismatch.
- `valid-word-square-boundary-checks-prevent-oob` — The three-part condition on line 14 both enforces the word-square invariant and prevents all possible IndexError scenarios.
- `valid-word-square-no-dependencies` — The solution imports nothing and depends only on Python builtins (`list`, `str`, `len`).
- `valid-word-square-single-direction-sufficient` — Iterating only over existing characters in rows (not separately over columns) is sufficient because any extra column character would be caught when that row is iterated as the outer loop.

