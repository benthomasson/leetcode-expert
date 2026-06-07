# File: reverse-vowels-of-a-string/solution.py

**Date:** 2026-06-06
**Time:** 18:54

## Purpose

This file implements [LeetCode 345 — Reverse Vowels of a String](https://leetcode.com/problems/reverse-vowels-of-a-string/). It owns a single responsibility: given a string, return a new string where only the vowel characters have their positions reversed, while all non-vowel characters stay in place.

It lives under `reverse-vowels-of-a-string/solution.py` following the repo's convention of one problem per directory with `solution.py`, `test_solution.py`, `plan.md`, and `review.md`.

## Key Components

### `Solution.reverseVowels(self, s: str) -> str`

The only method. Contract:

- **Input**: a string `s` of printable ASCII characters (per LeetCode constraints, `1 <= len(s) <= 3 * 10^5`).
- **Output**: a new string with vowels in reversed order, consonants/other characters unchanged.
- **Side effects**: none — pure function despite being on a class (LeetCode convention).

### `vowels` constant (local)

`set("aeiouAEIOU")` — a set of 10 characters covering both cases. Using a set gives O(1) membership testing instead of O(10) linear scan on a string.

## Patterns

**Two-pointer inward sweep.** `left` starts at 0, `right` at the last index. Both march inward:

- If `left` points to a non-vowel, advance it.
- Else if `right` points to a non-vowel, retreat it.
- Else both point to vowels — swap and move both.

This is the canonical in-place two-pointer pattern for "reverse a subset of elements." It's the same structure used in `reverse-only-letters/solution.py` (swap letters, skip non-letters).

**Mutable list copy.** Python strings are immutable, so the string is converted to `list(s)` for O(1) swaps, then joined back at the end. This avoids O(n^2) string concatenation.

## Dependencies

**Imports**: none — the solution is self-contained with no stdlib or third-party imports.

**Imported by**: `reverse-vowels-of-a-string/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are all test files across the repo that import their *own* `solution.py`, not this one. The actual consumer is only the local test file.

## Flow

1. Build a set of vowel characters (both cases).
2. Convert `s` to a mutable `chars` list.
3. Initialize `left = 0`, `right = len(chars) - 1`.
4. Loop while `left < right`:
   - Skip non-vowels from the left.
   - Skip non-vowels from the right.
   - When both point to vowels, swap them and advance both pointers inward.
5. Join and return.

Each character is visited at most once by each pointer, so the total work is O(n) time, O(n) space (for the list copy).

## Invariants

- **Pointer ordering**: the `while left < right` guard ensures no double-swaps and no out-of-bounds access. When `left >= right`, the string is fully processed.
- **Case preservation**: because the swap moves actual characters (not normalized copies), uppercase/lowercase vowels land in each other's original positions with their case intact.
- **Non-vowel stability**: the `elif`/`else` branching guarantees a pointer only advances past a character when it's confirmed as a non-vowel, or after a swap is performed.

## Error Handling

None. The method assumes valid input per LeetCode constraints. An empty string or single-character string works correctly — the while loop simply never executes, and `"".join(chars)` returns the original string.

## Topics to Explore

- [file] `reverse-only-letters/solution.py` — Uses the identical two-pointer-skip pattern but for letters vs. non-letters; compare the swap predicates
- [file] `reverse-vowels-of-a-string/test_solution.py` — See which edge cases are covered (empty, all vowels, no vowels, mixed case)
- [general] `two-pointer-inward-sweep` — This pattern recurs in `valid-palindrome`, `squares-of-a-sorted-array`, `two-sum` (sorted variant); worth cataloging as a cross-cutting technique
- [file] `remove-vowels-from-a-string/solution.py` — The complement problem (remove vowels entirely); compare the vowel-set usage
- [file] `determine-if-string-halves-are-alike/solution.py` — Another vowel-counting problem; see how the vowel set is defined there

## Beliefs

- `reverse-vowels-two-pointer-time` — `reverseVowels` runs in O(n) time because each pointer advances monotonically and they collectively cover the string once
- `reverse-vowels-case-sensitive-set` — The vowel set includes both uppercase and lowercase variants, so the solution handles mixed-case input without normalization
- `reverse-vowels-non-vowel-stability` — Non-vowel characters are never moved; only characters at positions where both pointers point to vowels are swapped
- `reverse-vowels-no-imports` — The solution has zero imports and depends only on Python builtins (`set`, `list`, `str.join`)

