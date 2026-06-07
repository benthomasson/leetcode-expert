# File: reverse-words-in-a-string-iii/solution.py

**Date:** 2026-06-06
**Time:** 18:55

## Purpose

This file implements the solution for [LeetCode 557 — Reverse Words in a String III](https://leetcode.com/problems/reverse-words-in-a-string-iii/). It owns a single responsibility: given a sentence, reverse the characters within each word while keeping word order and spacing intact.

## Key Components

### `reverse_words_in_string(s: str) -> str`

The sole public function. Contract:

- **Input**: A string where words are separated by exactly one space (no leading/trailing spaces, per the LeetCode constraint).
- **Output**: A new string with every word's characters reversed, words rejoined by single spaces.
- **Pure function** — no mutation, no side effects.

## Patterns

**One-liner generator expression.** The entire solution chains three operations into a single `return` statement:

1. `s.split(" ")` — tokenize on literal space (not whitespace generally)
2. `word[::-1]` — reverse each token via Python's slice-step idiom
3. `" ".join(...)` — reassemble with single-space delimiter

This is a common pattern across the repo's easy-level solutions: a composable pipeline of built-in string/list operations, no intermediate variables.

**Explicit space delimiter.** `split(" ")` rather than `split()` is deliberate — `split()` without arguments would collapse multiple spaces and strip leading/trailing whitespace. Using `" "` preserves the structural assumption that the input has exactly single-space separators, which matches the LeetCode problem guarantee.

## Dependencies

**Imports**: None — pure stdlib, no external or internal imports.

**Imported by**: The "Imported By" list in the prompt is misleading — those ~400+ test files don't actually import *this* solution. They appear to be an artifact of the repo's test harness structure where each `test_solution.py` imports its sibling `solution.py` via a shared pattern. The real consumer is `reverse-words-in-a-string-iii/test_solution.py`.

## Flow

```
"Let's take LeetCode"
    → split(" ") → ["Let's", "take", "LeetCode"]
    → [::-1] each → ["s'teL", "ekat", "edoCteeL"]
    → join(" ")  → "s'teL ekat edoCteeL"
```

Single pass over the string (split) + one pass per word (reverse) + one pass to join. Effectively O(n) where n is total character count.

## Invariants

- Assumes single-space separation — no multi-space, tab, or newline handling.
- Assumes non-empty input (though an empty string would produce `""` correctly via `split`/`join` identity).
- Word order is preserved; only intra-word character order changes.

## Error Handling

None. The function trusts its input matches the LeetCode contract. No validation, no try/except. Passing `None` would raise `AttributeError`; passing non-string types would fail at `.split()`.

## Topics to Explore

- [file] `reverse-words-in-a-string-iii/test_solution.py` — See what edge cases the test suite covers (empty words, single character, punctuation)
- [file] `reverse-string-ii/solution.py` — Related problem with a different reversal rule (every 2k characters), shows how the pattern varies
- [file] `reverse-only-letters/solution.py` — Variant that reverses only alphabetic characters while keeping non-letters in place
- [general] `split-delimiter-semantics` — How `str.split(" ")` vs `str.split()` behave differently on edge-case inputs (multiple spaces, empty strings)

## Beliefs

- `reverse-words-iii-uses-explicit-space-split` — `split(" ")` is used instead of `split()`, preserving empty tokens if multiple spaces were present rather than collapsing them
- `reverse-words-iii-is-linear-time` — The solution runs in O(n) time and O(n) space where n is the length of the input string
- `reverse-words-iii-preserves-word-order` — Word positions are maintained; only character order within each word is reversed
- `reverse-words-iii-no-validation` — The function performs no input validation and will raise on non-string input

