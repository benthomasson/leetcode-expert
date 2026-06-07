# File: find-common-characters/solution.py

**Date:** 2026-06-06
**Time:** 16:36

## Purpose

This file solves [LeetCode 1002 — Find Common Characters](https://leetcode.com/problems/find-common-characters/). Given a list of strings, it returns every character that appears in **all** strings, including duplicates. For example, `["bella", "label", "roller"]` returns `["e", "l", "l"]` because `e` appears at least once in every word and `l` appears at least twice in every word.

It's one of ~400+ solutions in the `leetcode-implementations` repo, following the standard structure: `solution.py` + `test_solution.py` + `review.md` + `plan.md`.

## Key Components

**`Solution.commonChars(self, words: List[str]) -> List[str]`** — the single method, matching LeetCode's expected signature. Takes a non-empty list of lowercase strings, returns a flat list of individual characters.

## Patterns

The solution uses **Counter intersection** — a concise idiom for multi-set problems:

1. Seed `common` with the character frequencies of the first word.
2. For each remaining word, intersect (`&=`) with that word's frequencies. `Counter.__iand__` keeps the **minimum count** of each key across both counters.
3. `common.elements()` expands the final counter back into individual characters (e.g., `Counter({'l': 2, 'e': 1})` → `['l', 'l', 'e']`).

This is the textbook approach for "characters common to all strings with multiplicity." The `&` operator on `Counter` objects does exactly what the problem asks for — no manual min-tracking needed.

## Dependencies

**Imports:** `collections.Counter` (the workhorse) and `typing.List` (type annotation).

**Imported by:** The `test_solution.py` files listed in the "Imported By" section aren't actually importing *this* file — that list appears to be an artifact of the repo-wide test infrastructure. The direct consumer is `find-common-characters/test_solution.py`.

## Flow

```
words = ["bella", "label", "roller"]

Step 1: common = Counter("bella")  →  {'b':1, 'e':1, 'l':2, 'a':1}
Step 2: common &= Counter("label") →  {'l':2, 'e':1, 'a':1, 'b':1} & {'l':2, 'a':1, 'b':1, 'e':1} = {'b':1, 'e':1, 'l':2, 'a':1}
Step 3: common &= Counter("roller") → {'b':1, 'e':1, 'l':2, 'a':1} & {'r':2, 'o':1, 'l':2, 'e':1} = {'e':1, 'l':2}
Step 4: list(common.elements())     → ['e', 'l', 'l']
```

Time complexity: O(n * k) where n is the number of words and k is the average word length. Space: O(1) since the counter is bounded by 26 lowercase letters.

## Invariants

- **`words` is non-empty** — the code indexes `words[0]` unconditionally. An empty list would raise `IndexError`.
- **Characters are lowercase English letters** — per the LeetCode constraint. The solution doesn't enforce this, but `Counter` would work on any characters.
- **The `&=` operation preserves minimum counts** — this is the core invariant that makes the algorithm correct. After processing all words, `common[c]` equals the minimum number of times `c` appears across all words.

## Error Handling

None. The code trusts the LeetCode contract (non-empty list of non-empty lowercase strings). An empty `words` list crashes; an empty string in `words` is handled correctly (intersection with an empty counter yields an empty counter).

## Topics to Explore

- [file] `find-common-characters/test_solution.py` — See which edge cases the test suite covers (single word, all identical, no common chars)
- [file] `find-common-characters/review.md` — Check if the review flags any alternative approaches or performance notes
- [function] `intersection-of-two-arrays-ii/solution.py:intersect` — A related problem that also uses Counter intersection but on integer arrays instead of characters
- [general] `counter-intersection-pattern` — How `Counter.__and__` and `Counter.__or__` work under the hood and where else they appear in this repo
- [file] `find-words-that-can-be-formed-by-characters/solution.py` — Another Counter-based character frequency problem with a slightly different constraint

## Beliefs

- `counter-and-is-element-wise-min` — `Counter.__iand__` keeps the minimum count of each key present in both operands, which is equivalent to multi-set intersection
- `common-chars-assumes-nonempty-input` — `commonChars` will raise `IndexError` if `words` is an empty list, relying on LeetCode's guarantee of at least one word
- `elements-expands-by-count` — `Counter.elements()` yields each key repeated by its count, converting the frequency map back to a flat character list
- `solution-is-linear-in-total-chars` — The algorithm visits each character in each word exactly once, making it O(total characters across all words)

