# File: keyboard-row/solution.py

**Date:** 2026-06-06
**Time:** 17:11

## `keyboard-row/solution.py`

### Purpose

This file solves [LeetCode 500 — Keyboard Row](https://leetcode.com/problems/keyboard-row/): given a list of words, return only those that can be typed using letters from a single row of an American QWERTY keyboard. It's a self-contained module owning both the solution and its test suite.

### Key Components

**`find_words(words: list[str]) -> list[str]`** — The sole public function. Takes a list of strings and filters it down to words whose letters all belong to one keyboard row.

**`row_map`** (line 13) — A dict mapping each lowercase letter to its row index (0 = top row `qwertyuiop`, 1 = home row `asdfghjkl`, 2 = bottom row `zxcvbnm`). Built inline via a dict comprehension over `enumerate`.

**`TestFindWords`** (lines 17–38) — Eight unit tests covering the LeetCode examples plus edge cases: single characters, all-uppercase, mixed case, no matches, and all matches.

### Patterns

**Set-cardinality check** — The core logic is a single list comprehension (line 14):
```python
[w for w in words if len(set(row_map[c] for c in w.lower())) == 1]
```
For each word, it maps every character to its row index, collects those into a set, and checks whether the set has exactly one element. If so, all letters share a row. This is idiomatic Python — compact and avoids explicit loops or conditionals.

**Single-file solution+test** — The solution and its `unittest.TestCase` live in the same file, runnable via `python -m unittest` or `python solution.py`. This is the standard pattern across the repo.

### Dependencies

**Imports:** Only `unittest` from the standard library. No external packages.

**Imported by:** The `test_solution.py` files listed in the `Imported By` section don't actually import *this* file — that list appears to be a repo-wide cross-reference artifact. The real consumer is `keyboard-row/test_solution.py`, which likely imports `find_words` from this module.

### Flow

1. Build `row_map` once per call — `enumerate` assigns index 0/1/2 to the three row strings, then the nested comprehension unpacks each string's characters into `{char: row_index}` pairs.
2. For each word `w`, lowercase it, look up every character in `row_map`, collect the row indices into a set.
3. If the set has size 1, every letter hit the same row — keep the word (preserving original casing).
4. Return the filtered list.

### Invariants

- **Input words contain only alphabetic characters.** The function does not guard against digits, punctuation, or empty strings — `row_map` only has `a-z`, so a non-alpha character would raise `KeyError`.
- **Case-insensitive matching, case-preserving output.** `w.lower()` is used for lookup, but the original `w` is returned.
- **Order preservation.** Output retains the input order of matched words.

### Error Handling

None. If a word contains a character not in `row_map` (anything outside `a-zA-Z`), the generator expression inside `set(...)` raises an unhandled `KeyError`. This is acceptable because the LeetCode problem guarantees alphabetic-only input.

---

## Topics to Explore

- [file] `keyboard-row/test_solution.py` — See how the external test file imports and exercises `find_words`, and whether it adds cases beyond the inline tests
- [function] `single-row-keyboard/solution.py:calculate_time` — A related keyboard-geometry problem; compare how it models key positions versus row membership
- [general] `set-membership-filtering-pattern` — The `len(set(...)) == 1` idiom appears in several solutions (e.g., `check-if-all-characters-have-equal-number-of-occurrences`); worth recognizing as a recurring technique
- [file] `keyboard-row/review.md` — The code review may document alternative approaches (e.g., using `all()` with a row set instead of the set-cardinality trick)

## Beliefs

- `keyboard-row-row-map-covers-26-letters` — `row_map` maps exactly the 26 lowercase English letters to row indices 0, 1, or 2; no other characters are handled
- `keyboard-row-case-insensitive-match` — `find_words` lowercases each word for row lookup but returns the original-cased word, so matching is case-insensitive and output is case-preserving
- `keyboard-row-no-input-validation` — Non-alphabetic characters in input words cause an unhandled `KeyError` from the `row_map` lookup
- `keyboard-row-single-pass-filtering` — The algorithm is O(n*m) where n is word count and m is max word length — one pass through each word with constant-time dict lookups

