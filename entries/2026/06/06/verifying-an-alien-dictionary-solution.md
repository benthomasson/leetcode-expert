# File: verifying-an-alien-dictionary/solution.py

**Date:** 2026-06-06
**Time:** 19:41

## `verifying-an-alien-dictionary/solution.py`

### Purpose

This file solves [LeetCode 953: Verifying an Alien Dictionary](https://leetcode.com/problems/verifying-an-alien-dictionary/). Given a list of words and a string defining a custom alphabet ordering, it determines whether the words are sorted lexicographically according to that alien alphabet. It's one of ~500 solutions in the `leetcode-implementations` repo, each in its own directory.

Note: the function is misnamed `reverse_string` — it has nothing to do with reversing strings. The signature and docstring correctly describe alien dictionary verification.

### Key Components

**`reverse_string(words, order) -> bool`** — the sole public function. Despite the name, it checks whether `words` is sorted under the alphabet defined by `order`.

- **`rank` dict** (line 12): Maps each character to its ordinal position in the alien alphabet. This is the core data structure — it converts the problem from "compare under custom order" to "compare integers."

- **Pairwise comparison loop** (lines 14–20): Iterates over adjacent word pairs `(words[i], words[i+1])` and compares them character-by-character using `rank`.

### Patterns

**Rank-mapping idiom**: Building a `{char: index}` dict from the ordering string is the standard approach for custom-alphabet problems. It turns O(n) alphabet lookups into O(1) dict lookups.

**Early-exit comparison**: The inner loop mirrors how `strcmp` works — it walks characters in lockstep and returns as soon as it finds a decisive difference. Three cases at each character position:
1. `rank[w1[j]] < rank[w2[j]]` → w1 comes first, `break` (this pair is fine, move to next pair)
2. `rank[w1[j]] > rank[w2[j]]` → w1 comes after w2, `return False`
3. Equal → continue to next character

### Flow

1. Build `rank` lookup from `order`.
2. For each consecutive pair `(w1, w2)`:
   - Walk characters at matching positions.
   - If `w1` is longer than `w2` and all shared characters match (`j >= len(w2)`), return `False` — a prefix must come before the longer word.
   - If a character in `w1` ranks lower, this pair is sorted — break to the next pair.
   - If a character in `w1` ranks higher, the list isn't sorted — return `False`.
3. If all pairs pass, return `True`.

### Dependencies

**Imports**: Only `typing.List` — no external dependencies.

**Imported by**: The `test_solution.py` in the same directory. The "Imported By" list in the prompt is misleading — those hundreds of test files each import their *own* `solution.py`, not this one.

### Invariants

- `order` is assumed to be exactly 26 characters covering all lowercase English letters. No validation is performed — a missing character would raise `KeyError`.
- `words` must contain at least one element (loop range is `len(words) - 1`, which is 0 for a single word, correctly returning `True`).
- The prefix rule is enforced: `"apple"` is not considered sorted before `"app"` in any alphabet.

### Error Handling

None. The function assumes valid input per LeetCode constraints. Characters not in `order` will produce an unhandled `KeyError`. Empty `words` list returns `True` (the loop body never executes).

---

## Topics to Explore

- [file] `verifying-an-alien-dictionary/test_solution.py` — See what edge cases are covered (prefix words, single word, identical words)
- [function] `verifying-an-alien-dictionary/solution.py:reverse_string` — The function name is wrong; worth checking if the test file also uses this name or if it's a rename artifact
- [file] `verifying-an-alien-dictionary/review.md` — May contain notes on the naming issue or complexity analysis
- [general] `custom-alphabet-sorting` — The rank-map pattern recurs in problems like custom sort string (LC 791) and alien dictionary (LC 269, the topological-sort variant)

## Beliefs

- `alien-dict-prefix-rule` — If word A is a prefix of word B and A is longer, the function correctly returns False (line 17–18)
- `alien-dict-function-misnamed` — The function is named `reverse_string` but implements alien dictionary order verification; this is a naming bug
- `alien-dict-assumes-valid-order` — The function assumes `order` contains all characters appearing in `words`; missing characters cause an unhandled KeyError
- `alien-dict-linear-complexity` — Time complexity is O(M) where M is the total number of characters across all words, since each character is examined at most once

