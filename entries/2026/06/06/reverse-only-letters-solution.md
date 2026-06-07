# File: reverse-only-letters/solution.py

**Date:** 2026-06-06
**Time:** 18:53

## Purpose

This file implements LeetCode problem **917 - Reverse Only Letters**. It provides a `Solution` class with a method that reverses only the English alphabetic characters in a string while leaving all non-letter characters (digits, punctuation, spaces) in their original positions.

Note: the method is misnamed `num_rescue_boats` — this is a copy-paste artifact from a different problem. The docstring and implementation correctly solve "Reverse Only Letters."

## Key Components

### `Solution.num_rescue_boats(self, s: str) -> str`

**Contract**: Takes a string `s`, returns a new string where all `isalpha()` characters appear in reverse order but non-alpha characters remain at their original indices.

**Example**: `"a-bC-dEf-ghIj"` → `"j-Ih-gfE-dCba"`

## Patterns

**Two-pointer convergence**: Classic technique where `left` starts at 0 and `right` at `len-1`. Both pointers move inward, skipping non-letter characters. When both point at letters, the values are swapped. This avoids needing to extract letters, reverse them, and re-insert — doing the work in a single pass over the array.

The string is converted to a `list` first since Python strings are immutable, then joined back at the end.

## Dependencies

**Imports**: None — uses only Python builtins (`str.isalpha`, `list`, `str.join`).

**Imported by**: `reverse-only-letters/test_solution.py` (and hundreds of other test files that appear to share a common test harness importing all solutions).

## Flow

1. Convert `s` to a mutable `list` of characters
2. Initialize two pointers at the string boundaries
3. Loop while `left < right`:
   - If `chars[left]` is not alphabetic, advance `left`
   - Else if `chars[right]` is not alphabetic, retreat `right`
   - Else swap the two characters and advance both pointers
4. Join and return the result

The `elif`/`else` structure means exactly one pointer moves (or both move on swap) per iteration, guaranteeing O(n) time with O(n) space for the list copy.

## Invariants

- **Pointer ordering**: `left < right` is checked before every operation — the loop terminates when pointers meet or cross.
- **Non-letter stability**: Non-alpha characters are never moved; only alpha characters participate in swaps.
- **Single-pass**: Each index is visited at most once by either pointer.

## Error Handling

None. The method trusts that `s` is a valid string. Empty strings and single-character strings work correctly — the `while left < right` guard handles both cases by skipping the loop entirely.

## Topics to Explore

- [file] `reverse-only-letters/test_solution.py` — See what edge cases are tested (empty string, all-alpha, no-alpha, single char)
- [function] `reverse-vowels-of-a-string/solution.py` — Same two-pointer-with-filter pattern applied to vowels instead of all letters
- [file] `reverse-only-letters/review.md` — May document the method name mismatch and other review findings
- [general] `two-pointer-convergence-pattern` — How this repo applies the converging two-pointer idiom across different string/array problems

## Beliefs

- `method-name-mismatch` — `num_rescue_boats` is an incorrect method name for the Reverse Only Letters problem; the implementation solves problem 917, not the rescue boats problem
- `non-alpha-positional-invariant` — Non-alphabetic characters in the input string are guaranteed to remain at their original indices in the output
- `two-pointer-linear-time` — The algorithm runs in O(n) time because each pointer advances monotonically inward and they collectively visit each index at most once
- `no-external-dependencies` — The solution uses only Python built-in operations (`str.isalpha`, `list`, `str.join`) with zero imports

