# File: percentage-of-letter-in-string/solution.py

**Date:** 2026-06-06
**Time:** 18:31

## `percentage-of-letter-in-string/solution.py`

### Purpose

Solves [LeetCode 2278](https://leetcode.com/problems/percentage-of-letter-in-string/) — given a string `s` and a character `letter`, return the floor percentage of characters in `s` that equal `letter`. This is a single-responsibility module: one class, one method, one expression.

### Key Components

**`Solution.percentageLetter(self, s: str, letter: str) -> int`** — the only method. It computes `count * 100 // len(s)` in a single expression, returning an integer in `[0, 100]`.

The method uses `str.count()` for occurrence counting and integer floor division (`//`) to satisfy the "rounded down" requirement. The multiplication by 100 happens *before* the division — this is critical. `count * 100 // len(s)` avoids floating-point entirely, which prevents rounding artifacts that `int(count / len(s) * 100)` could introduce.

### Patterns

- **One-liner arithmetic solution** — no intermediate variables, no imports, no branching. This is the idiomatic pattern for trivial LeetCode problems in this repo: a class wrapping a single method that returns an expression.
- **LeetCode class convention** — the `Solution` class with a specifically-named method follows LeetCode's submission format, which the entire repo adheres to.

### Dependencies

**Imports:** None. Pure stdlib — only uses `str.count()` and integer arithmetic.

**Imported by:** `percentage-of-letter-in-string/test_solution.py` directly. The massive "Imported By" list in the prompt is misleading — those are *other* problems' test files importing *their own* `solution.py`, not this one. The only real consumer is this problem's own test file.

### Flow

1. `s.count(letter)` — O(n) scan counting occurrences of `letter` in `s`
2. Multiply by 100
3. Integer-divide by `len(s)`
4. Return the result

No loops, no branches, no mutation. The entire method is a single return statement.

### Invariants

- **`len(s) >= 1`** — guaranteed by LeetCode's constraints (1 <= s.length <= 100). Without this, the division would raise `ZeroDivisionError`. The code does not validate this itself — it trusts the caller.
- **`letter` is a single lowercase English letter** — also a LeetCode constraint. `str.count()` works with multi-character strings too, but the problem guarantees single-char input.
- **Result is in `[0, 100]`** — follows from `count <= len(s)`, so `count * 100 // len(s) <= 100`.

### Error Handling

None. The method will raise `ZeroDivisionError` on empty string input, but the problem constraints prevent this. This is consistent with the repo's approach: solutions trust LeetCode's input guarantees rather than adding defensive checks.

## Topics to Explore

- [file] `percentage-of-letter-in-string/test_solution.py` — See what edge cases the tests cover (e.g., letter not present, all characters match)
- [file] `percentage-of-letter-in-string/review.md` — Read the code review for any noted alternatives or pitfalls
- [general] `integer-vs-float-division-in-percentage-problems` — Why `count * 100 // n` is preferred over `int(count / n * 100)` for floor-percentage calculations (floating-point precision)
- [function] `count-the-number-of-consistent-strings/solution.py:Solution.countConsistentStrings` — Another string-counting problem to compare approaches

## Beliefs

- `percentage-floor-via-integer-arithmetic` — `percentageLetter` computes floor percentage using `count * 100 // len(s)`, avoiding floating-point entirely
- `no-zero-length-guard` — The method has no guard against empty-string input; it relies on LeetCode's constraint that `len(s) >= 1`
- `single-expression-solution` — The entire solution is a single return statement with no branching, loops, or intermediate state
- `multiplication-before-division-ordering` — Multiplying by 100 before dividing by `len(s)` is load-bearing: reversing the order (`count // len(s) * 100`) would produce 0 for any `count < len(s)`

