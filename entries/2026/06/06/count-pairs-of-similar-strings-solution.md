# File: count-pairs-of-similar-strings/solution.py

**Date:** 2026-06-06
**Time:** 16:02

## Purpose

This file solves [LeetCode 2506: Count Pairs of Similar Strings](https://leetcode.com/problems/count-pairs-of-similar-strings/). Two strings are "similar" if they contain exactly the same set of distinct characters (ignoring frequency). The function counts all such pairs `(i, j)` where `i < j`.

## Key Components

### `count_similar_pairs(words: list[str]) -> int`

The sole public function. Takes a list of lowercase strings, returns the count of pairs sharing the same character set.

**Contract:** Input is a list of lowercase English strings. Output is a non-negative integer. No mutation of the input.

## Patterns

**Counting-based combinatorics.** Instead of comparing every pair (O(n^2) comparisons), the solution groups words by their character fingerprint using `Counter(frozenset(w) for w in words)`. Each group of size `n` contributes `n*(n-1)//2` pairs — the standard "n choose 2" formula.

**`frozenset` as a hashable signature.** Converting each word to `frozenset` collapses character frequency down to character presence, which is exactly the "similar" predicate. `frozenset` is hashable (unlike `set`), so it works as a `Counter` key.

## Dependencies

**Imports:** `collections.Counter` — used to tally how many words share each character set.

**Imported by:** The `"Imported By"` list in the prompt is misleading — those are test files across the entire repo that import `Counter` from `collections`, not files that import this module. The actual consumer is `count-pairs-of-similar-strings/test_solution.py`.

## Flow

1. For each word `w`, compute `frozenset(w)` — the set of distinct characters.
2. `Counter` tallies how many words map to each distinct frozenset.
3. For each group of size `n`, accumulate `n*(n-1)//2` (the number of unordered pairs within that group).
4. Return the sum.

**Time complexity:** O(n * k) where n is the number of words and k is average word length (for building frozensets). The final summation is O(u) where u is the number of unique character sets — at most min(n, 2^26).

**Space complexity:** O(u) for the Counter.

## Invariants

- The pairing formula `n*(n-1)//2` is always a non-negative integer for `n >= 1`, so the result is always >= 0.
- `frozenset` guarantees that `"abc"` and `"cba"` and `"aabbc"` all hash identically — frequency and order are irrelevant.

## Error Handling

None. The function trusts its caller to provide valid input (list of strings). An empty list returns 0 naturally since `Counter` produces no entries and `sum` of an empty generator is 0.

## Topics to Explore

- [file] `count-pairs-of-similar-strings/test_solution.py` — See what edge cases are covered (empty list, single word, all-identical words)
- [function] `number-of-good-pairs/solution.py:count_similar_pairs` — Another "count pairs" problem likely using the same n-choose-2 pattern; compare approaches
- [general] `frozenset-as-hash-key` — This pattern recurs across solutions that need set-equality grouping (e.g., anagram detection uses sorted tuples; this uses frozensets)
- [file] `count-pairs-of-similar-strings/plan.md` — The planning document may reveal alternative approaches considered (e.g., bitmask instead of frozenset)

## Beliefs

- `similar-pairs-uses-grouping-not-brute-force` — The solution avoids O(n^2) pairwise comparison by grouping words with identical character sets and applying the combinatorial formula.
- `frozenset-captures-similarity-predicate` — Two words are "similar" iff `frozenset(a) == frozenset(b)`; the solution relies on this equivalence being exact.
- `empty-input-returns-zero` — An empty `words` list produces 0 with no special-case check, via `sum` over an empty generator.
- `n-choose-2-integer-division-is-exact` — `n*(n-1)//2` is always exact (no remainder) because one of `n` or `n-1` is even.

