# File: check-distances-between-same-letters/solution.py

**Date:** 2026-06-06
**Time:** 15:34

## `check-distances-between-same-letters/solution.py`

### Purpose

This file solves [LeetCode 2399: Check Distances Between Same Letters](https://leetcode.com/problems/check-distances-between-same-letters/). It owns the single responsibility of validating whether a string is "well-spaced" — meaning that for every letter appearing exactly twice, the number of characters between its two occurrences matches the value specified in a distance array.

### Key Components

**`well_spaced_string(s, distance) -> bool`** — the sole public function. It takes a string `s` (where each letter appears exactly twice) and a length-26 `distance` array (one entry per lowercase letter, indexed `a`=0 through `z`=25). Returns `True` if every letter pair satisfies its required spacing.

### Patterns

**Single-pass with early exit.** The function uses a dictionary `first_seen` to record the index of each letter's first occurrence. On the second occurrence, it immediately checks the distance constraint and short-circuits with `False` on the first violation. This avoids scanning the full string when a mismatch appears early.

**Index arithmetic for distance.** The distance between two positions `i` and `j` (where `j > i`) is defined as `i - first_seen[c] - 1` — the count of characters *strictly between* the two occurrences, not inclusive. This matches the LeetCode problem's definition.

**`ord()` mapping for letter-to-index.** `ord(c) - ord("a")` converts a lowercase letter to its 0-based index into the `distance` array. This is the standard idiom for this kind of problem.

### Dependencies

**Imports:** None — pure Python, no standard library or third-party imports.

**Imported by:** `check-distances-between-same-letters/test_solution.py` (the "Imported By" list in the prompt appears to be a test-runner artifact — hundreds of test files reference it, but that's likely because a shared test harness imports all solution modules, not because those other problems depend on this function).

### Flow

1. Initialize empty dict `first_seen`.
2. Iterate over `s` with `enumerate`, yielding `(index, character)` pairs.
3. If the character was seen before (exists in `first_seen`):
   - Compute the gap: `i - first_seen[c] - 1`.
   - Look up the required distance: `distance[ord(c) - ord("a")]`.
   - If they don't match, return `False` immediately.
4. If the character hasn't been seen, record its index.
5. If the loop completes without returning `False`, return `True`.

### Invariants

- **Each letter appears exactly twice** — the problem guarantees this. The code doesn't validate it; if a letter appeared three times, the third occurrence would overwrite nothing (the `first_seen` entry was already consumed on the second occurrence, but the dict entry persists, so the third would re-check against the *first* occurrence's index — a latent bug if the precondition were violated).
- **`distance` has exactly 26 entries** — assumed but not validated.
- **`s` contains only lowercase letters** — the `ord(c) - ord("a")` mapping would produce out-of-range indices otherwise.

### Error Handling

None. The function trusts its inputs match the problem constraints. No exceptions are raised or caught. Invalid inputs (uppercase letters, missing distance entries, letters appearing more or fewer than twice) would produce silent wrong answers or `IndexError`, not descriptive failures. This is typical for competitive programming solutions.

## Topics to Explore

- [file] `check-distances-between-same-letters/test_solution.py` — See the test cases to understand edge cases and how the function is exercised
- [file] `check-distances-between-same-letters/plan.md` — The planning document may reveal alternative approaches considered
- [function] `largest-substring-between-two-equal-characters/solution.py:maxLengthBetweenEqualCharacters` — A related problem using the same first-seen-index pattern but optimizing a different objective
- [general] `first-seen-dict-pattern` — This single-pass dictionary pattern recurs across many string/array problems (e.g., two-sum, first duplicate); worth cataloging where it appears in this repo

## Beliefs

- `well-spaced-uses-exclusive-distance` — The distance formula `i - first_seen[c] - 1` counts characters *between* the two occurrences, excluding both endpoints
- `well-spaced-early-exit` — `well_spaced_string` returns `False` on the first letter pair that violates its distance constraint, without examining remaining letters
- `well-spaced-assumes-exactly-two-occurrences` — The function does not validate that each letter appears exactly twice; a third occurrence would silently compare against the first occurrence's index, not the second
- `well-spaced-no-imports` — The solution uses no imports; it relies solely on Python builtins (`dict`, `enumerate`, `ord`)

