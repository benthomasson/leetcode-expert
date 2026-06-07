# File: count-items-matching-a-rule/solution.py

**Date:** 2026-06-06
**Time:** 15:59

## Purpose

This file solves [LeetCode 1773 — Count Items Matching a Rule](https://leetcode.com/problems/count-items-matching-a-rule/). It owns a single responsibility: given a list of items (each described by a type/color/name triple) and a filtering rule, count how many items match.

## Key Components

**`Solution.countMatches`** — The only method. Takes a list of string triples, a rule key (`"type"`, `"color"`, or `"name"`), and a rule value. Returns the count of matching items.

The core trick is the dictionary lookup on line 14:

```python
index = {"type": 0, "color": 1, "name": 2}[ruleKey]
```

This maps the semantic key name to its positional index in each `[type, color, name]` triple, then uses a generator expression to count matches in a single pass.

## Patterns

- **Dictionary dispatch for index mapping** — avoids an if/elif chain. This is a common Python idiom for mapping string keys to behavior or positions.
- **Generator expression with `sum`** — `sum(1 for item in items if ...)` is idiomatic Python for counting filtered elements, equivalent to `len([...])` but without allocating the intermediate list.

## Dependencies

**Imports:** `typing.List` only — no external or project-internal dependencies.

**Imported by:** The `test_solution.py` in the same directory. The long "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share the same `Solution` class name pattern; they import from their own `solution.py`, not this one.

## Flow

1. Translate `ruleKey` string to an integer index (0, 1, or 2).
2. Iterate over every item in `items`.
3. For each item, compare `item[index]` against `ruleValue`.
4. Sum up the matches and return.

Single pass, O(n) time, O(1) extra space.

## Invariants

- `ruleKey` **must** be one of `"type"`, `"color"`, or `"name"`. Any other value raises a `KeyError` from the dictionary lookup — there's no defensive check.
- Each item in `items` must have at least 3 elements. The code trusts the LeetCode contract and doesn't bounds-check.

## Error Handling

None. An invalid `ruleKey` produces an unhandled `KeyError`. This is appropriate for a LeetCode solution where inputs are guaranteed valid by the problem constraints.

## Topics to Explore

- [file] `count-items-matching-a-rule/test_solution.py` — See what edge cases the test suite covers and whether invalid ruleKey is tested
- [file] `count-items-matching-a-rule/review.md` — Read the code review for any noted improvements or alternatives
- [general] `dict-dispatch-pattern` — Compare this dictionary-as-dispatch approach with other solutions in the repo that use if/elif chains for similar key-to-index mappings
- [function] `count-the-number-of-consistent-strings/solution.py:countConsistentStrings` — Another filtering-and-counting problem worth comparing for pattern similarity

## Beliefs

- `count-matches-uses-dict-dispatch` — `countMatches` maps `ruleKey` to a positional index via a dictionary literal rather than conditional branching
- `count-matches-raises-on-invalid-key` — Passing a `ruleKey` not in `{"type", "color", "name"}` raises `KeyError` with no fallback
- `count-matches-single-pass` — The method iterates over `items` exactly once, O(n) time and O(1) auxiliary space
- `count-matches-no-external-deps` — The solution depends only on `typing.List` from the standard library

