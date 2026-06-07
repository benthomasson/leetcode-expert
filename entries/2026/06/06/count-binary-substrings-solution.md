# File: count-binary-substrings/solution.py

**Date:** 2026-06-06
**Time:** 15:55

## Purpose

This file solves [LeetCode 696 - Count Binary Substrings](https://leetcode.com/problems/count-binary-substrings/). It counts substrings in a binary string where the number of consecutive `0`s and `1`s are equal, and all `0`s and `1`s are grouped together (e.g., `"0011"`, `"1100"`, `"01"`, `"10"`).

The file owns both the solution and its test suite — a self-contained unit following the repo's convention of one problem per directory.

## Key Components

### `count_binary_substrings(s: str) -> int`

The core algorithm. Uses a **group-counting** approach with two variables:

- `prev`: size of the previous run of identical characters (starts at `0`)
- `curr`: size of the current run (starts at `1`)

At each group boundary (where `s[i] != s[i-1]`), the number of valid substrings that span these two groups is `min(prev, curr)`. This works because a valid substring must pair equal-length portions from adjacent groups — so you can form at most `min(prev, curr)` such pairs.

After the loop, a final `min(prev, curr)` captures the last pair of groups.

### `TestCountBinarySubstrings`

Eight test methods covering: LeetCode examples, single characters, uniform strings, two-character strings, alternating patterns, equal-length runs, and unequal-length runs.

## Patterns

**O(1) space group counting.** Rather than materializing a list of group lengths (a common alternative), this solution tracks only the previous and current group sizes. This is a well-known optimization for this problem class — the same pattern appears in problems like "Longest Turbulent Subarray."

**Inline tests.** The `unittest` suite lives in the same file as the solution, with a separate `test_solution.py` importing it (per the repo convention).

## Dependencies

**Imports:** Only `unittest` from the standard library — no external dependencies.

**Imported by:** `count-binary-substrings/test_solution.py`. The massive "Imported By" list in the context is misleading — those are other problems' test files that happen to share the same `unittest` import, not actual consumers of this function.

## Flow

1. Initialize `prev = 0`, `curr = 1`, `result = 0`.
2. Iterate from index 1 through the string.
3. If the current character matches the previous, extend the current group (`curr += 1`).
4. If it differs, a group boundary is hit: add `min(prev, curr)` to `result`, shift `curr` into `prev`, reset `curr = 1`.
5. After the loop, add the final `min(prev, curr)` to capture the last group pair.
6. Return `result`.

For `"00110011"`: groups are `[2, 2, 2, 2]`. At each boundary: `min(0,2)=0`, `min(2,2)=2`, `min(2,2)=2`. Final: `min(2,2)=2`. Total: **6**.

## Invariants

- `curr >= 1` always — it starts at 1 and resets to 1 at each boundary.
- `prev == 0` only before the first group boundary is encountered, which correctly contributes 0 valid substrings.
- The final `result += min(prev, curr)` outside the loop is essential — without it, the last group pair is missed.
- The function is correct for single-character strings: the loop doesn't execute, and `min(0, 1) = 0`.

## Error Handling

None. The function assumes `s` is a non-empty string of `'0'` and `'1'` characters, consistent with LeetCode's constraints. No validation, no exceptions. Empty string would cause `curr = 1` to be initialized for a string with no characters, but the loop wouldn't execute and `min(0, 1) = 0` is returned — accidentally correct.

## Topics to Explore

- [file] `count-binary-substrings/test_solution.py` — How the external test file imports and exercises this solution
- [function] `consecutive-characters/solution.py:maxPower` — Same group-counting pattern applied to a different problem (longest run of one character)
- [general] `group-length-array-vs-two-variable` — The alternative approach that builds `groups = [2, 2, 2, 2]` explicitly, then sums `min(groups[i], groups[i+1])` — equivalent but O(n) space
- [file] `count-substrings-with-only-one-distinct-letter/solution.py` — Related substring-counting problem that also uses run-length reasoning
- [general] `binary-string-patterns` — How this repo handles the family of binary string problems (alternating bits, balanced substrings, prefix divisibility)

## Beliefs

- `count-binary-substrings-linear-time` — `count_binary_substrings` runs in O(n) time and O(1) space, making a single pass over the string
- `final-min-required` — The `result += min(prev, curr)` after the loop on line 24 is load-bearing; removing it undercounts by the contribution of the last two groups
- `prev-zero-sentinel` — `prev` starts at 0 so that the first group boundary contributes zero substrings, since there is no "previous" group before the first one
- `min-of-adjacent-groups` — The number of valid substrings spanning two adjacent groups of sizes a and b is exactly `min(a, b)`

