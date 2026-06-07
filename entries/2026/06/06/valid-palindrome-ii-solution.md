# File: valid-palindrome-ii/solution.py

**Date:** 2026-06-06
**Time:** 19:38

## Purpose

This file implements **LeetCode 680 — Valid Palindrome II**. Given a string, it determines whether the string can become a palindrome by deleting **at most one** character. It exports a single function `validPalindrome` used by the test suite.

## Key Components

### `validPalindrome(s: str) -> bool`

The top-level solver. Uses a two-pointer approach that walks inward from both ends of the string. When a mismatch is found, it forks into two possibilities — skip the left character or skip the right character — and checks if either produces a palindrome. Only one mismatch is tolerated, which enforces the "at most one deletion" constraint.

### `is_palindrome(left: int, right: int) -> bool`

A closure over `s` that checks whether the substring `s[left:right+1]` is a palindrome using a simple inward sweep. It's called at most twice (on mismatch), and only over the remaining suffix of the string — not the full string — so it doesn't redo work already validated by the outer loop.

## Patterns

**Two-pointer palindrome check** — the canonical O(n) approach. The outer loop narrows the window; `is_palindrome` handles the residual check after a skip.

**Greedy single-fork** — on the first mismatch, both skip options are tried via `or`. If either works, the string qualifies. There's no backtracking or recursion beyond this single fork, which keeps it O(n) overall.

**Closure instead of parameter passing** — `is_palindrome` captures `s` from the enclosing scope rather than taking it as an argument, reducing boilerplate.

## Dependencies

**Imports**: None. Pure Python, no standard library usage.

**Imported by**: `valid-palindrome-ii/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those other test files don't actually import this solution; they share a common test runner pattern.

## Flow

1. Initialize `left = 0`, `right = len(s) - 1`.
2. Walk inward: if `s[left] == s[right]`, advance both pointers.
3. On first mismatch: return `is_palindrome(left+1, right) or is_palindrome(left, right-1)`. This is the "use your one deletion" step.
4. If the outer loop completes without mismatch, the string is already a palindrome — return `True`.

The key insight: characters validated by the outer loop before the mismatch are guaranteed to be symmetric, so `is_palindrome` only needs to check the remaining inner substring.

## Invariants

- **At most one deletion**: the outer loop handles the zero-deletion case; the fork handles exactly one deletion. There's no path that tolerates two mismatches.
- **O(n) time, O(1) space**: each character is examined at most twice (once in the outer loop, once in `is_palindrome`). No auxiliary data structures.
- **Input assumption**: `s` contains only lowercase English letters (per LeetCode constraints). No validation is performed.

## Error Handling

None. The function assumes valid input — a non-empty string of lowercase letters. It won't crash on empty strings (the `while left < right` guard handles it), but there's no explicit validation or exception raising.

## Topics to Explore

- [file] `valid-palindrome/solution.py` — The simpler predecessor problem (no deletions allowed); compare to see how the deletion fork extends the basic pattern
- [function] `valid-palindrome-ii/solution.py:is_palindrome` — Verify that it's never called on the full string, only on the reduced window after a mismatch
- [file] `valid-palindrome-ii/test_solution.py` — Check which edge cases are covered (empty string, single char, already-palindrome, deletion at start vs end vs middle)
- [general] `greedy-vs-dp-palindrome` — Why a greedy single-fork works for k=1 deletions but wouldn't generalize to k>1 without DP

## Beliefs

- `at-most-two-is-palindrome-calls` — `is_palindrome` is called at most twice per invocation of `validPalindrome`, and only when the outer loop encounters a mismatch
- `linear-time-guarantee` — The total work across the outer loop and both `is_palindrome` calls is bounded by 2n character comparisons
- `no-allocation` — The solution uses zero auxiliary data structures; space complexity is O(1) excluding the input string
- `early-return-on-mismatch` — The outer loop returns immediately on the first mismatch, delegating to the two skip checks rather than continuing iteration

