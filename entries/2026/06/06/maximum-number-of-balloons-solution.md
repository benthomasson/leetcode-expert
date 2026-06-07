# File: maximum-number-of-balloons/solution.py

**Date:** 2026-06-06
**Time:** 17:38

## `maximum-number-of-balloons/solution.py`

### Purpose

This file solves [LeetCode #1189 — Maximum Number of Balloons](https://leetcode.com/problems/maximum-number-of-balloons/). Given a string of lowercase English letters, it determines how many times the word "balloon" can be spelled using the available characters. It owns both the solution and its inline test suite.

### Key Components

**`max_number_of_balloons(text: str) -> int`** — The sole solver function. It counts character frequencies in `text`, then returns the minimum number of complete "balloon" instances those frequencies can support.

The word "balloon" requires: `b`(1), `a`(1), `l`(2), `o`(2), `n`(1). The function expresses this directly by floor-dividing `l` and `o` counts by 2 while taking the other counts as-is, then returning the `min` across all five.

**`TestMaxNumberOfBalloons`** — Nine test cases covering LeetCode examples, edge cases (empty string, no matching characters, partial characters), and the critical case where a doubled letter (`l`) is the bottleneck.

### Patterns

**Counter-based frequency analysis** — the standard idiom for "how many times can I form word X from string Y." Rather than building a `Counter` for "balloon" and computing `min(text_count[c] // balloon_count[c])`, this solution hardcodes the target frequencies. That's simpler for a fixed target word but wouldn't generalize (see `rearrange-characters-to-make-target-string/solution.py` for the generalized version).

**Implicit zero from Counter** — `Counter` returns 0 for missing keys, so there's no need for `.get(c, 0)`. If `text` has no `'b'`, `count['b']` is 0 and `min(...)` correctly returns 0.

### Dependencies

**Imports:** `collections.Counter` (frequency counting), `unittest` (inline tests).

**Imported by:** The massive `Imported By` list is misleading — those are test files across the entire repo that likely share a common test runner or import pattern, not files that actually call `max_number_of_balloons`. The real consumer is `maximum-number-of-balloons/test_solution.py`.

### Flow

1. `Counter(text)` builds a frequency map in O(n) time, one pass.
2. `min(...)` computes the bottleneck across the five required characters. Each lookup is O(1).
3. The `// 2` on `l` and `o` accounts for "balloon" needing two of each.

Total: O(n) time, O(1) space (the counter has at most 26 keys).

### Invariants

- The input is assumed to be lowercase English letters only (per the problem constraints). No validation is performed.
- The return value is always non-negative — `Counter` returns non-negative integers and `//` on non-negative integers stays non-negative.
- The five characters in `min(...)` are exactly the distinct characters in "balloon" — missing any one would produce incorrect results.

### Error Handling

None. The function trusts its input. An empty string yields 0 naturally through `Counter`'s default-zero behavior. Non-string inputs would raise at the `Counter` call.

---

## Topics to Explore

- [file] `rearrange-characters-to-make-target-string/solution.py` — The generalized version of this problem: forming an arbitrary target string, not just "balloon"
- [function] `find-words-that-can-be-formed-by-characters/solution.py:countCharacters` — Same Counter-based frequency pattern applied to multiple words
- [file] `ransom-note/solution.py` — Another character-availability problem using Counter; checks if one string can be formed from another
- [general] `counter-vs-manual-frequency-maps` — When hardcoding target frequencies (as here) beats computing them dynamically, and vice versa
- [file] `check-if-all-characters-have-equal-number-of-occurrences/solution.py` — Related frequency-analysis problem with a different predicate over the counts

## Beliefs

- `balloon-needs-double-l-and-o` — The `// 2` divisor is applied to exactly `l` and `o` because "balloon" contains two of each; all other target characters appear once
- `counter-default-zero-drives-correctness` — The solution relies on `Counter.__missing__` returning 0 for absent keys; no explicit key-existence checks are needed
- `solution-is-linear-time-constant-space` — `Counter(text)` is O(n) and bounded to 26 entries; the `min` over 5 values is O(1)
- `hardcoded-target-not-generalizable` — The five-argument `min(...)` encodes the word "balloon" directly; changing the target word requires rewriting the return expression

