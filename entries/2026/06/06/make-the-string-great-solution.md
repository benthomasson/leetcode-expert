# File: make-the-string-great/solution.py

**Date:** 2026-06-06
**Time:** 17:30

## `make-the-string-great/solution.py`

### Purpose

This file solves [LeetCode 1544 — Make The String Great](https://leetcode.com/problems/make-the-string-great/). The problem: given a string of mixed-case English letters, repeatedly remove any adjacent pair where one character is the uppercase version of the other (e.g., `"aA"` or `"Aa"`), until no such pair remains.

Note: the method is misnamed `goodNodes` — it should be `makeGood` per the LeetCode signature. The docstring is correct about what it does.

### Key Components

**`Solution.goodNodes(self, s: str) -> str`** — the single entry point. Takes a string, returns the "great" version with all bad adjacent pairs removed.

### Patterns

**Stack-based pair cancellation.** This is the canonical pattern for problems where adjacent elements can annihilate each other (see also: `remove-all-adjacent-duplicates-in-string`). Instead of repeatedly scanning the string for pairs (which would be O(n²)), the stack processes each character once:

- If the top of the stack and the current character form a "bad pair," pop the stack (cancel them).
- Otherwise, push the current character.

The trick for detecting a bad pair is `abs(ord(stack[-1]) - ord(c)) == 32`. This works because in ASCII, every lowercase letter is exactly 32 higher than its uppercase counterpart (`ord('a') - ord('A') == 32`). Two characters that are the same letter in different cases will always differ by exactly 32. Two characters that are different letters — even across case — will never differ by exactly 32, because no two distinct letters occupy adjacent slots 32 apart in the ASCII table.

### Dependencies

**Imports:** None — pure standard library, no external dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — those ~400+ test files are importing from their own local `solution.py`, not from this file. The actual consumer is `make-the-string-great/test_solution.py`.

### Flow

1. Initialize an empty `stack` (list).
2. Iterate through each character `c` in `s`.
3. For each character, check if the stack is non-empty and the top element forms a case-inverse pair with `c` (ASCII difference of 32).
4. If yes: pop the stack — both characters are eliminated.
5. If no: push `c` onto the stack.
6. Join the stack into a string and return.

The stack naturally handles chain reactions. When a pop exposes a new top, the *next* incoming character is checked against that new top — so cascading cancellations like `"abBAc"` → `"aAc"` → `"c"` are handled in a single pass without re-scanning.

### Invariants

- **ASCII magic number 32:** The solution assumes ASCII encoding where `|upper - lower| == 32` for every English letter. This is always true for standard Python `str`.
- **Single-pass guarantee:** Every character is pushed at most once and popped at most once → O(n) time, O(n) space.
- **Empty input safety:** If `s` is empty, the loop doesn't execute and `"".join([])` returns `""`.

### Error Handling

None. The function trusts its input — no validation that `s` contains only English letters. Non-alphabetic characters would pass through the stack unpaired, which is correct behavior for the problem constraints.

---

## Topics to Explore

- [file] `make-the-string-great/test_solution.py` — See what edge cases the tests cover (empty string, all-cancel, no-cancel, cascading pairs)
- [file] `remove-all-adjacent-duplicates-in-string/solution.py` — Same stack-cancellation pattern but for identical adjacent chars instead of case-inverse pairs
- [general] `stack-pair-cancellation` — The broader family of problems (valid parentheses, duplicate removal, asteroid collision) that use this exact stack idiom
- [file] `make-the-string-great/review.md` — May document the method naming discrepancy (`goodNodes` vs `makeGood`)

## Beliefs

- `ascii-32-detects-case-pairs` — `abs(ord(a) - ord(b)) == 32` is true if and only if `a` and `b` are the same English letter in different cases, given inputs restricted to `[a-zA-Z]`
- `stack-cancellation-is-single-pass` — The algorithm processes each character exactly once (push) and removes it at most once (pop), giving O(n) time complexity
- `method-name-mismatch` — The method is named `goodNodes` but implements LeetCode 1544's `makeGood`; the name appears to be a copy-paste artifact from a tree problem
- `cascading-removals-handled-implicitly` — Chain reactions (where removing one pair exposes a new bad pair) are handled without re-scanning because the next character is checked against the newly-exposed stack top

