# File: valid-palindrome/solution.py

**Date:** 2026-06-06
**Time:** 19:39

## Purpose

This file implements [LeetCode 125: Valid Palindrome](https://leetcode.com/problems/valid-palindrome/). It determines whether a string reads the same forwards and backwards after stripping all non-alphanumeric characters and normalizing case. It's one of ~400+ solution files in the `leetcode-implementations` repo, each following the same `Solution` class convention that LeetCode expects.

## Key Components

### `Solution.isPalindrome(s: str) -> bool`

The only method. Contract: given any string `s`, return `True` if it's a valid palindrome considering only alphanumeric characters and ignoring case, `False` otherwise.

## Patterns

**Two-pointer inward sweep.** Two indices start at opposite ends of the string and walk toward each other. Each pointer skips non-alphanumeric characters before comparing. This is the canonical O(n) time, O(1) space approach — no filtered copy of the string is ever allocated.

The alternative one-liner (`s_clean == s_clean[::-1]` after filtering) would be O(n) space. This solution avoids that.

## Dependencies

**Imports:** None — uses only builtins (`str.isalnum`, `str.lower`).

**Imported by:** The "Imported By" list in the prompt is misleading — those are test files across the entire repo that share a common test harness importing from `solution.py` in their own directories, not files that import *this* solution. The only file that genuinely imports this module is `valid-palindrome/test_solution.py`.

## Flow

1. Initialize `left = 0`, `right = len(s) - 1`.
2. Outer `while left < right` loop drives convergence.
3. Inner loops advance `left` forward and `right` backward past any non-alphanumeric characters (spaces, punctuation, etc.).
4. Compare `s[left].lower()` to `s[right].lower()`. On mismatch, return `False` immediately.
5. Move both pointers inward (`left += 1`, `right -= 1`).
6. If the loop completes without returning `False`, the string is a palindrome — return `True`.

For input `"A man, a plan, a canal: Panama"`:
- The pointers skip commas, spaces, and the colon.
- Each alphabetic comparison (`A`/`a`, `m`/`m`, `a`/`a`, ...) matches case-insensitively.
- Returns `True`.

## Invariants

- **Guard in inner loops**: Both inner `while` loops re-check `left < right`, preventing out-of-bounds access on strings that are entirely non-alphanumeric (e.g., `",.!"`).
- **Case normalization**: `.lower()` is called at comparison time, not during preprocessing — the original string is never mutated or copied.
- **Empty/single-char strings**: The outer loop condition `left < right` handles these correctly — they return `True` with zero comparisons.

## Error Handling

None. The method assumes `s` is a valid Python string (guaranteed by LeetCode's contract). No exceptions are raised or caught. Non-alphanumeric-only strings like `""` or `"!@#"` are handled gracefully by the pointer guards and return `True`.

## Topics to Explore

- [file] `valid-palindrome/test_solution.py` — See what edge cases are tested (empty string, single char, all non-alnum, mixed case)
- [file] `valid-palindrome-ii/solution.py` — The follow-up problem: can you make it a palindrome by removing at most one character? Uses the same two-pointer foundation with a twist
- [function] `backspace-string-compare/solution.py:backspaceCompare` — Another two-pointer problem that walks strings from both ends, but with a different skip condition (backspace chars)
- [file] `palindrome-linked-list/solution.py` — Same palindrome check applied to a linked list, where the O(1) space constraint forces a different structural approach (reverse half the list)

## Beliefs

- `valid-palindrome-uses-o1-space` — `isPalindrome` uses O(1) auxiliary space; it never allocates a filtered or reversed copy of the input string
- `valid-palindrome-inner-loop-guards` — The inner skip loops re-check `left < right`, which prevents index-out-of-bounds on strings containing no alphanumeric characters
- `valid-palindrome-case-insensitive-at-compare` — Case normalization happens at comparison time via `.lower()`, not by preprocessing the entire string
- `valid-palindrome-empty-is-palindrome` — An empty string or a string with no alphanumeric characters returns `True` (the loop body never executes)

