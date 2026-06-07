# File: roman-to-integer/solution.py

**Date:** 2026-06-06
**Time:** 18:57

## `roman-to-integer/solution.py`

### Purpose

This file implements LeetCode problem #13 — Roman to Integer. It owns a single responsibility: converting a valid Roman numeral string (like `"MCMXCIV"`) into its integer equivalent (`1994`). It's a standalone solution module following the repo's convention of one problem per directory.

### Key Components

**`roman_to_int(s: str) -> int`** — The sole public function. Contract: given a string `s` containing only valid Roman numeral characters representing a value in [1, 3999], returns the corresponding integer.

**`values` dict** — Maps the seven Roman numeral symbols to their integer values. Defined locally inside the function (not module-level), so it's reconstructed on each call.

### Patterns

The solution uses the **subtraction-rule scan pattern**: iterate left to right, and at each position decide whether to add or subtract the current symbol's value based on a lookahead comparison with the next symbol.

This is the canonical single-pass approach for this problem. It exploits the fact that in valid Roman numerals, a smaller value preceding a larger value always means subtraction (e.g., `IV` = 4, `XC` = 90). In all other cases, values are additive.

The iteration uses index-based `range(len(s))` rather than `enumerate` or `zip` — slightly more verbose but makes the `i + 1` lookahead bounds check explicit.

### Dependencies

**Imports**: None. Pure Python, no standard library usage.

**Imported by**: The `roman-to-integer/test_solution.py` file directly. The massive "Imported By" list in the prompt is misleading — those are unrelated test files across the repo, likely an artifact of the analysis tool matching on a shared test runner or import pattern, not actual imports of this function.

### Flow

1. Build the `values` lookup table.
2. Initialize `result = 0`.
3. For each index `i` in the string:
   - **Lookahead**: if `i + 1` is in bounds and `values[s[i]] < values[s[i + 1]]`, this is a subtraction case (e.g., `I` before `V`). Subtract `values[s[i]]` from `result`.
   - **Otherwise**: add `values[s[i]]` to `result`.
4. Return `result`.

For input `"XIV"`:
- `i=0`: `X(10)` vs `I(1)` → 10 >= 1 → add 10. Result: 10
- `i=1`: `I(1)` vs `V(5)` → 1 < 5 → subtract 1. Result: 9
- `i=2`: `V(5)`, no next → add 5. Result: 14

### Invariants

- **Input validity assumed**: The function does not validate that `s` contains only valid Roman characters or represents a well-formed numeral. A `KeyError` would propagate on invalid characters.
- **Single-pass guarantee**: The string is traversed exactly once, O(n) time.
- **Constant space**: Only the fixed 7-entry dict and a running total.

### Error Handling

None. Invalid characters raise `KeyError` from the `values` dict lookup. Empty string input returns 0 (the loop body never executes). There's no explicit validation — the function trusts the caller to provide valid input per the LeetCode problem constraints.

## Topics to Explore

- [file] `roman-to-integer/test_solution.py` — See what edge cases the test suite covers (empty string, single characters, max value 3999)
- [file] `roman-to-integer/review.md` — The code review likely discusses alternative approaches and complexity analysis
- [file] `roman-to-integer/plan.md` — Design decisions made before implementation
- [general] `subtraction-rule-alternatives` — Compare this lookahead approach with the reverse-iteration variant (iterate right-to-left, track previous value) or the two-character prefix matching approach
- [function] `excel-sheet-column-number/solution.py:titleToNumber` — Similar positional-value accumulation pattern applied to base-26 conversion

## Beliefs

- `roman-subtraction-lookahead` — `roman_to_int` subtracts `values[s[i]]` if and only if `values[s[i]] < values[s[i+1]]`, which correctly handles all six Roman subtraction pairs (IV, IX, XL, XC, CD, CM)
- `roman-single-pass-linear` — The function performs exactly one pass over the input string with O(1) work per character, giving O(n) time and O(1) space
- `roman-no-input-validation` — The function assumes valid input; invalid characters will raise an unhandled `KeyError` from the `values` dict
- `roman-empty-returns-zero` — An empty string input returns 0 because the loop doesn't execute and `result` is initialized to 0

