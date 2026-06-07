# File: rotate-string/solution.py

**Date:** 2026-06-06
**Time:** 18:58

## Purpose

This file implements the solution to [LeetCode 796 - Rotate String](https://leetcode.com/problems/rotate-string/). It determines whether string `s` can become string `goal` by performing any number of left-shift rotations (moving the first character to the end repeatedly).

It's one of ~500+ problem solutions in the `leetcode-implementations` repo, each isolated in its own directory with a consistent `solution.py` / `test_solution.py` / `review.md` / `plan.md` structure.

## Key Components

**`can_transform(s, goal) -> bool`** — The sole public function. It checks two conditions in a single expression:

1. `len(s) == len(goal)` — strings must be the same length (a rotation can't change length)
2. `goal in s + s` — if `goal` is a substring of `s` concatenated with itself, then some rotation of `s` produces `goal`

## Patterns

**String doubling trick.** Concatenating `s` with itself produces a string that contains every possible rotation of `s` as a contiguous substring. For `s = "abcde"`, `s + s = "abcdeabcde"`, which contains `"bcdea"`, `"cdeab"`, `"deabc"`, `"eabcd"`, and `"abcde"` — all five rotations. This reduces rotation checking to a single substring search.

**Short-circuit evaluation.** The length check comes first. If lengths differ, Python skips the `in` check entirely, avoiding the O(n) concatenation and substring search.

## Dependencies

**Imports:** None — pure Python, no standard library or third-party dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that happen to share a common test harness pattern, not actual consumers of `can_transform`. The real consumer is `rotate-string/test_solution.py`.

## Flow

1. Compare lengths — O(1)
2. Concatenate `s + s` — O(n) time and space
3. Check `goal in s + s` — O(n) on average using Python's built-in substring search (CPython uses a modified Boyer-Moore-Horspool)
4. Return the boolean result

Overall: O(n) time, O(n) space.

## Invariants

- Both inputs are assumed to be strings (no type coercion or validation).
- Empty strings: `can_transform("", "")` returns `True` — `len` matches and `"" in ""` is `True`. This is correct since zero rotations of `""` yields `""`.

## Error Handling

None. The function is a pure predicate with no failure modes beyond receiving non-string inputs, which would raise a `TypeError` from Python's built-in operators.

## Topics to Explore

- [file] `rotate-string/test_solution.py` — See what edge cases are covered (empty strings, single char, no match)
- [file] `rotate-string/review.md` — Automated review notes on this solution's quality and alternatives
- [function] `repeated-substring-pattern/solution.py:can_transform` — Uses the same `s + s` doubling trick for a related but distinct problem
- [general] `string-doubling-rotation-proof` — Why `goal in s+s` is both necessary and sufficient when lengths match
- [file] `perform-string-shifts/solution.py` — A generalization where shifts can be left or right with varying amounts

## Beliefs

- `rotate-string-doubling-correctness` — `goal in s + s` is equivalent to checking all `len(s)` rotations, given `len(s) == len(goal)`
- `rotate-string-no-imports` — The solution uses zero imports; it relies entirely on Python built-in string operators
- `rotate-string-empty-string-true` — `can_transform("", "")` returns `True`, which is the correct behavior (zero rotations)
- `rotate-string-linear-complexity` — Time and space complexity are both O(n) where n is `len(s)`

