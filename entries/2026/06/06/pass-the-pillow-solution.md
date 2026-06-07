# File: pass-the-pillow/solution.py

**Date:** 2026-06-06
**Time:** 18:30

## `pass-the-pillow/solution.py`

### Purpose

This file solves [LeetCode 2582 — Pass the Pillow](https://leetcode.com/problems/pass-the-pillow/). It computes which person holds a pillow after `time` seconds, given `n` people standing in a line. The pillow starts at person 1, moves forward to person `n`, then reverses back to person 1, repeating indefinitely.

### Key Components

**`pillowHolder(n, time) -> int`** — The sole function. Takes the line length and elapsed time, returns the 1-indexed position of the holder.

The core insight: the pillow traverses `n - 1` steps per pass (forward or backward). Instead of simulating each second, it uses modular arithmetic to skip full passes and compute the final position from the remainder.

### Flow

1. **`cycle = n - 1`** — One full pass (person 1 → person n, or n → 1) takes exactly `n - 1` seconds.
2. **`full_passes = time // cycle`** — How many complete passes have finished.
3. **`remainder = time % cycle`** — Seconds into the current (incomplete) pass.
4. **Parity check on `full_passes`** — Even means the pillow is moving forward (1 → n), so position is `1 + remainder`. Odd means moving backward (n → 1), so position is `n - remainder`.

### Patterns

**Modular arithmetic reduction** — This is the standard approach for cyclic/bouncing problems. Rather than simulating O(time) steps, it reduces to O(1) by exploiting the periodic structure. The period is `2 * (n - 1)` for a full round-trip, but the solution cleverly splits this into half-periods and uses parity to determine direction.

### Dependencies

**Imports**: None. Pure function with no external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files from *other* problems that happen to share a common test harness pattern (likely `from solution import *`). The actual consumer is `pass-the-pillow/test_solution.py`.

### Invariants

- `n >= 2` (implied by the problem constraints; with `n = 1` the pillow never moves, and `cycle` would be 0, causing a `ZeroDivisionError`)
- `time >= 0`
- Return value is always in `[1, n]`

### Error Handling

None. The function trusts its caller to provide valid inputs per LeetCode constraints. Passing `n = 1` triggers a division-by-zero; there's no guard against it (nor should there be for a LeetCode solution).

## Topics to Explore

- [file] `pass-the-pillow/test_solution.py` — Verify which edge cases are covered (n=2, time=0, time exactly on a boundary)
- [file] `pass-the-pillow/plan.md` — See the problem-solving approach and whether alternative solutions (simulation, mod 2*(n-1)) were considered
- [general] `bouncing-sequence-pattern` — This forward-then-reverse pattern appears in other LeetCode problems (e.g., ZigZag conversion, string compression); worth comparing approaches
- [function] `defuse-the-bomb/solution.py:decrypt` — Another cyclic-array problem in this repo that likely uses modular arithmetic differently

## Beliefs

- `pillow-holder-o1-time` — `pillowHolder` runs in O(1) time and space regardless of the `time` input, using division and modulo instead of simulation
- `pillow-holder-parity-direction` — Even `full_passes` means forward direction (returns `1 + remainder`), odd means backward (returns `n - remainder`)
- `pillow-holder-n1-crash` — Calling `pillowHolder(1, t)` for any `t > 0` raises `ZeroDivisionError` because `cycle` is 0
- `pillow-holder-zero-indexed-cycle` — The cycle length is `n - 1` (not `n`), representing the number of hand-offs per pass, not the number of people

