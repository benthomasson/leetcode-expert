# File: valid-word-abbreviation/solution.py

**Date:** 2026-06-06
**Time:** 19:40

## Purpose

This file implements LeetCode problem **408 - Valid Word Abbreviation**. It determines whether a given abbreviation string is a valid representation of a word, where digits in the abbreviation represent the count of characters they replace. For example, `"i12iz4n"` is a valid abbreviation of `"internationalization"` because `i` + 12 skipped chars + `iz` + 4 skipped chars + `n` reconstructs the full word.

The file is self-contained: it defines the solution function and its unit tests in one module, following the repo-wide convention of colocating implementation and tests.

## Key Components

### `validWordAbbreviation(word, abbr) -> bool`

The sole public function. It walks both strings in lockstep using a two-pointer approach:

- **`i`**: current position in `word`
- **`j`**: current position in `abbr`

When `abbr[j]` is a letter, it must match `word[i]` exactly. When `abbr[j]` is a digit, the function parses the full multi-digit number and advances `i` by that amount (skipping that many characters in `word`).

The function returns `True` only when both pointers reach the end of their respective strings simultaneously.

### `TestValidWordAbbreviation`

16 test cases covering:
- Happy-path abbreviations (`"i12iz4n"`, full numeric `"12"`, identity `"word"`)
- Leading zero rejection (`"s010n"`, `"01"`, `"a0b"`)
- Length mismatches — abbreviation too short, too long, or number exceeding word length
- Single-character edge cases
- Multi-number abbreviations (`"sub4u4"`)

## Patterns

**Two-pointer string matching** — the canonical approach for this problem. One pointer per input string, advanced at different rates depending on whether the current abbreviation character is a letter or digit.

**Digit accumulation via Horner's method** — `num = num * 10 + int(abbr[j])` builds multi-digit numbers one character at a time without slicing or `int()` on a substring.

**Self-contained module** — solution + tests in one file, runnable via `python -m unittest` or `python solution.py`. This is the standard layout across the entire repo.

## Dependencies

**Imports**: Only `unittest` from the standard library. No external dependencies.

**Imported by**: The `test_solution.py` file in the same directory. The massive "Imported By" list in the prompt is misleading — those are other problems' test files that import `unittest`, not this module. Only `valid-word-abbreviation/test_solution.py` actually imports from this file.

## Flow

1. Initialize `i = 0` (word pointer), `j = 0` (abbr pointer).
2. Loop while both pointers are in bounds:
   - If `abbr[j]` is a digit:
     - Reject immediately if it's `'0'` (leading zero).
     - Parse the full number by consuming consecutive digits into `num`.
     - Advance `i` by `num` (skip that many word characters).
   - If `abbr[j]` is a letter:
     - Compare `word[i]` to `abbr[j]`. Mismatch → return `False`.
     - Advance both pointers by 1.
3. Return `i == len(word) and j == len(abbr)` — both must be fully consumed.

## Invariants

- **No leading zeros**: Any numeric segment starting with `'0'` is immediately rejected. This includes standalone `'0'` (which would mean "skip zero characters" — semantically meaningless and disallowed by the problem spec).
- **Exact consumption**: The abbreviation is valid only if it accounts for every character in `word` — no more, no less. The final `i == len(word) and j == len(abbr)` check enforces this.
- **Digits are never compared as letters**: The branching on `abbr[j].isdigit()` ensures digit characters are always consumed as part of a number, never matched against `word[i]`.

## Error Handling

There is none beyond returning `False` for invalid inputs. The function assumes both inputs are well-formed strings (lowercase letters for `word`, lowercase letters and digits for `abbr`). Out-of-bounds access is prevented by the loop guard `i < len(word) and j < len(abbr)`, and the digit-parsing inner loop checks `j < len(abbr)`.

## Topics to Explore

- [file] `valid-word-abbreviation/test_solution.py` — The separate test file that imports this solution; may contain additional test cases beyond the inline ones
- [file] `valid-word-abbreviation/plan.md` — The planning document for this solution, likely discusses alternative approaches (regex, recursion)
- [file] `valid-word-abbreviation/review.md` — Code review notes that may flag edge cases or complexity analysis
- [general] `two-pointer-string-problems` — Other solutions in this repo using the two-pointer pattern on strings (e.g., `backspace-string-compare`, `long-pressed-name`) for comparison
- [function] `valid-word-abbreviation/solution.py:validWordAbbreviation` — Trace through with `word="hi", abbr="2"` and `word="hi", abbr="3"` to see how the over-skip case is caught by the final equality check rather than an explicit bounds check

## Beliefs

- `leading-zero-rejection` — Any numeric segment in `abbr` starting with `'0'` causes immediate `False` return, including the standalone digit `0`
- `exact-consumption-invariant` — The function returns `True` only when both pointers `i` and `j` reach exactly the end of `word` and `abbr` respectively; partial consumption of either string is always `False`
- `no-bounds-violation-on-overshoot` — When a number in `abbr` exceeds the remaining length of `word`, `i` overshoots `len(word)` and the final `i == len(word)` check catches it without raising an `IndexError`
- `digit-accumulation-is-greedy` — Consecutive digits in `abbr` are always parsed as a single number (e.g., `"12"` means skip 12, not skip 1 then skip 2), which is enforced by the inner `while` loop consuming all adjacent digits

