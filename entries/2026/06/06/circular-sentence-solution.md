# File: circular-sentence/solution.py

**Date:** 2026-06-06
**Time:** 15:45

## `circular-sentence/solution.py`

### Purpose

Solves [LeetCode 2490 — Circular Sentence](https://leetcode.com/problems/circular-sentence/). A sentence is "circular" if the last character of every word matches the first character of the next word, wrapping around so the last word connects back to the first. This file owns that single check.

### Key Components

**`is_circular(sentence: str) -> bool`** — The sole function. Takes a space-separated sentence string and returns whether it satisfies the circular property. No class, no state, pure function.

### Patterns

The solution avoids splitting the string into words entirely. Instead, it exploits the structure of spaces as word boundaries:

1. **Wrap-around check** (line 12): `sentence[0] != sentence[-1]` — the first character of the first word must equal the last character of the last word. This is the circular "closing" condition.

2. **Adjacent-word check** (lines 13–15): For every space at index `i`, the character at `i-1` (end of the preceding word) must equal the character at `i+1` (start of the next word). This covers all consecutive word pairs in a single pass.

This is O(n) time, O(1) space — no allocations, no split, no list of words.

### Dependencies

**Imports:** None. Pure standard Python.

**Imported by:** `circular-sentence/test_solution.py` (its direct test file). The "Imported By" list in the prompt is misleading — that list appears to be the full test suite for the entire repo, not actual importers of this module.

### Flow

1. Early-exit if the first and last characters of the entire string differ.
2. Linear scan through every character. On encountering a space, compare the characters flanking it.
3. If any flanking pair mismatches, return `False`. If the loop completes, return `True`.

### Invariants

- **The sentence never starts or ends with a space.** The code indexes `sentence[i + 1]` when `ch == ' '` without bounds checking, and uses `sentence[i - 1]` which at `i=0` would wrap to `-1` (the last character). Both are safe only under LeetCode's stated constraint that the sentence is well-formed (no leading/trailing spaces, single spaces between words).
- **The sentence is non-empty.** `sentence[0]` and `sentence[-1]` would throw `IndexError` on an empty string.

### Error Handling

None. The function assumes valid input per the problem constraints. An empty string or one with leading/trailing spaces would produce an `IndexError` — this is acceptable for a LeetCode solution where inputs are guaranteed well-formed.

---

## Topics to Explore

- [file] `circular-sentence/test_solution.py` — See what edge cases the test suite covers (single word, two-character words, all-same-letter sentences)
- [file] `circular-sentence/plan.md` — The planning document may reveal alternative approaches that were considered and rejected
- [file] `circular-sentence/review.md` — Post-implementation review notes on correctness and style
- [general] `space-as-boundary-pattern` — Several other string problems in this repo (e.g., `check-if-numbers-are-ascending-in-a-sentence`, `sorting-the-sentence`) likely use similar space-scanning techniques instead of `.split()`
- [function] `backspace-string-compare/solution.py:backspaceCompare` — Another example of avoiding materialization (processing strings in-place rather than building intermediate structures)

## Beliefs

- `circular-sentence-no-split` — `is_circular` checks circularity without calling `str.split()`, using O(1) auxiliary space
- `circular-sentence-space-boundary` — The algorithm relies on the invariant that spaces never appear at position 0 or `len(sentence)-1`; violating this would cause incorrect results or `IndexError`
- `circular-sentence-single-pass` — The function performs at most one full scan of the string (O(n) time) with an early exit on the first failing condition
- `circular-sentence-wrap-check-is-separate` — The wrap-around condition (first char == last char) is checked independently from the space-boundary checks, not unified into the loop

