# File: backspace-string-compare/solution.py

**Date:** 2026-06-06
**Time:** 15:19

## Backspace String Compare — `solution.py`

### Purpose

This file solves [LeetCode 844: Backspace String Compare](https://leetcode.com/problems/backspace-string-compare/). It determines whether two strings are equal after processing `#` characters as backspaces. It's the canonical O(n) time, O(1) space solution using reverse traversal — the optimal approach for this problem.

### Key Components

**`backspaceCompare(s, t) -> bool`** — The main entry point. Walks both strings backward simultaneously, comparing characters that survive backspace processing. Returns `True` if the two strings produce identical results after all backspaces are applied.

**`_next_valid(string, index) -> int`** — The workhorse helper. Given a string and a current index, walks backward past any characters that would be deleted by backspaces, returning the index of the next character that "survives." Returns a negative value when the entire string has been consumed.

### Patterns

**Reverse two-pointer with skip counting.** The key insight is that backspaces only affect characters *before* them, so walking backward lets you process deletions without a stack. The `skip` counter in `_next_valid` accumulates pending backspaces — each `#` increments it, each non-`#` character with `skip > 0` gets consumed (skipped) and decrements it. This replaces the naive O(n) space stack-based approach.

**Synchronized iteration.** `backspaceCompare` advances both pointers independently through `_next_valid`, then compares the surviving characters pairwise. The three exit conditions form a complete decision:
1. Both exhausted → equal
2. One exhausted, one not → unequal (length mismatch)
3. Characters differ → unequal

### Dependencies

**Imports:** None — pure algorithmic code with no external dependencies.

**Imported by:** `backspace-string-compare/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are other problem directories' test files, likely sharing a common test harness or runner, not actually importing this solution.

### Flow

1. Initialize `i` and `j` to the last index of `s` and `t`.
2. Loop:
   - Call `_next_valid(s, i)` — skip past all backspaced characters in `s`, landing on the next surviving character (or -1).
   - Call `_next_valid(t, j)` — same for `t`.
   - Compare: both exhausted? one exhausted? characters differ?
   - Decrement both pointers by 1 to advance past the matched characters.
3. `_next_valid` internally: when it sees `#`, increments `skip`; when it sees a regular char with `skip > 0`, decrements `skip` and skips the char; when `skip == 0` on a regular char, breaks and returns that index.

### Invariants

- **`_next_valid` always returns an index where `string[index]` is a non-backspaced character, or a negative value.** It never returns the index of a `#` or a character that would be deleted by a subsequent `#`.
- **`skip` is non-negative throughout `_next_valid`.** It starts at 0 and only decrements when positive.
- **Each call to `_next_valid` is O(k) where k is the number of characters traversed**, but across all calls for one string the total work is O(n) — each character is visited exactly once across the entire `backspaceCompare` loop.
- **The algorithm is purely read-only** — neither string is modified.

### Error Handling

None. The function assumes valid input per the LeetCode contract: strings contain only lowercase letters and `#`. No bounds checking beyond the `index >= 0` guard in `_next_valid`. Invalid input (e.g., `None`) would raise a `TypeError` from `len()`.

---

## Topics to Explore

- [file] `backspace-string-compare/test_solution.py` — Edge cases tested (empty results, consecutive backspaces, backspaces exceeding available characters)
- [file] `backspace-string-compare/plan.md` — Whether alternative approaches (stack-based O(n) space) were considered and why this one was chosen
- [general] `reverse-two-pointer-pattern` — Other problems in this repo using the same reverse traversal with skip counting (e.g., `long-pressed-name`)
- [function] `remove-all-adjacent-duplicates-in-string/solution.py:removeDuplicates` — Stack-based string processing for comparison — the approach this solution deliberately avoids

## Beliefs

- `backspace-compare-O1-space` — `backspaceCompare` uses O(1) auxiliary space; no stack, list, or intermediate string is allocated
- `next-valid-terminates` — `_next_valid` always terminates because `index` strictly decreases on every iteration of its while loop
- `backspace-compare-single-pass` — Each character in both strings is visited exactly once across all `_next_valid` calls, giving O(n+m) total time
- `skip-counter-non-negative` — The `skip` variable in `_next_valid` is never decremented below zero; the `elif skip > 0` guard prevents it

