# File: substrings-of-size-three-with-distinct-characters/solution.py

**Date:** 2026-06-06
**Time:** 19:18

## Purpose

This file solves [LeetCode 1876: Substrings of Size Three with Distinct Characters](https://leetcode.com/problems/substrings-of-size-three-with-distinct-characters/). It counts how many length-3 substrings of a given string have all three characters distinct.

It follows the repo's convention: one `Solution` class per problem directory, with the solving method on that class.

## Key Components

### `Solution.highest_island(self, s: str) -> int`

**Note the naming bug**: the method is called `highest_island`, which is clearly a copy-paste artifact from a different problem. The LeetCode platform expects `countGoodSubstrings`, but within this repo the tests likely call `highest_island` directly, so it works despite the wrong name.

**Contract**: Given a string `s` of lowercase English letters, returns the count of substrings of length 3 where all three characters are different.

## Patterns

**Sliding window (fixed size 3)**: The loop iterates `i` from `0` to `len(s) - 3` (inclusive), examining the triple `s[i], s[i+1], s[i+2]` each iteration. Rather than using a set or `len(set(...)) == 3`, it manually checks all three pairwise inequalities. This is a micro-optimization — three comparisons vs. set construction — that's idiomatic for fixed-size windows small enough to enumerate pairs.

**Accumulator pattern**: A running `count` is incremented when the condition holds, then returned.

## Dependencies

**Imports**: None. The solution is self-contained with no standard library or third-party imports.

**Imported by**: The "Imported By" list in the prompt is misleading — it lists hundreds of test files across unrelated problems. This is likely an artifact of a shared test harness or import-scanning tool that resolves `solution.py` generically. The real consumer is `substrings-of-size-three-with-distinct-characters/test_solution.py`.

## Flow

1. Initialize `count = 0`.
2. For each index `i` in `[0, len(s) - 3]`:
   - Check `s[i] != s[i+1]`, `s[i+1] != s[i+2]`, and `s[i] != s[i+2]`.
   - If all three hold, increment `count`.
3. Return `count`.

Time complexity: O(n). Space complexity: O(1).

## Invariants

- The loop range `range(len(s) - 2)` guarantees `i+2` is always a valid index, so no bounds checking is needed.
- The three pairwise inequality checks are equivalent to `len({s[i], s[i+1], s[i+2]}) == 3` — all three characters in the window must be distinct.
- For strings shorter than 3 characters, `range(len(s) - 2)` produces an empty range, so the function correctly returns 0.

## Error Handling

None. The function assumes `s` is a valid string. An empty string or string shorter than 3 characters returns 0 naturally via the empty loop range. No exceptions are raised or caught.

## Topics to Explore

- [file] `substrings-of-size-three-with-distinct-characters/test_solution.py` — See what test cases exercise this solution, including edge cases
- [file] `substrings-of-size-three-with-distinct-characters/review.md` — The code review may flag the `highest_island` naming issue
- [general] `method-naming-consistency` — Several solutions in this repo may have copy-paste method names from other problems; worth auditing
- [function] `count-vowel-substrings-of-a-string/solution.py:Solution` — A harder variant of substring-with-distinct-characters using a variable-size sliding window
- [file] `diet-plan-performance/solution.py` — Another fixed-size sliding window problem for comparison

## Beliefs

- `wrong-method-name` — The method is named `highest_island` instead of `countGoodSubstrings`; this is a copy-paste error from a different problem
- `pairwise-check-equivalence` — The three pairwise `!=` checks are logically equivalent to `len(set(window)) == 3` for a window of size 3
- `empty-input-safe` — Strings with fewer than 3 characters return 0 without any special-case code, because `range(len(s) - 2)` is empty
- `constant-space` — The solution uses O(1) auxiliary space regardless of input size

