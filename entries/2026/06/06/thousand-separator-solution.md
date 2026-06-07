# File: thousand-separator/solution.py

**Date:** 2026-06-06
**Time:** 19:28

## `thousand-separator/solution.py`

### Purpose

This file implements the solution for [LeetCode 1556 — Thousand Separator](https://leetcode.com/problems/thousand-separator/). It formats a non-negative integer by inserting dots (`.`) every three digits from the right, mimicking locale-specific thousand separators (e.g., `1234567` → `"1.234.567"`).

### Key Components

**`Solution.thousand_separator(self, n: int) -> str`** — the sole method. Takes a non-negative integer and returns its dot-separated string representation.

### Flow

1. Convert `n` to its string form `s`.
2. Repeatedly chop 3-character chunks off the right end of `s`, appending each chunk to `chunks`.
3. Whatever remains (1–3 characters) becomes the final chunk — this is the leftmost group.
4. Reverse `chunks` (they were collected right-to-left) and join with `"."`.

For `n = 1234567`:
- Iteration 1: `chunks = ["567"]`, `s = "1234"`
- Iteration 2: `chunks = ["567", "234"]`, `s = "1"`
- After loop: `chunks = ["567", "234", "1"]`
- Reversed + joined: `"1.234.567"`

### Patterns

**Right-to-left chunking via slicing** — instead of using modular arithmetic or Python's format specifiers (`f"{n:,}".replace(",", ".")`), the solution manually partitions the string. This is a common pattern in LeetCode solutions that avoids reliance on locale or format-spec behavior to demonstrate the algorithm explicitly.

### Dependencies

**Imports**: None — pure stdlib, no external dependencies.

**Imported by**: `thousand-separator/test_solution.py` (directly). The massive "Imported By" list in the prompt is likely an artifact of how the test harness resolves imports across the repo — those other test files don't actually import this solution; they share a common test runner infrastructure.

### Invariants

- `n` is assumed non-negative (per the LeetCode constraint `0 <= n < 2^31`). Negative numbers would produce `"-xxx"` with the minus sign stuck to the first chunk, which would be incorrect.
- The while loop guarantees every chunk except the leftmost is exactly 3 characters. The leftmost chunk is 1–3 characters.
- Single-digit and two-digit numbers pass straight through — the while condition `len(s) > 3` is never true, so the result is just `str(n)` with no dots.

### Error Handling

None. The method trusts its caller to provide a valid non-negative integer. No type checking, no bounds validation — appropriate for a LeetCode submission where the problem constraints guarantee valid input.

## Topics to Explore

- [file] `thousand-separator/test_solution.py` — See which edge cases (0, single-digit, exactly 3 digits, large values) the test suite covers
- [file] `thousand-separator/review.md` — Read the code review notes for alternative approaches or identified issues
- [general] `string-chunking-patterns` — Compare this right-to-left slicing approach with other chunking strategies used across the repo (e.g., `divide-a-string-into-groups-of-size-k`)
- [function] `thousand-separator/solution.py:thousand_separator` — Benchmark against the one-liner `f"{n:,}".replace(",", ".")` to understand the tradeoff between explicitness and brevity

## Beliefs

- `thousand-separator-chunks-right-to-left` — The while loop always removes exactly 3 characters per iteration from the right of the string, guaranteeing uniform chunk sizes except for the leftmost group
- `thousand-separator-no-dot-for-small` — Inputs with 3 or fewer digits produce no dot in the output because the while-loop body never executes
- `thousand-separator-negative-unsupported` — The method produces incorrect output for negative integers (the minus sign would be glued to the first chunk) but this is acceptable given LeetCode's `n >= 0` constraint
- `thousand-separator-pure-string-ops` — The solution uses only string slicing and list operations with no imports, format specifiers, or regex

