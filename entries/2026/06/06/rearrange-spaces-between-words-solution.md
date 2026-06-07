# File: rearrange-spaces-between-words/solution.py

**Date:** 2026-06-06
**Time:** 18:40

## `rearrange-spaces-between-words/solution.py`

### Purpose

This file solves [LeetCode 1592: Rearrange Spaces Between Words](https://leetcode.com/problems/rearrange-spaces-between-words/). Given a string with words separated by (possibly irregular) spaces, redistribute all spaces **evenly** between words, with any remainder appended to the end.

### Key Components

**`reorderSpaces(text: str) -> str`** — The sole function. Contract:

- **Input**: A string containing lowercase letters and spaces. Leading/trailing/multiple consecutive spaces are all valid.
- **Output**: The same words in the same order, with spaces redistributed evenly between adjacent words. Any leftover spaces (when total spaces don't divide evenly by `len(words) - 1`) are appended after the last word.

### Flow

1. **Count total spaces** — `text.count(' ')` counts every space in the original string, regardless of position.
2. **Extract words** — `text.split()` splits on any whitespace and discards empties, so `"  hello   world  "` yields `["hello", "world"]`.
3. **Single-word edge case** — If only one word exists, there are zero gaps between words. All spaces go after the word: `words[0] + ' ' * total_spaces`.
4. **Even distribution** — `divmod(total_spaces, len(words) - 1)` computes `between` (spaces per gap) and `extra` (leftover spaces for the end).
5. **Reassemble** — Join words with `between` spaces, append `extra` spaces.

### Patterns

- **`divmod` for quotient+remainder** — A Python idiom that avoids two separate `//` and `%` operations. Clean for distribution problems where you need both the "per-item share" and the "leftover".
- **`str.split()` without arguments** — Splits on all whitespace runs and strips leading/trailing whitespace. This is the right tool here because it extracts words regardless of how the original spacing was arranged.

### Dependencies

- **Imports**: None — pure stdlib string operations.
- **Imported by**: `rearrange-spaces-between-words/test_solution.py` (directly). The large "Imported By" list in the prompt is noise from the test harness — those test files share a common test runner import pattern, not a direct dependency on this solution.

### Invariants

- The total number of space characters in the output always equals `total_spaces` from the input. No spaces are created or destroyed.
- Word order is preserved — `split()` maintains left-to-right order.
- When `len(words) == 1`, all spaces trail the single word (the problem guarantees at least one word).

### Error Handling

None. The function assumes valid input per the LeetCode contract (non-empty string with at least one word). No explicit validation, no exceptions raised. An empty string would cause `words[0]` to raise `IndexError` — but that's outside the problem's input constraints.

---

## Topics to Explore

- [file] `rearrange-spaces-between-words/test_solution.py` — See the edge cases tested: single word, all spaces, leading/trailing spaces
- [file] `rearrange-spaces-between-words/plan.md` — Check if the plan discusses alternative approaches (e.g., regex-based extraction)
- [general] `divmod-in-distribution-problems` — `divmod` appears across many LeetCode solutions that distribute items evenly (e.g., `distribute-candies-to-people`, `arranging-coins`)
- [function] `rearrange-characters-to-make-target-string/solution.py:rearrangeCharacters` — A related string rearrangement problem that uses character frequency counting instead of space redistribution

---

## Beliefs

- `rearrange-spaces-preserves-space-count` — The output always contains exactly the same number of space characters as the input.
- `rearrange-spaces-single-word-trailing` — When the input contains exactly one word, all spaces are placed after that word (not before).
- `rearrange-spaces-no-imports` — The solution uses only Python builtins (`str.count`, `str.split`, `divmod`, `str.join`) with zero imports.
- `rearrange-spaces-word-order-preserved` — Words appear in the output in the same left-to-right order as the input; only spacing changes.

