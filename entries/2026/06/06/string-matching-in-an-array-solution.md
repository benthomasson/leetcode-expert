# File: string-matching-in-an-array/solution.py

**Date:** 2026-06-06
**Time:** 19:16

## Purpose

This file solves [LeetCode 1408 — String Matching in an Array](https://leetcode.com/problems/string-matching-in-an-array/). It finds all strings in a given list that appear as a substring of at least one other string in the same list. It's an Easy-tier problem housed under the standard project layout: one `Solution` class per problem directory.

## Key Components

**`Solution.stringMatching(words: List[str]) -> List[str]`** — The single entry point. Takes a list of unique lowercase strings and returns those that are substrings of any *other* word in the list.

The contract is straightforward: given `["mass", "as", "hero", "superhero"]`, it returns `["as", "mass"]` because `"as"` appears in `"mass"` and `"mass"` appears in... wait — actually `"mass"` doesn't appear in any other word there. Let me re-read: `"as"` is in `"mass"`, and `"hero"` is in `"superhero"`. So it'd return `["as", "hero"]`.

## Patterns

**Brute-force pairwise comparison.** The solution checks every word against every other word using Python's `in` operator for substring membership. The `break` on line 15 is the key optimization: once a word is confirmed as a substring of *any* other word, it stops checking further and moves to the next candidate. This prevents duplicates in the result without needing a set.

**LeetCode class convention.** The bare `Solution` class with a single method matches LeetCode's expected interface exactly.

## Dependencies

- **Imports:** `List` from `typing` — used only for the type annotation. In Python 3.9+ this could be `list[str]` directly, but `typing.List` keeps compatibility.
- **Imported by:** `string-matching-in-an-array/test_solution.py` (the "Imported By" list in the prompt is the full cross-repo test suite that happens to share the same `Solution` import pattern — not actual importers of *this* file).

## Flow

1. Initialize an empty `result` list.
2. Outer loop: iterate over each `(i, word)` pair.
3. Inner loop: iterate over each `(j, other)` pair.
4. Skip self-comparison (`i != j`).
5. Check `word in other` — Python's built-in substring test (uses a variant of Boyer-Moore/Horspool under the hood in CPython).
6. On first match, append `word` to `result` and `break` the inner loop.
7. Return the accumulated list.

**Complexity:** O(n^2 * m) where n is the number of words and m is the average word length (cost of `in`). This is fine for the problem's constraints (n <= 100, word length <= 30).

## Invariants

- **No duplicates in output.** The `break` after the first match ensures each word appears at most once in `result`, even if it's a substring of multiple other words.
- **Self-comparison excluded.** The `i != j` guard prevents a word from matching itself (every string is trivially a substring of itself).
- **Order preserved.** Results appear in the same order as the input list, since the outer loop iterates in input order.

## Error Handling

None. The function assumes valid input per LeetCode constraints (non-empty list of unique lowercase strings). No edge-case guards for empty lists, though an empty `words` list would correctly return `[]` since neither loop body executes.

## Topics to Explore

- [file] `string-matching-in-an-array/test_solution.py` — See what edge cases the test suite covers (empty matches, all-substring inputs, single-element lists)
- [file] `string-matching-in-an-array/review.md` — Check if the review identified the O(n^2 * m) complexity or suggested alternatives like sorting by length
- [general] `aho-corasick-multi-pattern` — For large inputs, Aho-Corasick could check all words simultaneously in O(total_length), though it's overkill here
- [function] `find-the-index-of-the-first-occurrence-in-a-string/solution.py:strStr` — Related substring-search problem that may use explicit algorithms instead of Python's `in`

## Beliefs

- `string-matching-no-duplicates` — The `break` after first match guarantees each word appears at most once in the output without using a set
- `string-matching-brute-force-quadratic` — The algorithm is O(n^2 * m) pairwise comparison, acceptable given LeetCode constraints of n <= 100
- `string-matching-preserves-input-order` — Results are returned in the same relative order as the input `words` list
- `string-matching-self-exclusion` — The `i != j` check is the sole mechanism preventing a word from being reported as its own substring

