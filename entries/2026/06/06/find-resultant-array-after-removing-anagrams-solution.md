# File: find-resultant-array-after-removing-anagrams/solution.py

**Date:** 2026-06-06
**Time:** 16:41

## Purpose

This file implements [LeetCode 2273: Find Resultant Array After Removing Anagrams](https://leetcode.com/problems/find-resultant-array-after-removing-anagrams/). It's one of hundreds of standalone solution modules in the `leetcode-implementations` repo, each owning a single problem's algorithm. Its sole responsibility is exporting `anagramOperations`, which filters consecutive anagrams from a word list.

## Key Components

### `anagramOperations(words: list[str]) -> list[str]`

The only public function. Contract:

- **Input**: A non-empty list of lowercase English strings.
- **Output**: A new list where consecutive anagram duplicates have been collapsed, keeping the *first* occurrence in each consecutive run.
- **Pure function** — no mutation of the input list.

## Patterns

**Stack-style accumulation**: The `result` list acts as a stack where each new word is compared against the top (`result[-1]`). This is a common LeetCode idiom for problems that require comparing each element to the most recently accepted one — similar to monotonic stack problems, but here the predicate is "is an anagram of."

**Sorted-character canonicalization**: Two strings are anagrams iff their sorted character sequences are equal. `sorted(word)` produces a canonical form for comparison. This avoids building a `Counter` or frequency array, trading a bit of performance (O(k log k) per word of length k) for brevity.

## Dependencies

**Imports**: None — the solution uses only builtins (`sorted`, `list`).

**Imported by**: The `test_solution.py` in the same directory imports `anagramOperations` for testing. The massive "Imported By" list in the prompt is misleading — those are other problem directories' test files, not actual importers of this module. They likely share a common test harness pattern, not a direct dependency on this function.

## Flow

1. Seed `result` with `words[0]` — the first word is always kept.
2. Iterate over `words[1:]`.
3. For each word, sort its characters and compare against the sorted characters of `result[-1]` (the last accepted word).
4. If they differ (not anagrams), append the word to `result`.
5. If they match (anagrams), skip — the word is silently dropped.
6. Return `result`.

The comparison is always against the last *accepted* word, not the last *seen* word. This means if `words = ["a", "a", "b", "a"]`, the second `"a"` is dropped (anagram of `result[-1]` = `"a"`), `"b"` is kept, and the final `"a"` is kept too (not an anagram of `"b"`).

## Invariants

- **Non-empty input assumed**: `words[0]` is accessed unconditionally. An empty list would raise `IndexError`.
- **Consecutive-only dedup**: Non-adjacent anagrams are preserved. `["ab", "cd", "ba"]` returns `["ab", "cd", "ba"]` — the `"ba"` survives because `"cd"` separates it from `"ab"`.
- **Stability**: The first word in each consecutive anagram group is the one retained — order is preserved.

## Error Handling

None. The function trusts its caller to provide a non-empty list of strings per the LeetCode problem constraints. An empty input crashes with an `IndexError` on `words[0]`.

---

## Topics to Explore

- [file] `find-resultant-array-after-removing-anagrams/test_solution.py` — See which edge cases the test suite covers (empty input, single element, all anagrams, no anagrams)
- [file] `find-resultant-array-after-removing-anagrams/review.md` — Check if the review flags the missing empty-list guard or discusses Counter vs sorted tradeoffs
- [function] `find-common-characters/solution.py:commonChars` — Another solution using sorted-character or Counter-based anagram detection for comparison
- [general] `consecutive-dedup-pattern` — How other solutions in this repo handle consecutive-element filtering (e.g., `delete-characters-to-make-fancy-string`, `remove-all-adjacent-duplicates-in-string`)

## Beliefs

- `anagram-operations-crashes-on-empty` — `anagramOperations([])` raises `IndexError` because `words[0]` is accessed without a length check
- `anagram-check-uses-sorted-canonical-form` — Two words are compared as anagrams via `sorted(word) == sorted(other)`, not via frequency counting
- `dedup-is-consecutive-only` — Non-adjacent anagram pairs are preserved; only consecutive anagram runs are collapsed to their first element
- `comparison-target-is-last-accepted` — Each word is compared against `result[-1]` (last kept word), not the previous word in the input, which matters when consecutive anagrams are dropped

