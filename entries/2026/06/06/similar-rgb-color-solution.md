# File: similar-rgb-color/solution.py

**Date:** 2026-06-06
**Time:** 19:07

## Purpose

This file solves [LeetCode 800 - Similar RGB Color](https://leetcode.com/problems/similar-rgb-color/). It finds the closest "shorthand" hex color (where each RGB component is a repeated digit like `#aabbcc`) to a given arbitrary hex color, minimizing the sum of squared differences across the three channels. It also contains its own inline unit tests.

## Key Components

### `Solution.similarRGB(color: str) -> str`

The public interface matching LeetCode's expected signature. Takes a 7-character hex string (`#RRGGBB`) and returns the nearest shorthand-representable color.

### `closest(comp: str) -> str` (nested helper)

The core math. Given a 2-character hex component (e.g. `"09"`), it finds the nearest value in the set `{0x00, 0x11, 0x22, ..., 0xff}` — the 16 values where both hex digits are identical.

The technique: shorthand values are all multiples of 17 (`0x11 = 17`). So `round(val / 17) * 17` snaps to the nearest one. The result is formatted back to a zero-padded 2-digit hex string.

## Patterns

**Independent channel decomposition.** The problem decomposes into three independent subproblems — one per color channel. The similarity metric (sum of squared differences) is separable, so minimizing each channel independently minimizes the total. This is why `closest` is applied to each channel slice independently rather than searching over all 4096 shorthand colors.

**Nested helper.** `closest` is defined inside `similarRGB` as a closure, which is a common pattern in LeetCode solutions to keep the helper tightly scoped. It doesn't actually capture any state from the enclosing scope, so it could be a static method, but the nesting keeps things compact.

**Inline tests.** Tests live in the same file as the solution rather than in a separate `test_solution.py`, though a separate test file also exists and imports from here.

## Dependencies

**Imports:** Only `unittest` from the standard library — no external dependencies.

**Imported by:** The separate `similar-rgb-color/test_solution.py` imports the `Solution` class. The massive "Imported By" list in the prompt is misleading — those are *all* test files across the repo, not files that specifically import this module. Only `similar-rgb-color/test_solution.py` actually imports from this file.

## Flow

1. Caller passes a string like `"#09f166"`.
2. `similarRGB` slices it into three 2-char components: `"09"`, `"f1"`, `"66"`.
3. Each component goes through `closest`:
   - Parse hex to int: `"09"` → `9`
   - Divide by 17 and round: `9 / 17 = 0.529` → `round(0.529) = 1`
   - Multiply back: `1 * 17 = 17` → `0x11`
   - Format: `"11"`
4. Concatenate with `"#"` prefix: `"#11ee66"`.

## Invariants

- **Input format:** Assumes a well-formed 7-character hex color string starting with `#`. No validation is performed — malformed input will produce wrong results or raise `ValueError` from `int(comp, 16)`.
- **Output is always shorthand-representable:** Every returned value has the form `#XXYYZZ` where each pair consists of identical digits, because every output component is a multiple of 17.
- **Rounding ties go up:** Python's `round()` uses banker's rounding (round half to even), but this only matters at the exact midpoint `8.5` (i.e., input value `144.5`), which can't occur since inputs are integers. So in practice, values ≤8 from a multiple of 17 round toward it, and values ≥9 from it round to the next.

## Error Handling

None. The function assumes valid input per LeetCode's constraints. An invalid hex string would propagate a `ValueError` from `int(comp, 16)`. A string too short would raise an `IndexError` from the slicing.

## Topics to Explore

- [file] `similar-rgb-color/plan.md` — The solution design rationale and approach discussion before implementation
- [file] `similar-rgb-color/review.md` — Post-implementation review notes on this solution
- [general] `shorthand-color-math` — Why dividing by 17 works: `0x11 * n` produces all shorthand values, making this a nearest-integer-on-a-grid problem
- [function] `similar-rgb-color/test_solution.py:TestSimilarRGB` — The external test file to see if it adds coverage beyond the inline tests
- [general] `banker-rounding-edge-cases` — Whether Python's round-half-to-even could ever affect correctness here (it can't, since hex components are integers and no integer divided by 17 is exactly `n + 0.5`)

## Beliefs

- `shorthand-values-are-multiples-of-17` — All shorthand hex components (`00`, `11`, `22`, ..., `ff`) are exactly the multiples of 17 from 0 to 255, which is why `round(val/17)*17` finds the nearest one.
- `channels-are-independent` — Each RGB channel is processed independently because the squared-difference similarity metric is separable across channels.
- `closest-returns-zero-padded-hex` — The `f"{nearest:02x}"` format ensures single-digit results like `0` produce `"00"` not `"0"`, preserving the 2-char-per-channel invariant.
- `no-input-validation` — The solution assumes LeetCode-guaranteed valid input; no guards exist for malformed hex strings or wrong-length inputs.
- `rounding-midpoint-unreachable` — Integer inputs to `closest` can never hit a `.5` fractional quotient when divided by 17, so Python's banker's rounding is irrelevant to correctness.

