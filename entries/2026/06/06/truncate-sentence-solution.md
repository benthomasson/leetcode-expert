# File: truncate-sentence/solution.py

**Date:** 2026-06-06
**Time:** 19:31



## `truncate-sentence/solution.py`

### Purpose

This file implements the solution to [LeetCode 1816 — Truncate Sentence](https://leetcode.com/problems/truncate-sentence/). It owns exactly one responsibility: given a sentence string and an integer `k`, return the first `k` words of that sentence as a single space-separated string.

### Key Components

**`Solution.truncateSentence(self, s: str, k: int) -> str`** — The sole method. It splits the input on whitespace, slices the first `k` elements, and joins them back with spaces.

The implementation is a single expression: `" ".join(s.split()[:k])`. No intermediate state, no mutation.

### Patterns

- **One-liner idiom**: The split-slice-join chain is the canonical Python pattern for "take first N words." It avoids manual index tracking or counting spaces.
- **LeetCode `Solution` class convention**: Every solution in this repo wraps its logic in a `Solution` class with a specifically-named method matching the LeetCode submission interface.

### Dependencies

**Imports**: None — uses only Python builtins (`str.split`, `str.join`, list slicing).

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files from *other* problems that happen to share a common test harness import pattern (likely importing `Solution` from their own `solution.py`). The actual consumer is `truncate-sentence/test_solution.py`.

### Flow

1. `s.split()` tokenizes the sentence on any whitespace, producing a `list[str]`.
2. `[:k]` slices the first `k` words. If `k >= len(words)`, it returns all words (no error).
3. `" ".join(...)` reassembles the words with single spaces.

The entire method is a pure function — no side effects, no state.

### Invariants

- The problem guarantees `s` contains only letters and spaces, with no leading/trailing spaces and no double spaces. Because of this, `s.split()` and `s.split(" ")` behave identically here — but `split()` (no argument) is the safer choice since it handles edge cases with multiple spaces gracefully.
- `1 <= k <= number of words in s` per the problem constraints, so the slice never produces an empty list.

### Error Handling

None. The method trusts its inputs per LeetCode's guarantees. If `k` exceeds the word count, Python's slice semantics silently return all available words — which is correct behavior, not a bug.

## Topics to Explore

- [file] `truncate-sentence/test_solution.py` — See how edge cases (k equals word count, single word) are tested
- [file] `truncate-sentence/plan.md` — The problem analysis and approach reasoning before implementation
- [file] `truncate-sentence/review.md` — Post-implementation review notes, likely covering complexity and alternatives
- [general] `split-vs-split-delimiter` — Why `s.split()` (no args) differs from `s.split(" ")` in handling consecutive whitespace, and which LeetCode problems expose that distinction

## Beliefs

- `truncate-sentence-pure-function` — `truncateSentence` is a pure function with no side effects, no instance state, and deterministic output for any given input
- `truncate-sentence-no-imports` — The solution uses zero imports; it relies entirely on Python builtin string and list operations
- `truncate-sentence-safe-overslice` — Passing `k` greater than the word count returns the full sentence without error, due to Python slice semantics
- `truncate-sentence-single-expression` — The entire solution body is a single return expression using the split-slice-join chain

