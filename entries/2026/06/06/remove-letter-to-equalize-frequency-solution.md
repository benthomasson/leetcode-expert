# File: remove-letter-to-equalize-frequency/solution.py

**Date:** 2026-06-06
**Time:** 18:47

## `remove-letter-to-equalize-frequency/solution.py`

### Purpose

This file solves [LeetCode 2423: Remove Letter To Equalize Frequency](https://leetcode.com/problems/remove-letter-to-equalize-frequency/). It determines whether you can remove exactly one character from a string so that every remaining distinct character appears the same number of times.

### Key Components

**`can_equal_frequency(word: str) -> bool`** — The sole public function. Takes a lowercase letter string of length 2–100 and returns `True` if deleting exactly one character makes all remaining character frequencies equal.

### Patterns

**Brute-force simulation.** Rather than reasoning about frequency counts analytically (which is notoriously error-prone for this problem due to many edge cases), the solution tries every possible single deletion and checks whether the result has uniform frequency. This is the "just simulate it" idiom — trade O(n^2) time for zero risk of missing a corner case.

The uniformity check `len(set(counts.values())) == 1` is a standard Python idiom: if all values in a `Counter` are equal, the set of values has exactly one element.

### Dependencies

- **Imports:** `collections.Counter` — used to count character frequencies in each candidate string.
- **Imported by:** `remove-letter-to-equalize-frequency/test_solution.py` and ~400+ other test files (the "Imported By" list in the prompt is the test harness importing `Counter` from `collections`, not this file specifically).

### Flow

1. Iterate `i` over every index `[0, len(word))`.
2. For each `i`, build a new string with index `i` removed via `word[:i] + word[i+1:]`.
3. Count character frequencies of the shortened string with `Counter`.
4. Check if all frequencies are identical: `len(set(counts.values())) == 1`.
5. If any deletion produces uniform frequencies, return `True` immediately (short-circuit).
6. If no deletion works, return `False`.

### Invariants

- Exactly one character is removed per trial — the function never considers removing zero or two+ characters.
- The `Counter` of an empty string is empty, so `set(counts.values())` would be an empty set with length 0, not 1. This doesn't arise in practice because `len(word) >= 2` per the problem constraints, so the shortened string always has at least one character.
- The function is pure — no mutation of the input.

### Error Handling

None. The function assumes valid input per the LeetCode contract (lowercase English letters, length 2–100). No exceptions are raised or caught.

### Complexity

- **Time:** O(n^2) — n iterations, each building an O(n) string and counting it.
- **Space:** O(n) — the sliced string and `Counter` each use O(n) space.

For n ≤ 100 this is trivially fast. An O(n) analytical approach exists but is much harder to get right — this problem is infamous for tricky edge cases (e.g., `"aazz"`, `"abc"`, `"aaaa"`).

## Topics to Explore

- [file] `remove-letter-to-equalize-frequency/test_solution.py` — See which edge cases the test suite covers (single-frequency strings, all-same characters, length-2 inputs)
- [file] `remove-letter-to-equalize-frequency/review.md` — Check if the review flags the O(n^2) approach or discusses the analytical alternative
- [function] `check-if-all-characters-have-equal-number-of-occurrences/solution.py:areOccurrencesEqual` — Related problem (equal frequency without any removal) — contrast the simpler check
- [general] `brute-force-vs-analytical-frequency-problems` — This problem is a well-known trap where analytical solutions have subtle bugs; understand when brute force is the right call

## Beliefs

- `brute-force-deletion-correctness` — The brute-force approach of trying every single-index deletion is correct for all inputs within the problem's constraints (length 2–100) and avoids the edge-case bugs common in O(n) analytical solutions.
- `uniform-frequency-check-idiom` — `len(set(counter.values())) == 1` is the canonical Python check for whether all character frequencies are equal.
- `quadratic-acceptable-for-n-100` — The O(n^2) time complexity is well within limits for the constraint n ≤ 100, making optimization unnecessary.
- `no-empty-counter-risk` — The `Counter` is never called on an empty string because the problem guarantees `len(word) >= 2`, so the shortened string always has at least one character.

