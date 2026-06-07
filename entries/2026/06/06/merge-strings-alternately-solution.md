# File: merge-strings-alternately/solution.py

**Date:** 2026-06-06
**Time:** 17:47

## `merge-strings-alternately/solution.py`

### Purpose

This file implements [LeetCode 1768 — Merge Strings Alternately](https://leetcode.com/problems/merge-strings-alternately/). It's a standalone solution module in a repository of LeetCode problems, each living in its own directory. The function interleaves characters from two input strings, taking one character at a time from each, and appends the remainder of the longer string when the shorter one is exhausted.

### Key Components

**`mergeAlternately(word1, word2)`** — The sole function. Takes two strings, returns a single merged string. The contract: characters alternate starting with `word1[0]`, then `word2[0]`, then `word1[1]`, etc. When one string runs out, the rest of the other is appended verbatim.

### Patterns

The solution uses a **single-pass index-based iteration** over `range(max(len(word1), len(word2)))`, with bounds-checked appends for each string. This is the "iterate to the longer length" idiom — rather than zipping and handling the tail separately, it uses one loop with two conditional appends. The list-accumulate-then-join pattern (`result = []` → `.append()` → `"".join()`) is standard Python for efficient string building.

An alternative would be `itertools.zip_longest` followed by join, or Python's built-in `zip` plus slicing for the tail. This implementation is more explicit and arguably easier to read at interview speed.

### Dependencies

**Imports:** None — pure function, no standard library or third-party dependencies.

**Imported by:** The `test_solution.py` in the same directory, plus ~400+ test files across other problem directories. That massive "Imported By" list is likely an artifact of a shared test harness or runner (`run_tests.py`) that discovers and imports all solution modules — individual problem tests shouldn't logically depend on an unrelated problem's solution.

### Flow

1. Initialize empty list `result`.
2. Loop `i` from `0` to `max(len(word1), len(word2)) - 1`.
3. If `i < len(word1)`, append `word1[i]` (character from first string).
4. If `i < len(word2)`, append `word2[i]` (character from second string).
5. Join and return.

For `mergeAlternately("ab", "pqrs")`: iteration produces `['a','p','b','q','r','s']` → `"apbqrs"`. The `word1` guard fails at `i=2,3`, so only `word2` characters are appended for those indices.

### Invariants

- `word1` always contributes its character **before** `word2` at each index — the ordering is deterministic.
- Every character from both inputs appears exactly once in the output.
- Output length always equals `len(word1) + len(word2)`.

### Error Handling

None. Empty strings are handled implicitly — if `word1` is empty, only `word2` characters pass the guard; if both are empty, the range is 0 and the result is `""`. No validation, no exceptions raised.

### Complexity

O(n + m) time and space where n and m are the lengths of `word1` and `word2`. Each character is visited exactly once.

## Topics to Explore

- [file] `merge-strings-alternately/test_solution.py` — See how edge cases (empty strings, single chars, vastly different lengths) are tested
- [file] `merge-strings-alternately/review.md` — Code review notes that may document alternative approaches considered
- [function] `greatest-common-divisor-of-strings/solution.py:gcdOfStrings` — A related string-interleaving problem that uses a different structural pattern
- [file] `run_tests.py` — Explains the shared test harness and why hundreds of test files appear to import this module
- [general] `two-pointer-string-merge` — Compare this index-based approach to a two-pointer or `itertools.zip_longest` implementation

## Beliefs

- `merge-alternately-output-length` — Output length is always exactly `len(word1) + len(word2)`; no characters are dropped or duplicated
- `merge-alternately-word1-first` — At each index position, `word1`'s character is appended before `word2`'s, guaranteeing `word1` leads
- `merge-alternately-no-deps` — The solution is a pure function with zero imports, making it fully self-contained
- `merge-alternately-linear-complexity` — Time and space are both O(n + m), single pass with list accumulation

