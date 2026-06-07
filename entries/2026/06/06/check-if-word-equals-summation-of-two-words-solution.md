# File: check-if-word-equals-summation-of-two-words/solution.py

**Date:** 2026-06-06
**Time:** 15:44

## `check-if-word-equals-summation-of-two-words/solution.py`

### Purpose

This file solves [LeetCode 1880](https://leetcode.com/problems/check-if-word-equals-summation-of-two-words/). It contains both the solution and its tests in a single module. The problem defines a letter-to-digit mapping where `'a'=0, 'b'=1, ..., 'j'=9`, converts each word into a number by concatenating those digits, and checks whether `firstWord + secondWord == targetWord` under that encoding.

### Key Components

**`Solution.isSumEqual`** — The sole public method. Takes three strings restricted to `'a'`–`'j'` and returns a boolean.

**`word_to_num`** (nested closure) — Converts a word to its numeric value. For each character, it computes `ord(c) - ord('a')` to get a digit 0–9, joins the digit strings, then parses the result as an integer. For example, `"acb"` → `"021"` → `21`.

**`TestSolution`** — Seven test cases covering the LeetCode examples, single-character inputs, boundary values (`'a'` = 0, `'j'` = 9), and an all-zeros case.

### Patterns

- **Nested helper function**: `word_to_num` is defined inside `isSumEqual` rather than as a method or module-level function. This scopes the utility to the only place it's used.
- **String-concatenation numeric conversion**: Instead of computing `digit * 10^position` arithmetically, the code builds a digit string and calls `int()`. This is idiomatic Python for multi-digit construction and avoids manual place-value math.
- **Self-contained module**: Solution + tests colocated in one file, consistent with every other problem directory in this repo.

### Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The `test_solution.py` in this same directory imports from this file. The massive "Imported By" list in the prompt is misleading — those are other problems' test files importing `unittest`, not this module. The actual dependency graph for this file is trivial.

### Flow

1. `isSumEqual` is called with three strings.
2. Each string passes through `word_to_num`: character → `ord` delta → string digit → join → `int()`.
3. The two numeric results are summed and compared to the third via `==`.
4. A single boolean is returned.

There are no loops beyond the generator expressions inside `word_to_num`. The entire computation is O(n) in total characters across all three words.

### Invariants

- **Input alphabet**: The code assumes characters are in `'a'`–`'j'`. Characters outside this range would produce multi-digit values per character (e.g., `'k'` → `10`), which still works numerically but changes the semantics — `"ka"` would become `"100"` (100), not a two-digit number. This matches the LeetCode constraint that inputs are restricted to `'a'`–`'j'`.
- **Leading zeros are harmless**: `int("021")` → `21` in Python. The word `"aab"` maps to `"001"` → `1`, which is correct per the problem definition.

### Error Handling

None. The function trusts its inputs per the LeetCode contract. Empty strings would produce `int("")` which raises `ValueError`, but the problem guarantees `1 <= len(word) <= 8`.

---

## Topics to Explore

- [file] `check-if-word-equals-summation-of-two-words/test_solution.py` — See how the test module imports and invokes the solution separately from the inline tests
- [function] `check-if-word-equals-summation-of-two-words/solution.py:word_to_num` — Consider the alternative arithmetic approach (`reduce` with `acc * 10 + digit`) and when string-join-then-parse is preferable
- [general] `ord-based-letter-mapping` — This `ord(c) - ord('a')` pattern recurs across many problems in this repo (e.g., `decode-the-message`, `replace-all-digits-with-characters`); understanding it once covers dozens of solutions
- [file] `add-strings/solution.py` — A related problem that also converts between string and numeric representations but handles arbitrary-length addition without `int()`

## Beliefs

- `word-to-num-uses-string-concat` — `word_to_num` builds a digit string via `join` + `str()` and parses with `int()`, rather than computing the number arithmetically with place values
- `ord-offset-maps-a-through-j-to-0-through-9` — The mapping `ord(c) - ord('a')` produces single-digit values (0–9) only when the input character is in `'a'`–`'j'`
- `leading-zero-safety` — Python's `int()` on strings with leading zeros (e.g., `"001"`) silently drops them, making the conversion correct without special-casing
- `no-input-validation` — The function performs no bounds checking on input characters or string length, relying entirely on LeetCode's problem constraints

