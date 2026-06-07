# File: find-the-index-of-the-first-occurrence-in-a-string/solution.py

**Date:** 2026-06-06
**Time:** 16:46

## Purpose

This file solves [LeetCode 28 — Find the Index of the First Occurrence in a String](https://leetcode.com/problems/find-the-index-of-the-first-occurrence-in-a-string/). It implements substring search: given `haystack` and `needle`, return the index where `needle` first appears, or `-1` if absent.

It uses the **KMP (Knuth-Morris-Pratt) algorithm** rather than Python's built-in `str.find()` or `str.index()`, making the algorithmic intent explicit.

## Key Components

### `Solution.strStr(haystack, needle) -> int`

The single method. Two phases:

**Phase 1 — Build the LPS (Longest Proper Prefix which is also Suffix) array** (lines 12–21):

- `lps[i]` stores the length of the longest proper prefix of `needle[0..i]` that is also a suffix.
- Uses two pointers: `i` scans the pattern, `length` tracks the current matching prefix length.
- When characters match, extend the prefix. When they don't and `length > 0`, fall back to `lps[length - 1]` — this is the key insight that avoids restarting from scratch.

**Phase 2 — Search haystack using the LPS table** (lines 24–33):

- Two pointers: `i` into `haystack`, `j` into `needle`.
- On match, advance both. When `j == m`, the full needle has been found — return `i - j`.
- On mismatch with `j > 0`, fall back `j` to `lps[j - 1]` instead of resetting to 0.
- On mismatch with `j == 0`, just advance `i`.

## Patterns

- **KMP pattern matching**: O(n + m) time, O(m) space. Avoids the O(n*m) worst case of naive substring search (e.g., searching `"aaaaab"` in `"aaaaaaaaab"`).
- **LeetCode class convention**: single `Solution` class with a method matching the problem's signature.
- **No imports**: pure algorithmic implementation with no external dependencies.

## Dependencies

**Imports**: None.

**Imported by**: The `test_solution.py` in the same directory, plus the "Imported By" list in the prompt shows hundreds of other test files — this is an artifact of the test harness importing all solutions uniformly, not a real dependency relationship. Only `find-the-index-of-the-first-occurrence-in-a-string/test_solution.py` exercises this code meaningfully.

## Flow

```
strStr("hello", "ll")
  1. Build LPS for "ll" → [0, 1]
  2. Search:
     i=0, j=0: 'h' vs 'l' → mismatch, j=0, advance i
     i=1, j=0: 'e' vs 'l' → mismatch, j=0, advance i
     i=2, j=0: 'l' vs 'l' → match, i=3, j=1
     i=3, j=1: 'l' vs 'l' → match, i=4, j=2, j==m → return 4-2=2
```

## Invariants

- **LPS values are bounded**: `0 <= lps[i] < i+1` for all `i`. Each entry is strictly less than the index + 1 (proper prefix, not the whole string).
- **Search progress guarantee**: every iteration of the search loop either advances `i` or decreases `j`. Since `j` can only decrease a finite number of times before `i` must advance, the algorithm terminates in O(n + m) steps.
- **First occurrence**: returns immediately on the first full match (`j == m`), guaranteeing the leftmost index.
- **Empty needle is not special-cased**: if `needle` is empty (`m = 0`), the LPS loop doesn't execute, the search loop immediately hits `j == m` (both are 0), and returns `0 - 0 = 0`. This matches LeetCode's expected behavior.

## Error Handling

None. The method always returns an `int` — either a valid index or `-1`. No exceptions are raised. Input validation is deferred to LeetCode's constraints (both inputs are guaranteed to be lowercase English strings with `1 <= needle.length <= haystack.length <= 10^4`, though the code handles empty needle correctly anyway).

## Topics to Explore

- [file] `find-the-index-of-the-first-occurrence-in-a-string/test_solution.py` — See what edge cases are tested (empty strings, full-string matches, no-match, single-char)
- [file] `find-the-index-of-the-first-occurrence-in-a-string/plan.md` — Check whether KMP was a deliberate choice over alternatives like Rabin-Karp or Python builtins
- [general] `kmp-failure-function-fallback` — The `length = lps[length - 1]` fallback on mismatch is the subtlest part of KMP; trace through a pattern like `"AAACAAAA"` to see cascading fallbacks
- [function] `find-the-index-of-the-first-occurrence-in-a-string/solution.py:strStr` — Test with adversarial input like `haystack="aaaaaa"`, `needle="aab"` to see how KMP avoids O(n*m) backtracking
- [file] `repeated-substring-pattern/solution.py` — Another problem where KMP's LPS array is often used (checking if a string is a repeated pattern)

## Beliefs

- `kmp-time-complexity` — `strStr` runs in O(n + m) time where n = len(haystack) and m = len(needle), with no backtracking on haystack
- `kmp-space-complexity` — The only auxiliary allocation is the `lps` array of size m, making space complexity O(m)
- `first-match-semantics` — The search returns immediately on the first complete match, guaranteeing the leftmost occurrence index
- `empty-needle-returns-zero` — When `needle` is empty, the method returns 0 without special-case code, as a consequence of the `j == m` check when both are 0

