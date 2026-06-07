# File: find-the-longest-balanced-substring-of-a-binary-string/solution.py

**Date:** 2026-06-06
**Time:** 16:47

## Purpose

This file solves [LeetCode 2609: Find the Longest Balanced Substring of a Binary String](https://leetcode.com/problems/find-the-longest-balanced-substring-of-a-binary-string/). It exports a single function `longestBalancedSubstring` that finds the longest contiguous substring where some number of `'0'`s are immediately followed by the same number of `'1'`s — e.g., `"0011"` or `"000111"`.

## Key Components

**`longestBalancedSubstring(s: str) -> int`** — The sole function. Takes a binary string and returns the length of the longest balanced substring (always even, or 0).

## Patterns

The solution uses a **single-pass counter technique** — tracking running counts of consecutive `'0'`s and `'1'`s rather than checking all substrings. This is the same family of approach used in `count-binary-substrings/solution.py`, which solves a related problem (counting all such substrings rather than finding the longest).

The state machine has two implicit states:
1. **Accumulating zeros**: `c == '0'` and `ones == 0`
2. **Accumulating ones**: `c == '1'`

The transition from state 2 back to state 1 (hitting a `'0'` after seeing `'1'`s) resets both counters — this is the key invariant that starts a fresh balanced-substring candidate.

## Dependencies

**Imports**: None. Pure function with no external dependencies.

**Imported by**: The `test_solution.py` in the same directory. The large "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a test harness pattern, not actual consumers of this function.

## Flow

Walk through `s = "001111"`:

| char | `zeros` | `ones` | `best` | why |
|------|---------|--------|--------|-----|
| `0`  | 1       | 0      | 0      | ones=0, just increment zeros |
| `0`  | 2       | 0      | 0      | same |
| `1`  | 2       | 1      | 2      | `2*min(2,1)=2` |
| `1`  | 2       | 2      | 4      | `2*min(2,2)=4` |
| `1`  | 2       | 3      | 4      | `2*min(2,3)=4`, ones exceed zeros |
| `1`  | 2       | 4      | 4      | same |

Result: `4` (the balanced substring `"0011"`).

The critical detail is the reset logic: when a `'0'` appears after one or more `'1'`s (`ones > 0`), both counters go to zero before incrementing `zeros`. This correctly handles sequences like `"11100011"` — the `'0'` after the `'1'` block starts a fresh candidate.

## Invariants

- `best` is updated only on `'1'` characters, using `2 * min(zeros, ones)`. This guarantees the result is always even.
- The reset (`zeros = ones = 0`) fires when a `'0'` follows a `'1'`, enforcing that balanced substrings must be contiguous with no interleaving.
- `zeros` only grows during consecutive `'0'` runs. Once a `'1'` appears, `zeros` is frozen until the next reset.

## Error Handling

None. The function assumes valid input (a string of `'0'`s and `'1'`s). An empty string returns 0 naturally since the loop body never executes.

## Topics to Explore

- [file] `count-binary-substrings/solution.py` — Solves the closely related problem of *counting* all balanced substrings; likely uses the same counter technique
- [function] `find-the-longest-balanced-substring-of-a-binary-string/test_solution.py:test_*` — See what edge cases are validated (empty string, all zeros, all ones, multiple balanced segments)
- [file] `find-the-longest-balanced-substring-of-a-binary-string/plan.md` — May document alternative approaches considered (e.g., O(n^2) brute force, regex-based)
- [general] `single-pass-counter-vs-grouping` — Compare this running-counter approach against the alternative of grouping consecutive characters first (as in the `itertools.groupby` idiom), which trades a small space overhead for arguably clearer logic

## Beliefs

- `balanced-substring-always-even` — `longestBalancedSubstring` always returns an even integer (including 0), never odd
- `single-pass-linear-time` — The algorithm runs in O(n) time and O(1) space with exactly one pass over the string
- `reset-on-zero-after-ones` — Both counters reset to zero when a `'0'` is encountered after one or more `'1'`s, preventing stale zero-counts from inflating results across non-contiguous segments
- `best-updated-only-on-ones` — The `best` variable is only updated when processing a `'1'` character, which means trailing zeros never affect the result

