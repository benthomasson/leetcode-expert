# File: reverse-bits/solution.py

**Date:** 2026-06-06
**Time:** 18:52

## `reverse-bits/solution.py`

### Purpose

This file implements **LeetCode #190 — Reverse Bits**. It provides a single function that takes a 32-bit unsigned integer and returns the integer formed by reversing its binary representation. For example, `0b00000010100101000001111010011100` becomes `0b00111001011110000010100101000000`.

### Key Components

**`reverse_bits(n: int) -> int`** — The sole public function. Contract: accepts a 32-bit unsigned integer (0 to 2^32 - 1), returns a 32-bit unsigned integer with all 32 bits reversed.

### Flow

The algorithm builds the result one bit at a time across exactly 32 iterations:

1. **Extract**: `n & 1` isolates the least significant bit of `n`.
2. **Place**: `result << 1` shifts the accumulator left to make room, then `| (n & 1)` appends the extracted bit at position 0.
3. **Advance**: `n >>= 1` drops the consumed bit from `n`.

After 32 iterations, the first bit extracted (originally bit 0 of `n`) sits at bit 31 of `result`, and the last bit extracted (originally bit 31) sits at bit 0. This is the classic iterative bit-reversal idiom.

### Patterns

- **Accumulator pattern**: `result` is built incrementally via shift-and-OR, avoiding string conversion or array manipulation.
- **Fixed-width iteration**: The loop runs exactly 32 times regardless of the input value, which is critical — without this, leading zeros in the input would be lost (e.g., reversing `1` must produce `2147483648`, not `1`).

### Dependencies

**Imports**: None — pure arithmetic, no standard library usage.

**Imported by**: The `reverse-bits/test_solution.py` file. The massive "Imported By" list in the prompt is misleading — those are test files for *other* problems that likely share a common test harness or import pattern, not actual consumers of `reverse_bits`.

### Invariants

- The loop always executes exactly 32 times, guaranteeing the output is a full 32-bit reversal. This is the key correctness invariant — a `while n:` loop would silently drop leading zeros.
- The result is always in range `[0, 2^32 - 1]` because at most 32 bits are ever set.
- Input must be non-negative. Python's right-shift on negative integers preserves the sign bit, which would produce incorrect results for negative inputs — but the problem guarantees unsigned input.

### Error Handling

None. The function assumes valid input per the LeetCode contract (unsigned 32-bit integer). No bounds checking, no type validation. This is typical for competitive programming solutions.

## Topics to Explore

- [file] `reverse-bits/test_solution.py` — Verify which edge cases are covered (0, max uint32, palindromic bit patterns)
- [function] `number-of-1-bits/solution.py:hammingWeight` — Related bit-manipulation problem using the same `n & 1` / `n >>= 1` pattern
- [file] `complement-of-base-10-integer/solution.py` — Another bitwise problem; compare how it handles the "width" question differently
- [general] `bit-reversal-alternatives` — Divide-and-conquer reversal (swap halves, then quarters, etc.) achieves O(log n) operations instead of O(n), relevant for follow-up optimization
- [file] `hamming-distance/solution.py` — XOR-based bit manipulation; complements understanding of the bitwise toolkit used across this repo

## Beliefs

- `reverse-bits-fixed-32-iterations` — `reverse_bits` always iterates exactly 32 times, ensuring leading zeros in the input become trailing ones in the output (e.g., `reverse_bits(1)` returns `2147483648`, not `1`).
- `reverse-bits-no-dependencies` — The solution uses no imports; it is purely arithmetic with bitwise shift and mask operations.
- `reverse-bits-unsigned-only` — The function assumes non-negative input; Python's right-shift on negative integers would produce incorrect results since it sign-extends.
- `reverse-bits-accumulator-pattern` — The result is built LSB-first by extracting bits from `n` right-to-left and appending them to `result` left-to-right via `(result << 1) | (n & 1)`.

