# File: binary-watch/solution.py

**Date:** 2026-06-06
**Time:** 15:27

## `binary-watch/solution.py`

### Purpose

This file solves [LeetCode 401 — Binary Watch](https://leetcode.com/problems/binary-watch/). A binary watch has 4 LEDs for hours (0–11) and 6 LEDs for minutes (0–59). Given a number of lit LEDs, return all valid times the watch could display. It's the single source of the `readBinaryWatch` function for this problem directory.

### Key Components

**`readBinaryWatch(turnedOn: int) -> list[str]`** — The only public function. Takes the count of lit LEDs and returns all valid time strings in `"h:mm"` format (no leading zero on hours, zero-padded minutes).

### Patterns

**Brute-force enumeration with bit-counting filter.** Rather than generating combinations of LED positions across hour/minute partitions, the solution iterates every possible `(h, m)` pair and keeps only those whose total popcount matches `turnedOn`. This is the canonical "count bits" approach for this problem — simple, correct, and fast enough given the tiny search space (12 × 60 = 720 candidates).

The entire function is a single list comprehension — no intermediate state, no mutation.

### Dependencies

**Imports:** None. Uses only builtins (`bin`, `range`, f-strings).

**Imported by:** `binary-watch/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are all test files for *other* problems; they don't actually import this module. Only `binary-watch/test_solution.py` exercises this code.

### Flow

1. Outer loop: `h` iterates 0–11 (valid hours).
2. Inner loop: `m` iterates 0–59 (valid minutes).
3. Filter: `bin(h).count("1") + bin(m).count("1") == turnedOn` — counts set bits in both values, keeps the pair only if the total equals the input.
4. Format: `f"{h}:{m:02d}"` — hour with no padding, minute zero-padded to 2 digits.

The result order is deterministic: hours ascending, minutes ascending within each hour (Python's `range` guarantees this).

### Invariants

- Hours are always in [0, 11], minutes in [0, 59] — enforced by the `range` bounds, not by explicit validation.
- Output format is always `"h:mm"` — the f-string's `:02d` ensures two-digit minutes; hours are naturally unpadded.
- The function never raises for any `turnedOn` value — if `turnedOn` exceeds the maximum possible set bits (10), the comprehension simply yields an empty list.

### Error Handling

None. Invalid inputs (negative values, values > 10) silently return an empty list because no `(h, m)` pair can satisfy the bit-count condition. This matches LeetCode's constraint that `0 <= turnedOn <= 10`.

---

## Topics to Explore

- [file] `binary-watch/test_solution.py` — See which edge cases are tested (turnedOn=0, turnedOn=10, etc.)
- [file] `binary-watch/review.md` — Read the code review for alternative approaches and complexity analysis
- [general] `bit-counting-approaches` — Compare `bin(x).count("1")` vs `x.bit_count()` (Python 3.10+) vs Kernighan's algorithm for popcount
- [function] `counting-bits/solution.py:countBits` — Related problem that precomputes bit counts for a range, contrast with the inline approach here
- [file] `binary-watch/plan.md` — Understand what alternatives were considered before choosing brute-force enumeration

## Beliefs

- `binary-watch-brute-force-720` — The solution evaluates exactly 720 candidate (h, m) pairs regardless of `turnedOn` value; there is no early termination or pruning.
- `binary-watch-output-order` — Results are ordered by hour ascending, then minute ascending within each hour, as a consequence of nested `range()` iteration.
- `binary-watch-no-validation` — The function performs no input validation; out-of-range `turnedOn` values produce an empty list rather than an error.
- `binary-watch-zero-imports` — The solution has no imports — it relies entirely on Python builtins (`bin`, `range`, `str.count`).

