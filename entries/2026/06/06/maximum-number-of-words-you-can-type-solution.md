# File: maximum-number-of-words-you-can-type/solution.py

**Date:** 2026-06-06
**Time:** 17:40

## Purpose

This file is the solution and test suite for [LeetCode 1935 — Maximum Number of Words You Can Type](https://leetcode.com/problems/maximum-number-of-words-you-can-type/). It owns the complete implementation: the algorithm in `Solution.canBeTypedWords` and the verification in `TestSolution`. Each problem directory in this repo follows the same structure (`solution.py`, `test_solution.py`, `plan.md`, `review.md`), though here the solution and tests are combined in a single file.

## Key Components

### `Solution.canBeTypedWords(text, brokenLetters) -> int`

Takes a space-separated string of words and a string of distinct broken letter keys. Returns how many words can be fully typed — meaning none of their characters appear in the broken set.

The implementation is two lines:
1. Convert `brokenLetters` to a `set` for O(1) membership checks.
2. Split `text` on spaces, test each word with `set.isdisjoint()`, and sum the boolean results.

### `TestSolution`

Seven test cases covering: the three LeetCode examples, no broken letters, a single word that can't be typed, single-character words, and all letters broken.

## Patterns

- **Set-based membership**: Converting `brokenLetters` to a set turns per-character lookups from O(b) to O(1), making the overall complexity O(n) in the total length of `text` rather than O(n * b).
- **`set.isdisjoint`**: Instead of checking `any(c in broken for c in word)`, `isdisjoint` delegates to a C-level loop — both more concise and faster.
- **`sum(generator)`**: Counts `True` values directly, avoiding an intermediate list or explicit counter.
- **Self-contained module**: Solution + tests in one file, runnable via `python solution.py` or `pytest`.

## Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — it lists hundreds of `test_solution.py` files across unrelated problems. This is likely an artifact of the analysis tool matching on `import unittest` or the common `Solution` class name, not actual cross-problem imports. This module is self-contained and not imported by other solutions.

## Flow

1. `brokenLetters` → `set(brokenLetters)` — O(b) construction.
2. `text.split()` → list of words — O(n) split on whitespace.
3. For each word, `broken.isdisjoint(word)` — returns `True` if no character in `word` is in `broken`. Internally iterates over the shorter of the two sets/iterables.
4. `sum(...)` counts the `True` values → final count.

## Invariants

- `brokenLetters` contains distinct lowercase letters (guaranteed by the problem constraints — the code doesn't validate this, nor does it need to since `set()` deduplicates anyway).
- `text` is non-empty and contains only lowercase letters and spaces (problem guarantee).
- Words are separated by single spaces with no leading/trailing spaces (per LeetCode spec), so `str.split()` produces the correct word list.

## Error Handling

None. The function trusts its inputs match the LeetCode contract. No defensive checks, no exceptions raised. This is appropriate — LeetCode guarantees valid inputs, and the set operations handle edge cases (empty `brokenLetters` → empty set → `isdisjoint` always returns `True`).

---

## Topics to Explore

- [file] `maximum-number-of-words-you-can-type/review.md` — The code review may document alternative approaches or performance observations
- [function] `check-if-the-sentence-is-pangram/solution.py:canBeTypedWords` — Another set-membership problem with a complementary check (all letters present vs. no broken letters present)
- [general] `set-isdisjoint-vs-intersection` — When `isdisjoint` is preferable to checking `len(a & b) == 0` or `any(c in s for c in word)` — relevant to many solutions in this repo
- [file] `find-words-that-can-be-formed-by-characters/solution.py` — A harder variant where character counts matter, not just presence

## Beliefs

- `broken-set-disjoint-pattern` — `canBeTypedWords` counts words by testing `set.isdisjoint` against a precomputed broken-letter set, making it O(n) in total text length
- `empty-broken-letters-returns-all-words` — When `brokenLetters` is empty, the function returns the total word count because an empty set is disjoint with everything
- `no-cross-problem-imports` — Despite the large "Imported By" list, this module is self-contained and not actually imported by other problem solutions
- `single-file-solution-test-pattern` — The solution and tests coexist in `solution.py`, runnable both as a script (`__main__`) and via test discovery

