# File: check-if-number-has-equal-digit-count-and-digit-value/solution.py

**Date:** 2026-06-06
**Time:** 15:41

## Purpose

This file solves [LeetCode 2283: Check if Number Has Equal Digit Count and Digit Value](https://leetcode.com/problems/check-if-number-has-equal-digit-count-and-digit-value/). It's a self-describing number check: given a string `num` of length `n`, verify that for every index `i` (0 through n-1), the digit `i` appears in `num` exactly `int(num[i])` times.

For example, `"1210"` is valid: digit 0 appears 1 time, digit 1 appears 2 times, digit 2 appears 1 time, digit 3 appears 0 times.

## Key Components

**`Solution.digitCount(self, num: str) -> bool`** — The core method. Counts digit frequencies with `Counter`, then checks every index against its expected count in a single `all()` expression.

**`rearrange_array`** — A module-level alias that binds `Solution().digitCount` to a bare function name. This is a project convention so tests can import a uniform entry point without caring about the `Solution` class.

## Patterns

**Counter + all()** — A common idiom in this repo for frequency-validation problems. `Counter(num)` builds the frequency map in O(n), then `all(...)` short-circuits on the first mismatch. The string-to-int conversion (`int(num[i])`) and int-to-string conversion (`str(i)`) bridge the two representations: `Counter` keys are characters, but `i` is an integer index.

**Missing-key safety** — `Counter` returns 0 for absent keys, so `count[str(i)]` never raises `KeyError` even when digit `i` doesn't appear in `num`. This is load-bearing — a plain `dict` would break here.

## Dependencies

**Imports:** `collections.Counter` — the only dependency.

**Imported by:** The corresponding `test_solution.py` imports from this module. The massive "Imported By" list in the context is a red herring — that's the test harness's shared import mechanism pulling in all solution modules, not a real dependency relationship.

## Flow

1. `Counter(num)` builds a `{char: count}` dict from the input string.
2. `range(len(num))` iterates index `i` from 0 to n-1.
3. For each `i`, compare `count[str(i)]` (actual frequency of digit `i`) against `int(num[i])` (expected frequency declared at position `i`).
4. `all()` returns `True` only if every index satisfies the equality.

## Invariants

- `num` contains only digit characters (guaranteed by the problem constraints).
- `len(num)` is at most 10, so `i` ranges 0–9 — all single-digit values, meaning `str(i)` always produces a valid `Counter` key.
- The comparison is exact equality, not "at least" — digit `i` must appear *exactly* `int(num[i])` times.

## Error Handling

None. The function trusts the caller to pass a valid digit string per the LeetCode contract. Passing non-digit characters or an empty string would produce wrong results silently, not exceptions (thanks to `Counter`'s defaulting behavior).

## Topics to Explore

- [file] `check-if-number-has-equal-digit-count-and-digit-value/test_solution.py` — See what edge cases the tests cover (empty string, all-zeros, longer inputs)
- [general] `self-describing-numbers` — The mathematical concept behind this problem; numbers like 2020 and 6210001000 that encode their own digit frequencies
- [function] `check-if-all-characters-have-equal-number-of-occurrences/solution.py:Solution` — A related Counter-based frequency problem that checks uniform counts rather than positional counts
- [file] `count-the-digits-that-divide-a-number/solution.py` — Another digit-counting problem with a different validation predicate

## Beliefs

- `counter-default-zero` — `Counter[str(i)]` returns 0 for digits not present in `num`, which is essential for correctness when the expected count is also 0
- `alias-is-bound-instance-method` — `rearrange_array` is a bound method on a throwaway `Solution()` instance, not a standalone function; it carries a `self` reference
- `short-circuit-on-first-mismatch` — `all()` stops iteration as soon as any index fails the equality check, so worst case is O(n) comparisons but best case is O(1)
- `misnamed-alias` — The alias `rearrange_array` has no semantic relationship to the actual problem; it's likely a copy-paste artifact from the project's code generation pipeline

