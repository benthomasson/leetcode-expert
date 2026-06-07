# File: check-if-string-is-a-prefix-of-array/solution.py

**Date:** 2026-06-06
**Time:** 15:42

## Purpose

This file solves [LeetCode 1961: Check If String Is a Prefix of Array](https://leetcode.com/problems/check-if-string-is-a-prefix-of-array/). It determines whether a given string `s` exactly equals the concatenation of the first `k` elements of `words` for some `k`. It's one solution module among hundreds in the `leetcode-implementations` repo, each following the same `solution.py` / `test_solution.py` / `review.md` / `plan.md` convention.

## Key Components

**`is_prefix_string(s, words)`** — The sole public function. Takes a target string and a list of words, returns `True` if `s` equals `words[0] + words[1] + ... + words[k-1]` for some valid `k >= 1`.

Contract: `s` must be a non-empty string, `words` a non-empty list of strings (per LeetCode constraints). The function never mutates its inputs.

## Patterns

**Incremental accumulation with early exit** — Rather than precomputing all possible prefix concatenations, it builds the prefix one word at a time and checks for equality after each addition. This avoids unnecessary work via two exit conditions:

1. **Match found** (`prefix == s`) — return `True` immediately.
2. **Overshoot** (`len(prefix) > len(s)`) — no possible future match, return `False` immediately.

This is the standard greedy string-building pattern for prefix-matching problems. No `itertools`, no `join` — just a loop with string concatenation.

## Dependencies

**Imports**: None. Pure Python, no standard library or third-party dependencies.

**Imported by**: The `test_solution.py` in the same directory. The "Imported By" list in the prompt is misleading — those are test files for *other* problems, not actual importers of this module. Each problem's test file imports its own `solution.py` via a relative import pattern; they don't cross-import.

## Flow

1. Initialize `prefix` as an empty string.
2. For each `word` in `words`:
   - Append `word` to `prefix`.
   - If `prefix == s`: exact match found, return `True`.
   - If `len(prefix) > len(s)`: overshot, return `False`.
3. If the loop exhausts `words` without matching, return `False` (the full concatenation of all words is shorter than `s`, or doesn't match).

## Invariants

- The function only returns `True` on an **exact boundary match** — `s` must end exactly where some word ends. If `s = "ab"` and `words = ["a", "bc"]`, the prefix after one word is `"a"` (no match), after two is `"abc"` (overshoot), so it correctly returns `False`.
- `k` must be at least 1: the empty prefix (`""`) is never compared because the check happens *after* appending.
- The length guard (`len(prefix) > len(s)`) ensures O(n) time where n = len(s), not O(total length of all words).

## Error Handling

None. The function assumes valid inputs per LeetCode guarantees. Empty `words` list or empty `s` would produce `False` — correct for the empty-words case, but the empty-`s` case would also return `False` even though zero words concatenated equals `""`. This doesn't matter for the problem's constraints (`1 <= s.length`, `1 <= words.length`).

## Topics to Explore

- [file] `check-if-string-is-a-prefix-of-array/test_solution.py` — See what edge cases the tests cover (single word match, overshoot, partial word boundaries)
- [file] `check-if-two-string-arrays-are-equivalent/solution.py` — Related string concatenation problem; compare the approach
- [file] `check-if-string-is-a-prefix-of-array/review.md` — Code review notes may highlight alternative approaches (e.g., `itertools.accumulate` + `join`)
- [general] `string-concatenation-performance` — Repeated `+=` on strings is O(n^2) in the worst case in CPython (though often optimized); `"".join()` with `itertools.accumulate` would be O(n)

## Beliefs

- `prefix-match-requires-word-boundary` — `is_prefix_string` only returns `True` when `s` aligns exactly with a word boundary in `words`; partial word matches are rejected
- `early-exit-on-overshoot` — The length check `len(prefix) > len(s)` guarantees the loop terminates as soon as the accumulated prefix exceeds the target, avoiding unnecessary concatenation
- `no-cross-problem-imports` — Despite the "Imported By" list, each problem's `test_solution.py` imports only its own `solution.py`, not solutions from other problems
- `empty-prefix-never-compared` — The equality check occurs after appending, so the function cannot match `s = ""`; this is safe given LeetCode's `1 <= s.length` constraint

