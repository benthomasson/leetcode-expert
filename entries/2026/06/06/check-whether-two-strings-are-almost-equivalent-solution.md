# File: check-whether-two-strings-are-almost-equivalent/solution.py

**Date:** 2026-06-06
**Time:** 15:45

## Purpose

This file implements [LeetCode 2068: Check Whether Two Strings are Almost Equivalent](https://leetcode.com/problems/check-whether-two-strings-are-almost-equivalent/). It belongs to the `leetcode-implementations` repo, where each problem lives in its own directory with a solution, tests, plan, and review.

The solution determines whether two strings are "almost equivalent" — meaning for every letter in the alphabet, the difference in frequency between the two strings is at most 3.

## Key Components

**`Solution.checkAlmostEquivalent(self, word1, word2) -> bool`** — The single method, following LeetCode's expected class/method signature. It:
- Accepts two strings of lowercase English letters
- Returns `True` if no character's frequency differs by more than 3 between the two strings

## Patterns

- **Counter-based frequency comparison**: Uses `collections.Counter` to build frequency maps, then iterates over the union of keys. `Counter` returns 0 for missing keys, so `freq1[c] - freq2[c]` works correctly even when a character appears in only one string.
- **Early exit on violation**: Returns `False` as soon as any character exceeds the threshold, avoiding unnecessary work on the remaining characters.
- **Standard LeetCode class structure**: Wraps the function in a `Solution` class with no `__init__`, matching the LeetCode submission format used throughout this repo.

## Dependencies

**Imports**: `collections.Counter` — the only external dependency.

**Imported by**: The test file `check-whether-two-strings-are-almost-equivalent/test_solution.py`. The large "Imported By" list in the prompt is misleading — those are unrelated test files that happen to import from their own `solution.py` modules, not from this one.

## Flow

1. Build `freq1` from `word1` and `freq2` from `word2` using `Counter`.
2. Compute the union of all characters present in either counter via `set(freq1) | set(freq2)`.
3. For each character in that union, check if `abs(freq1[c] - freq2[c]) > 3`.
4. If any character exceeds the threshold, return `False` immediately.
5. If the loop completes, return `True`.

## Invariants

- The threshold is hardcoded at 3, matching the problem definition.
- The union of key sets guarantees every character appearing in *either* string is checked — not just characters in `word1`.
- `Counter.__getitem__` returns 0 for absent keys, so no `KeyError` is possible.

## Error Handling

None. The function assumes valid input per LeetCode constraints (lowercase English letters, non-empty strings). No exceptions are raised or caught.

## Topics to Explore

- [file] `check-whether-two-strings-are-almost-equivalent/test_solution.py` — See the edge cases being tested (identical strings, single-char differences, boundary at exactly 3 vs 4)
- [file] `check-whether-two-strings-are-almost-equivalent/review.md` — Contains the code review and any noted improvements or alternatives
- [function] `find-common-characters/solution.py:commonChars` — Another Counter-based solution that uses intersection instead of difference, showing a contrasting Counter pattern
- [general] `counter-vs-manual-frequency` — Several solutions in this repo compare Counter-based approaches against manual dict or array-based counting; understanding when each is preferred

## Beliefs

- `counter-missing-key-returns-zero` — `Counter.__getitem__` returns 0 for keys not in the counter, making `freq1[c] - freq2[c]` safe without `.get()` defaults
- `threshold-is-hardcoded-3` — The almost-equivalent threshold of 3 is baked into the comparison, not parameterized
- `union-covers-all-characters` — Using `set(freq1) | set(freq2)` ensures characters appearing in only one string are still checked against the threshold
- `early-exit-on-first-violation` — The method short-circuits on the first character exceeding the frequency difference limit rather than scanning all 26 letters

