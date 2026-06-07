# File: find-words-that-can-be-formed-by-characters/solution.py

**Date:** 2026-06-06
**Time:** 16:49

## `find-words-that-can-be-formed-by-characters/solution.py`

### Purpose

Solves [LeetCode 1160 — Find Words That Can Be Formed by Characters](https://leetcode.com/problems/find-words-that-can-be-formed-by-characters/). Given a list of words and a string of available characters, it returns the total length of all words that can be spelled using the available characters, where each character can be used at most once per word.

### Key Components

**`Solution.countCharacters(words, chars) -> int`** — The single method. It takes a list of candidate words and a character pool, and returns the sum of lengths of all "good" words (words whose character requirements are a subset of the pool).

### Patterns

The solution uses **Counter subtraction** as a set-containment check. `Counter(word) - chars_count` produces a Counter with only the positive remainders — characters needed by the word but not available in `chars`. If that result is empty (falsy), the word can be formed. This is a well-known Python idiom: Counter subtraction drops zero and negative counts, so `not (A - B)` is equivalent to "A is a sub-multiset of B."

The entire computation is a single generator expression inside `sum()`, which avoids intermediate list allocation.

### Dependencies

**Imports:** `collections.Counter` for frequency counting, `typing.List` for type hints.

**Imported by:** The test file at `find-words-that-can-be-formed-by-characters/test_solution.py`. The large "Imported By" list in the prompt is an artifact of the repo's shared test infrastructure — those other test files don't actually import this solution.

### Flow

1. Build a `Counter` from `chars` once (O(len(chars))).
2. For each word, build a `Counter` from the word, subtract the chars Counter, and check if the result is empty.
3. If empty (the word is formable), contribute `len(word)` to the running sum.

Total complexity: O(n * k) where n is the number of words and k is the average word length. The chars Counter is built once and reused.

### Invariants

- Each character in `chars` is available at most once **per word** — the chars pool resets between words (it's not consumed).
- Counter subtraction drops non-positive values, so the emptiness check correctly handles characters that appear in `chars` but not in the word.

### Error Handling

None. The method trusts its inputs match the LeetCode contract (non-empty strings, lowercase English letters). No validation, no exceptions — appropriate for a competitive programming solution.

## Topics to Explore

- [file] `find-words-that-can-be-formed-by-characters/test_solution.py` — See what edge cases are covered (empty words, duplicate characters, exact match)
- [function] `find-common-characters/solution.py:commonChars` — Another Counter-intersection problem; compare the multiset techniques
- [file] `rearrange-characters-to-make-target-string/solution.py` — Similar "can we form X from Y" problem using character counting
- [general] `counter-subtraction-idiom` — Python's Counter arithmetic (subtraction, intersection, union) and when each applies
- [file] `ransom-note/solution.py` — Same sub-multiset containment check in a different problem context

## Beliefs

- `counter-subtraction-emptiness-is-subset-check` — `not (Counter(word) - chars_count)` is true if and only if every character in `word` appears in `chars` with sufficient multiplicity
- `chars-pool-not-consumed-across-words` — The `chars_count` Counter is computed once and shared read-only across all word checks; each word is evaluated independently against the full pool
- `solution-is-single-pass-over-words` — The method iterates the words list exactly once with a generator expression; no sorting, grouping, or multi-pass logic
- `no-input-validation` — The method assumes all inputs conform to LeetCode constraints and performs no defensive checks

