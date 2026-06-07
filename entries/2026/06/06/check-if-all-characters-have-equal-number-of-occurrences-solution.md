# File: check-if-all-characters-have-equal-number-of-occurrences/solution.py

**Date:** 2026-06-06
**Time:** 15:36

## Purpose

This file solves [LeetCode 1941: Check if All Characters Have Equal Number of Occurrences](https://leetcode.com/problems/check-if-all-characters-have-equal-number-of-occurrences/). Given a string `s`, it returns `True` if every distinct character appears the same number of times. It's a classic frequency-uniformity check.

## Key Components

**`Solution.areOccurrencesEqual(self, s: str) -> bool`** — The core method. Counts character frequencies with `Counter`, extracts the frequency values, converts them to a set, and checks that the set has exactly one element. If all characters share the same count, the set of counts is `{k}` for some `k`, so its length is 1.

**`make_string_sorted`** — A module-level alias that binds `Solution().areOccurrencesEqual` as a bare function. This is the repo's convention for exposing solutions to the test harness. The name `make_string_sorted` is a misnomer — it doesn't match the problem — likely a copy-paste artifact from the repo's code generation tooling.

## Patterns

- **One-liner reduction**: The entire algorithm is a single expression — `len(set(Counter(s).values())) == 1`. This is a common Python idiom for "are all values in a collection equal?"
- **Module-level alias**: Every solution file in this repo instantiates `Solution()` and binds the target method to a top-level name so tests can import it uniformly without knowing the class API.

## Dependencies

**Imports**: `collections.Counter` — standard library, no external deps.

**Imported by**: The massive `imported_by` list is misleading. Those are test files for *other* problems, not consumers of this solution's logic. The actual consumer is `check-if-all-characters-have-equal-number-of-occurrences/test_solution.py`. The cross-references likely reflect a shared test runner or import pattern rather than real code dependencies.

## Flow

1. `Counter(s)` builds a `{char: count}` mapping in O(n).
2. `.values()` yields the counts (a `dict_values` view).
3. `set(...)` deduplicates the counts.
4. `len(...) == 1` checks that exactly one distinct count exists.

For `s = "abacbc"`: Counter gives `{'a':2, 'b':2, 'c':2}`, values are `[2,2,2]`, set is `{2}`, length is 1 → `True`.

For `s = "aaabb"`: Counter gives `{'a':3, 'b':2}`, values are `[3,2]`, set is `{3,2}`, length is 2 → `False`.

## Invariants

- The input `s` is guaranteed non-empty per the LeetCode constraints (1 ≤ len(s) ≤ 1000), so `Counter(s).values()` is never empty and `set(...)` always has at least one element.
- Time complexity is O(n) where n = len(s). Space is O(k) where k is the alphabet size (at most 26 lowercase English letters per the problem constraints).

## Error Handling

None. The function assumes valid input per LeetCode guarantees. An empty string would produce an empty `Counter`, an empty set, and `len(set()) == 1` → `False`, which is a reasonable degenerate answer but not explicitly handled.

## Topics to Explore

- [file] `check-if-all-characters-have-equal-number-of-occurrences/test_solution.py` — See what edge cases the test suite covers (single char, all same, mixed)
- [file] `check-if-all-characters-have-equal-number-of-occurrences/review.md` — The code review may note the `make_string_sorted` naming issue
- [function] `remove-letter-to-equalize-frequency/solution.py:equalFrequency` — The harder variant: can removing one character make all frequencies equal?
- [general] `Counter-set-pattern` — The `len(set(Counter(x).values())) == 1` idiom appears across multiple solutions in this repo for uniformity checks

## Beliefs

- `equal-freq-single-expression` — The entire algorithm is a single expression with no branching, loops, or intermediate variables
- `make-string-sorted-is-misnomer` — The module-level alias `make_string_sorted` does not match the problem name or the method it wraps (`areOccurrencesEqual`)
- `counter-set-len-one-idiom` — Checking `len(set(values)) == 1` is the canonical Python idiom for "all elements are equal" and is used here for frequency uniformity
- `empty-string-returns-false` — On empty input (outside LeetCode constraints), the function returns `False` because `set()` has length 0, not 1

