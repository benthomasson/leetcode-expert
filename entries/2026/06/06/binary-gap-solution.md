# File: binary-gap/solution.py

**Date:** 2026-06-06
**Time:** 15:22

## `binary-gap/solution.py`

### Purpose

This file solves [LeetCode 868 — Binary Gap](https://leetcode.com/problems/binary-gap/). It finds the longest distance between any two adjacent `1` bits in the binary representation of a positive integer. It's a standalone solution module following the repo's convention of one problem per directory.

### Key Components

**`binary_gap(n: int) -> int`** — the sole exported function. Contract:
- Input: positive integer `n` where `1 <= n <= 10^9`
- Output: the maximum gap (number of bit positions) between consecutive `1` bits, or `0` if fewer than two `1` bits exist

Three local variables drive the logic:
- `max_gap`: running maximum distance seen so far
- `last_one`: bit position of the most recently seen `1` bit (`-1` as sentinel for "haven't seen one yet")
- `pos`: current bit position being examined (0-indexed from LSB)

### Patterns

**Bit-scanning via right-shift loop.** Rather than converting to a string with `bin()`, the code examines one bit at a time by masking with `& 1` and shifting `n >>= 1`. This is the idiomatic low-level approach — O(log n) iterations, no string allocation.

**Sentinel-based tracking.** `last_one = -1` distinguishes "no `1` seen yet" from "first `1` was at position 0." The `if last_one >= 0` guard ensures we only compute a gap after seeing at least two `1` bits.

### Dependencies

**Imports:** None — pure computation with no standard library or project imports.

**Imported by:** `binary-gap/test_solution.py` directly. The "Imported By" list in the prompt shows hundreds of test files, which is an artifact of the repo's shared test infrastructure — those files don't actually call `binary_gap`, they import the test runner or shared fixtures.

### Flow

1. Initialize `max_gap = 0`, `last_one = -1`, `pos = 0`.
2. Loop while `n > 0` (bits remain):
   - If the LSB is `1`: if we've seen a previous `1` (`last_one >= 0`), update `max_gap` with the distance `pos - last_one`. Then record this position as `last_one`.
   - Increment `pos`, right-shift `n` by one.
3. Return `max_gap`.

For `n = 22` (binary `10110`): positions of `1` bits are 1, 2, 4. Gaps are `2-1=1` and `4-2=2`. Returns `2`.

### Invariants

- **`last_one` is always the position of the most recent `1` bit, or `-1`.** This ensures gaps are measured between *adjacent* `1` bits, not between arbitrary ones.
- **The loop terminates.** `n >>= 1` on a positive integer guarantees `n` reaches `0`.
- **`max_gap` is non-negative.** Since `pos` strictly increases and `last_one` is always a previously visited `pos`, the difference is always positive.

### Error Handling

None. The function assumes valid input per the LeetCode constraint (`1 <= n <= 10^9`). Passing `0` would skip the loop entirely and return `0` — harmless but outside spec. Negative integers would loop indefinitely in CPython (arbitrary-precision integers never reach `0` via `>>= 1` when negative), but the docstring constrains the domain.

## Topics to Explore

- [file] `binary-gap/test_solution.py` — See what edge cases are covered (single bit, all bits set, power of two)
- [function] `hamming-distance/solution.py:hamming_distance` — Another bit-manipulation solution using XOR; compare the scanning pattern
- [file] `number-of-1-bits/solution.py` — Uses the same right-shift loop to count set bits rather than measure gaps
- [general] `bit-scan-vs-string-conversion` — Compare performance and readability of `n & 1` / `n >>= 1` loops vs. `bin(n)` string indexing across solutions in this repo
- [file] `binary-number-with-alternating-bits/solution.py` — Related bit-pattern analysis problem; likely uses similar scanning

## Beliefs

- `binary-gap-returns-zero-for-single-set-bit` — When `n` is a power of two (exactly one `1` bit), `binary_gap` returns `0` because `last_one >= 0` is true only once and no gap is ever computed.
- `binary-gap-measures-adjacent-ones-only` — The gap is always between consecutive `1` bits in the binary representation, not between the first and last; `last_one` is updated on every `1` bit encountered.
- `binary-gap-no-dependencies` — The module has zero imports; it uses only built-in integer operations.
- `binary-gap-negative-input-infinite-loop` — Passing a negative integer causes an infinite loop because Python's arbitrary-precision right-shift of a negative number never reaches `0`.

