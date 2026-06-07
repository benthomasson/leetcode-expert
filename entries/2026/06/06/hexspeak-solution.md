# File: hexspeak/solution.py

**Date:** 2026-06-06
**Time:** 17:00

## `hexspeak/solution.py`

### Purpose

This file implements [LeetCode 1271 - Hexspeak](https://leetcode.com/problems/hexspeak/). It converts a decimal number (given as a string) into a "Hexspeak" representation where hex digits `0` and `1` are replaced with letters `O` and `I`, and the result is valid only if every character is one of `{A, B, C, D, E, F, I, O}`. The file owns both the solution and its unit tests — a self-contained module following the repo's per-problem convention.

### Key Components

**`to_hexspeak(num: str) -> str`** — The sole function. Takes a decimal integer as a string, returns either a valid Hexspeak string or `"ERROR"`.

The contract:
- Input: a string representing a non-negative decimal integer (no validation on this — trusts the caller).
- Output: uppercase Hexspeak string if every hex digit is in `{0, 1, A-F}`, otherwise `"ERROR"`.

**`TestToHexspeak`** — 11 test cases covering the examples from the problem, edge cases (single digits, large values, all-letter hex like `DEADBEEF`), and invalid-digit rejection.

### Patterns

**Three-step pipeline idiom**: The function is a clean transform chain — convert to hex, substitute characters, validate. No branching in the transform phase; the only conditional is the final validity gate. This is idiomatic for problems where the core logic is "transform then validate."

**Inline tests**: The `unittest` class lives in the same file as the solution, following the repo-wide convention of `solution.py` containing both implementation and tests (though some problems split tests into `test_solution.py`).

### Dependencies

**Imports**: Only `unittest` from the standard library. No external dependencies. The hex conversion uses Python's built-in `hex()`.

**Imported by**: The massive `imported_by` list is misleading — those are test files across the entire repo. They likely share a common test runner infrastructure, not a direct import of `to_hexspeak`. The function itself has no downstream consumers.

### Flow

```
"257" → int("257") = 257
      → hex(257) = "0x101"
      → [2:] = "101"
      → .upper() = "101"
      → .replace("0","O").replace("1","I") = "IOI"
      → all chars in {A,B,C,D,E,F,I,O}? → yes → "IOI"
```

The `.upper()` call is necessary because `hex()` returns lowercase hex letters (`a`-`f`), but Hexspeak requires uppercase.

The two `.replace()` calls are order-independent here — `"0"` and `"1"` don't overlap with each other or with `"O"`/`"I"` in the input (hex output only contains `0-9a-f`).

### Invariants

- The function assumes `num` is a valid non-negative decimal integer string. No guard against negative numbers or non-numeric input.
- The valid character set `{"A","B","C","D","E","F","I","O"}` is exactly the six hex letter-digits plus the two substituted characters. Any remaining numeric digit (2-9) causes `"ERROR"`.
- The `hex()` prefix `"0x"` is always stripped via `[2:]`. This is safe because Python's `hex()` always produces that prefix for non-negative integers.

### Error Handling

The only "error" path is returning the string `"ERROR"` — this is the problem's specified output, not an exception. No exceptions are caught or raised. Invalid input (non-numeric string) would propagate a `ValueError` from `int(num)` uncaught, which is acceptable since LeetCode guarantees valid input.

## Topics to Explore

- [file] `hexspeak/test_solution.py` — The separate test file may contain additional or different test cases beyond the inline ones
- [function] `convert-a-number-to-hexadecimal/solution.py:toHex` — Related problem that also uses hex conversion but with different constraints (handles negative numbers via two's complement)
- [file] `confusing-number/solution.py` — Similar digit-mapping pattern where specific digits are replaced and validity is checked
- [general] `hexspeak-valid-charset` — The set `{A,B,C,D,E,F,I,O}` is the crux — understanding why exactly these 8 characters are valid ties back to the problem's definition of "speakable" hex

## Beliefs

- `hexspeak-replace-order-independent` — The two `.replace()` calls on lines produce the same result regardless of order, because hex output contains no `O` or `I` characters before substitution
- `hexspeak-no-negative-handling` — `to_hexspeak` does not handle negative integers; `hex()` on a negative int produces `"-0x..."` which would break the `[2:]` slicing (keeping the `x`)
- `hexspeak-valid-set-complete` — The valid set `{A,B,C,D,E,F,I,O}` is exactly the hex letter digits `A-F` plus the substitutions for `0→O` and `1→I`; digits `2-9` are the only rejection trigger
- `hexspeak-string-input-contract` — The function takes `num` as a string (not int) matching the LeetCode signature, converting internally via `int(num)`

