# File: number-of-strings-that-appear-as-substrings-in-word/solution.py

**Date:** 2026-06-06
**Time:** 18:22

## Purpose

This file solves [LeetCode 1967: Number of Strings That Appear as Substrings in Word](https://leetcode.com/problems/number-of-strings-that-appear-as-substrings-in-word/). It owns exactly one responsibility: given a list of pattern strings and a target word, count how many patterns appear as substrings of that word.

Within the project, it follows the standard convention — each problem directory contains a `solution.py` with a `Solution` class that LeetCode's judge can invoke.

## Key Components

**`Solution.numOfStrings(patterns, word) -> int`** — The sole method. Takes a list of strings and a target string, returns the count of patterns found as substrings in `word`. The contract matches LeetCode's expected signature: `List[str]` input, `int` output.

## Patterns

The implementation uses a **generator expression with `sum`** — a standard Python idiom for counting elements that satisfy a predicate. `sum(1 for p in patterns if p in word)` is functionally equivalent to `len([p for p in patterns if p in word])` but avoids allocating an intermediate list.

The substring check itself delegates entirely to Python's `in` operator on strings, which under the hood uses a fast substring search (a variant of Boyer-Moore/Horspool in CPython).

## Dependencies

**Imports**: `typing.List` — used only for the type annotation. In Python 3.9+ this could be replaced with `list[str]`, but the project uses the `typing` import consistently across all solutions for compatibility.

**Imported by**: The `test_solution.py` in the same directory imports this `Solution` class. The massive "Imported By" list in the prompt is misleading — those are test files from *other* problem directories that happen to share the same import pattern (`from solution import Solution`), not actual cross-problem dependencies.

## Flow

1. Iterate over each string `p` in `patterns`
2. For each `p`, test `p in word` — Python's string containment check
3. Yield `1` for every match
4. `sum` accumulates the count

No intermediate data structures, no early termination. Every pattern is checked unconditionally.

## Invariants

- The method is pure — no side effects, no mutation of inputs.
- The return value is always in `[0, len(patterns)]`.
- Empty `patterns` returns `0`. An empty string `""` in `patterns` always counts as a match (empty string is a substring of every string).

## Error Handling

None. The method trusts its inputs conform to LeetCode's constraints (non-null list, non-null strings). This is appropriate — validation happens at the platform boundary, not inside the solution.

## Topics to Explore

- [file] `number-of-strings-that-appear-as-substrings-in-word/test_solution.py` — See what edge cases the test suite covers (empty patterns, empty word, overlapping matches)
- [file] `number-of-strings-that-appear-as-substrings-in-word/review.md` — The code review may note complexity tradeoffs or alternative approaches
- [function] `string-matching-in-an-array/solution.py:Solution` — A related problem (find strings that are substrings of other strings in the same array) that uses the same `in` operator pattern but with a different structure
- [general] `cpython-string-search` — CPython's `str.__contains__` uses a hybrid algorithm combining Boyer-Moore and Horspool; understanding it clarifies why naive `in` checks are competitive with explicit algorithm implementations for typical LeetCode constraints

## Beliefs

- `numofstrings-pure-function` — `numOfStrings` is a pure function with no side effects, no mutation, and deterministic output for any given input
- `numofstrings-linear-complexity` — Time complexity is O(n * m * k) where n = len(patterns), m = max pattern length, k = len(word), since each `in` check is O(m * k) in the worst case
- `empty-string-always-matches` — An empty string in `patterns` always increments the count, because `"" in word` is `True` for any `word`
- `no-cross-problem-dependencies` — Despite the large "Imported By" list, this solution has zero actual cross-problem dependencies; each test file imports its own directory's `Solution`

