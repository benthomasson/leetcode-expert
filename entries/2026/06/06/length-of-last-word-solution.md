# File: length-of-last-word/solution.py

**Date:** 2026-06-06
**Time:** 17:22

## `length-of-last-word/solution.py`

### Purpose

This file implements the solution to [LeetCode #58 — Length of Last Word](https://leetcode.com/problems/length-of-last-word/). It owns exactly one responsibility: given a string of words separated by spaces, return the length of the last word. The function `length_of_last_word` is the public API consumed by the test harness.

### Key Components

**`length_of_last_word(s: str) -> int`** — The sole function. Its contract:
- **Input**: A string `s` containing words separated by spaces. Per the LeetCode constraint, `s` contains at least one word composed of English letters and spaces.
- **Output**: An integer — the character count of the last word.

### Patterns

The implementation chains three built-in string/list operations in a single expression:

1. `s.rstrip()` — strips trailing spaces so a string like `"hello world   "` becomes `"hello world"`. This is the key defensive step; without it, `split()[-1]` would still work (since `str.split()` with no args already handles trailing whitespace), making the `rstrip()` technically redundant here but explicit about intent.
2. `.split()` — splits on any whitespace into a list of words. Using the no-arg form means consecutive spaces are collapsed and leading/trailing whitespace is ignored.
3. `[-1]` — grabs the last element.
4. `len(...)` — returns its length.

This is the idiomatic Python one-liner approach — no loops, no manual index tracking.

### Dependencies

**Imports**: None. Pure stdlib, no external packages.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files for *other* problems, not actual consumers of this function. The real consumer is `length-of-last-word/test_solution.py`, which imports `length_of_last_word` to run test cases against it. The long list likely reflects a shared test runner or test infrastructure pattern across the repo rather than direct imports of this function.

### Flow

```
input: "   fly me   to   the moon  "
       │
       ▼ rstrip()
"   fly me   to   the moon"
       │
       ▼ split()
["fly", "me", "to", "the", "moon"]
       │
       ▼ [-1]
"moon"
       │
       ▼ len()
4
```

### Invariants

- The LeetCode problem guarantees `s` contains at least one word, so `split()` will never return an empty list. The code does not guard against `IndexError` from `[-1]` on an empty list — it relies on this precondition.
- Words consist only of English letters (no punctuation splitting needed).

### Error Handling

None. If `s` is empty or all-spaces, `split()` returns `[]` and `[-1]` raises `IndexError`. This is acceptable because the problem constraints guarantee at least one word exists. The function trusts its caller to meet the precondition.

---

## Topics to Explore

- [file] `length-of-last-word/test_solution.py` — See what edge cases the test suite covers (trailing spaces, single word, single character)
- [file] `length-of-last-word/review.md` — Read the code review notes for alternative approaches and complexity analysis
- [function] `number-of-segments-in-a-string/solution.py:number_of_segments` — A closely related problem that also uses `split()` on whitespace-delimited strings
- [general] `split-no-args-vs-split-char` — Python's `str.split()` (no args) vs `str.split(' ')` behave very differently with consecutive/trailing spaces; understanding this distinction is key to many string problems in this repo

## Beliefs

- `length-of-last-word-uses-split` — `length_of_last_word` relies on `str.split()` with no arguments, which collapses consecutive whitespace and strips leading/trailing spaces
- `length-of-last-word-no-empty-guard` — The function assumes `s` contains at least one word and will raise `IndexError` on an empty or all-whitespace input
- `length-of-last-word-rstrip-redundant` — The `rstrip()` call is redundant with no-arg `split()`'s whitespace handling, but makes the trailing-space intent explicit
- `length-of-last-word-o-n-time` — The function runs in O(n) time and O(n) space due to `split()` materializing the full word list

