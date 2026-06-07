# File: consecutive-characters/solution.py

**Date:** 2026-06-06
**Time:** 15:49

## `consecutive-characters/solution.py`

### Purpose

This file solves [LeetCode 1446 — Consecutive Characters](https://leetcode.com/problems/consecutive-characters/). It computes the **power** of a string, defined as the length of the longest substring consisting of a single repeated character. The file owns exactly one responsibility: implementing the `Solution.maxPower` method for submission to LeetCode's judge.

### Key Components

**`Solution.maxPower(self, s: str) -> int`** — The sole public method. Takes a non-empty string `s` and returns the length of its longest run of identical consecutive characters.

- `max_count` — tracks the global best run length seen so far
- `count` — tracks the current run length being extended

### Patterns

**Single-pass linear scan.** The algorithm walks the string once from index 1, comparing each character to its predecessor. This is the canonical "current vs. previous" pattern for run-length problems — no auxiliary data structures, no groupby, no regex.

**Eager max update.** Rather than computing `max_count = max(max_count, count)` after the loop or at every step unconditionally, the update only fires inside the `s[i] == s[i-1]` branch. This avoids a redundant comparison on run-break steps at the cost of a subtle correctness point (see Invariants).

### Dependencies

**Imports:** None. Pure stdlib, no external libraries.

**Imported by:** `consecutive-characters/test_solution.py` (directly). The "Imported By" list in the prompt is misleading — it reflects the test harness's generic import pattern across all problems, not actual consumers of `maxPower`.

### Flow

1. Initialize both `max_count` and `count` to 1 (a single character is always a valid run).
2. Iterate `i` from 1 to `len(s) - 1`.
3. If `s[i] == s[i-1]`: extend the current run (`count += 1`), update `max_count` if this run is now the longest.
4. Otherwise: reset `count = 1` (new run starting at `i`).
5. Return `max_count`.

The data transformation is trivial — a string goes in, a single integer comes out. No mutation of input.

### Invariants

- **`s` is non-empty.** The method initializes `max_count = 1` without checking `len(s)`. An empty string would skip the loop and incorrectly return 1. LeetCode's constraints guarantee `1 <= len(s) <= 500`, so this is safe within the problem's contract but would be a bug for general-purpose use.
- **`max_count` is updated only inside the extension branch.** This means a single-character run that starts at the end of the string never triggers an update. That's fine because `max_count` is initialized to 1, and any single-char run has length 1. But it means the final run's length is only captured in `max_count` if it's at least 2 characters long — which is correct, since a length-1 run can never beat the initialized value of 1.

### Error Handling

None. No validation, no exceptions, no edge-case guards. The method trusts the caller to provide a non-empty string, per LeetCode's problem constraints. An empty string input would silently return an incorrect result (1) rather than raising.

---

## Topics to Explore

- [file] `consecutive-characters/test_solution.py` — See which edge cases the test suite covers (single char, all same, alternating)
- [file] `consecutive-characters/review.md` — Read the code review for style and correctness observations
- [function] `max-consecutive-ones/solution.py:findMaxConsecutiveOnes` — Same run-length pattern applied to a binary array instead of a string
- [function] `longer-contiguous-segments-of-ones-than-zeros/solution.py:checkZeroOnes` — Variant that compares max run lengths of two different characters
- [general] `run-length-encoding-patterns` — How this single-pass scan relates to `itertools.groupby` and RLE-based alternatives across the repo

## Beliefs

- `maxpower-linear-time` — `maxPower` runs in O(n) time and O(1) space with a single pass over the string
- `maxpower-empty-string-bug` — `maxPower` returns 1 for an empty string instead of 0 or raising, but LeetCode guarantees non-empty input
- `maxpower-no-imports` — The solution uses no imports; it is a self-contained method with no external dependencies
- `maxpower-eager-max-update` — `max_count` is only updated when extending a run, not on run breaks; correctness relies on the initial value of 1 covering all single-character runs

