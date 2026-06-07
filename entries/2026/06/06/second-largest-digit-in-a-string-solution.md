# File: second-largest-digit-in-a-string/solution.py

**Date:** 2026-06-06
**Time:** 19:00

## `second-largest-digit-in-a-string/solution.py`

### Purpose

This file solves [LeetCode 1796 — Second Largest Digit in a String](https://leetcode.com/problems/second-largest-digit-in-a-string/). It owns a single responsibility: given an alphanumeric string, extract all unique digit characters and return the second-largest, or `-1` if fewer than two distinct digits exist.

### Key Components

**`second_highest(s: str) -> int`** — The sole public function.

- **Input contract**: `s` is a string of lowercase English letters and/or digits (per the LeetCode constraint).
- **Output contract**: Returns the second-largest unique digit as an `int`, or `-1` if the string contains fewer than two distinct digits.

### Patterns

**Set-based deduplication**: Rather than sorting or maintaining a top-two tracker, the solution collects all digits into a set, which naturally deduplicates. This is a common idiom in this repo's easy-tier solutions — favor clarity and Python builtins over manual state management.

**Two-pass max extraction**: Instead of sorting the set (O(n log n)) or using `heapq.nlargest`, it calls `max()` twice with a `remove()` in between. This is O(n) in the size of the digit set, which is bounded at 10 elements — so performance is constant regardless of input length. The string scan itself is O(len(s)).

### Dependencies

**Imports**: None — pure stdlib, no external or internal imports.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files across hundreds of other problems. They don't actually import this module. The only real consumer is `second-largest-digit-in-a-string/test_solution.py`, which tests this function directly.

### Flow

1. **Filter & convert**: `{int(c) for c in s if c.isdigit()}` — single pass over the string, extracting digit characters and converting to `int`. The set comprehension deduplicates.
2. **Early return**: If the resulting set has fewer than 2 elements, return `-1`.
3. **Remove max**: `digits.remove(max(digits))` mutates the set in-place, dropping the largest digit.
4. **Return new max**: `max(digits)` on the reduced set yields the second-largest.

### Invariants

- The digit set contains at most 10 elements (digits 0–9), so all set/max operations are O(1) in practice.
- `digits.remove(max(digits))` is safe because the `len(digits) < 2` guard ensures at least 2 elements remain when reached.
- The function never raises — the guard clause covers the edge cases where `max()` would fail on an empty set.

### Error Handling

No exceptions are raised or caught. The `-1` sentinel value serves as the error/absence signal, matching the LeetCode problem specification. The `len(digits) < 2` check prevents `max()` from being called on an empty set after removal.

## Topics to Explore

- [file] `second-largest-digit-in-a-string/test_solution.py` — See what edge cases are covered (all-letters, single digit, all same digit, mixed)
- [file] `second-largest-digit-in-a-string/review.md` — Code review notes may flag alternative approaches or known issues
- [function] `third-maximum-number/solution.py:thirdMax` — Similar "k-th largest" problem with a more complex approach (3rd max with distinct-value semantics)
- [file] `number-of-different-integers-in-a-string/solution.py` — Related string-digit-extraction problem, likely uses a different parsing strategy
- [general] `set-based-digit-extraction` — Pattern recurs across digit-manipulation problems in this repo; worth comparing approaches

## Beliefs

- `second-highest-returns-minus-one-on-fewer-than-two-distinct-digits` — `second_highest` returns -1 when the input contains zero or one distinct digit characters
- `second-highest-is-o-n-in-string-length` — The function's time complexity is O(len(s)) since the digit set is bounded at size 10
- `second-highest-mutates-local-set-not-input` — The set is constructed internally; the input string `s` is never modified
- `second-highest-no-imports` — The module has zero imports, relying entirely on Python builtins (`set`, `max`, `int`, `str.isdigit`)

