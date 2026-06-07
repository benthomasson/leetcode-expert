# File: number-complement/solution.py

**Date:** 2026-06-06
**Time:** 18:13

## `number-complement/solution.py`

### Purpose

This file implements the solution to [LeetCode 476 — Number Complement](https://leetcode.com/problems/number-complement/). Given a positive integer, it returns the integer formed by flipping every bit in the number's binary representation (excluding leading zeros). For example, `5` (binary `101`) becomes `2` (binary `010`).

### Key Components

**`find_complement(num: int) -> int`** — The sole public function. Takes a positive integer and returns its bitwise complement with respect to the number's own bit-length (not a fixed 32-bit or 64-bit width).

### Patterns

The solution uses the **XOR-with-mask** idiom, which is the canonical bit-manipulation approach for this class of problem:

1. **`num.bit_length()`** — Python's built-in that returns the number of bits needed to represent `num`, ignoring the sign and leading zeros. For `5` (`101`), this returns `3`.

2. **`(1 << num.bit_length()) - 1`** — Constructs a bitmask of all `1`s with exactly the same width as `num`. For a 3-bit number, this produces `111` (i.e., `7`). The shift creates a power of two one position above the MSB, then subtracting 1 fills all lower bits.

3. **`num ^ mask`** — XOR against the all-ones mask flips every bit. `101 ^ 111 = 010`.

This is a pure-math, constant-space approach — no string conversion, no loops.

### Dependencies

**Imports:** None. The solution uses only Python builtins (`int.bit_length`, bitwise operators).

**Imported by:** `number-complement/test_solution.py` directly, plus hundreds of other test files across the repo (the "Imported By" list in the prompt is the test runner's cross-reference index, not actual imports of this function — those test files import their own respective solutions via a shared test harness pattern).

### Flow

```
num = 5  (binary: 101)
  → bit_length = 3
  → mask = (1 << 3) - 1 = 8 - 1 = 7  (binary: 111)
  → result = 5 ^ 7 = 2  (binary: 010)
```

The entire computation is three operations with no branching or iteration.

### Invariants

- **Precondition:** `1 <= num < 2^31`. The docstring states this constraint (matching LeetCode's guarantee). For `num = 0`, `bit_length()` returns `0`, the mask becomes `0`, and the result would be `0` — technically correct but outside the problem's stated domain.
- **No leading zeros in the complement:** Guaranteed by sizing the mask to `bit_length()` rather than a fixed width. The complement of `5` (`101`) is `2` (`010`), not `4294967290` (`11...010`).

### Error Handling

None. The function trusts the caller to provide a valid positive integer per the LeetCode contract. No validation, no exceptions.

### Relationship to `complement-of-base-10-integer/`

The repo contains a separate `complement-of-base-10-integer/` directory (LeetCode 1009), which is the same problem rebranded. Both likely use an identical or near-identical approach.

---

## Topics to Explore

- [file] `complement-of-base-10-integer/solution.py` — Almost certainly the same algorithm; compare to confirm code reuse or divergence
- [file] `number-complement/test_solution.py` — See which edge cases are tested (num=1, powers of two, max value)
- [function] `hamming-distance/solution.py:hammingDistance` — Another XOR-based bit manipulation problem in the same repo
- [general] `bit_length-vs-fixed-width` — Understanding when to use `int.bit_length()` versus a fixed 32-bit mask matters across multiple problems in this repo (e.g., `reverse-bits`, `number-of-1-bits`)

---

## Beliefs

- `xor-mask-width-matches-input` — The mask is always exactly `num.bit_length()` bits wide, so the complement never introduces bits above the MSB of the input
- `no-special-case-needed` — The algorithm handles all valid inputs (1 to 2^31-1) without branching; single-bit numbers like `1` produce `0` correctly via `1 ^ 1 = 0`
- `zero-is-out-of-domain` — The docstring constrains `num >= 1`; passing `0` would return `0` (mask is `0`), which is degenerate but not an error
- `pure-bitwise-no-string-conversion` — The solution avoids `bin()` or string manipulation, using only arithmetic and bitwise ops for O(1) time and space

