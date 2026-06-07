# File: shortest-completing-word/solution.py

**Date:** 2026-06-06
**Time:** 19:04

## Purpose

This file solves [LeetCode 748: Shortest Completing Word](https://leetcode.com/problems/shortest-completing-word/). It owns both the solution and its test suite in a single module — the standard layout for this repo where each problem directory contains a `solution.py` with implementation + inline tests.

The problem: given a license plate string (mixed letters, digits, spaces) and a list of lowercase words, find the shortest word that contains every letter from the plate (ignoring digits/spaces, case-insensitive). Ties go to the word appearing first.

## Key Components

### `shortestCompletingWord(licensePlate, words) -> str`

The sole public function. Contract:

- **Input**: `licensePlate` — arbitrary string with letters, digits, spaces. `words` — non-empty list of lowercase strings. At least one word is guaranteed to be a completing word (per the problem constraints).
- **Output**: The shortest completing word, first-occurrence wins on ties.
- **Returns `None`** if no completing word exists (shouldn't happen per problem guarantees, but the code doesn't guard against it).

### `TestShortestCompletingWord`

Seven test cases covering: basic examples, single-letter plates, tie-breaking by order, mixed-case plates, plates that are mostly digits/spaces, and repeated letters requiring exact multiplicity.

## Patterns

**Counter subtraction for multiset containment.** The key idiom is on line 16:

```python
if not (plate - Counter(word)):
```

`Counter.__sub__` drops zero/negative counts, so `plate - Counter(word)` yields an empty `Counter` (falsy) exactly when `word` contains at least as many of every letter as `plate` requires. This is a standard Python idiom for "is A a sub-multiset of B."

**Linear scan with running minimum.** Rather than sorting or using `min()` with a key, the code iterates once and tracks `result` manually. This preserves first-occurrence tie-breaking naturally — a later word of equal length won't replace `result` because of the strict `<`.

## Dependencies

**Imports:** `collections.Counter` (multiset operations), `unittest` (test harness).

**Imported by:** The "Imported By" list in the prompt is misleading — those are *other* problems' test files that likely share a common test runner or import pattern, not files that actually import `shortestCompletingWord`. The only genuine consumer is `shortest-completing-word/test_solution.py`.

## Flow

1. **Extract plate letters**: Generator expression filters `licensePlate` to alpha characters, lowercases them, feeds into `Counter`. This produces a frequency map like `{'s': 1, 'p': 1, 't': 1}` for `"1s3 PSt"`.

2. **Scan words**: For each word, build its `Counter` and subtract the plate counter. If the result is empty (all plate letters are satisfied), check if this word is shorter than the current best.

3. **Return**: The first shortest completing word found, or `None` if none exists.

**Time complexity**: O(n·m) where n = number of words and m = average word length (for building each word's Counter). **Space**: O(1) extra beyond the counters (plate alphabet is bounded at 26).

## Invariants

- **Case normalization happens once**, at plate parsing time. Words are assumed lowercase per the problem contract — the code does not lowercase them.
- **Tie-breaking is strictly by length, then by input order.** The `<` (not `<=`) ensures the first word of a given length wins.
- **Digits and spaces in `licensePlate` are silently dropped** by the `isalpha()` filter — they don't affect the required letter counts.

## Error Handling

None. The function assumes valid inputs per LeetCode guarantees. If `words` is empty or no word completes the plate, it returns `None` — no exception raised. The `Counter` subtraction is safe on any string input.

## Topics to Explore

- [file] `shortest-completing-word/plan.md` — Problem-solving approach and complexity analysis before implementation
- [file] `shortest-completing-word/test_solution.py` — Whether additional edge cases exist beyond the inline tests
- [function] `find-common-characters/solution.py:commonChars` — Another problem likely using Counter intersection, a related multiset pattern
- [general] `counter-subtraction-idiom` — How `Counter.__sub__` vs `Counter.subtract` differ (the former drops non-positives, the latter doesn't) and when each is appropriate
- [file] `rearrange-characters-to-make-target-string/solution.py` — Similar "does source contain enough of each letter" problem, likely uses the same Counter containment check

## Beliefs

- `counter-sub-empty-means-containment` — `not (A - Counter(B))` is true iff B contains at least as many of every key as A; this is the sole correctness mechanism for the completing-word check
- `plate-parsing-ignores-non-alpha` — Only alphabetic characters from `licensePlate` contribute to the required letter counts; digits and spaces are filtered by `isalpha()`
- `tie-breaking-favors-first-occurrence` — When multiple words have the same minimal length, the one appearing earliest in `words` is returned, enforced by strict `<` comparison
- `word-case-not-normalized` — The solution lowercases plate letters but assumes `words` are already lowercase per the problem contract

