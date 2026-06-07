# File: remove-all-adjacent-duplicates-in-string/solution.py

**Date:** 2026-06-06
**Time:** 18:44

## Purpose

This file solves [LeetCode 1047 — Remove All Adjacent Duplicates In String](https://leetcode.com/problems/remove-all-adjacent-duplicates-in-string/). It owns the `Solution.removeDuplicates` method, which repeatedly removes pairs of adjacent identical characters until no more exist. For example, `"abbaca"` becomes `"ca"`: `abb` → `a`, then `aaca` → `ca`.

## Key Components

**`Solution.removeDuplicates(s: str) -> str`** — The sole method. Takes a string of lowercase English letters and returns the string after all adjacent duplicate pair removals have been applied. The removal is transitive: removing a pair may create a new adjacent pair, which is also removed.

## Patterns

**Stack-based simulation.** Rather than repeatedly scanning the string for pairs (which would be O(n²)), this uses a stack to process each character exactly once. The stack acts as the "result so far" — when the next character matches the top, they cancel out (pop); otherwise it extends the result (push). This is the textbook idiom for adjacent-pair cancellation problems.

The final `"".join(stack)` converts the list-of-characters back into a string.

## Dependencies

**Imports:** None — pure standard library, no external dependencies.

**Imported by:** The `test_solution.py` in the same directory. The long "Imported By" list in the prompt is misleading — those are unrelated test files in sibling problem directories; they import their own local `solution.py`, not this one.

## Flow

1. Initialize an empty stack (`list[str]`).
2. Iterate through each character `ch` in the input string `s`.
3. If the stack is non-empty and its top element equals `ch`, pop the top (the pair cancels).
4. Otherwise, push `ch` onto the stack.
5. After all characters are processed, join the stack into a string and return it.

For `"abbaca"`:
- `a` → stack: `[a]`
- `b` → stack: `[a, b]`
- `b` → matches top, pop → stack: `[a]`
- `a` → matches top, pop → stack: `[]`
- `c` → stack: `[c]`
- `a` → stack: `[c, a]`
- Result: `"ca"`

## Invariants

- **Single-pass guarantee:** Every character is visited exactly once — O(n) time, O(n) space.
- **No adjacent duplicates in the stack at any point.** The push/pop logic ensures two identical characters never sit adjacent in the stack, so the final result is fully reduced.
- **Input constraint:** Assumes `s` contains only lowercase English letters (per the problem spec). No validation is performed.

## Error Handling

None. Empty input produces an empty string naturally (the loop body never executes, `"".join([])` returns `""`). No exceptions are raised or caught.

## Topics to Explore

- [file] `remove-all-adjacent-duplicates-in-string/test_solution.py` — See the test cases to understand edge cases (empty string, no duplicates, full cancellation)
- [file] `make-the-string-great/solution.py` — A similar stack-based cancellation problem where upper/lower pairs cancel instead of identical pairs
- [file] `valid-parentheses/solution.py` — Another classic stack-matching problem with a different matching predicate
- [file] `backspace-string-compare/solution.py` — Stack-based string processing with a different cancellation trigger (backspace character)
- [general] `stack-for-pair-cancellation` — The general pattern of using a stack to cancel adjacent matching elements appears across many LeetCode problems (1047, 1544, 20, 844)

## Beliefs

- `remove-duplicates-stack-invariant` — The stack never contains two identical adjacent characters at any point during execution, guaranteeing a fully reduced result without multiple passes.
- `remove-duplicates-time-complexity` — `removeDuplicates` runs in O(n) time and O(n) space, where n is the length of the input string.
- `remove-duplicates-no-dependencies` — The solution module has zero imports and depends only on Python builtins (`list`, `str.join`).
- `remove-duplicates-empty-safe` — An empty string input produces an empty string output with no special-casing needed.

