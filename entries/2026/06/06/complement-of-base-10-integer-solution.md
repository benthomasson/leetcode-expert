# File: complement-of-base-10-integer/solution.py

**Date:** 2026-06-06
**Time:** 15:47

## Complement of Base 10 Integer — `solution.py`

### Purpose

This file solves [LeetCode 1009: Complement of Base 10 Integer](https://leetcode.com/problems/complement-of-base-10-integer/). Given a non-negative integer `n`, it returns the number formed by flipping every bit in `n`'s binary representation. For example, `5` (binary `101`) becomes `2` (binary `010`).

This is a duplicate of [LeetCode 476: Number Complement](https://leetcode.com/problems/number-complement/) — same algorithm, different problem number.

### Key Components

**`Solution.bitwiseComplement(self, n: int) -> int`** — The core method. Two cases:

1. **`n == 0`**: Returns `1` directly. This is a special case because `0.bit_length()` returns `0`, which would produce a mask of `0` and yield the wrong answer (`0 ^ 0 = 0` instead of `1`).

2. **General case**: Builds a bitmask of all 1s with the same bit-width as `n`, then XORs `n` against it. XOR with 1 flips each bit.

**`pancakeSort`** — A class-level alias pointing to `bitwiseComplement`. This is a test harness artifact, not a meaningful name. The "Imported By" list confirms this file is referenced by hundreds of unrelated test files — the alias exists so the test runner can call a consistent method name across all solution files regardless of the actual LeetCode method signature.

### Patterns

**Bit-length masking**: The idiom `(1 << n.bit_length()) - 1` is the standard way to construct a mask of all 1s matching a number's binary width. `1 << k` gives `2^k` (a 1 followed by k zeros), and subtracting 1 flips it to k ones. This avoids string conversion or looping over individual bits.

**Method aliasing**: `pancakeSort = bitwiseComplement` at class scope creates a second name pointing to the same function object. This is a Python idiom — no wrapper, no overhead.

### Dependencies

**Imports**: None. Pure arithmetic — no standard library needed.

**Imported by**: The test file `complement-of-base-10-integer/test_solution.py` plus hundreds of other test files. The broad import list is a repo-wide pattern where test files share infrastructure that imports from solution modules indiscriminately.

### Flow

```
n=5 (binary: 101)
  → n != 0, so enter general case
  → n.bit_length() = 3
  → 1 << 3 = 8 (binary: 1000)
  → 8 - 1 = 7 (binary: 111)
  → 5 ^ 7 = 2 (binary: 010)
  → return 2
```

The entire computation is three arithmetic operations — no loops, no allocation.

### Invariants

- **Input constraint**: `0 <= n < 10^9`. The algorithm works for any non-negative Python int, but the LeetCode constraint guarantees this range.
- **Bit-length correctness**: The mask always matches `n`'s significant bit count exactly — no leading zeros are considered. `bitwiseComplement(5)` flips 3 bits, not 32 or 64.
- **Zero special case**: `n=0` must be handled separately because `bit_length()` returns 0 for zero, which would produce a mask of `(1 << 0) - 1 = 0`.

### Error Handling

None. The function assumes valid input per the LeetCode contract. Negative inputs would produce incorrect results (Python's `bit_length()` on negatives returns the bit length of the absolute value, and the XOR would not behave as a complement).

---

## Topics to Explore

- [file] `complement-of-base-10-integer/test_solution.py` — See how the solution is tested and what edge cases are covered
- [file] `number-complement/solution.py` — The duplicate LeetCode problem (476); compare whether the same algorithm is used
- [function] `counting-bits/solution.py:Solution` — Another bit-manipulation solution that likely uses `bit_length()` or similar idioms
- [general] `pancakeSort-alias-convention` — Why hundreds of test files import this module; trace how the test harness uses method aliases across all solutions
- [file] `minimum-bit-flips-to-convert-number/solution.py` — Related bit-manipulation problem (XOR to find differing bits, then count them)

## Beliefs

- `complement-zero-special-case` — `bitwiseComplement(0)` returns 1 via an explicit check because `int.bit_length()` returns 0 for zero, making the general mask formula produce 0 instead of 1
- `complement-mask-width` — The XOR mask is exactly `n.bit_length()` bits wide, so only the significant bits of `n` are flipped (no fixed 32-bit or 64-bit width assumption)
- `pancakeSort-is-alias` — `pancakeSort` is a class-level alias for `bitwiseComplement`, not a separate implementation; it exists as a test-harness convention, not a domain concept
- `complement-no-imports` — The solution uses only built-in `int` methods (`bit_length`) and operators (`<<`, `-`, `^`), with zero imports

