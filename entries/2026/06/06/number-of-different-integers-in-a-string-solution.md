# File: number-of-different-integers-in-a-string/solution.py

**Date:** 2026-06-06
**Time:** 18:16

## `number-of-different-integers-in-a-string/solution.py`

### Purpose

This file solves [LeetCode 1805: Number of Different Integers in a String](https://leetcode.com/problems/number-of-different-integers-in-a-string/). It owns both the solution and its test suite in a single module — the standard layout across this repository.

### Key Components

**`num_different_integers(word: str) -> int`** — The sole public function. Takes a mixed alphanumeric string and returns the count of distinct integers embedded in it. The contract: letters act as separators, leading zeros are normalized (so `"1"`, `"01"`, and `"001"` are all the same integer), and a string with no digits returns `0`.

**`TestNumDifferentIntegers`** — Nine test cases covering the LeetCode examples plus edge cases (all-letters, all-digits, zeros, leading zeros).

### Patterns

The solution follows a **replace-split-normalize** idiom in two lines:

1. `re.sub(r'[a-z]', ' ', word)` — Replace every lowercase letter with a space, leaving digit runs intact.
2. `.split()` — Split on whitespace, naturally handling consecutive letters (multiple spaces collapse).
3. `{n.lstrip('0') or '0' for n in nums}` — Set comprehension for dedup. `lstrip('0')` normalizes leading zeros; the `or '0'` fallback handles the all-zeros case (where `lstrip` would produce an empty string).

The `len(set(...))` pattern is the idiomatic Python way to count distinct elements.

### Dependencies

**Imports:** `re` (regex substitution) and `unittest` (test harness). No project-internal dependencies.

**Imported by:** The `test_solution.py` in this same directory, plus the "Imported By" list in the prompt is misleading — that list appears to be the full set of test files across the repo that share the same `unittest` import pattern, not actual importers of this module.

### Flow

```
word = "a123bc34d8ef34"
  → re.sub letters → " 123  34 8  34"
  → split           → ["123", "34", "8", "34"]
  → set comprehension with lstrip('0')
                     → {"123", "34", "8"}
  → len             → 3
```

The entire transformation is a single expression pipeline — no loops, no mutable state.

### Invariants

- **Input contract:** `word` contains only lowercase English letters and digits (per LeetCode constraints). The regex `[a-z]` relies on this — uppercase letters or special characters would survive the substitution and break `.split()` behavior.
- **Zero normalization:** The string `"0"` is always preserved. `"0".lstrip('0')` yields `""`, and the `or '0'` clause catches it. This guarantees `"0"`, `"00"`, and `"000"` all map to the canonical `"0"`.
- **No integer overflow:** By operating on strings rather than converting to `int`, the solution handles arbitrarily large numbers — important since LeetCode's constraints allow digit sequences up to length 200.

### Error Handling

None. The function assumes valid input per LeetCode constraints. No try/except, no input validation. Invalid input (e.g., uppercase letters, special characters) would silently produce wrong results rather than raising.

## Topics to Explore

- [file] `number-of-different-integers-in-a-string/test_solution.py` — The external test file that imports this solution; check if it adds coverage beyond the inline tests
- [function] `second-largest-digit-in-a-string/solution.py:second_highest` — Another string-digit extraction problem; compare the parsing strategy
- [general] `string-vs-int-normalization` — This solution normalizes via string `lstrip('0')` instead of `int()` conversion — explore which other solutions in the repo make this tradeoff and why (hint: arbitrary-length digit sequences)
- [file] `number-of-valid-words-in-a-sentence/solution.py` — Another regex-based string parsing problem; compare the decomposition approach

## Beliefs

- `leading-zero-normalization-uses-string-not-int` — `num_different_integers` normalizes leading zeros via `str.lstrip('0')`, not `int()` conversion, making it safe for digit sequences exceeding Python's typical numeric ranges
- `letter-replacement-preserves-digit-adjacency` — Replacing `[a-z]` with spaces and splitting guarantees that consecutive digits remain grouped as a single number token
- `zero-string-fallback-prevents-empty-key` — The `or '0'` in the set comprehension ensures the all-zeros case (`"000"`) maps to `"0"` rather than the empty string, which would miscount
- `solution-assumes-lowercase-only-input` — The regex `[a-z]` does not handle uppercase letters; the function produces incorrect results if the input contains characters outside `[a-z0-9]`

