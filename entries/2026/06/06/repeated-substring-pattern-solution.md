# File: repeated-substring-pattern/solution.py

**Date:** 2026-06-06
**Time:** 18:50

## `repeated-substring-pattern/solution.py`

### Purpose

This file solves [LeetCode 459: Repeated Substring Pattern](https://leetcode.com/problems/repeated-substring-pattern/). It determines whether a string `s` can be constructed by concatenating multiple copies of a substring. The file owns the core algorithmic logic; test coverage lives in the sibling `test_solution.py`.

### Key Components

**`can_construct(s: str) -> bool`** — The sole public function. Takes a non-empty string of lowercase English letters and returns `True` if the entire string is a repeating pattern (e.g., `"abab"` → `True`, `"abc"` → `False`).

### Patterns

The implementation uses the **string doubling trick**, a well-known O(n) idiom for this problem class:

```python
return s in (s + s)[1:-1]
```

The insight: if `s` is built from a repeating unit, then concatenating `s` with itself (`s + s`) creates a string where `s` reappears at an offset other than 0 and `len(s)`. Slicing off the first and last characters (`[1:-1]`) destroys those two trivial occurrences. If `s` still appears in the trimmed result, a non-trivial repeating structure exists.

**Example walkthrough:**
- `s = "abab"` → `s + s = "abababab"` → trimmed = `"bababa"` → `"abab" in "bababa"` → `True` (found at index 2)
- `s = "abc"` → `s + s = "abcabc"` → trimmed = `"bcab"` → `"abc" in "bcab"` → `False`

This replaces what would otherwise be a divisor-enumeration approach (try every possible period length that divides `len(s)`) with a single substring search. Python's `in` operator delegates to a CPython implementation that uses a modified Boyer-Moore / Two-Way algorithm, giving average-case sublinear performance.

### Dependencies

**Imports:** None — the solution is self-contained, using only Python builtins.

**Imported by:** `repeated-substring-pattern/test_solution.py` directly, plus the "Imported By" list in the prompt shows hundreds of other test files. This is an artifact of the repo's test infrastructure — likely a shared test runner or import pattern — not a real dependency on this function.

### Flow

1. Concatenate `s` with itself → `2n`-length string.
2. Slice off first and last characters → `2n - 2`-length string.
3. Search for `s` in the sliced string.
4. Return the boolean result.

No loops, no branching, no mutation. The entire function is a single expression.

### Invariants

- **Input constraint**: `s` must be non-empty (an empty string would trivially match, but the LeetCode problem guarantees `1 <= len(s) <= 10^4`).
- **Correctness guarantee**: The trimming `[1:-1]` is critical — without it, `s` always appears at positions 0 and `len(s)` in `s + s`, making every input a false positive.

### Error Handling

None. The function assumes valid input per the LeetCode contract. An empty string would return `True` (since `"" in ""`), which would be incorrect for the problem but is outside the specified input range.

### Complexity

- **Time:** O(n) average via CPython's substring search; O(n²) worst case.
- **Space:** O(n) for the concatenated string.

---

## Topics to Explore

- [file] `repeated-substring-pattern/test_solution.py` — See what edge cases are covered (single char, all same chars, near-misses)
- [function] `greatest-common-divisor-of-strings/solution.py:gcdOfStrings` — A related string-repetition problem that uses a similar doubling insight
- [general] `kmp-failure-function` — The KMP algorithm's failure table provides an alternative O(n) solution with O(1) extra space (check if `len(s) % (len(s) - failure[-1]) == 0`)
- [file] `rotate-string/solution.py` — Uses the same `s in (s + s)` idiom for rotation detection

## Beliefs

- `repeated-substring-double-trick` — `s in (s+s)[1:-1]` returns True iff s is composed of a repeated substring; the `[1:-1]` trim eliminates the two trivial self-matches at positions 0 and len(s)
- `repeated-substring-no-imports` — The solution has zero dependencies; it uses only Python built-in string concatenation, slicing, and membership testing
- `repeated-substring-single-expression` — The entire algorithm is a single return expression with no branching or iteration at the Python level
- `repeated-substring-space-linear` — The concatenation `s + s` allocates O(n) additional memory, making space complexity linear

