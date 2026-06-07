# File: valid-parentheses/solution.py

**Date:** 2026-06-06
**Time:** 19:39

## `valid-parentheses/solution.py`

### Purpose

This file implements the solution to [LeetCode #20 — Valid Parentheses](https://leetcode.com/problems/valid-parentheses/). It owns a single responsibility: determining whether a string consisting of bracket characters `()[]{}` has every opener properly matched and nested with its corresponding closer.

### Key Components

**`is_valid(s: str) -> bool`** — The sole public function. Contract: given a string containing only the six bracket characters, returns `True` if and only if every opening bracket has a matching closing bracket in the correct nesting order.

Three internal pieces do the work:

- **`stack`** (list) — accumulates unmatched opening brackets. Acts as a LIFO structure via `append`/`pop`.
- **`match`** (dict) — maps each closing bracket to its expected opening counterpart. This dict also doubles as the membership test for "is this character a closer?" via `if ch in match`.
- **The loop** — single pass over `s`, branching on whether each character is a closer or an opener.

### Patterns

**Stack-based bracket matching** — the textbook approach. The `match` dict serves double duty: it's both a lookup table and a set membership test, which keeps the code tight.

**Early return on mismatch** — the function short-circuits as soon as it finds a closer with no matching opener (`not stack`) or a mismatched opener (`stack.pop() != match[ch]`). This avoids unnecessary work on malformed input.

**Implicit else for openers** — any character not in `match` is treated as an opener and pushed onto the stack. This works because the problem guarantees the input contains only the six bracket characters.

### Dependencies

**Imports**: None. This is a pure function with zero dependencies — no standard library, no project utilities.

**Imported by**: The "Imported By" list in the prompt shows hundreds of test files across the repo reference this. That's misleading — those are test files for *other* problems that happen to share a common test harness pattern, not actual consumers of `is_valid`. The real consumer is `valid-parentheses/test_solution.py`.

### Flow

1. Initialize empty `stack` and the `match` mapping `{')':'(', ']':'[', '}':'{'}`.
2. Iterate character-by-character through `s`:
   - **Closer encountered** (`ch in match`): check two failure conditions in one expression — `not stack` (nothing to match against) or `stack.pop() != match[ch]` (top of stack doesn't match). If either is true, return `False`.
   - **Opener encountered** (else branch): push onto `stack`.
3. After the loop, return `not stack` — `True` only if every opener was consumed by a closer.

### Invariants

- **At every point during iteration**, `stack` contains only opening brackets that have not yet been matched.
- **The final `not stack` check** enforces that no openers remain unmatched — without it, inputs like `"("` would incorrectly return `True`.
- **The `not stack` guard before `pop`** prevents `IndexError` on inputs like `")"` where a closer appears with nothing on the stack.

### Error Handling

There is none in the traditional sense — no exceptions raised, no error codes. The function communicates failure purely through its boolean return value. It is resilient to edge cases:

- Empty string → returns `True` (no brackets to mismatch).
- Lone closer → `not stack` triggers, returns `False`.
- Lone opener → loop completes, `not stack` is `False`.
- The `stack.pop()` call is guarded by the `not stack` check via short-circuit evaluation, so it never raises `IndexError`.

## Topics to Explore

- [file] `valid-parentheses/test_solution.py` — See what edge cases the test suite covers and how the function is exercised
- [file] `valid-parentheses/review.md` — Read the code review for alternative approaches or noted tradeoffs
- [file] `remove-outermost-parentheses/solution.py` — A related parentheses problem that likely uses a similar stack technique with a twist
- [function] `maximum-nesting-depth-of-the-parentheses/solution.py:maxDepth` — Another stack/counter parentheses problem; compare how it tracks depth vs. validity
- [general] `stack-based-leetcode-patterns` — Several solutions in this repo use stacks (baseball-game, make-the-string-great, remove-all-adjacent-duplicates-in-string); compare their stack usage idioms

## Beliefs

- `valid-parentheses-pure-function` — `is_valid` is a pure function with no side effects, no imports, and no state beyond its local variables
- `valid-parentheses-single-pass` — The solution processes the input in exactly one pass with O(n) time and O(n) worst-case space
- `valid-parentheses-match-dict-dual-use` — The `match` dict serves both as a closer-detection set (`ch in match`) and as a closer-to-opener lookup, eliminating the need for a separate set
- `valid-parentheses-no-index-error` — Short-circuit evaluation of `not stack or stack.pop() != match[ch]` guarantees `pop` is never called on an empty list

