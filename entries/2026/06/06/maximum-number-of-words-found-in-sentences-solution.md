# File: maximum-number-of-words-found-in-sentences/solution.py

**Date:** 2026-06-06
**Time:** 17:40

## `maximum-number-of-words-found-in-sentences/solution.py`

### Purpose

Solves [LeetCode 2114 — Maximum Number of Words Found in Sentences](https://leetcode.com/problems/maximum-number-of-words-found-in-sentences/). Given a list of sentences, return the maximum word count across all of them. This file owns the algorithm implementation; test coverage lives in the sibling `test_solution.py`.

### Key Components

**`Solution.mostWordsFound(self, sentences: List[str]) -> int`** — the single method. Its contract:

- **Input**: a non-empty list of strings, each containing space-separated words (per LeetCode constraints: `1 <= sentences.length <= 100`, each sentence has at least one word).
- **Output**: an integer — the highest word count among all sentences.
- **Mechanism**: `str.split()` (no delimiter argument) splits on any whitespace and discards leading/trailing/consecutive spaces, then `len()` counts the resulting tokens. `max()` over a generator expression selects the largest.

### Patterns

- **Single-expression solution**: the entire algorithm is one `return` statement using a generator expression inside `max()`. This is idiomatic Python for reduce-over-map operations and avoids intermediate list allocation.
- **LeetCode class convention**: wraps the function in a `Solution` class with no state — standard for LeetCode's judge interface.

### Dependencies

- **Imports**: `List` from `typing` — used only for the type annotation. At runtime this has no effect; it's a static-analysis aid.
- **Imported by**: the sibling `test_solution.py` imports `Solution` to run assertions. The "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share the same `from solution import Solution` pattern, not actual consumers of this specific file.

### Flow

1. The generator `(len(s.split()) for s in sentences)` lazily yields one integer per sentence.
2. `max()` consumes the generator, tracking the running maximum. Total iteration: one pass, O(n) in the number of sentences, O(m) per sentence where m is character count.
3. The result is returned directly — no mutation, no side effects.

### Invariants

- Relies on LeetCode's guarantee that `sentences` is non-empty. If called with an empty list, `max()` raises `ValueError: max() of an empty sequence`.
- `str.split()` with no arguments handles multiple spaces, tabs, and leading/trailing whitespace gracefully — but the problem guarantees single-space separation and no leading/trailing spaces.

### Error Handling

None. The function trusts its caller to provide valid input per the problem constraints. No try/except, no input validation. This is appropriate for a LeetCode solution where the judge enforces preconditions.

---

## Topics to Explore

- [file] `maximum-number-of-words-found-in-sentences/test_solution.py` — See what edge cases the test suite covers (single sentence, tied counts, single-word sentences)
- [file] `maximum-number-of-words-found-in-sentences/review.md` — Read the code review for quality notes and alternative approaches
- [function] `richest-customer-wealth/solution.py:maximumWealth` — Structurally identical pattern (max-of-sum over nested structure), good comparison
- [general] `generator-vs-list-comprehension` — Why a generator expression inside `max()` is preferred over building a full list first

## Beliefs

- `mostWordsFound-uses-split-no-args` — `str.split()` is called without a delimiter, so it splits on any whitespace and strips leading/trailing spaces, not just single space characters
- `mostWordsFound-single-pass` — The generator-based implementation iterates through sentences exactly once with O(1) auxiliary space (beyond the split of each individual sentence)
- `mostWordsFound-empty-list-raises` — Passing an empty `sentences` list raises `ValueError` from `max()` because no fallback default is provided
- `solution-is-stateless` — The `Solution` class holds no instance state; `mostWordsFound` is a pure function that could equivalently be a standalone function

