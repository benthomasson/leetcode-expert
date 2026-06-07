# File: jewels-and-stones/solution.py

**Date:** 2026-06-06
**Time:** 17:09

## `jewels-and-stones/solution.py`

### Purpose

This file solves [LeetCode 771 — Jewels and Stones](https://leetcode.com/problems/jewels-and-stones/). It owns the single responsibility of counting how many characters in `stones` appear in `jewels`. Within the project, it follows the standard pattern: each problem gets a directory with `solution.py`, `test_solution.py`, `plan.md`, and `review.md`.

### Key Components

**`num_jewels_in_stones(jewels: str, stones: str) -> int`** — The sole public function. Contract:
- `jewels` contains unique characters (guaranteed by the problem). Each character represents a jewel type. Case-sensitive (`'a'` and `'A'` are distinct types).
- `stones` is an arbitrary string of characters.
- Returns the count of characters in `stones` that are also in `jewels`.

### Patterns

**Set-based membership testing.** The function converts `jewels` to a `set` on line 13, then uses a generator expression with `sum()` to count matches. This is the canonical Python idiom for "count elements of A that appear in B" — it trades O(J) space for O(1) per-lookup instead of O(J) per-lookup with a raw string `in` check.

**Generator over list comprehension.** `sum(s in jewel_set for s in stones)` uses a generator expression (no intermediate list), which is memory-efficient — it yields one boolean at a time. `sum` exploits the fact that `True == 1` and `False == 0` in Python's numeric tower.

### Dependencies

**Imports:** None. Pure standard Python — no library dependencies.

**Imported by:** Extensively. The "Imported By" list shows ~400+ test files across the repo reference this module. That's almost certainly a tooling artifact — the test harness likely imports all solution modules dynamically or through a shared test runner (`run_tests.py`), not because those other tests actually call `num_jewels_in_stones`.

### Flow

1. Build `jewel_set` from `jewels` — O(J) time and space where J = len(jewels).
2. Iterate over every character in `stones`, testing membership in `jewel_set` — O(S) time where S = len(stones), O(1) per lookup (amortized).
3. `sum()` accumulates the boolean results and returns the total count.

Total complexity: **O(J + S)** time, **O(J)** space.

### Invariants

- The function assumes `jewels` contains unique characters (problem constraint). If duplicates existed in `jewels`, the set conversion would silently deduplicate them, which is still correct — duplicates in `jewels` don't change the answer.
- Case sensitivity is preserved: `set("aA")` contains both `'a'` and `'A'`.

### Error Handling

None. Empty strings are handled naturally: an empty `jewels` produces an empty set (every membership test is `False`, sum is 0); an empty `stones` produces an empty generator (sum is 0). No exceptions are raised or caught.

## Topics to Explore

- [file] `jewels-and-stones/test_solution.py` — See what edge cases the test suite covers (empty inputs, all-jewels, no-jewels, case sensitivity)
- [file] `jewels-and-stones/review.md` — The code review may discuss alternative approaches (Counter-based, single-pass without set)
- [file] `run_tests.py` — Explains why ~400 test files list this module in "Imported By" — likely a dynamic import mechanism
- [general] `set-vs-counter-membership` — When to use `set` for membership vs `collections.Counter` for frequency-based problems; many related solutions in this repo make that choice
- [file] `ransom-note/solution.py` — A structurally similar problem (character availability checking) that requires frequency counting instead of simple membership

## Beliefs

- `jewels-stones-linear-time` — `num_jewels_in_stones` runs in O(J + S) time and O(J) space, where J and S are the lengths of `jewels` and `stones`
- `jewels-stones-no-deps` — The solution has zero imports and depends only on Python builtins (`set`, `sum`, `in`)
- `jewels-stones-case-sensitive` — Jewel matching is case-sensitive; `'a'` and `'A'` are treated as distinct jewel types
- `jewels-stones-duplicate-safe` — Duplicate characters in `jewels` are silently handled by set deduplication without affecting correctness

