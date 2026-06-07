# File: first-unique-character-in-a-string/solution.py

**Date:** 2026-06-06
**Time:** 16:51

## `first-unique-character-in-a-string/solution.py`

### Purpose

This file solves [LeetCode 387 — First Unique Character in a String](https://leetcode.com/problems/first-unique-character-in-a-string/). It owns a single responsibility: given a string of lowercase English letters, return the index of the first character that appears exactly once, or `-1` if every character repeats.

### Key Components

**`firstUniqChar(s: str) -> int`** — The sole public function. Contract:
- **Input**: a string `s` of lowercase English letters (constraint from the problem).
- **Output**: integer index of the first non-repeating character, or `-1` if none exists.
- **Side effects**: none. Pure function.

### Patterns

**Two-pass frequency counting** — a classic idiom for "first X satisfying a frequency condition" problems:

1. **Pass 1** (`Counter(s)`): Build a complete frequency map in O(n) time.
2. **Pass 2** (`for i, c in enumerate(s)`): Walk the string in original order, returning the first character whose count is exactly 1.

This is the canonical approach for this problem class. The alternative — using `s.index()` per distinct character — would be O(n·k) where k is alphabet size, which is fine for a 26-letter alphabet but less idiomatic. The `Counter` approach generalizes cleanly to arbitrary alphabets.

The function uses early return: it exits as soon as the first unique character is found, avoiding unnecessary iteration.

### Dependencies

**Imports**: `collections.Counter` — the only external dependency. Standard library, no third-party packages.

**Imported by**: `first-unique-character-in-a-string/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those other test files likely import shared test utilities, not this solution.

### Flow

```
s = "leetcode"
       │
       ▼
Counter(s) → {'l':1, 'e':3, 't':1, 'c':1, 'o':1, 'd':1}
       │
       ▼
enumerate(s): i=0 c='l' → counts['l']==1 → return 0
```

For `s = "aabb"`: the loop exhausts all characters without finding count==1, falls through to `return -1`.

### Invariants

- The frequency map is computed over the **entire** string before any lookup. This guarantees that `counts[c] == 1` means globally unique, not just "unseen so far."
- Iteration order in pass 2 matches string order, ensuring the **first** unique character is returned, not an arbitrary one.

### Error Handling

None — and none is needed. `Counter("")` returns an empty counter, the loop body never executes, and `-1` is returned. The function handles the empty-string edge case implicitly.

### Complexity

- **Time**: O(n) — two linear passes over `s`.
- **Space**: O(1) — the counter holds at most 26 entries (lowercase English letters constraint). Effectively O(k) where k is alphabet size, but k is bounded by 26.

## Topics to Explore

- [file] `first-unique-character-in-a-string/test_solution.py` — See what edge cases the tests cover (empty string, all duplicates, single char)
- [file] `first-unique-character-in-a-string/review.md` — Read the code review for alternative approaches or noted tradeoffs
- [function] `ransom-note/solution.py:canConstruct` — Another Counter-based frequency problem; compare how the pattern adapts when checking subset relationships instead of uniqueness
- [general] `two-pass-vs-ordered-dict` — Python 3.7+ dicts preserve insertion order, so an `OrderedDict`-based single-structure approach is possible but unnecessary here
- [file] `first-letter-to-appear-twice/solution.py` — The inverse problem (first duplicate instead of first unique); compare the approach

## Beliefs

- `first-unique-returns-first-by-position` — The second pass iterates in string order, guaranteeing the returned index is the leftmost unique character, not merely any unique character.
- `counter-before-scan` — The frequency map is fully built before the scan begins; no character is evaluated for uniqueness against a partial count.
- `negative-one-sentinel` — The function returns `-1` (not `None` or an exception) when no unique character exists, matching LeetCode's API contract.
- `constant-space-under-constraint` — Space is O(1) because the problem constrains input to lowercase English letters, capping the counter at 26 keys.

