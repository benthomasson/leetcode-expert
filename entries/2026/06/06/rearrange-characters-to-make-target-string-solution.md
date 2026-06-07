# File: rearrange-characters-to-make-target-string/solution.py

**Date:** 2026-06-06
**Time:** 18:39

## `rearrange-characters-to-make-target-string/solution.py`

### Purpose

This file solves [LeetCode 2287 — Rearrange Characters to Make Target String](https://leetcode.com/problems/rearrange-characters-to-make-target-string/). Given a source string `s` and a `target` string, it computes the maximum number of complete copies of `target` that can be formed using only the characters from `s` (each character consumed once per copy).

### Key Components

**`maxNumberOfCopies(s, target) -> int`** — The sole function. It counts character frequencies in both strings, then for each character in `target`, computes how many times that character's demand can be satisfied by `s`. The answer is the minimum across all target characters — the bottleneck letter limits how many full copies you can build.

### Patterns

**Frequency-ratio bottleneck** — This is the canonical pattern for "how many X can I build from Y" problems: count supply and demand per unit, then take the minimum ratio. It's the same idea behind `maximum-number-of-balloons/solution.py` (how many times can you spell "balloon" from a string).

**`Counter` as the abstraction** — Rather than manually building frequency dicts, the solution leans on `collections.Counter`, which makes the intent immediately clear.

### Dependencies

- **Imports**: `collections.Counter` — standard library, no external deps.
- **Imported by**: Hundreds of `test_solution.py` files across the repo reference it (this is an artifact of the test harness importing from solution modules uniformly, not because those tests actually test *this* function).

### Flow

1. `Counter(s)` builds a frequency map of available characters.
2. `Counter(target)` builds a frequency map of required characters per copy.
3. The generator `s_count[c] // t_count[c] for c in t_count` iterates over every distinct character in `target`, computing how many copies that character alone could support via integer division.
4. `min(...)` returns the bottleneck — the character that runs out first.

### Invariants

- `target` must be non-empty. If `target` is empty, `t_count` is empty and `min()` over an empty iterable raises `ValueError`.
- If `s` is missing a character that `target` needs, `s_count[c]` returns `0` (Counter's default), so `0 // t_count[c]` yields `0` — the function correctly returns 0.
- Integer division ensures only *complete* copies count.

### Error Handling

None. The function trusts its caller to provide valid, non-empty strings — appropriate for a LeetCode solution where the problem constraints guarantee `1 <= target.length`. An empty `target` would crash with `ValueError` from `min()` on an empty sequence.

---

## Topics to Explore

- [file] `rearrange-characters-to-make-target-string/test_solution.py` — See which edge cases the tests cover (empty source, repeated characters in target, etc.)
- [function] `maximum-number-of-balloons/solution.py:maxNumberOfBalloons` — Same frequency-bottleneck pattern applied to a fixed target string
- [file] `ransom-note/solution.py` — Related problem: can you form one string from another's characters (boolean variant of this pattern)
- [general] `counter-default-zero` — `Counter.__getitem__` returns 0 for missing keys, which is load-bearing here and avoids a `KeyError` guard

## Beliefs

- `empty-target-raises` — Passing an empty `target` raises `ValueError` because `min()` receives an empty generator
- `missing-char-returns-zero` — If any character in `target` is absent from `s`, the function returns 0 due to `Counter`'s default-zero behavior
- `time-complexity-linear` — Runtime is O(|s| + |target|) for counting, plus O(|unique chars in target|) for the min scan
- `space-complexity-linear` — Space is O(|alphabet|) for the two Counter objects, bounded by the character set size

