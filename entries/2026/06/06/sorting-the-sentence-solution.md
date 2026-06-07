# File: sorting-the-sentence/solution.py

**Date:** 2026-06-06
**Time:** 19:13

## `sorting-the-sentence/solution.py`

### Purpose

This file solves [LeetCode 1859 — Sorting the Sentence](https://leetcode.com/problems/sorting-the-sentence/). It takes a "shuffled sentence" — where each word has its original 1-indexed position appended as a trailing digit — and reconstructs the original sentence by placing each word at its correct position.

For example: `"is2 sentence4 This1 a3"` → `"This is a sentence"`.

### Key Components

**`Solution.sort_sentence(self, s: str) -> str`** — The single public method. Contract:

- **Input**: A string `s` where each space-delimited token ends with a digit `1`–`9` indicating its position. Words are guaranteed to be at most 9 (per problem constraints), so a single trailing character always encodes the position.
- **Output**: The reconstructed sentence with words in order, joined by single spaces.

### Flow

1. **Split** the input on whitespace into tokens (e.g., `["is2", "sentence4", "This1", "a3"]`).
2. **Allocate** a result array sized to the number of tokens.
3. **Place** each token: extract the last character as the 1-indexed position, strip it off, and write the word into `result[pos - 1]`.
4. **Join** and return the result array with spaces.

The approach is a single-pass scatter: iterate the shuffled words once and directly place each one. This avoids sorting entirely — it's O(n) in both time and space (where n is the number of words).

### Patterns

- **Positional scatter** rather than sort: pre-allocates the output array and writes each element to its final index in one pass. This is the idiomatic approach when positions are known upfront and bounded by the input size.
- **In-place digit extraction**: `word[-1]` grabs the position, `word[:-1]` strips it. Works because the problem guarantees exactly one trailing digit per word.

### Dependencies

- **Imports**: None — pure Python, no standard library usage.
- **Imported by**: `sorting-the-sentence/test_solution.py` and (per the provided list) hundreds of other test files across the repo. That "imported by" list is misleading — it likely reflects a shared test harness or conftest pattern, not actual usage of `sort_sentence` from other problem directories.

### Invariants

- The last character of every word in the input **must** be a digit `1`–`9`. If it isn't, `int(word[-1])` will raise `ValueError`.
- Positions are **1-indexed** and **unique**. Duplicate positions would silently overwrite earlier placements. Missing positions would leave empty strings `""` in the output.
- Word count is at most 9 (per problem constraints), so a single digit always suffices.

### Error Handling

None. The code trusts the caller to provide valid input per the LeetCode contract. Invalid trailing characters, out-of-range positions, or duplicate positions produce silent wrong answers or exceptions — appropriate for a competitive programming context where inputs are guaranteed well-formed.

## Topics to Explore

- [file] `sorting-the-sentence/test_solution.py` — See what edge cases the tests cover (single word, max words, etc.)
- [file] `sorting-the-sentence/review.md` — Check the code review for any noted limitations or alternative approaches
- [function] `shuffle-string/solution.py:Solution.restoreString` — Same positional-scatter pattern applied to characters instead of words
- [general] `positional-scatter-vs-sort` — When direct placement (O(n)) beats comparison sort (O(n log n)) in LeetCode problems
- [file] `decode-the-message/solution.py` — Another string-reconstruction problem using a mapping approach

## Beliefs

- `sort-sentence-single-digit-position` — `sort_sentence` only supports positions 1–9 because it reads exactly one trailing character; inputs with 10+ words would misparse the position.
- `sort-sentence-linear-time` — The algorithm runs in O(n) time and space (n = number of words), avoiding any comparison sort.
- `sort-sentence-no-validation` — No input validation is performed; non-digit trailing characters raise `ValueError`, and duplicate positions silently overwrite.
- `sort-sentence-1-indexed-input` — The trailing digit is 1-indexed per the LeetCode problem spec; the code converts to 0-indexed with `int(word[-1]) - 1`.

