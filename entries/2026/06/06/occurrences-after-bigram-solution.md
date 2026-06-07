# File: occurrences-after-bigram/solution.py

**Date:** 2026-06-06
**Time:** 18:25

## Purpose

This file is the solution and test suite for [LeetCode 1078: Occurrences After Bigram](https://leetcode.com/problems/occurrences-after-bigram/). It finds all words in a text that immediately follow a given two-word sequence (bigram). In the project, it follows the standard pattern: one `Solution` class with the algorithm, one `unittest.TestCase` class with coverage, both in the same file.

## Key Components

### `Solution.findOcurrences(text, first, second) -> List[str]`

The single method on the class. Takes a space-separated string and two words forming a bigram, returns every word that appears directly after an occurrence of that bigram.

The core logic is a list comprehension over valid indices `i` in `range(len(words) - 2)`. The `- 2` bound ensures `words[i + 2]` never goes out of bounds. For each `i`, it checks whether `words[i]` and `words[i + 1]` match `first` and `second`, and if so, collects `words[i + 2]`.

### `TestFindOcurrences`

Seven test cases covering:
- Standard matches (multiple bigram hits)
- No matches at all
- Bigram at the end of the string (no third word to collect)
- Overlapping bigrams (`"a a a a"` with bigram `("a", "a")`)
- Single-word input (impossible to form a bigram)
- `first == second` with interleaved matches

## Patterns

- **Single-file solution+test**: Consistent with every other problem directory in this repo — `solution.py` contains both production code and tests, runnable via `python -m unittest` or `python solution.py`.
- **List comprehension with index bounds**: Rather than zipping or using `enumerate` with lookahead, it indexes directly with a carefully bounded `range`. This is a common LeetCode idiom for fixed-window problems.
- **No sentinel or padding**: The `- 2` in the range bound is the entire boundary-safety mechanism. No try/except, no default values.

## Dependencies

**Imports**: `typing.List` (type annotation), `unittest` (test framework). No project-internal imports.

**Imported by**: The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that happen to share the same `import unittest` / `from typing import List` pattern. Nothing actually imports *this* module's `Solution` class.

## Flow

1. `text.split()` tokenizes on whitespace into a list of words.
2. The list comprehension iterates `i` from `0` to `len(words) - 3` (inclusive).
3. At each position, it checks whether the pair `(words[i], words[i+1])` matches `(first, second)`.
4. On match, `words[i+2]` is appended to the result.
5. Overlapping is handled naturally — if `words[i+2]` itself starts a new bigram match at position `i+1`, that's checked independently on the next iteration.

**Time**: O(n) where n is the number of words. **Space**: O(n) for `split()` and the result list.

## Invariants

- The index `i + 2` is always valid when accessed, guaranteed by `range(len(words) - 2)`.
- When `len(words) < 3`, the range is empty, so the result is `[]` — no special case needed.
- Comparisons are exact string equality (case-sensitive), matching the problem's constraint that all words are lowercase.

## Error Handling

None. The method assumes valid input per the LeetCode contract: `text` is a non-empty string of lowercase words separated by single spaces, and `first`/`second` are non-empty lowercase words. If `text` is empty, `split()` returns `[]`, the range is `range(-2)` which is empty, and the result is `[]` — it degrades gracefully without explicit handling.

## Topics to Explore

- [file] `occurrences-after-bigram/test_solution.py` — Likely a duplicate or extended test file; worth checking if it adds coverage beyond what's inline
- [file] `occurrences-after-bigram/review.md` — The code review notes for this solution, may flag alternative approaches or edge cases
- [general] `sliding-window-vs-index-bound` — Compare this direct-indexing approach with sliding window solutions used in problems like `diet-plan-performance` or `maximum-average-subarray-i`
- [function] `most-common-word/solution.py:Solution` — Another string-splitting + word-matching problem; compare tokenization strategies

## Beliefs

- `bigram-no-oob` — `findOcurrences` can never raise an `IndexError` because the range bound `len(words) - 2` prevents access beyond list length.
- `bigram-overlap-allowed` — Overlapping bigram matches are collected independently; a word can serve as `second` in one match and `first` in the next.
- `bigram-linear-time` — The algorithm performs exactly one pass over the word list with O(1) work per position, making it O(n) overall.
- `bigram-empty-safe` — Inputs with fewer than 3 words always produce an empty list without special-case code, due to `range(negative)` being empty.

