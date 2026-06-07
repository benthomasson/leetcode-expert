# File: count-common-words-with-one-occurrence/solution.py

**Date:** 2026-06-06
**Time:** 15:55

## `count-common-words-with-one-occurrence/solution.py`

### Purpose

This file solves [LeetCode 2085 — Count Common Words With One Occurrence](https://leetcode.com/problems/count-common-words-with-one-occurrence/). It owns a single responsibility: given two string arrays, count how many strings appear exactly once in **both** arrays. It follows the repo's convention of one `Solution` class per problem directory.

### Key Components

**`Solution.countWords(words1, words2) -> int`** — The sole method. Takes two lists of strings and returns the count of words that have frequency 1 in `words1` AND frequency 1 in `words2`.

### Patterns

- **Counter-based frequency analysis**: Instead of nested loops or set intersection, the solution builds two frequency maps up front and then does a single-pass filter. This is the idiomatic Python approach for frequency problems.
- **Generator expression with `sum`**: `sum(1 for w in c1 if ...)` avoids materializing an intermediate list — it counts matches lazily.
- **Implicit `Counter` default**: `c2[w]` returns `0` for missing keys (a `Counter` inherits from `dict` but defaults missing keys to `0`). This means the check `c2[w] == 1` correctly rejects words that appear in `words1` but not in `words2` — they get count `0`, which isn't `1`.

### Dependencies

- **Imports**: `collections.Counter` — the only dependency.
- **Imported by**: The test file `count-common-words-with-one-occurrence/test_solution.py` imports this `Solution` class. The massive "Imported By" list in the prompt is noise — those are unrelated test files that import `Counter` from `collections`, not from this module.

### Flow

1. Build `c1`: frequency map of all words in `words1`.
2. Build `c2`: frequency map of all words in `words2`.
3. Iterate over keys in `c1`. For each word `w`, check if `c1[w] == 1` (unique in first array) and `c2[w] == 1` (unique in second array).
4. Sum the matches and return.

Time complexity: O(n + m) where n = len(words1), m = len(words2). Space: O(n + m) for the two counters.

### Invariants

- Only iterates over `c1`'s keys — words exclusive to `words2` are never candidates. This is correct because a common word must appear in both arrays.
- The `== 1` check on both counters enforces "exactly once in each", not "at least once in each".

### Error Handling

None. The method trusts its inputs match the LeetCode contract (non-empty lists of lowercase strings). No validation, no try/except — appropriate for a competitive-programming solution.

## Topics to Explore

- [file] `count-common-words-with-one-occurrence/test_solution.py` — See how edge cases (empty overlap, all duplicates, identical arrays) are tested
- [file] `uncommon-words-from-two-sentences/solution.py` — Similar frequency-counting pattern but for words unique to one sentence
- [function] `count-common-words-with-one-occurrence/solution.py:countWords` — Try replacing the generator with set intersection: `len({w for w in c1 if c1[w]==1} & {w for w in c2 if c2[w]==1})` and compare readability
- [general] `counter-default-behavior` — Understanding why `Counter.__missing__` returns `0` is critical to seeing why this code handles absent keys without explicit membership checks

## Beliefs

- `counter-missing-key-returns-zero` — `c2[w]` returns `0` when `w` is not in `words2`, so the `== 1` check implicitly rejects words absent from the other array
- `iterates-only-c1-keys` — The solution only iterates `c1`'s keys; words exclusive to `words2` are never examined, which is correct since they can't be common
- `linear-time-complexity` — Total work is O(n + m) — two counter constructions plus one pass over `c1`'s unique keys
- `no-input-validation` — The method assumes valid LeetCode-contract inputs and performs no defensive checks

