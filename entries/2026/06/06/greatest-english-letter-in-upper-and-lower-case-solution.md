# File: greatest-english-letter-in-upper-and-lower-case/solution.py

**Date:** 2026-06-06
**Time:** 16:57

## `greatest-english-letter-in-upper-and-lower-case/solution.py`

### Purpose

This file solves [LeetCode 2309](https://leetcode.com/problems/greatest-english-letter-in-upper-and-lower-case/): given a string of English letters, find the greatest (alphabetically last) letter that appears in **both** uppercase and lowercase forms. Return the uppercase version, or `""` if no such letter exists.

### Key Components

**`get_max_occurrences(s: str) -> str`** — The sole function. Despite its name (which suggests frequency counting), it actually finds the greatest letter present in both cases. The contract: accepts any string of English letters, returns a single uppercase character or the empty string.

### Patterns

**Reverse-alphabet scan.** Rather than collecting all dual-case letters and taking the max, the function iterates `"ZYXWVUTSRQPONMLKJIHGFEDCBA"` — the alphabet in descending order. The first match is guaranteed to be the greatest, so it returns immediately. This is a classic early-exit optimization: worst case is 26 iterations (no match), best case is 1 (letter `Z` qualifies).

**Set-based membership.** The input string is converted to a `set` on line 12 before any lookups. This turns each `in` check from O(n) to O(1), making the overall function O(n) where n is the length of `s`, rather than O(26n).

### Dependencies

**Imports:** None — pure standard Python, no library dependencies.

**Imported by:** The "Imported By" list is misleading. Those 400+ test files don't actually import *this* solution — they import their own `solution.py` via a shared test harness pattern. The only genuine consumer is `greatest-english-letter-in-upper-and-lower-case/test_solution.py`.

### Flow

1. Convert `s` to a `set` of characters (O(n)).
2. Walk the uppercase alphabet from `Z` down to `A`.
3. For each uppercase letter `c`, check if both `c` and `c.lower()` exist in the set.
4. Return the first `c` that passes (greatest dual-case letter).
5. If the loop exhausts without a match, return `""`.

### Invariants

- The return value is always either a single uppercase ASCII letter or the empty string — never lowercase, never multi-character.
- The descending iteration order guarantees the first match is the lexicographic maximum without needing a separate `max()` call.
- The function is pure: no mutation of `s`, no side effects.

### Error Handling

None. The function assumes valid input (a string of English letters per the LeetCode constraint). An empty string input naturally produces `""` — the set will be empty, no uppercase letter matches, and the fallback return fires. Non-letter characters in `s` are harmless; they'll land in the set but never match an uppercase letter check.

### Naming Note

The function name `get_max_occurrences` is a misnomer — it doesn't count occurrences. A clearer name would be `greatestLetter` or `greatest_dual_case_letter`. This is likely an artifact of the automated generation pipeline used across this repo.

## Topics to Explore

- [file] `greatest-english-letter-in-upper-and-lower-case/test_solution.py` — See what edge cases the test suite covers (empty string, single case only, all 26 letters present)
- [file] `greatest-english-letter-in-upper-and-lower-case/review.md` — Check if the code review flagged the misleading function name
- [function] `longest-nice-substring/solution.py:get_max_occurrences` — Another dual-case letter problem that likely uses a similar set-based pattern; compare approaches
- [general] `function-naming-conventions` — Whether the `get_max_occurrences` name is a repo-wide template artifact or specific to this solution
- [file] `run_tests.py` — Understand the shared test harness that makes these solutions appear cross-imported

## Beliefs

- `reverse-alpha-scan-gives-max` — Iterating `"ZYXWVUTSRQPONMLKJIHGFEDCBA"` and returning on first match guarantees the lexicographically greatest result without needing `max()`
- `set-conversion-is-o1-lookup` — Converting `s` to a set before the loop ensures each membership check is O(1), making the function O(n + 26) overall
- `function-name-mismatches-behavior` — `get_max_occurrences` does not count occurrences; it finds the greatest letter appearing in both cases
- `empty-input-returns-empty-string` — When `s` is empty, the function returns `""` via the fallback path with no special-case handling needed

