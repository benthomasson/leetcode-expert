# File: ransom-note/solution.py

**Date:** 2026-06-06
**Time:** 18:38

## `ransom-note/solution.py`

### Purpose

This file implements the solution to [LeetCode 383 — Ransom Note](https://leetcode.com/problems/ransom-note/). It determines whether a ransom note string can be constructed by using each letter from a magazine string at most once. It owns exactly one responsibility: the `can_construct` function.

### Key Components

**`can_construct(ransom_note: str, magazine: str) -> bool`**

The sole public function. It returns `True` if every character in `ransom_note` appears in `magazine` with at least the required frequency.

The implementation is a single expression:

```python
return not (Counter(ransom_note) - Counter(magazine))
```

### Patterns

**Counter subtraction idiom.** `Counter` subtraction drops zero and negative counts, keeping only characters where `ransom_note` has a _surplus_ over `magazine`. If the resulting `Counter` is empty (falsy), every character was available — so `not empty_counter` evaluates to `True`.

This is a common Python idiom for "multiset subset" checks: `A` is a sub-multiset of `B` iff `A - B` is empty.

### Dependencies

**Imports:** `collections.Counter` — the only dependency. No custom modules.

**Imported by:** The `ransom-note/test_solution.py` file imports this function directly. The large "imported by" list in the context is an artifact of the repo's test infrastructure — those test files don't import `can_construct`; they share a common test runner pattern that indexes all solution modules.

### Flow

1. Build a `Counter` (character frequency map) for `ransom_note`.
2. Build a `Counter` for `magazine`.
3. Subtract: for each character, compute `count_in_note - count_in_magazine`. `Counter.__sub__` discards keys where the result is zero or negative.
4. If any key survives (positive count), the note needs more of that character than the magazine provides → the Counter is truthy → `not truthy` → return `False`.
5. If empty → `not {}` → return `True`.

**Time complexity:** O(n + m) where n = len(ransom_note), m = len(magazine).  
**Space complexity:** O(1) — bounded by alphabet size (at most 26 lowercase English letters per the problem constraints).

### Invariants

- Each magazine letter is consumed at most once (enforced by the subtraction semantics of `Counter`).
- The function is pure — no mutation of inputs, no side effects.
- Both arguments are expected to be strings. No explicit validation; the function relies on `Counter` accepting any iterable.

### Error Handling

None. The function delegates entirely to `Counter`, which will raise `TypeError` if given a non-iterable. Empty strings are handled correctly: `Counter("") - Counter(anything)` produces an empty `Counter`, returning `True` (an empty note can always be constructed).

---

## Topics to Explore

- [file] `ransom-note/test_solution.py` — See how edge cases (empty strings, exact match, insufficient characters) are tested
- [file] `ransom-note/plan.md` — The problem decomposition and approach selection before implementation
- [function] `find-common-characters/solution.py:commonChars` — Another Counter-intersection pattern, worth comparing with Counter subtraction
- [general] `counter-arithmetic` — Python's `Counter.__sub__` vs `Counter.subtract` (in-place) and the `&` / `|` operators for multiset intersection/union
- [file] `rearrange-characters-to-make-target-string/solution.py` — Similar "can we build X from Y" problem, likely uses Counter division (`//`) for the multi-copy variant

## Beliefs

- `counter-subtraction-drops-nonpositive` — `Counter.__sub__` discards keys with zero or negative counts, so an empty result means the first multiset is a subset of the second
- `can-construct-is-pure` — `can_construct` has no side effects and does not mutate its arguments
- `ransom-note-linear-time` — The solution runs in O(n + m) time, bounded by input lengths, with O(1) auxiliary space (alphabet-size counters)
- `empty-ransom-note-always-constructible` — `can_construct("", magazine)` returns `True` for any magazine value, including empty string

