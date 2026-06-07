# File: count-asterisks/solution.py

**Date:** 2026-06-06
**Time:** 15:54

## `count-asterisks/solution.py`

### Purpose

This file solves [LeetCode 2315: Count Asterisks](https://leetcode.com/problems/count-asterisks/). It owns the single responsibility of counting `*` characters in a string while ignoring any `*` that falls between a matched pair of `|` delimiters. It's the canonical solution module for this problem in the `leetcode-implementations` repo.

### Key Components

**`count_stars_except_between_pair(s: str) -> int`** — The sole function. Its contract:

- **Input**: A string `s` containing lowercase letters, `|`, and `*`. The problem guarantees an even number of `|` characters, so every `|` has a partner.
- **Output**: The count of `*` characters that are *not* enclosed between any paired `|` delimiters.
- **Side effects**: None. Pure function.

### Patterns

**Toggle-flag state machine** — The function uses a boolean `inside` as a two-state automaton. Each `|` flips the state. This is the standard idiom for "skip content between matched delimiters" when delimiters don't nest and always come in pairs. It avoids the overhead of splitting or regex and processes the string in a single pass.

The approach is O(n) time, O(1) space — no auxiliary data structures, no string slicing.

### Dependencies

**Imports**: None. The function uses only Python builtins.

**Imported by**: The "Imported By" list in the prompt is misleading — those hundreds of test files are unrelated problems. The actual consumer is `count-asterisks/test_solution.py`. The other test files likely share a common test harness or conftest that imports broadly, not this function specifically.

### Flow

1. Initialize `count = 0` (accumulator) and `inside = False` (state flag).
2. Iterate character-by-character over `s`.
3. On `|`: toggle `inside`. This pairs the 1st `|` with the 2nd, the 3rd with the 4th, etc.
4. On `*` when `inside is False`: increment `count`. Asterisks inside paired bars are silently skipped.
5. All other characters (lowercase letters, `*` when inside): ignored.
6. Return the final count.

For input `"l|*e*et|c**o|*de|"`:
- `l` → outside, not `*`, skip
- `|` → toggle to inside
- `*e*et` → inside, all skipped
- `|` → toggle to outside
- `c**o` → outside, two `*` counted → count = 2
- `|` → toggle to inside
- `*de` → inside, skipped
- `|` → toggle to outside
- Result: **2**

### Invariants

- **Even `|` count** is a precondition from the problem statement. If violated, the function still runs without error but `inside` would be `True` at the end, which could silently miscount trailing asterisks. The function does not validate this.
- **Pairing is positional**: the 1st and 2nd `|` form a pair, the 3rd and 4th form a pair, etc. There's no nesting or matching logic — the toggle naturally enforces left-to-right sequential pairing.

### Error Handling

None. The function assumes valid input per the problem constraints. An empty string returns 0 (the loop simply doesn't execute). No exceptions are raised or caught.

## Topics to Explore

- [file] `count-asterisks/test_solution.py` — See what edge cases are tested (empty string, no bars, consecutive bars, all-asterisk segments)
- [file] `count-asterisks/plan.md` — The problem analysis and approach reasoning before implementation
- [function] `maximum-nesting-depth-of-the-parentheses/solution.py:maxDepth` — A related toggle/counter pattern but tracking depth instead of a binary flag
- [general] `toggle-flag-vs-split-approach` — Compare this single-pass toggle to the alternative of `s.split('|')` and summing `*` counts at even indices

## Beliefs

- `count-asterisks-linear-scan` — `count_stars_except_between_pair` processes the input in a single O(n) pass with O(1) auxiliary space
- `count-asterisks-toggle-pairing` — Pipe characters are paired sequentially by position (1st with 2nd, 3rd with 4th) via a boolean toggle, not by any matching or nesting logic
- `count-asterisks-no-validation` — The function does not validate that `|` count is even; it trusts the caller to satisfy this precondition
- `count-asterisks-pure-function` — The function is pure with no side effects, no imports, and no mutable state beyond local variables

