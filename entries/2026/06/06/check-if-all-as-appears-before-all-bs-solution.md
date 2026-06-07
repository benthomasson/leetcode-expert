# File: check-if-all-as-appears-before-all-bs/solution.py

**Date:** 2026-06-06
**Time:** 15:36

## `check-if-all-as-appears-before-all-bs/solution.py`

### Purpose

This file solves [LeetCode 2124: Check if All A's Appears Before All B's](https://leetcode.com/problems/check-if-all-as-appears-before-all-bs/). It owns the single responsibility of determining whether a string of `'a'`s and `'b'`s has all `'a'`s preceding all `'b'`s — i.e., the string matches the pattern `a*b*`.

### Key Components

**`Solution.checkIfAllAsAppearsBeforeAllBs(self, s: str) -> bool`** — The only method. Takes a string consisting solely of `'a'` and `'b'` characters and returns `True` if no `'a'` appears after any `'b'`.

### Patterns

The solution uses **substring negation** rather than iteration: instead of scanning characters and tracking state transitions, it checks for the absence of the forbidden substring `"ba"`. This is the idiomatic Python approach — delegating the scan to CPython's optimized C-level `__contains__` implementation.

The insight is that `"ba"` exists in the string if and only if some `'a'` appears after some `'b'`. The problem reduces to a single membership test.

### Dependencies

**Imports:** None. The solution is self-contained with no stdlib or third-party imports.

**Imported by:** The `test_solution.py` in the same directory imports this `Solution` class. The massive "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that import their own local `Solution` classes, not this one.

### Flow

1. Python's `not in` operator calls `str.__contains__`, which runs a substring search (a variant of the Boyer-Moore or two-way algorithm in CPython).
2. If `"ba"` is found anywhere in `s`, the method returns `False`.
3. If `"ba"` is not found, it returns `True`.

No loops, no state, no intermediate data structures. The entire function is a single expression.

### Invariants

- **Input constraint:** `s` contains only `'a'` and `'b'` characters. The solution doesn't validate this — it trusts the LeetCode contract.
- **Semantic equivalence:** `"ba" not in s` is equivalent to "the string is a (possibly empty) run of `'a'`s followed by a (possibly empty) run of `'b'`s." This holds because the only way to violate the ordering is a `'b'`-to-`'a'` transition, which is exactly the substring `"ba"`.

### Error Handling

None. The method cannot raise under valid inputs. For empty strings, `"ba" not in ""` returns `True`, which is correct (vacuously, all a's appear before all b's).

---

## Topics to Explore

- [file] `check-if-all-as-appears-before-all-bs/test_solution.py` — See what edge cases the tests cover (empty string, all-a, all-b, single character)
- [file] `check-if-all-as-appears-before-all-bs/review.md` — Read the code review for alternative approaches and complexity analysis
- [function] `check-if-binary-string-has-at-most-one-segment-of-ones/solution.py:Solution` — Structurally identical problem (no `"01"` substring), good for comparing the pattern
- [general] `substring-negation-pattern` — Several solutions in this repo reduce ordering/segmentation problems to checking for a forbidden 2-character substring

## Beliefs

- `ba-substring-equivalence` — `"ba" not in s` is true if and only if every `'a'` in `s` precedes every `'b'` in `s`, given the input contains only `'a'` and `'b'`
- `constant-space-linear-time` — The solution runs in O(n) time and O(1) space via CPython's built-in substring search
- `no-input-validation` — The method assumes the caller satisfies the LeetCode constraint (only `'a'` and `'b'` characters); it does not guard against other characters
- `empty-string-returns-true` — An empty input returns `True`, correctly handling the vacuous case

