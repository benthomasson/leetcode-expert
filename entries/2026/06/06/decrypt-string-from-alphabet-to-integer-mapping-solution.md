# File: decrypt-string-from-alphabet-to-integer-mapping/solution.py

**Date:** 2026-06-06
**Time:** 16:12

## Decrypt String from Alphabet to Integer Mapping

### Purpose

This file implements LeetCode problem #1309 — decoding a numeric string where digits `1`–`9` map to letters `a`–`i`, and two-digit sequences `10#`–`26#` map to `j`–`z`. It's a self-contained solution + test module following the repo's standard layout.

### Key Components

**`Solution.sortItems(self, s: str) -> str`** — Misleadingly named (should be `freqAlphabets` per the LeetCode problem). Walks the string left-to-right, consuming either 3 characters (when a `#` follows at position `i+2`) or 1 character, converting each numeric token to its corresponding letter via `chr(ord("a") + num - 1)`.

**`TestSolution`** — Eight test cases covering single digits, double digits with `#`, mixed sequences, boundary between 9/10, and the full a–z alphabet.

### Patterns

- **Greedy lookahead**: The `while` loop peeks two positions ahead (`s[i + 2] == "#"`) to decide whether to consume a 2-digit-plus-hash token or a single digit. The lookahead is guarded by a bounds check (`i + 2 < len(s)`), so it never overruns.
- **Character arithmetic**: `chr(ord("a") + num - 1)` converts 1-based numeric values to lowercase letters — standard for alphabet-mapping problems.
- **Combined solution + test file**: The repo convention puts `Solution` and `TestSolution` in the same `solution.py`, runnable via `unittest.main()`.

### Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo. The actual consumer is `decrypt-string-from-alphabet-to-integer-mapping/test_solution.py`, which imports `Solution` from this module.

### Flow

1. Initialize an empty `result` list and index `i = 0`.
2. At each position, check if `s[i+2]` exists and equals `"#"`.
   - **Yes**: parse `s[i:i+2]` as a two-digit integer (10–26), advance `i` by 3.
   - **No**: parse `s[i]` as a single-digit integer (1–9), advance `i` by 1.
3. Convert the integer to a letter and append to `result`.
4. Join and return.

### Invariants

- The input is assumed to be a valid encoded string: digits 1–9 standalone, digits 10–26 always followed by `#`. No validation is performed.
- The lookahead prioritizes the 3-character `##` token — this is correct because a `#` at position `i+2` unambiguously signals a double-digit encoding. Single digits can never be followed by `#` in a valid input.
- `num` is always in `[1, 26]` for valid inputs, so the output is always lowercase `a`–`z`.

### Error Handling

None. Invalid inputs (non-digit characters, out-of-range numbers, malformed `#` placement) will either raise `ValueError` from `int()` or produce garbage output silently. This is typical for LeetCode solutions where inputs are guaranteed valid.

### Notable Issue

The method is named `sortItems`, which is the name for LeetCode #1203 (Sort Items by Groups Respecting Dependencies). The correct LeetCode method name for problem #1309 is `freqAlphabets`. This won't affect functionality but makes the code confusing to navigate.

## Topics to Explore

- [file] `decrypt-string-from-alphabet-to-integer-mapping/test_solution.py` — Separate test file that imports this Solution; check if it duplicates or extends the inline tests
- [file] `decrypt-string-from-alphabet-to-integer-mapping/review.md` — Code review notes that may flag the method naming issue
- [general] `greedy-lookahead-parsing` — Compare with `1-bit-and-2-bit-characters/solution.py` which uses the same peek-ahead-to-decide-token-width pattern
- [function] `decode-the-message/solution.py:Solution` — Another alphabet-mapping problem; compare the character arithmetic approach

## Beliefs

- `decrypt-method-misnamed` — `Solution.sortItems` should be named `freqAlphabets`; the current name belongs to LeetCode #1203, not #1309
- `hash-lookahead-greedy-correct` — The 3-char token (`XX#`) is always checked before the 1-char token, which is the only correct parse order for this encoding
- `no-input-validation` — The solution assumes all inputs are valid encoded strings and will raise `ValueError` or produce wrong output on malformed input
- `chr-arithmetic-maps-1-to-a` — `chr(ord("a") + num - 1)` maps integer 1 to `'a'` and integer 26 to `'z'`, covering the full lowercase alphabet

