# File: reformat-the-string/solution.py

**Date:** 2026-06-06
**Time:** 18:42

## Purpose

This file solves [LeetCode 1417: Reformat The String](https://leetcode.com/problems/reformat-the-string/). Given a string of lowercase letters and digits, it interleaves the two character types so no two adjacent characters share the same type (both letters or both digits). If that's impossible, it returns an empty string.

The file owns both the solution and its test suite — a self-contained unit following the repo's convention of `solution.py` per problem directory.

## Key Components

### `Solution.reformat(s: str) -> str`

The only public method. Contract:

- **Input**: A string `s` containing only lowercase English letters and digits.
- **Output**: Any valid interleaving where adjacent characters differ in type, or `""` if impossible.
- **Guarantee**: The output is a permutation of `s` (or empty). No characters are added or dropped.

### `TestReformat`

Ten test cases covering: balanced counts, all-letters, all-digits, single characters, off-by-one in both directions, and the impossible case where the count difference exceeds 1.

## Patterns

**Partition-then-interleave**: The algorithm separates the input into two buckets by type, then zips them together. This is the canonical approach for "alternate two groups" problems — it reduces the interleaving constraint to a simple length check.

**Longer-group-first**: Lines 19–20 ensure the group with more elements goes into `letters` (despite the name). This guarantees the interleave loop consumes all of `digits`, and any leftover single element from `letters` is appended at the end. The variable naming is misleading after the swap — `letters` may hold digits.

**Inline tests**: The test class lives in the same file as the solution, matching the repo-wide pattern visible in the directory structure (each problem has `solution.py` + `test_solution.py`, but the solution file itself also contains tests runnable via `__main__`).

## Dependencies

**Imports**: Only `unittest` from the standard library. No external dependencies.

**Imported by**: The `test_solution.py` files listed in the "Imported By" section import this module's `Solution` class. The massive list (~400 files) appears to be an artifact of the repo's shared test infrastructure — these are not direct consumers of the reformat logic but rather follow a common import pattern across the repo.

## Flow

1. **Partition** (lines 15–16): Two list comprehensions split `s` into `letters` (alpha chars) and `digits` (digit chars).
2. **Feasibility check** (line 18): If the two lists differ in length by more than 1, return `""` — interleaving is impossible because one type would have to sit adjacent to itself.
3. **Normalize order** (lines 20–21): If `digits` is longer, swap so the longer list is always in `letters`. This simplifies the merge to one code path.
4. **Interleave** (lines 23–26): Iterate over the shorter list's indices. For each index, append one from `letters` then one from `digits`. If `letters` has one extra element, append it at the end.
5. **Join and return** (line 28): Concatenate the result list into a string.

## Invariants

- **|len(letters) - len(digits)| <= 1**: Enforced at line 18. This is the necessary and sufficient condition for a valid interleaving of two groups.
- **The longer group always occupies even indices (0, 2, 4, ...)**: After the swap at line 20–21, `letters` is always >= `digits` in length, so it fills positions 0, 2, 4, ... ensuring the ends of the string belong to the majority type.
- **Output length equals input length** (when non-empty): Every character from `s` appears exactly once in the result.

## Error Handling

No exceptions are raised. The impossible case is communicated via the return value `""`. The algorithm assumes the input contract (lowercase letters + digits only) is met — there's no validation of character types.

## Topics to Explore

- [file] `reformat-the-string/test_solution.py` — The external test file that imports `Solution`; may contain additional edge cases beyond the inline tests
- [file] `reformat-the-string/plan.md` — The planning document likely captures the problem analysis and approach selection rationale
- [function] `reformat-the-string/solution.py:reformat` — Worth tracing through with input `"a12"` to see the swap path where digits outnumber letters
- [general] `interleave-pattern-solutions` — Other problems in this repo using the partition-then-interleave pattern (e.g., `sort-array-by-parity`, `shuffle-the-array`)
- [file] `reformat-the-string/review.md` — The code review document may flag the misleading variable names after the swap

## Beliefs

- `reformat-impossible-iff-diff-gt-1` — `reformat` returns `""` if and only if the count of letters and digits differ by more than 1
- `reformat-longer-group-gets-even-indices` — After the swap, the longer group always occupies even-indexed positions (0, 2, 4, ...) in the output
- `reformat-variable-names-misleading-after-swap` — After line 21, `letters` may contain digit characters and `digits` may contain letter characters; the names reflect initial assignment, not post-swap content
- `reformat-output-is-deterministic` — For a given input, the output is always the same permutation (no randomness), though it may not match LeetCode's expected output since any valid interleaving is accepted

