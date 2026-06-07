# File: replace-all-digits-with-characters/solution.py

**Date:** 2026-06-06
**Time:** 18:51

## Purpose

This file is the solution and test suite for [LeetCode 1844: Replace All Digits with Characters](https://leetcode.com/problems/replace-all-digits-with-characters/). It owns the complete implementation — algorithm, module-level export alias, and unit tests — all in a single file, following the repo's convention of self-contained problem directories.

## Key Components

### `Solution.replaceDigits(self, s: str) -> str`

The core algorithm. Given a string where even-indexed positions hold lowercase letters and odd-indexed positions hold digit characters, it replaces each digit with the character obtained by shifting the preceding letter forward by that digit's value in the alphabet.

**Contract**: `s` must alternate between letters (even indices) and digits (odd indices). The method does not validate this — it trusts the LeetCode guarantee.

### `count_balls` (module-level alias)

```python
count_balls = Solution().replaceDigits
```

This is a **misnamed export**. The name `count_balls` belongs to a different LeetCode problem (1742: Maximum Number of Balls in a Box). It exists because this repo uses a uniform import convention across test files — the "Imported By" list shows hundreds of test files importing from this module, which means the test runner or generated test harness imports a canonical symbol name from each solution module. The name mismatch is a code-gen artifact, not a logic error.

### `TestReplaceDigits`

Six test cases covering the standard examples, edge cases (single character, zero shift), and boundary behavior (shifting from `'z'`, large shift of 9).

## Patterns

- **Single-file module**: Solution class, export alias, and tests colocated — the repo treats each problem directory as a self-contained unit.
- **In-place list mutation**: Converts the string to a `list` for O(1) character replacement, then joins back. This avoids O(n²) string concatenation.
- **Stride-2 iteration**: `range(1, len(s), 2)` skips even indices entirely, since only odd-indexed positions need transformation.
- **Character arithmetic via `ord`/`chr`**: The shift operation `chr(ord(chars[i-1]) + int(chars[i]))` is the standard Python idiom for alphabetic offset.

## Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The massive "Imported By" list (300+ test files) is misleading. These files don't depend on the *logic* of this module — they import the `count_balls` alias as part of a generated test harness pattern. The dependency is structural (naming convention), not functional.

## Flow

1. Convert input string `s` to a mutable `list` of characters.
2. Iterate over odd indices (1, 3, 5, …).
3. For each odd index `i`, read the preceding character at `i-1`, read the digit at `i`, compute `chr(ord(prev_char) + digit)`, and write the result back to `chars[i]`.
4. Join and return.

For input `"a1c1e1"`:
- Index 1: `chr(ord('a') + 1)` → `'b'` → `"abc1e1"`
- Index 3: `chr(ord('c') + 1)` → `'d'` → `"abcde1"`
- Index 5: `chr(ord('e') + 1)` → `'f'` → `"abcdef"`

## Invariants

- **Odd indices only**: The loop only touches indices 1, 3, 5, …; even-indexed characters pass through unchanged.
- **Left-neighbor dependency**: Each replacement at index `i` reads from `i-1`, which is always an even index (a letter) and is never modified by this loop — so there are no read-after-write hazards.
- **No bounds overflow**: The problem guarantees `s` has letters at even indices and digits at odd indices, so `i-1` is always valid when `i >= 1`.

## Error Handling

None. The code assumes valid input per the LeetCode contract. Passing a string with letters at odd indices would produce `int()` `ValueError`; passing an empty string works fine (the loop body never executes).

## Topics to Explore

- [file] `replace-all-digits-with-characters/test_solution.py` — See how the external test harness imports and exercises this solution via the `count_balls` alias
- [file] `replace-all-digits-with-characters/review.md` — The code review may document the naming mismatch or other observations
- [general] `module-alias-naming-convention` — Investigate why all solutions export through a single canonical name and whether the mismatch pattern (`count_balls` for unrelated problems) is systematic across the repo
- [file] `run_tests.py` — Understand how the repo-wide test runner discovers and imports solution modules
- [function] `replace-all-digits-with-characters/solution.py:replaceDigits` — Compare this O(n) in-place approach against alternative implementations (e.g., list comprehension with conditional)

## Beliefs

- `odd-index-only-mutation` — `replaceDigits` only modifies characters at odd indices; even-indexed characters are never written to
- `no-read-after-write-hazard` — Each replacement reads from an even index (`i-1`) that is never modified by the loop, so iteration order doesn't affect correctness
- `misnamed-module-export` — The module-level alias `count_balls` does not match this problem (LeetCode 1844); it's a code-generation artifact from the repo's test harness
- `linear-time-linear-space` — The algorithm runs in O(n) time and O(n) space (the `list(s)` copy), which is optimal for this problem

