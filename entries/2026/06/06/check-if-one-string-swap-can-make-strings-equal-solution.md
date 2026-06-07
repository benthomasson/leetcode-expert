# File: check-if-one-string-swap-can-make-strings-equal/solution.py

**Date:** 2026-06-06
**Time:** 15:42

## Purpose

This file implements [LeetCode 1790: Check if One String Swap Can Make Strings Equal](https://leetcode.com/problems/check-if-one-string-swap-can-make-strings-equal/). It owns the complete solution and its test suite in a single module — the standard structure across this repository where each problem directory contains `solution.py` with both implementation and unit tests.

## Key Components

### `are_almost_equal(s1: str, s2: str) -> bool`

The sole public function. Returns `True` if `s1` can be made equal to `s2` by performing **at most one** swap of two characters within **one** of the strings.

**Contract:**
- Inputs: two strings of equal length (guaranteed by the problem constraints)
- Output: boolean
- Pure function — no side effects or mutation

### `TestAreAlmostEqual`

Nine test cases covering:
- Already-equal strings (zero swaps needed)
- Exactly one swap needed (`"bank"` / `"kanb"`)
- Impossible cases (too many mismatches, wrong characters)
- Edge cases: single-character strings, exactly one mismatch position (can't fix with a swap), same-frequency characters with >2 diffs

## Flow

1. **Scan for mismatches**: Iterate through both strings index-by-index, collecting indices where `s1[i] != s2[i]` into `diffs`.

2. **Early exit**: If `len(diffs) > 2`, return `False` immediately — more than two mismatches means no single swap can fix it. This is an O(n) worst-case optimization that avoids scanning the rest of the string.

3. **Decision by mismatch count**:
   - **0 diffs**: strings are already equal — return `True`
   - **2 diffs**: check if swapping the two mismatched positions produces a match: `s1[i] == s2[j] and s1[j] == s2[i]`
   - **1 diff**: return `False` — a swap always affects two positions, so a single mismatch is unfixable

## Patterns

- **Collect-and-decide**: accumulate mismatch indices, then branch on count. This is the idiomatic approach for "at most K swaps" problems — avoids nested loops.
- **Early termination**: the `if len(diffs) > 2: return False` inside the loop short-circuits on strings with many mismatches, keeping the common rejection case fast.
- **Self-contained module**: solution + tests in one file, runnable via `python solution.py` or `unittest` discovery.

## Dependencies

**Imports**: only `unittest` from the standard library — no external dependencies.

**Imported by**: the `test_solution.py` in this same directory, plus the massive list of `test_solution.py` files across 400+ other problem directories. That "imported by" list is likely an artifact of the test harness or code-expert tooling rather than actual import relationships — those other test files wouldn't import this problem's solution.

## Invariants

- `len(diffs)` is always in `{0, 1, 2}` when the decision branches execute, because the loop exits early once it exceeds 2.
- The swap check (`s1[i] == s2[j] and s1[j] == s2[i]`) is symmetric — it doesn't matter which string the swap is performed on.
- The function assumes `len(s1) == len(s2)`. If violated, it would silently ignore trailing characters in the longer string (iterates over `range(len(s1))`).

## Error Handling

None — the function trusts its inputs per LeetCode conventions. No length validation, no type checking. An `IndexError` would surface naturally if `s2` were shorter than `s1`.

## Topics to Explore

- [file] `buddy-strings/solution.py` — Closely related problem: checks if swapping two characters in `s1` makes it equal to `s2`, but requires **exactly** one swap (already-equal strings need special handling with duplicate characters)
- [function] `check-if-one-string-swap-can-make-strings-equal/solution.py:are_almost_equal` — Compare the early-exit-at-2 strategy versus alternatives like collecting all diffs then checking length
- [file] `check-whether-two-strings-are-almost-equivalent/solution.py` — Different notion of "almost equivalent" (frequency-based rather than positional) — useful contrast
- [general] `single-swap-vs-k-swap-patterns` — How this collect-mismatch-indices pattern generalizes to K-swap and K-edit-distance problems

## Beliefs

- `swap-check-symmetry` — The cross-check `s1[i]==s2[j] and s1[j]==s2[i]` is equivalent regardless of which string the swap is applied to, so the function doesn't need to specify which string is swapped
- `early-exit-bounds-diffs` — The `len(diffs) > 2` guard inside the loop guarantees that `diffs` has at most 2 elements when the post-loop branches execute
- `one-mismatch-always-false` — Exactly one positional mismatch is never fixable by a single swap because a swap always changes two positions simultaneously
- `no-input-validation` — The function does not validate that `s1` and `s2` have equal length; it relies on the caller (LeetCode harness) to guarantee this precondition

