# File: counting-words-with-a-given-prefix/solution.py

**Date:** 2026-06-06
**Time:** 16:08

## `counting-words-with-a-given-prefix/solution.py`

### Purpose

This file solves [LeetCode 2185 — Counting Words With a Given Prefix](https://leetcode.com/problems/counting-words-with-a-given-prefix/). It provides the single function the project needs: given a list of words and a prefix string, count how many words start with that prefix. It's a straightforward string-matching problem categorized as Easy.

### Key Components

**`count_prefixes(words, pref) -> int`** — The sole public function. Takes a list of strings and a prefix, returns the count of words that begin with `pref`. The function name deviates from LeetCode's canonical `prefixCount` — this repo uses snake_case throughout.

The implementation is a one-liner: `sum(w.startswith(pref) for w in words)`. This exploits Python's truthy coercion — `str.startswith()` returns `bool`, and `sum()` treats `True` as `1`. The generator expression avoids allocating an intermediate list.

### Patterns

- **Generator-based counting**: `sum(pred(x) for x in iterable)` is the idiomatic Python replacement for a loop-and-counter. This pattern appears across many solutions in this repo.
- **Single-function module**: No class wrapping. The repo convention is one exported function per solution file, matching LeetCode's function signature (adapted to snake_case).
- **Type-annotated signature**: Uses `List[str]` from `typing`, consistent with the repo's style for LeetCode solutions.

### Dependencies

**Imports**: `typing.List` — used only for the type annotation. On Python 3.9+ this could be replaced with `list[str]`, but the repo targets broader compatibility.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files across the entire repo that import from their *own* `solution.py`, not from this file specifically. The actual dependent is `counting-words-with-a-given-prefix/test_solution.py`.

### Flow

1. Caller passes `words` (list of strings) and `pref` (string).
2. Generator iterates over `words`, calling `w.startswith(pref)` on each.
3. `sum()` consumes the generator, accumulating `True` values as `1`.
4. Returns the integer count.

No early termination — every word is checked. This is fine given LeetCode's constraints (n ≤ 100, word length ≤ 100).

### Invariants

- Assumes all strings in `words` are non-null (LeetCode guarantees lowercase English letters only).
- `pref` is assumed non-empty (constraint: `1 <= pref.length`).
- The function is pure — no mutation, no side effects.

### Error Handling

None. The function trusts its inputs per LeetCode's contract. An empty `words` list returns `0` naturally (sum of empty generator). A `pref` longer than any word simply yields all `False` from `startswith`, returning `0`.

## Topics to Explore

- [file] `counting-words-with-a-given-prefix/test_solution.py` — See what edge cases the test suite covers (empty list, prefix longer than words, all-match / no-match)
- [file] `count-prefixes-of-a-given-string/solution.py` — The inverse problem (count which strings are prefixes of a target); compare the approach
- [file] `check-if-string-is-a-prefix-of-array/solution.py` — Related prefix problem with a different structure (concatenation-based)
- [general] `generator-vs-listcomp-counting` — Whether `sum(gen)` vs `sum([listcomp])` matters for these small input sizes; the repo consistently uses generators

## Beliefs

- `count-prefixes-pure-function` — `count_prefixes` is a pure function with no side effects, no mutation, and deterministic output for any given input.
- `count-prefixes-linear-time` — `count_prefixes` runs in O(n * m) time where n is `len(words)` and m is `len(pref)`, checking every word exactly once.
- `count-prefixes-handles-empty-words` — Passing an empty `words` list returns `0` without error, as `sum()` over an empty generator yields `0`.
- `imported-by-list-is-cross-repo-artifact` — The "Imported By" list reflects test files importing their own local `solution.py`, not actual cross-module dependencies on this file.

