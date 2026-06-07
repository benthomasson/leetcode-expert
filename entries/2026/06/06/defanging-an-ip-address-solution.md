# File: defanging-an-ip-address/solution.py

**Date:** 2026-06-06
**Time:** 16:13

## Purpose

This file solves [LeetCode 1108 — Defanging an IP Address](https://leetcode.com/problems/defanging-an-ip-address/). It owns exactly one responsibility: transforming a valid IPv4 address string by wrapping each `.` in brackets (`[.]`), producing a "defanged" representation safe for display in contexts where dots might be parsed as separators (e.g., logs, chat messages, security reports).

## Key Components

### `Solution.defangIPaddr(self, address: str) -> str`

- **Contract**: Given a valid IPv4 address string (e.g., `"1.1.1.1"`), returns the same string with every `.` replaced by `"[.]"` (e.g., `"1[.]1[.]1[.]1"`).
- **Delegation**: Entirely delegates to `str.replace`, which performs a left-to-right scan replacing all non-overlapping occurrences in a single pass.

## Patterns

- **LeetCode `Solution` class convention**: The method lives on a `Solution` class with no `__init__`, matching LeetCode's expected interface so the judge can call `Solution().defangIPaddr(address)`.
- **One-liner delegation**: Rather than manual iteration or regex, the solution uses the most direct standard library call. This is idiomatic for simple string substitution problems — no reason to build machinery when a built-in does exactly the right thing.

## Dependencies

**Imports**: None. Pure standard library, no external packages.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files across the entire repo that import their *own* `solution.py`, not this one. The only real consumer is `defanging-an-ip-address/test_solution.py`, which imports this `Solution` class to run test cases against it.

## Flow

1. Caller passes a string like `"255.100.50.0"`.
2. `str.replace(".", "[.]")` scans left to right, building a new string with each `.` expanded to `[.]`.
3. The new string (`"255[.]100[.]50[.]0"`) is returned.

There is no branching, no state, no iteration visible at the Python level — `str.replace` handles it internally in C (CPython).

## Invariants

- **Precondition**: `address` must be a valid IPv4 address string. The method performs no validation — it trusts the caller (LeetCode's judge guarantees this).
- **Output guarantee**: The result always has exactly 3 `[.]` substrings for a valid IPv4 input, since every IPv4 address has exactly 3 dots.
- **No mutation**: Strings are immutable in Python; `replace` returns a new string.

## Error Handling

None. There is no validation, no try/except, no edge-case guarding. This is appropriate — the problem guarantees valid input, and `str.replace` on any string with no dots simply returns the original string unchanged (a safe no-op).

## Topics to Explore

- [file] `defanging-an-ip-address/test_solution.py` — See what edge cases the test suite covers (single-digit octets, max-value `255.255.255.255`, etc.)
- [file] `defanging-an-ip-address/review.md` — The code review may note alternative approaches (join/split, regex) and why `str.replace` wins here
- [function] `goal-parser-interpretation/solution.py:interpret` — Another string-replacement problem; compare the approach when multiple distinct substitutions are needed
- [general] `str.replace-vs-regex` — When `str.replace` suffices vs. when `re.sub` becomes necessary (pattern matching, conditional replacement, backreferences)

## Beliefs

- `defang-uses-single-replace` — The solution performs exactly one `str.replace` call with no loops, regex, or manual character iteration.
- `defang-no-input-validation` — The method assumes `address` is a valid IPv4 string and performs zero validation or error handling.
- `defang-pure-function` — `defangIPaddr` has no side effects, no instance state, and no imports; its output depends solely on its input.
- `defang-three-dots-invariant` — For any valid IPv4 input, the output contains exactly three `[.]` substrings, corresponding to the three dots in the address.

