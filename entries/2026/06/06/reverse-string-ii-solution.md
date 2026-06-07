# File: reverse-string-ii/solution.py

**Date:** 2026-06-06
**Time:** 18:54

## `reverse-string-ii/solution.py`

### Purpose

This file implements [LeetCode 541: Reverse String II](https://leetcode.com/problems/reverse-string-ii/). It owns exactly one responsibility: given a string `s` and an integer `k`, reverse the first `k` characters in every `2k`-character window, leaving the remainder of each window untouched. If fewer than `k` characters remain in the final window, all of them are reversed.

### Key Components

**`Solution.reverseStr(self, s: str, k: int) -> str`** — The sole method. Contract:
- **Input**: `s` (lowercase English letters), `k` (positive integer window size).
- **Output**: A new string with the specified reversal pattern applied.
- **Side effects**: None. Pure function.

### Patterns

**Convert-mutate-join**: The string is converted to a mutable `list` of characters, modified in place via slice assignment, then joined back. This is the standard Python idiom for in-place string manipulation since Python strings are immutable.

**Stride-based iteration**: `range(0, len(chars), 2 * k)` steps through the string in `2k` chunks. Only the first `k` characters of each chunk are reversed — the second half is implicitly left alone because the slice assignment only touches `chars[i:i+k]`.

**Slice self-reversal**: `chars[i:i+k][::-1]` creates a reversed copy of the slice and assigns it back. Python's slice bounds are clamped to the sequence length, so when fewer than `k` characters remain, the slice naturally covers only what's left — no explicit bounds check needed.

### Dependencies

**Imports**: None — pure stdlib Python.

**Imported by**: `reverse-string-ii/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those 400+ test files share a common test harness pattern that imports a `Solution` class from their own local `solution.py`, not from this file.

### Flow

1. `list(s)` — O(n) conversion to mutable char array.
2. `for i in range(0, len(chars), 2 * k)` — iterate at positions 0, 2k, 4k, ...
3. `chars[i:i+k] = chars[i:i+k][::-1]` — reverse the first k characters of the current window in place.
4. `"".join(chars)` — O(n) recombination into a string.

Total time complexity: O(n). Each character is visited at most once during reversal. Space: O(n) for the char list.

### Invariants

- After processing, for every window starting at index `i = 2k * m`, characters at positions `[i, i+k)` are reversed relative to the input, while `[i+k, i+2k)` are unchanged.
- Python's slice clamping guarantees correctness when the final window has fewer than `k` or fewer than `2k` characters — no off-by-one or out-of-bounds possible.

### Error Handling

None. The method trusts its inputs per LeetCode conventions. Empty string produces empty output naturally (the `range` produces no iterations). `k=0` would cause `range` to raise `ValueError` (zero step), but the problem guarantees `1 <= k <= 10^4`.

## Topics to Explore

- [file] `reverse-string-ii/test_solution.py` — See which edge cases (k > len(s), k == 1, k == len(s)) the test suite covers
- [file] `reverse-string-ii/review.md` — Code review notes that may flag alternative approaches or performance observations
- [function] `reverse-only-letters/solution.py:reverseOnlyLetters` — Related two-pointer reversal that skips non-alpha characters; compare strategies
- [file] `reverse-vowels-of-a-string/solution.py` — Another selective-reversal problem; uses two-pointer instead of stride-based windowing
- [general] `python-slice-assignment-semantics` — Understanding how `chars[i:j] = ...` works when the replacement has different length than the target slice

## Beliefs

- `reverse-str-ii-linear-time` — `reverseStr` runs in O(n) time and O(n) space regardless of k
- `reverse-str-ii-no-bounds-check` — The solution relies on Python's slice clamping to handle the final partial window, with no explicit length guard
- `reverse-str-ii-pure-function` — `reverseStr` has no side effects; it returns a new string and does not mutate the input
- `reverse-str-ii-stride-pattern` — The `range(0, n, 2*k)` stride ensures only the first k of every 2k characters are reversed, with the second half left untouched implicitly

