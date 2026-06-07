# File: palindrome-permutation/solution.py

**Date:** 2026-06-06
**Time:** 18:28

## Purpose

This file solves [LeetCode 266 — Palindrome Permutation](https://leetcode.com/problems/palindrome-permutation/). It determines whether **any** rearrangement of the input string could form a palindrome. It doesn't find the permutation — just answers yes/no.

## Key Components

**`canPermutePalindrome(s: str) -> bool`** — The sole public function. It exploits the mathematical property that a string can be rearranged into a palindrome if and only if **at most one character has an odd frequency**. Even-length palindromes need all characters paired; odd-length palindromes allow exactly one unpaired center character.

## Flow

1. `Counter(s)` builds a frequency map: `{"a": 2, "b": 1}` for `"aab"`.
2. `.values()` yields the raw counts.
3. `c % 2 for c in ...` maps each count to 0 (even) or 1 (odd) — a generator of bits.
4. `sum(...)` counts how many characters have odd frequency.
5. `<= 1` enforces the palindrome invariant.

The entire logic is a single expression. For input `"aab"`: counts are `{a:2, b:1}`, odd counts = 1, result = `True` (rearranges to `"aba"`).

## Patterns

**Counting-to-parity reduction** — The solution doesn't care about the actual counts, only their parity. This is a common idiom in palindrome problems. An alternative approach uses XOR on a bitmask (`set` symmetric difference), but `Counter` + modular arithmetic is more readable and equally O(n).

**Single-expression body** — The function fits in one line because the problem has a clean mathematical characterization. No iteration state, no early returns.

## Dependencies

- **Imports**: `collections.Counter` — standard library frequency counter, O(n) construction.
- **Imported by**: `palindrome-permutation/test_solution.py` and hundreds of other test files (the "Imported By" list in the prompt is the test harness importing from a shared runner, not direct imports of this function).

## Invariants

- Input is assumed to be lowercase English letters (per the LeetCode constraint). The solution works on any hashable characters, but the problem scope is narrower.
- The `<= 1` threshold is unconditional — it handles both even-length strings (must be 0 odd counts) and odd-length strings (must be exactly 1) in a single check, because an even-length string with 1 odd count is impossible (odd counts always have the same parity as the string length).

## Error Handling

None. Empty string returns `True` (sum is 0), which is correct — the empty string is a palindrome. No input validation; the function trusts its caller.

## Topics to Explore

- [file] `palindrome-permutation/test_solution.py` — Edge cases tested: empty string, single char, all-same chars, even/odd length failures
- [function] `longest-palindrome/solution.py:longestPalindrome` — Uses the same odd-count insight but computes the max palindrome length from available characters
- [general] `parity-bitmask-approach` — Alternative O(n) solution using a set (add if absent, remove if present) where final set size <= 1 means palindrome-permutable
- [file] `palindrome-linked-list/solution.py` — Related palindrome problem that must check structure rather than permutability

## Beliefs

- `palindrome-perm-at-most-one-odd` — `canPermutePalindrome` returns `True` iff at most one character in `s` has an odd frequency count
- `palindrome-perm-empty-string-true` — An empty string input returns `True` (zero odd counts <= 1)
- `palindrome-perm-linear-time` — The solution runs in O(n) time and O(k) space where k is the alphabet size, dominated by `Counter` construction
- `palindrome-perm-no-validation` — The function performs no input validation and will accept any string, not just lowercase English letters

