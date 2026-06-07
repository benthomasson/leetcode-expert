# File: split-a-string-in-balanced-strings/solution.py

**Date:** 2026-06-06
**Time:** 19:14

## Purpose

This file implements LeetCode problem **1221 — Split a String in Balanced Strings**. It solves the problem of finding the maximum number of balanced substrings (substrings with equal counts of `'L'` and `'R'`) that a balanced string can be split into. The file is self-contained: it defines the solution function and its unit tests in one module.

## Key Components

### `find_special_integer(s: str) -> int`

Despite its misleading name (likely a copy-paste artifact from a template — the function has nothing to do with "special integers"), this is the core solver. Its contract:

- **Input**: A string `s` containing only `'L'` and `'R'`, guaranteed to be balanced overall (equal total L and R counts).
- **Output**: The maximum number of non-overlapping balanced substrings `s` can be split into.
- **Strategy**: Greedy — split as early as possible. Every time the running balance returns to zero, that's one more balanced substring.

### `TestFindSpecialInteger`

Six test cases covering the LeetCode examples plus edge cases: minimal input (`"RL"`), alternating characters, and nested structure (`"RRLLRRLL"`).

## Patterns

**Greedy counter pattern.** The solution uses a single integer `balance` as a stand-in for tracking `'R'` vs `'L'` counts. `'R'` increments, `'L'` decrements. When balance hits zero, both characters have appeared equally — that's a split point. This is the canonical O(n) greedy approach for this problem; no stack or auxiliary data structure needed.

**Self-contained test module.** The file bundles `unittest.TestCase` alongside the solution, runnable via `python -m unittest` or `python solution.py` directly through the `if __name__` guard.

## Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The `test_solution.py` in this same directory, plus hundreds of `test_solution.py` files across other problem directories. This is almost certainly a dependency-graph artifact — those other test files likely import from their *own* `solution.py`, not this one. The `Imported By` list reflects a tool that resolved `import solution` ambiguously across the flat directory structure.

## Flow

1. Initialize `balance = 0` and `result = 0`.
2. Iterate character by character through `s`.
3. For each `'R'`, add 1 to `balance`; for each `'L'`, subtract 1.
4. Whenever `balance == 0`, increment `result` — we've found a balanced substring.
5. Return `result`.

For `"RLRRLLRLRL"`: the balance trace is `[1,0,1,2,1,0,1,0,1,0]`, hitting zero at indices 1, 5, 7, 9 → returns 4.

## Invariants

- The algorithm assumes `s` is balanced overall (equal L and R). If it isn't, the final balance won't be zero, but the function still returns a count — it just won't account for the trailing unbalanced portion.
- The greedy "split at every zero-crossing" is provably optimal for maximizing the number of balanced splits, because deferring a split can never create more splits later.
- `balance` is always in the range `[-len(s), len(s)]`.

## Error Handling

None. The function trusts its input — no validation that `s` contains only `'L'`/`'R'`, no check that the string is balanced. Consistent with LeetCode solution conventions where inputs are guaranteed by the problem constraints.

## Topics to Explore

- [file] `split-a-string-in-balanced-strings/plan.md` — The problem analysis and approach rationale written before implementing the solution
- [file] `split-a-string-in-balanced-strings/review.md` — Post-implementation review, likely flags the misleading function name
- [general] `greedy-balance-counter` — This same balance-counter technique appears in parentheses problems (valid parentheses, max nesting depth) — worth comparing how the zero-crossing test adapts across problems
- [function] `split-a-string-in-balanced-strings/test_solution.py:*` — The separate test file may have additional or different test cases beyond what's inline here
- [general] `function-naming-conventions` — `find_special_integer` is clearly wrong for this problem; checking whether other solutions share this template artifact

## Beliefs

- `greedy-split-is-optimal` — Splitting at every zero-crossing of the balance counter produces the maximum number of balanced substrings; no other strategy yields more splits.
- `function-name-mismatch` — `find_special_integer` does not match the problem it solves; it likely originates from a code-generation template that wasn't updated per-problem.
- `r-positive-l-negative-convention` — The solution assigns `+1` to `'R'` and `-1` to `'L'`; swapping this convention would produce identical results since only zero-crossings matter.
- `no-input-validation` — The function performs no checks on its input; passing characters other than `'L'`/`'R'` silently produces wrong results rather than raising an error.

