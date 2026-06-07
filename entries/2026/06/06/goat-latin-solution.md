# File: goat-latin/solution.py

**Date:** 2026-06-06
**Time:** 16:56

## `goat-latin/solution.py`

### Purpose

This file is a self-contained LeetCode solution for [problem 824: Goat Latin](https://leetcode.com/problems/goat-latin/). It owns the transformation logic and its own test suite — the single function `to_goat_latin` is the entire public API.

### Key Components

**`to_goat_latin(sentence: str) -> str`** — Applies three rules to each word in the sentence:

1. If a word starts with a vowel (case-insensitive), append `"ma"`.
2. If it starts with a consonant, move the first character to the end, then append `"ma"`.
3. Append one `"a"` per the word's 1-based position index.

The vowel set is `"aeiouAEIOU"` — stored as a `set` for O(1) membership testing.

**`TestToGoatLatin`** — 8 unit tests covering both LeetCode examples, single-word inputs, single-character edge cases, and all-vowel-start sentences.

### Patterns

- **Single-file solution + tests**: Matches the repo convention — every problem directory has a `solution.py` with the function and inline `unittest` cases, plus a separate `test_solution.py` that imports from it.
- **Enumerate with start=1**: `enumerate(sentence.split(), 1)` gives a 1-based index directly, which maps cleanly to the "append i copies of 'a'" rule without an off-by-one adjustment.
- **String concatenation over join for small pieces**: Each word is built with `+` operators. Fine here — the pieces per word are constant (at most 4 concatenations).

### Dependencies

**Imports**: Only `unittest` from stdlib. No external or project-internal dependencies.

**Imported by**: The massive `imported_by` list is misleading — those are `test_solution.py` files across *other* problems that happen to share a test runner or import pattern. The real direct consumer is `goat-latin/test_solution.py`.

### Flow

1. Split `sentence` on whitespace into words.
2. For each word at 1-based index `i`:
   - Check if `word[0]` is in the vowel set.
   - If vowel: `word + "ma" + "a" * i`
   - If consonant: `word[1:] + word[0] + "ma" + "a" * i`
3. Join transformed words with spaces.

Data transformation: `str → list[str] → str`. Single pass, no intermediate data structures beyond the result list.

### Invariants

- **Non-empty words assumed**: `word[0]` is accessed without a guard. The problem guarantees the sentence contains only letters and spaces with no leading/trailing spaces and no double spaces, so this is safe within the problem's contract.
- **Case-preserving**: The first character of a consonant word is moved to the end without changing its case (`word[0]`, not `word[0].lower()`). This matches the problem spec.
- **Position is 1-based**: `enumerate(..., 1)` ensures the first word gets `"a"`, the second `"aa"`, etc.

### Error Handling

None. The function trusts its input matches the LeetCode constraints (non-empty sentence of English letters and single spaces). Passing an empty string would produce an empty string; passing a word with no characters would raise an `IndexError` on `word[0]`.

## Topics to Explore

- [file] `goat-latin/test_solution.py` — The external test file that imports `to_goat_latin`; likely has additional or differently structured test cases
- [file] `goat-latin/review.md` — Code review notes for this solution — may document alternative approaches or complexity analysis
- [function] `reverse-only-letters/solution.py:reverseOnlyLetters` — Another string-manipulation problem that uses a different traversal strategy (two pointers vs. linear scan)
- [general] `vowel-consonant-classification` — Several solutions in this repo deal with vowel detection (`reverse-vowels-of-a-string`, `count-vowel-substrings-of-a-string`); compare how the vowel set is defined and reused
- [file] `goat-latin/plan.md` — The planning doc for this solution; shows the problem decomposition approach before implementation

## Beliefs

- `goat-latin-vowel-check-is-case-insensitive` — The vowel set includes both upper and lowercase variants, so `word[0] in vowels` works regardless of the word's casing
- `goat-latin-index-is-1-based` — `enumerate(sentence.split(), 1)` produces 1-based indices, meaning the first word gets exactly one trailing `"a"`
- `goat-latin-consonant-rotation-preserves-case` — When moving a consonant to the end of a word, the original casing of that character is preserved (no `.lower()` or `.upper()` call)
- `goat-latin-assumes-nonempty-words` — The function accesses `word[0]` without a length check, relying on the LeetCode guarantee that the input contains no empty tokens

