# File: index-pairs-of-a-string/solution.py

**Date:** 2026-06-06
**Time:** 17:05

## `index-pairs-of-a-string/solution.py`

### Purpose

This file solves [LeetCode 1065 — Index Pairs of a String](https://leetcode.com/problems/index-pairs-of-a-string/). Given a string `text` and a list of `words`, it finds every `[i, j]` pair where `text[i..j]` exactly matches some word in the list, returning all such pairs sorted lexicographically (by `i` first, then `j`).

### Key Components

**`Solution.indexPairs(text, words) -> List[List[int]]`** — The core algorithm. For each word, it slides a window of that word's length across `text`, checking for exact substring matches via slice comparison. Matches are collected as `[start, end]` pairs, then sorted before return.

**`has_all_codes_in_range(text, words)`** — A free-function wrapper that delegates to `Solution().indexPairs`. The name is a misnomer (it describes a different LeetCode problem); this is likely an artifact of automated scaffolding across the repo.

### Patterns

**Brute-force multi-pattern search**: The solution uses a nested loop — outer over `words`, inner over every valid starting position in `text`. This is O(W * N * L) where W = number of words, N = length of text, L = average word length. No trie or Aho-Corasick; appropriate for the problem's constraints (all inputs ≤ 100).

**Post-hoc sorting**: Rather than inserting results in order or using a sorted container, results are collected unsorted and `result.sort()` is called once at the end. Since Python's `list.sort()` compares lists element-wise, this produces the required lexicographic ordering by `[i, j]`.

**LeetCode class convention**: The `Solution` class with a single method matches LeetCode's expected submission format. The standalone wrapper function provides a simpler call interface for tests.

### Dependencies

**Imports**: Only `typing.List` — no external libraries.

**Imported by**: The `Imported By` list in the prompt is misleading. Those are test files from *other* problems that happen to share a common test harness import pattern, not actual consumers of `indexPairs`. The real consumer is `index-pairs-of-a-string/test_solution.py`.

### Flow

1. Initialize empty `result` list.
2. For each `word` in `words`, compute its length `wlen`.
3. Slide index `i` from `0` to `len(text) - wlen` (inclusive).
4. If the slice `text[i:i+wlen]` equals `word`, append `[i, i + wlen - 1]` to `result`.
5. Sort `result` (lexicographic on `[i, j]` pairs).
6. Return `result`.

### Invariants

- Every returned pair `[i, j]` satisfies `0 <= i <= j < len(text)`.
- `text[i:j+1]` is guaranteed to be an element of `words` for every pair in the output.
- The output is sorted in ascending order by `i`, with ties broken by `j`.
- Overlapping matches and duplicate words both produce duplicate entries (e.g., if `words = ["a", "a"]`, each occurrence of `"a"` appears twice).

### Error Handling

None. The function trusts its inputs match the LeetCode contract (non-empty `text`, non-empty `words` list with non-empty strings). Invalid inputs like `words = []` produce an empty list naturally; `text = ""` produces an empty list since the inner `range` is empty.

## Topics to Explore

- [file] `index-pairs-of-a-string/test_solution.py` — See what edge cases the test suite covers (overlapping matches, repeated words, single-char matches)
- [file] `index-pairs-of-a-string/review.md` — Check if the review flagged the misnamed wrapper function or discussed trie-based alternatives
- [general] `aho-corasick-vs-brute-force` — For larger inputs, Aho-Corasick would reduce multi-pattern search from O(W*N*L) to O(N + total_word_length + matches), worth understanding the tradeoff
- [function] `index-pairs-of-a-string/solution.py:has_all_codes_in_range` — Investigate whether the misnamed wrapper is a systemic scaffolding issue across the repo

## Beliefs

- `index-pairs-brute-force-complexity` — `indexPairs` runs in O(W * N * L) time where W = len(words), N = len(text), L = max word length, due to nested loops with slice comparison
- `index-pairs-sort-guarantees-order` — The output ordering relies on Python's lexicographic list comparison in `list.sort()`, which sorts by first element then second element
- `index-pairs-wrapper-misnamed` — `has_all_codes_in_range` is incorrectly named; it wraps `indexPairs`, not the "check if all codes in range" problem (LeetCode 1461)
- `index-pairs-duplicate-words-produce-duplicate-results` — If the same word appears twice in `words`, each match position is reported twice in the output

