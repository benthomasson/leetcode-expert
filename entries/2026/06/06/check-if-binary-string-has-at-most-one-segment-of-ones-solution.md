# File: check-if-binary-string-has-at-most-one-segment-of-ones/solution.py

**Date:** 2026-06-06
**Time:** 15:38

## Purpose

This file solves [LeetCode 1784: Check if Binary String Has at Most One Segment of Ones](https://leetcode.com/problems/check-if-binary-string-has-at-most-one-segment-of-ones/). It determines whether a binary string (guaranteed to have no leading zeros) contains at most one contiguous block of `1`s. It provides two identical implementations: one as a LeetCode `Solution` class method, and one as a standalone function.

## Key Components

### `Solution.checkIfBinaryStringHasAtMostOneSegmentOfOnes(self, s: str) -> bool`
The LeetCode-compatible class method. Returns `True` if the string has at most one contiguous segment of `1`s.

### `minimum_energy(s: str) -> bool`
A standalone function with identical logic — a freestanding alias likely used by the test harness for convenience.

## Patterns

**Substring absence as a structural invariant.** The entire solution is `return "01" not in s`. This works because:

1. The problem guarantees no leading zeros, so the string starts with `1` (or is `"0"`).
2. If there are two or more segments of `1`s, there must be a `0` between them — meaning the string contains the pattern `1...0...1`, which necessarily includes the substring `"01"` at the boundary where a `0`-segment transitions back to a `1`-segment.
3. Conversely, if `"01"` never appears, then once the string transitions from `1`s to `0`s, it never transitions back — exactly one segment of `1`s (or none).

This is an O(n) scan with O(1) extra space, leveraging Python's `in` operator on strings (which uses a fast substring search internally).

**Dual interface pattern.** The class method and standalone function are duplicated verbatim, a convention used across this repo so tests can import either form.

## Dependencies

**Imports:** None — pure string operation with no external dependencies.

**Imported by:** `check-if-binary-string-has-at-most-one-segment-of-ones/test_solution.py` plus hundreds of other test files across the repo (the "Imported By" list in the prompt reflects a shared test harness pattern, not that those other problems use this solution's logic).

## Flow

1. Caller passes a binary string `s`.
2. Python's `in` operator scans `s` for the two-character substring `"01"`.
3. If `"01"` is found, the string has a `0` followed by a `1`, meaning ones are split into multiple segments → return `False`.
4. If `"01"` is not found → return `True`.

## Invariants

- **No leading zeros:** The problem guarantees `s[0] == '1'` (for non-empty input of length > 0 where at least one `1` exists). The solution's correctness depends on this — without it, `"01"` would be a valid single-segment string that gets incorrectly rejected.
- **Binary input:** `s` consists only of `'0'` and `'1'` characters.

## Error Handling

None. The function assumes valid input per the LeetCode contract. An empty string or non-binary string would still produce a boolean result (no crash), but the answer would be semantically meaningless.

## Topics to Explore

- [file] `check-if-binary-string-has-at-most-one-segment-of-ones/test_solution.py` — How the dual interface (class vs standalone) is tested
- [file] `longer-contiguous-segments-of-ones-than-zeros/solution.py` — Related binary string segment problem, likely uses a different counting approach
- [file] `check-if-all-1s-are-at-least-length-k-places-away/solution.py` — Another binary string spacing problem with stricter constraints
- [general] `substring-absence-pattern` — Other solutions in this repo that use "substring not in s" as the core insight (e.g., `check-if-all-as-appears-before-all-bs`)

## Beliefs

- `no-leading-zeros-required` — The `"01" not in s` check is only correct because the problem guarantees the input has no leading zeros; `"011"` would be incorrectly rejected otherwise
- `linear-time-constant-space` — The solution runs in O(n) time and O(1) space via Python's built-in substring search
- `dual-interface-identical` — `Solution.checkIfBinaryStringHasAtMostOneSegmentOfOnes` and `minimum_energy` implement exactly the same logic with no behavioral difference
- `no-imports-pure-string` — The solution has zero dependencies, using only Python's `in` operator on a string literal

