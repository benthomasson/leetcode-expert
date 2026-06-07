# File: binary-number-with-alternating-bits/solution.py

**Date:** 2026-06-06
**Time:** 15:23

## `binary-number-with-alternating-bits/solution.py`

### Purpose

Solves [LeetCode 693 — Binary Number with Alternating Bits](https://leetcode.com/problems/binary-number-with-alternating-bits/). The file owns exactly one responsibility: determine whether a positive integer's binary representation consists of strictly alternating `0`s and `1`s (e.g., `5 = 101`, `10 = 1010`).

### Key Components

**`has_alternating_bits(n: int) -> bool`** — the sole public function.

- **Contract**: accepts a positive integer in `[1, 2^31 - 1]`, returns `True` iff adjacent bits always differ.
- **No imports, no classes, no state.**

### Flow

The implementation is a two-step bit-manipulation trick:

1. **`m = n ^ (n >> 1)`** — XOR the number with itself shifted right by one. If bits alternate, every pair of adjacent bits differs, so XOR produces an all-ones mask. For example:
   - `n = 5` → `101 ^ 010 = 111`
   - `n = 7` → `111 ^ 011 = 100` (not all ones)

2. **`(m & (m + 1)) == 0`** — tests whether `m` is a sequence of all `1`s (i.e., `2^k - 1` for some `k`). Adding 1 to an all-ones value produces a single `1` followed by all `0`s, so the AND is zero. Any `0` bit in `m` breaks this property.

The entire check runs in O(1) time and O(1) space — no loops, no string conversion, no allocation.

### Patterns

- **Pure bit-manipulation idiom**: the "XOR with shifted self" pattern is a standard way to detect uniform adjacency relationships in binary. The "all-ones check via `m & (m+1) == 0`" is the same idiom used in power-of-two tests (`n & (n-1) == 0`), applied to the complement form.
- **No-dependency style**: consistent with the rest of the repo — each solution is a standalone function with no imports.

### Dependencies

- **Imports**: none.
- **Imported by**: `binary-number-with-alternating-bits/test_solution.py` directly, plus the massive shared test infrastructure that imports all solutions (the ~400 test files listed in "Imported By" appear to be an artifact of a shared test runner pattern, not direct usage of this function).

### Invariants

- The input must be a positive integer. The function doesn't validate this — it relies on LeetCode's constraint `1 <= n <= 2^31 - 1`. Passing `0` would return `True` (vacuously, since `m = 0` and `0 & 1 == 0`), which is arguably correct but outside the stated domain.

### Error Handling

None. Pure arithmetic — no exceptions, no edge-case guards. Failures would only come from passing a non-integer, which Python's type system doesn't prevent.

## Topics to Explore

- [file] `binary-number-with-alternating-bits/test_solution.py` — See what edge cases the tests cover (powers of two, max int, single-bit numbers)
- [function] `hamming-distance/solution.py:hammingDistance` — Another XOR-based bit manipulation solution in the same repo
- [general] `xor-adjacency-pattern` — The "XOR with shifted self" idiom appears in several problems (binary gap, counting bits); worth understanding as a reusable primitive
- [file] `complement-of-base-10-integer/solution.py` — Uses the related "all-ones mask" construction, good comparison for bit-mask idioms
- [file] `number-of-1-bits/solution.py` — The `n & (n-1)` kernel that this solution's `m & (m+1)` check mirrors

## Beliefs

- `alternating-bits-o1` — `has_alternating_bits` runs in O(1) time and space with no loops or string conversion
- `xor-shift-produces-all-ones` — For any integer with alternating bits, `n ^ (n >> 1)` produces a value of the form `2^k - 1` (all ones in binary)
- `all-ones-check-idiom` — `(m & (m + 1)) == 0` is true iff `m` is zero or every bit up to the MSB is set
- `zero-input-vacuously-passes` — Passing `n = 0` (outside the stated domain) returns `True` because `m = 0` satisfies the all-ones check

