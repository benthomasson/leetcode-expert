# File: maximum-repeating-substring/solution.py

**Date:** 2026-06-06
**Time:** 17:43

## `maximum-repeating-substring/solution.py`

### Purpose

This file implements LeetCode problem **1668 — Maximum Repeating Substring**. It provides a single function that determines the highest value of `k` such that `word` repeated `k` times is a substring of `sequence`. It's one of ~500+ solution files in the `leetcode-implementations` repo, each owning exactly one problem's solution.

### Key Components

**`longestAwesomeSubstring(sequence, word) -> int`** — The sole public function. Despite the misleading name (it has nothing to do with "awesome substrings"), it solves the maximum repeating substring problem.

- **Contract**: Given a string `sequence` and a string `word`, returns the largest integer `k >= 0` such that `word * k` (i.e., `word` concatenated `k` times) appears as a contiguous substring in `sequence`. Returns `0` if `word` itself doesn't appear in `sequence`.

### Patterns

**Linear search from below**: The algorithm starts at `k = 0` and increments, checking `word * (k+1) in sequence` at each step. This is a brute-force approach that leverages Python's built-in `in` operator for substring matching. The loop terminates at the first `k` where the next repetition isn't found, which is correct because if `word * n` isn't a substring, neither is `word * (n+1)`.

**Python string multiplication idiom**: `word * (k + 1)` constructs the repeated string. This is idiomatic Python and avoids manual concatenation.

### Dependencies

**Imports**: None — the solution is self-contained with no external dependencies.

**Imported by**: The `test_solution.py` files listed in the "Imported By" section are clearly an artifact of the repo's test infrastructure — those hundreds of test files don't actually import *this* solution. Only `maximum-repeating-substring/test_solution.py` meaningfully imports this function. The rest appear to be a bug in the dependency analysis tooling (likely every test file imports a common harness that transitively references all solutions, or the import graph was generated incorrectly).

### Flow

1. Initialize `k = 0`.
2. Build the candidate string `word * (k + 1)`.
3. Check if that candidate exists in `sequence` using Python's `in` operator (which uses a variant of Boyer-Moore/Horspool under the hood in CPython).
4. If found, increment `k` and repeat.
5. If not found, return `k` — the last successful repetition count.

### Invariants

- **Monotonic termination**: The candidate string grows by `len(word)` characters each iteration. Since `sequence` is finite, the loop must terminate — the candidate will eventually exceed `len(sequence)`.
- **No-gap property**: The function finds the *maximum* `k` because it starts from 0 and counts up. There are no gaps — if `word * 3` is a substring, then `word * 2` and `word * 1` are also substrings (they're prefixes of `word * 3`).

### Error Handling

None. The function assumes valid string inputs per the LeetCode contract. Empty `word` would cause an infinite loop since `"" in sequence` is always `True` — but the problem constraints guarantee `1 <= len(word)`.

### Naming Issue

The function is named `longestAwesomeSubstring`, which is the name for a different LeetCode problem (1542 — Find Longest Awesome Substring). The correct name for problem 1668 would be something like `maxRepeating`. This is likely a copy-paste error from the code generation pipeline.

### Complexity

- **Time**: O(k_max * n) where `n = len(sequence)` and `k_max` is the answer. Each `in` check is O(n) and the candidate grows linearly, so more precisely O(k_max^2 * len(word) + k_max * n). In practice `k_max` is small given the problem constraints (sequence length up to 100).
- **Space**: O(k_max * len(word)) for the constructed candidate string.

## Topics to Explore

- [file] `maximum-repeating-substring/test_solution.py` — See what edge cases are tested (empty results, single-char words, overlapping patterns)
- [file] `maximum-repeating-substring/review.md` — Check if the naming issue was flagged during review
- [function] `detect-pattern-of-length-m-repeated-k-or-more-times/solution.py` — Related problem involving repeated patterns; compare approaches
- [general] `function-naming-conventions` — Audit whether other solutions have mismatched function names from the generation pipeline
- [file] `maximum-repeating-substring/plan.md` — Understand whether alternative approaches (binary search on k, KMP) were considered

## Beliefs

- `max-repeating-uses-linear-scan` — The solution finds maximum k by incrementing from 0 and checking `word * (k+1) in sequence`, not by binary search or string algorithm
- `max-repeating-wrong-function-name` — The function is named `longestAwesomeSubstring` but solves LeetCode 1668 (Maximum Repeating Substring), not 1542 (Longest Awesome Substring)
- `max-repeating-no-empty-word-guard` — The function has no guard against empty `word` input, which would cause an infinite loop; it relies on LeetCode's constraint that `len(word) >= 1`
- `max-repeating-no-imports` — The solution has zero imports and depends only on Python builtins (`str.__mul__`, `str.__contains__`)

