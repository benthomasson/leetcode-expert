# File: check-if-numbers-are-ascending-in-a-sentence/solution.py

**Date:** 2026-06-06
**Time:** 15:41

## Purpose

This file implements [LeetCode 2042: Check if Numbers Are Ascending in a Sentence](https://leetcode.com/problems/check-if-numbers-are-ascending-in-a-sentence/). It contains both the solution and its unit tests in a single module — the standard layout across this repository. The responsibility is narrow: given a sentence string containing words and numeric tokens, determine whether all numbers appear in strictly increasing order from left to right.

## Key Components

### `Solution.areNumbersAscending(self, s: str) -> bool`

The core algorithm. Splits the sentence on whitespace, filters for numeric tokens via `str.isdigit()`, and checks strict monotonicity by tracking a running `prev` value initialized to `-1`.

**Contract**: Accepts a space-separated sentence where numbers are contiguous digit tokens. Returns `True` if every numeric token is strictly greater than all preceding numeric tokens, `False` otherwise. Non-numeric tokens are ignored entirely.

### `TestAreNumbersAscending`

Eight test cases covering the LeetCode examples plus edge cases: two-number ascending/descending, all-number sequences, boundary values (1 and 99), and leading-number descending sequences.

## Patterns

- **Single-file solution+test**: Matches the repo convention — every problem directory contains `solution.py` with the `Solution` class and `unittest.TestCase` subclass together, runnable via `python -m unittest` or `if __name__ == "__main__"`.
- **Sentinel initialization**: `prev = -1` works because the problem guarantees all numbers are positive integers (1–200 per the constraint), so any valid first number will pass the `num <= prev` check.
- **Token-based parsing**: Uses `str.split()` + `str.isdigit()` rather than regex — idiomatic for problems where tokens are cleanly whitespace-separated and numbers are always standalone tokens (not embedded in words).

## Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — it shows ~400+ test files. This is almost certainly an artifact of the analysis tool conflating `import unittest` across the repo, not actual imports of this module. No other solution depends on this file's `Solution` class.

## Flow

1. `s.split()` tokenizes the sentence into a list of whitespace-delimited strings.
2. Each token is tested with `isdigit()` — only purely numeric strings pass.
3. Numeric tokens are converted to `int` and compared against `prev`.
4. If any number is `<=` the previous one, short-circuit return `False`.
5. Otherwise update `prev` and continue. If the loop completes, return `True`.

The scan is single-pass O(n) where n is the length of the string, with O(n) space for the split result.

## Invariants

- **Strict monotonicity**: Each numeric token must be strictly greater than all prior numeric tokens — equality also fails (`num <= prev`).
- **Sentinel safety**: `prev = -1` is below any valid input number, so the first numeric token always passes. This relies on the LeetCode constraint that numbers are in range [1, 200].
- **`isdigit()` filter**: Only tokens consisting entirely of ASCII digits are treated as numbers. This correctly ignores words, punctuation, and mixed alphanumeric tokens.

## Error Handling

None — the function assumes well-formed input per the LeetCode contract. No validation of the input string, no handling of empty strings, no protection against tokens like `"007"` (which `isdigit()` would accept and `int()` would parse as 7). For LeetCode's constraints this is correct; the problem guarantees tokens are either lowercase English words or numbers without leading zeros.

## Topics to Explore

- [file] `check-if-numbers-are-ascending-in-a-sentence/test_solution.py` — The separate test file in this directory, if it exists alongside the embedded tests
- [file] `check-if-numbers-are-ascending-in-a-sentence/review.md` — The code review for this solution — likely discusses the `isdigit()` vs regex tradeoff
- [general] `isdigit-vs-isnumeric` — `str.isdigit()` returns `True` for superscript digits and other Unicode digit chars in Python 3; in this problem all tokens are ASCII so it's safe, but the distinction matters in general
- [function] `number-of-valid-words-in-a-sentence/solution.py:Solution` — A related sentence-parsing problem that likely uses more complex token validation (regex or character-level checks)
- [file] `run_tests.py` — The repo-wide test runner that exercises all solution files

## Beliefs

- `ascending-check-uses-sentinel-minus-one` — `prev` is initialized to `-1`, relying on the constraint that all numbers in the input are positive integers
- `isdigit-filters-non-numeric-tokens` — Non-numeric words are skipped entirely; only tokens where every character is a digit are treated as numbers
- `single-pass-short-circuit` — The algorithm returns `False` on the first non-ascending pair and never scans the rest of the string
- `solution-and-tests-colocated` — Both the `Solution` class and `TestAreNumbersAscending` live in the same file, following the repo-wide convention

