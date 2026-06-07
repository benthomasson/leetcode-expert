# File: first-letter-to-appear-twice/solution.py

**Date:** 2026-06-06
**Time:** 16:50

## Purpose

This file solves [LeetCode 2351: First Letter to Appear Twice](https://leetcode.com/problems/first-letter-to-appear-twice/). It owns the core algorithm for the problem: given a string of lowercase letters where at least one letter repeats, find the first letter whose second occurrence appears earliest (i.e., has the smallest index for its second appearance).

## Key Components

### `first_letter_to_appear_twice(s: str) -> str`

The sole export. Contract:

- **Input**: a string `s` of lowercase English letters, guaranteed to contain at least one repeated character.
- **Output**: a single character — the first letter encountered that was already seen.
- **Side effects**: none.

## Patterns

**Set-based membership tracking.** The function uses the classic "seen set" idiom — iterate through elements, check membership in O(1), add if new, return on first collision. This is the textbook approach for "first duplicate in a stream" problems.

**Early return.** The function exits as soon as it finds the answer, avoiding unnecessary iteration over the rest of the string. There is no post-loop fallback — the problem guarantees a duplicate exists, so the loop always terminates via `return`.

## Dependencies

**Imports**: None. Uses only Python builtins (`set`).

**Imported by**: The "Imported By" list in the prompt is misleading — it lists ~400+ test files across unrelated problems. This is likely an artifact of a shared test runner or import framework, not genuine cross-problem dependencies. The actual consumer is `first-letter-to-appear-twice/test_solution.py`.

## Flow

1. Initialize empty `set` called `seen`.
2. Iterate character-by-character through `s`.
3. For each character `c`:
   - If `c in seen` → return `c` immediately (this is the second occurrence).
   - Otherwise, `seen.add(c)` to record the first occurrence.
4. Implicit: function has no explicit `return None` — it relies on the problem's guarantee that a duplicate exists.

**Time complexity**: O(n) worst case, but bounded by O(26) since there are only 26 lowercase letters — the pigeonhole principle guarantees a collision by the 27th character.

**Space complexity**: O(1) — the set holds at most 26 entries.

## Invariants

- At any point in the loop, `seen` contains exactly the set of characters encountered before index `i` (each stored once).
- The function assumes `s` contains at least one duplicate — if it doesn't, the function falls off the end and returns `None`, which would be a silent bug.
- Input is assumed to be lowercase English letters only (no validation).

## Error Handling

None. The function trusts its caller to satisfy the precondition (at least one repeated letter). If the precondition is violated, the function returns `None` implicitly — no exception, no sentinel value. This is acceptable for a LeetCode solution where inputs are constrained by the problem statement.

## Topics to Explore

- [file] `first-letter-to-appear-twice/test_solution.py` — Verify what edge cases are tested (e.g., duplicate at position 2 vs. end of string, all-same-character input)
- [file] `first-letter-to-appear-twice/review.md` — The code review may note alternative approaches (bitmask with 26 bits, `Counter`, etc.)
- [function] `check-if-all-characters-have-equal-number-of-occurrences/solution.py:areOccurrencesEqual` — Another frequency/set-based character problem; compare the pattern
- [general] `bitmask-vs-set-for-26-letters` — A 26-bit integer bitmask (`seen |= 1 << (ord(c) - ord('a'))`) would eliminate hash overhead and is a common alternative for lowercase-only problems

## Beliefs

- `set-early-return-pattern` — The function returns on the first duplicate encountered during left-to-right iteration, guaranteeing the result is the letter whose *second* occurrence index is minimal.
- `pigeonhole-bound` — The loop executes at most 27 iterations regardless of string length, since 26 lowercase letters force a collision by the 27th character.
- `no-defensive-validation` — The function performs no input validation; passing a string with no duplicates silently returns `None`.
- `zero-external-dependencies` — The solution uses only Python builtins and imports nothing.

