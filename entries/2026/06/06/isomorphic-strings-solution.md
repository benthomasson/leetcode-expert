# File: isomorphic-strings/solution.py

**Date:** 2026-06-06
**Time:** 17:09

## Purpose

This file implements [LeetCode 205 — Isomorphic Strings](https://leetcode.com/problems/isomorphic-strings/). It determines whether two strings `s` and `t` have a one-to-one character mapping — every occurrence of character `x` in `s` maps to the same character `y` in `t`, and no two distinct characters in `s` map to the same character in `t`.

The file exports a single function `is_isomorphic` consumed by `test_solution.py` in the same directory (and, per the import list, by hundreds of other test files — likely via a shared test harness that discovers solutions generically).

## Key Components

**`is_isomorphic(s, t) -> bool`** — The sole public function. Contract:
- Precondition: `s` and `t` are strings of equal length (guaranteed by the problem).
- Returns `True` iff there exists a bijection between characters of `s` and characters of `t` that transforms `s` into `t`.

Two internal dictionaries enforce the bijection:
- `s_to_t`: maps each character in `s` to its assigned character in `t` (the forward mapping).
- `t_to_s`: maps each character in `t` back to its assigned character in `s` (the reverse mapping).

## Patterns

**Dual-map bijection enforcement.** This is the standard idiom for checking isomorphism between two sequences. A single map only enforces a function (many-to-one is allowed); the second map enforces injectivity, making it a bijection. This pattern appears wherever you need to verify a one-to-one correspondence — e.g., word pattern matching (LeetCode 290).

**Early-return on violation.** The function short-circuits with `return False` the moment it detects a conflict, avoiding unnecessary iteration over the rest of the strings.

## Dependencies

- **Imports**: None beyond builtins. Pure function with no external dependencies.
- **Imported by**: `isomorphic-strings/test_solution.py` directly, plus ~400 other test files (likely an artifact of a shared test runner importing all solutions uniformly, not because those tests actually exercise this function).

## Flow

For each position `i`, `zip(s, t)` yields the character pair `(c_s, c_t)`:

1. **Forward conflict check** (line 17–19): If `c_s` was previously mapped, verify it still maps to `c_t`. If not → `False`.
2. **Reverse conflict check** (line 20–21): If `c_s` is unmapped but `c_t` is already claimed by a different `s`-character → `False`. This prevents two distinct `s`-characters from collapsing onto the same `t`-character.
3. **Register new mapping** (line 22–24): Both directions recorded simultaneously.
4. **Success** (line 26): If the entire string is consumed without conflict, return `True`.

Example trace with `s="egg"`, `t="add"`:
- `(e,a)`: both maps empty → record `e↔a`
- `(g,d)`: both maps miss → record `g↔d`
- `(g,d)`: `s_to_t[g] == d` ✓ → continue
- Return `True`

Example trace with `s="foo"`, `t="bar"`:
- `(f,b)`: record `f↔b`
- `(o,a)`: record `o↔a`
- `(o,r)`: `s_to_t[o] == a ≠ r` → return `False`

## Invariants

1. **Bijection maintained at every step**: After processing position `i`, for every key `k` in `s_to_t`, `t_to_s[s_to_t[k]] == k` and vice versa. The two maps are always consistent mirrors.
2. **Equal-length assumption**: `zip` silently truncates to the shorter string. The function relies on the LeetCode guarantee that `len(s) == len(t)` — it does not validate this.
3. **Both maps updated atomically**: A new pair is always written to both `s_to_t` and `t_to_s` together (lines 23–24), never one without the other.

## Error Handling

None. The function assumes valid input per the problem constraints. No exceptions are raised or caught. Invalid input (e.g., strings of different lengths) would silently produce an incorrect result rather than an error.

---

## Topics to Explore

- [file] `isomorphic-strings/test_solution.py` — See what edge cases the test suite covers (empty strings, single char, all-same characters)
- [function] `word-pattern/solution.py` — If it exists, compare the identical dual-map bijection pattern applied to word-level tokens instead of characters
- [file] `isomorphic-strings/plan.md` — Read the planning doc to see if alternative approaches (e.g., canonical-form comparison via `str.translate`) were considered and rejected
- [general] `zip-truncation-safety` — Across the repo, whether equal-length preconditions are ever validated or always assumed from problem constraints

## Beliefs

- `isomorphic-dual-map-bijection` — `is_isomorphic` enforces a bijection (not just a function) by maintaining two synchronized dictionaries, one per direction
- `isomorphic-early-return` — The function returns `False` at the first conflict; it never scans the full input when a violation exists at position `i`
- `isomorphic-no-length-validation` — The function assumes `len(s) == len(t)` and will silently produce wrong results if this precondition is violated
- `isomorphic-zero-dependencies` — The solution uses only Python builtins (`dict`, `zip`) with no imports

