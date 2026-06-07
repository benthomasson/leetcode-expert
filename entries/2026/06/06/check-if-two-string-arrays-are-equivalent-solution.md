# File: check-if-two-string-arrays-are-equivalent/solution.py

**Date:** 2026-06-06
**Time:** 15:44



## Purpose

This file solves [LeetCode 1662: Check If Two String Arrays Are Equivalent](https://leetcode.com/problems/check-if-two-string-arrays-are-equivalent/). It determines whether two arrays of strings represent the same string when their elements are concatenated in order.

The file owns a single responsibility: given `word1` and `word2` (both `List[str]`), return `True` if `"".join(word1) == "".join(word2)`.

## Key Components

### `Solution.arrayStringsAreEqual(word1, word2) -> bool`

The only method. It concatenates each list into a single string using `str.join`, then compares for equality. No intermediate state, no mutation.

**Contract:**
- **Input**: Two lists of strings. Per LeetCode constraints, `1 <= len(word1), len(word2) <= 1000` and `1 <= len(word1[i]), len(word2[i]) <= 1000`.
- **Output**: A boolean.
- **Side effects**: None.

## Patterns

**One-liner solution pattern** — common across this repo's easy-tier problems. The entire logic fits in a single `return` statement, and the docstring is longer than the implementation.

**LeetCode class convention** — wraps the solution in a `Solution` class with a specifically-named method (`arrayStringsAreEqual`), matching LeetCode's expected interface.

## Dependencies

**Imports**: `List` from `typing` — used only for the type annotation. In Python 3.9+ this could be `list[str]` directly, but the repo consistently uses the `typing` import for compatibility.

**Imported by**: The `check-if-two-string-arrays-are-equivalent/test_solution.py` file imports this `Solution` class. The massive "Imported By" list in the context is misleading — those are test files for *other* problems that happen to share a common test harness pattern, not actual consumers of this specific solution.

## Flow

1. `"".join(word1)` allocates a new string by concatenating all elements of `word1`.
2. `"".join(word2)` does the same for `word2`.
3. `==` compares the two strings character by character.
4. The boolean result is returned directly.

**Complexity**: O(n + m) time and space, where n and m are the total character counts across `word1` and `word2` respectively.

## Invariants

- The method is pure — same inputs always produce the same output, no state is mutated.
- The concatenation preserves element ordering. `["a", "bc"]` and `["ab", "c"]` both produce `"abc"` and compare as equal, which is exactly the problem's specification.

## Error Handling

None. The method trusts its inputs conform to the LeetCode contract. An empty list would produce `""`, which is valid behavior. Non-string elements would raise at `str.join`, but that's a caller violation, not something this code guards against.

## Topics to Explore

- [file] `check-if-two-string-arrays-are-equivalent/test_solution.py` — See how edge cases (single-element arrays, single-character strings, mismatched arrays) are tested
- [file] `check-if-two-string-arrays-are-equivalent/review.md` — The code review likely discusses whether the O(n) space from `join` matters versus a pointer-based O(1) space approach
- [general] `pointer-based-alternative` — An O(1) space solution uses four pointers (array index + char index for each word) to compare character-by-character without concatenation — worth understanding as the follow-up optimization
- [file] `check-if-string-is-a-prefix-of-array/solution.py` — A related problem that also deals with string array concatenation, but with a prefix check instead of full equality

## Beliefs

- `join-based-equality` — `arrayStringsAreEqual` always produces the same result as comparing the arrays element-by-element with character-level pointer tracking, but uses O(n+m) space instead of O(1)
- `no-mutation-invariant` — The method never modifies `word1` or `word2`; it is a pure function
- `typing-import-convention` — This repo uses `from typing import List` for type annotations rather than built-in `list[]` syntax, consistently across all solution files
- `single-method-per-solution` — Each solution file exposes exactly one `Solution` class with one public method matching the LeetCode interface

