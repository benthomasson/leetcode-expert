# File: minimum-changes-to-make-alternating-binary-string/solution.py

**Date:** 2026-06-06
**Time:** 17:53

## Purpose

This file solves [LeetCode 1758: Minimum Changes to Make Alternating Binary String](https://leetcode.com/problems/minimum-changes-to-make-alternating-binary-string/). It owns the complete solution and its unit tests in a single module — the standard layout for this repository where each problem gets a directory with `solution.py` and `test_solution.py`.

## Key Components

### `canDistribute(s: str) -> int`

Despite the misleading name (likely a copy-paste artifact — the LeetCode method is `minOperations`), this function computes the minimum number of character flips to make a binary string alternate between `'0'` and `'1'`.

**Contract**: Accepts a non-empty string of `'0'`s and `'1'`s. Returns a non-negative integer.

### `TestCanDistribute`

Seven test methods covering the LeetCode examples, single characters, all-same strings, already-alternating strings, and two-character edge cases.

## Patterns

**The "count one pattern, derive the other" idiom.** There are exactly two valid alternating strings for any length: one starting with `'0'` (`010101...`) and one starting with `'1'` (`101010...`). The solution counts mismatches against the `'0'`-start pattern (`count`), then uses `len(s) - count` for the `'1'`-start pattern — because every position that matches one pattern mismatches the other. `min(count, len(s) - count)` picks the cheaper target.

This avoids a second pass entirely. It's the canonical O(n) / O(1) approach for this problem.

**Self-contained module.** Both the solution function and tests live in `solution.py`. The separate `test_solution.py` imports from here, enabling `pytest` discovery while also supporting `python solution.py` directly via the `__main__` guard.

## Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The massive `Imported By` list is misleading. Those are `test_solution.py` files from *other* problems, not actual consumers of `canDistribute`. This is likely an artifact of the static analysis tool treating all `from solution import *` patterns as cross-references when they each resolve to their own local `solution.py`.

## Flow

1. `enumerate(s)` yields `(index, char)` pairs.
2. The generator expression compares each character against the expected value for the `0`-start pattern: position `i` should be `'0'` if `i` is even, `'1'` if odd.
3. `sum(...)` counts mismatches → this is the cost to reach `"0101..."`.
4. `len(s) - count` is the cost to reach `"1010..."` (complement).
5. Return the minimum.

## Invariants

- `count + (len(s) - count) == len(s)` always holds — every position mismatches exactly one of the two target patterns.
- For any input of length 1, the result is always 0 (a single character is trivially alternating).
- The result is at most `len(s) // 2` — you never need to flip more than half the string.

## Error Handling

None. The function assumes valid input (non-empty binary string). Passing an empty string would return 0, which is arguably correct. Non-binary characters would silently count as mismatches against both `'0'` and `'1'`, producing a wrong answer rather than an error.

## Topics to Explore

- [file] `minimum-changes-to-make-alternating-binary-string/test_solution.py` — How the separate test file imports and exercises this solution
- [file] `minimum-changes-to-make-alternating-binary-string/plan.md` — The planning document that preceded this implementation
- [general] `function-naming-conventions` — The function is named `canDistribute` rather than `minOperations`; worth checking if other solutions also have mismatched names
- [function] `minimum-recolors-to-get-k-consecutive-black-blocks/solution.py:minRecolors` — A structurally similar "count mismatches in a window" problem for comparison
- [file] `binary-number-with-alternating-bits/solution.py` — Related problem that checks (rather than fixes) an alternating bit pattern

## Beliefs

- `complement-optimization` — The cost to reach the `'1'`-start pattern is always `len(s) - count` where `count` is the cost to reach the `'0'`-start pattern, so only one pass is needed.
- `function-name-mismatch` — The function is named `canDistribute` which does not match the LeetCode problem's expected method name `minOperations`, suggesting a copy-paste origin.
- `result-upper-bound` — The return value never exceeds `len(s) // 2` for any valid binary string input.
- `no-input-validation` — The function performs no validation on input; non-binary characters or empty strings are silently accepted without error.

