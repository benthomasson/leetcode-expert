# File: find-the-difference/solution.py

**Date:** 2026-06-06
**Time:** 16:45

## `find-the-difference/solution.py`

### Purpose

This file solves [LeetCode 389 — Find the Difference](https://leetcode.com/problems/find-the-difference/). Given two strings `s` and `t` where `t` is `s` shuffled with one extra character inserted, the function returns that extra character. It's one of ~500+ solution files in the `leetcode-implementations` repo, each owning a single problem's solution.

### Key Components

**`findTheDifference(s: str, t: str) -> str`** — The sole public function. Takes the original string and the augmented string, returns the single added character.

### Patterns

The solution uses **XOR cancellation** — the classic bit-manipulation trick for finding a unique element. XOR is self-inverse (`a ^ a == 0`), so XORing all characters from both strings cancels every paired character, leaving only the extra one.

The implementation is fully functional-style: `reduce(xor, ...)` over a generator that concatenates both strings' ordinals. No intermediate data structures, no mutation.

### Dependencies

**Imports:**
- `functools.reduce` — folds the XOR across all characters
- `operator.xor` — the XOR function passed to `reduce`

**Imported by:** The `test_solution.py` in the same directory, plus the "Imported By" list in the prompt is misleading — that list is likely an artifact of the test harness importing a shared runner, not this file specifically.

### Flow

1. Concatenate `s + t` into a single iterable
2. Map each character to its ordinal via `ord(c)`
3. Fold with XOR (`reduce(xor, ...)`) — paired characters cancel to 0, the extra survives
4. Convert the surviving ordinal back to a character with `chr()`

For `s = "abcd"`, `t = "abcde"`:
```
ord('a') ^ ord('b') ^ ord('c') ^ ord('d') ^ ord('a') ^ ord('b') ^ ord('c') ^ ord('d') ^ ord('e')
= 0 ^ 0 ^ 0 ^ 0 ^ ord('e')
= ord('e')
```

### Invariants

- `t` must be exactly `len(s) + 1` characters long. The XOR trick works correctly only when every character in `s` appears in `t` (possibly more than once, with the same multiplicity except for the added one).
- If `s` is empty, `t` is a single character — `reduce` still works because there's exactly one element (no initial value needed).

### Error Handling

None. If `s` and `t` are both empty, `reduce` raises `TypeError` (empty sequence with no initial value). The function trusts the caller to satisfy the LeetCode contract.

---

## Topics to Explore

- [file] `find-the-difference/test_solution.py` — See what edge cases the tests cover (empty `s`, duplicate characters, unicode)
- [file] `missing-number/solution.py` — Another XOR-cancellation solution; compare how the same bit trick applies to arrays vs strings
- [file] `hamming-distance/solution.py` — Related bit-manipulation problem using XOR to count differing bits
- [general] `xor-cancellation-pattern` — How XOR self-inverse property is used across multiple problems (single-number, missing-number, find-the-difference)

## Beliefs

- `xor-finds-unique-char` — XORing all characters of `s + t` isolates the extra character because every matched character cancels to zero
- `no-extra-space-used` — The solution uses O(1) auxiliary space (the generator is lazy; no list or counter is materialized)
- `reduce-no-initial-value` — `reduce` is called without an initial value, so it will raise `TypeError` if both `s` and `t` are empty
- `linear-time-complexity` — The solution runs in O(n) time where n = len(s) + len(t), making a single pass over the concatenated characters

