# File: determine-if-string-halves-are-alike/solution.py

**Date:** 2026-06-06
**Time:** 16:20

## Purpose

This file solves [LeetCode 1704: Determine if String Halves Are Alike](https://leetcode.com/problems/determine-if-string-halves-are-alike/). It owns a single responsibility: given an even-length string, determine whether the first half and second half contain the same number of vowels.

## Key Components

### `determine_if_string_halves_are_alike(s: str) -> bool`

The sole exported function. Contract:

- **Input**: An even-length string `s` containing uppercase and/or lowercase English letters.
- **Output**: `True` if the vowel count of `s[:len(s)//2]` equals the vowel count of `s[len(s)//2:]`.

### `vowels` (local constant)

A `set` of 10 characters — the five English vowels in both cases: `"aeiouAEIOU"`. Using a set gives O(1) membership tests instead of O(n) scans over a string literal.

## Patterns

- **Generator-based counting**: `sum(c in vowels for c in ...)` exploits the fact that `True` is `1` and `False` is `0` in Python arithmetic. This is idiomatic for counting elements matching a predicate without materializing a filtered list.
- **Flat function, no class**: Follows the repo's convention of exposing a bare function named after the problem slug (kebab-case → snake_case). No `Solution` class wrapping — the repo avoids LeetCode's class boilerplate.

## Dependencies

**Imports**: None. Pure standard-library Python — no external or internal imports.

**Imported by**: The "Imported By" list in the prompt is misleading — those are *all* test files across the repo, likely an artifact of the test harness importing a common fixture or conftest, not direct consumers of this function. The only genuine consumer is `determine-if-string-halves-are-alike/test_solution.py`.

## Flow

1. Build the vowel lookup set (10 elements).
2. Compute `mid = len(s) // 2` — integer division splits the string into two equal halves.
3. Count vowels in `s[:mid]` via a generator sum.
4. Count vowels in `s[mid:]` via a second generator sum.
5. Return whether the two counts are equal.

Both halves are scanned independently in a single pass each — total work is O(n) time, O(1) space (the set is fixed-size).

## Invariants

- **Even-length input assumed**: The function does not validate `len(s) % 2 == 0`. If `s` has odd length, the second half gets one extra character — this matches LeetCode's guarantee that `s` is always even-length.
- **Case-insensitive vowel matching**: Both `'A'` and `'a'` are in the set, so the function handles mixed-case input without calling `.lower()`.

## Error Handling

None. The function assumes valid input per LeetCode's constraints. Passing an empty string returns `True` (both halves have 0 vowels). Passing a non-string would raise a `TypeError` from the iteration — no explicit guard.

## Topics to Explore

- [file] `determine-if-string-halves-are-alike/test_solution.py` — See what edge cases the test suite covers (empty string, all-vowels, no-vowels, mixed case)
- [file] `determine-if-string-halves-are-alike/review.md` — The code review may note alternative approaches (e.g., `Counter`, single-pass difference tracking)
- [function] `reverse-vowels-of-a-string/solution.py:reverse_vowels_of_a_string` — Another vowel-focused problem; compare how the vowel set is constructed and used
- [general] `vowel-set-pattern` — Several solutions in this repo likely define the same `set("aeiouAEIOU")` — worth checking if there's a shared utility or if each reimplements it

## Beliefs

- `halves-alike-is-o-n-time` — The solution runs in O(n) time with O(1) auxiliary space; the vowel set is constant-size (10 elements).
- `halves-alike-assumes-even-length` — No validation that `len(s)` is even; the function silently produces a result for odd-length strings by giving the second half the extra character.
- `halves-alike-no-imports` — The function uses no imports — pure built-in Python operations only.
- `halves-alike-case-insensitive` — Vowel matching handles both cases via a prebuilt set containing all 10 case variants, avoiding a `.lower()` call on the input.

