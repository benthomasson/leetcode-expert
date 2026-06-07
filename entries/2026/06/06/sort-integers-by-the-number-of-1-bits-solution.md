# File: sort-integers-by-the-number-of-1-bits/solution.py

**Date:** 2026-06-06
**Time:** 19:12

## Purpose

This file solves [LeetCode 1356: Sort Integers by The Number of 1 Bits](https://leetcode.com/problems/sort-integers-by-the-number-of-1-bits/). It provides a single method that sorts an array of integers first by their popcount (number of `1` bits in binary representation), then by numeric value as a tiebreaker. It lives in the `sort-integers-by-the-number-of-1-bits/` directory alongside its plan, review, and tests — the standard layout for every problem in this repo.

## Key Components

**`Solution.sortByBits(self, arr: List[int]) -> List[int]`** — The core method. Takes a list of non-negative integers and returns a new list sorted by two criteria in priority order: ascending bit count, then ascending value.

**`sort_integers_by_the_number_of_1_bits`** — A module-level alias that binds an instance method to a bare function name. This follows the repo's convention of exposing a snake_case callable that matches the problem's directory name, which the test harness imports.

## Patterns

**Tuple sort key**: The lambda `lambda x: (bin(x).count('1'), x)` produces a 2-tuple. Python's `sorted()` compares tuples lexicographically, so bit count dominates and value breaks ties. This is idiomatic Python for multi-criteria sorts — no custom comparator needed.

**`bin().count('1')` for popcount**: Rather than using bit manipulation (Kernighan's trick, lookup tables), this leans on Python's built-in `bin()` string conversion. It's O(log n) per element in the number of bits, and perfectly adequate given LeetCode's constraint that values are at most 10^4 (14 bits).

**Instance-as-module-function alias**: The bottom line `sort_integers_by_the_number_of_1_bits = Solution().sortByBits` instantiates `Solution` at import time and binds the method. This is the repo-wide convention — every problem exposes its entry point this way for uniform test imports.

## Dependencies

**Imports**: Only `typing.List` — no external libraries.

**Imported by**: The test file `sort-integers-by-the-number-of-1-bits/test_solution.py` imports the module-level alias. The massive "Imported By" list in the context is misleading — those are test files for *other* problems that happen to share the same import pattern from their own `solution.py`, not actual consumers of this file.

## Flow

1. `sorted()` iterates over `arr`, calling the lambda on each element.
2. The lambda converts each integer to its binary string via `bin()` (e.g., `bin(7)` → `'0b111'`), counts the `'1'` characters, and pairs that count with the original value.
3. `sorted()` uses the resulting tuples for comparison — ascending by default.
4. A new list is returned; the input is not mutated.

## Invariants

- Input values must be non-negative integers (negative values would produce a `'-0b...'` string from `bin()`, and the `'1'` count would still be correct for the magnitude, but the sign character is not a `'1'` so it's silently ignored — the sort would treat `-7` as having 3 set bits same as `7`).
- The sort is stable with respect to elements that share both bit count and value (i.e., duplicates preserve their original relative order), since Python's `sorted()` is stable.
- The original list is never modified — `sorted()` returns a new list.

## Error Handling

None. The function trusts its input matches the LeetCode contract (list of non-negative integers). No validation, no try/except. An empty list returns an empty list; a single-element list returns a single-element list. These are handled naturally by `sorted()`.

## Topics to Explore

- [file] `sort-integers-by-the-number-of-1-bits/test_solution.py` — See what edge cases the test suite covers (empty list, single element, all same bit count, max values)
- [file] `counting-bits/solution.py` — Related problem that computes popcount for a range; compare the bit-counting technique used there
- [file] `number-of-1-bits/solution.py` — The pure popcount problem; likely uses a different counting approach worth comparing
- [general] `python-sort-key-tuples` — How Python's lexicographic tuple comparison enables multi-criteria sorts without `functools.cmp_to_key`
- [file] `sort-array-by-increasing-frequency/solution.py` — Another custom-sort problem in this repo; compare the key function design

## Beliefs

- `sort-by-bits-uses-string-popcount` — `sortByBits` computes popcount via `bin(x).count('1')` string counting, not bitwise arithmetic
- `sort-by-bits-stable-tiebreak` — Elements with equal bit count are sorted ascending by value; equal-value elements preserve input order (stable sort)
- `sort-by-bits-nonmutating` — The input list `arr` is never modified; `sorted()` returns a new list
- `module-alias-instantiates-at-import` — The module-level alias `sort_integers_by_the_number_of_1_bits` creates a `Solution()` instance at import time and binds its `sortByBits` method

