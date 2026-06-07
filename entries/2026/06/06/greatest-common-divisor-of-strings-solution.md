# File: greatest-common-divisor-of-strings/solution.py

**Date:** 2026-06-06
**Time:** 16:57

## `greatest-common-divisor-of-strings/solution.py`

### Purpose

This file solves [LeetCode 1071 — Greatest Common Divisor of Strings](https://leetcode.com/problems/greatest-common-divisor-of-strings/). It finds the largest string `x` such that both `str1` and `str2` can be constructed by concatenating copies of `x`. It's a standalone solution module following the repo's convention of one problem per directory.

### Key Components

**`gcdOfStrings(str1, str2) -> str`** — The sole public function. Takes two strings and returns their "GCD string," or `""` if none exists.

The function is two lines of logic:

1. **Compatibility check** (line 15): `str1 + str2 != str2 + str1` — if concatenation isn't commutative, no common divisor string exists. This is both necessary and sufficient: two strings share a divisor string *if and only if* their concatenations in both orders are identical.

2. **Extract the GCD string** (line 17): `str1[:gcd(len(str1), len(str2))]` — the GCD string's length equals the GCD of the two input lengths. Once we know a divisor exists, we just take the prefix of that length.

### Patterns

**Math-to-string reduction.** The key insight is that "string divides string" is structurally identical to "integer divides integer." The concatenation-commutativity check proves the strings share a repeating unit, then the numeric GCD gives its length. This avoids brute-force substring checking entirely.

**LeetCode method signature convention.** The function is a bare function (not inside a `Solution` class), matching this repo's style across all problems.

### Dependencies

**Imports:** `math.gcd` — Python's built-in Euclidean GCD, O(log(min(a,b))) time.

**Imported by:** `greatest-common-divisor-of-strings/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the test harness importing across the repo — those test files don't actually use `gcdOfStrings`.

### Flow

1. Concatenate `str1 + str2` and `str2 + str1`. Compare.
2. If unequal → return `""` immediately (no common divisor exists).
3. If equal → compute `gcd(len(str1), len(str2))`, slice `str1` to that length, return it.

Total work: O(n + m) for the string concatenation/comparison, O(log(min(n, m))) for the integer GCD. Space: O(n + m) for the concatenated strings.

### Invariants

- **Concatenation commutativity is the sole guard.** If `str1 + str2 == str2 + str1`, then `str1[:g]` (where `g = gcd(len(str1), len(str2))`) is guaranteed to divide both strings. No further validation is needed.
- **The result is always a prefix of `str1`.** The divisor string must be a prefix of both inputs (since both are built by repeating it), so slicing `str1` is correct.

### Error Handling

None. The function returns `""` for the "no answer" case. No exceptions are raised or caught. Inputs are assumed to be valid non-empty strings per the LeetCode contract.

## Topics to Explore

- [file] `greatest-common-divisor-of-strings/test_solution.py` — Test cases showing edge behavior (empty result, single-char strings, identical inputs)
- [file] `greatest-common-divisor-of-strings/plan.md` — How the solution approach was chosen and what alternatives were considered
- [file] `repeated-substring-pattern/solution.py` — A closely related problem (checking if a string is built from a repeated unit) that likely uses similar string-period reasoning
- [general] `string-divisibility-proof` — Why concatenation commutativity is equivalent to sharing a repeating unit (the formal argument via the Fine and Wilf theorem)
- [file] `x-of-a-kind-in-a-deck-of-cards/solution.py` — Another problem that reduces to computing GCD, but over integer counts

## Beliefs

- `gcd-strings-commutativity-check` — `str1 + str2 == str2 + str1` is a necessary and sufficient condition for the existence of a common divisor string
- `gcd-strings-length-determines-answer` — When a common divisor exists, its length equals `gcd(len(str1), len(str2))` and the string is `str1[:that_length]`
- `gcd-strings-no-exceptions` — The function never raises; it returns `""` for inputs with no common divisor
- `gcd-strings-linear-time` — The solution runs in O(n + m) time dominated by the string concatenation comparison, not by substring enumeration

