# File: longer-contiguous-segments-of-ones-than-zeros/solution.py

**Date:** 2026-06-06
**Time:** 17:25

## `longer-contiguous-segments-of-ones-than-zeros/solution.py`

### Purpose

Solves [LeetCode 1869](https://leetcode.com/problems/longer-contiguous-segments-of-ones-than-zeros/): given a binary string, determine whether the longest contiguous run of `'1'`s is strictly longer than the longest contiguous run of `'0'`s. This is an Easy-tier string problem that exercises single-pass run-length tracking.

### Key Components

**`checkZeroOnes(s: str) -> bool`** — The sole function. Takes a binary string and returns `True` iff the maximum contiguous segment of `'1'`s exceeds the maximum contiguous segment of `'0'`s. The comparison is strict (`>`), so equal lengths return `False`.

### Flow

The function walks the string character by character, maintaining three pieces of state:

1. **`cur`** — length of the current contiguous run
2. **`prev`** — the character of the current run (starts as `""`, so the first character always triggers a reset)
3. **`max_ones` / `max_zeros`** — best run lengths seen so far for each digit

On each character:
- If it matches `prev`, extend the run (`cur += 1`)
- Otherwise, start a new run (`cur = 1`, update `prev`)
- Then update the appropriate max based on whether the character is `'1'` or `'0'`

This is a single-pass O(n) time, O(1) space algorithm. No intermediate data structures are allocated.

### Patterns

- **Single-pass run-length encoding** — a standard idiom for contiguous-segment problems. Rather than materializing the groups (e.g., via `itertools.groupby`), it tracks run length inline, which is both simpler and avoids allocation.
- **Sentinel initialization** — `prev = ""` guarantees the first character always enters the `else` branch, correctly initializing `cur = 1` without a special case outside the loop.

### Dependencies

**Imports:** None. Pure Python, no standard library usage.

**Imported by:** The `test_solution.py` in its own directory. The massive "Imported By" list in the prompt is an artifact of the test harness — those are unrelated test files that share a common test runner infrastructure, not actual consumers of `checkZeroOnes`.

### Invariants

- `s` is assumed to be non-empty and consist only of `'0'` and `'1'` characters (per the LeetCode constraint). No validation is performed.
- After the loop, `max_ones` and `max_zeros` reflect the true maximums. If `s` is empty, both remain `0` and the function returns `False` — which is a reasonable degenerate case, though the problem guarantees `len(s) >= 1`.
- The update to `max_ones`/`max_zeros` happens on every iteration (not just at run boundaries), so the final run is always captured without a post-loop fixup.

### Error Handling

None. The function trusts its input per the LeetCode contract. Passing non-binary characters would silently be counted toward `max_zeros` (since they aren't `"1"`).

---

## Topics to Explore

- [file] `longer-contiguous-segments-of-ones-than-zeros/test_solution.py` — See what edge cases the test suite covers (single-char strings, equal-length runs, all-ones/all-zeros)
- [function] `consecutive-characters/solution.py:maxPower` — Same single-pass run-length pattern applied to finding the longest run of any single character
- [function] `max-consecutive-ones/solution.py:findMaxConsecutiveOnes` — Simpler variant that only tracks runs of `1`s, good comparison for understanding the dual-tracking here
- [file] `check-if-binary-string-has-at-most-one-segment-of-ones/solution.py` — Related binary string problem with a different structural question about runs
- [general] `run-length-single-pass-idiom` — The pattern of tracking `prev`/`cur` to avoid `groupby` appears across many solutions in this repo

## Beliefs

- `single-pass-dual-max-tracking` — `checkZeroOnes` computes both `max_ones` and `max_zeros` in a single O(n) pass with O(1) space, updating the relevant max on every character rather than only at run boundaries
- `sentinel-prev-initialization` — Initializing `prev = ""` ensures the first character always starts a fresh run without requiring a conditional before the loop
- `no-post-loop-fixup-needed` — Because the max update happens inside the loop (not only at run transitions), the final run's length is always reflected in the result without a trailing adjustment
- `non-binary-input-silent-miscount` — Characters other than `"1"` are silently counted toward `max_zeros`, since the only branch check is `c == "1"`

