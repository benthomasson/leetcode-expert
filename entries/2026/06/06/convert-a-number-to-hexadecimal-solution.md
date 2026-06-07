# File: convert-a-number-to-hexadecimal/solution.py

**Date:** 2026-06-06
**Time:** 15:51

## Purpose

This file solves [LeetCode 405 — Convert a Number to Hexadecimal](https://leetcode.com/problems/convert-a-number-to-hexadecimal/). It converts a 32-bit signed integer to its lowercase hexadecimal string representation, handling negative numbers via two's complement. The file is self-contained: solution and tests in one module.

## Key Components

### `to_hex(num: int) -> str`

Converts an integer in `[-2^31, 2^31 - 1]` to a hex string.

- **Early exit**: Returns `"0"` immediately for zero, since the main loop would produce an empty string.
- **Two's complement masking**: `num &= 0xFFFFFFFF` (line 17) reinterprets negative Python integers as unsigned 32-bit values. Python integers have arbitrary precision, so `-1` becomes `4294967295` (`0xFFFFFFFF`) after masking — exactly the 32-bit two's complement representation.
- **Digit extraction loop**: Extracts the lowest 4 bits (`num & 0xF`) each iteration to index into `hex_chars`, then right-shifts by 4. Digits are collected least-significant-first, then reversed.

### `TestToHex`

Eight test cases covering the boundary space: zero, small positives, powers of two, negative one (`ffffffff`), `INT_MAX` (`7fffffff`), and `INT_MIN` (`80000000`).

## Patterns

**Bit-manipulation hex conversion**: Rather than using Python's built-in `hex()`, this manually extracts nibbles (4-bit groups) with bitwise AND and shift. This is the standard approach LeetCode expects — it demonstrates understanding of binary representation and two's complement.

**Lookup string as digit map**: `hex_chars = "0123456789abcdef"` uses string indexing as a lightweight alternative to a dictionary or conditional chain for digit-to-character conversion.

**Reverse-accumulate**: Building the result list in reverse (LSB first) then calling `reversed()` is a common idiom when extracting digits from least-significant to most-significant.

## Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The `test_solution.py` file in this same directory imports it. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure, not actual imports of this module.

## Flow

```
to_hex(-1)
  → num == 0? No
  → num &= 0xFFFFFFFF → 4294967295
  → loop: extract 0xF → 'f', shift right, repeat 8 times
  → result = ['f','f','f','f','f','f','f','f']
  → reversed → "ffffffff"
```

For positive `26`:
```
  → 26 & 0xF = 10 → 'a', 26 >> 4 = 1
  → 1 & 0xF = 1 → '1', 1 >> 4 = 0
  → reversed(['a','1']) → "1a"
```

## Invariants

- The mask `0xFFFFFFFF` constrains output to at most 8 hex digits (32 bits). Inputs outside `[-2^31, 2^31 - 1]` would silently truncate to 32 bits — the function doesn't validate the range.
- The output never has leading zeros (the loop terminates when `num` reaches 0).
- The output is always lowercase (enforced by the `hex_chars` constant).

## Error Handling

None. The function trusts its caller to provide an integer in the valid range. No exceptions are raised or caught. Invalid input types would fail at the `&=` operation with a `TypeError`.

## Topics to Explore

- [file] `convert-a-number-to-hexadecimal/review.md` — Code review notes may document alternative approaches or edge cases considered
- [function] `base-7/solution.py:convertToBase7` — Same digit-extraction pattern applied to a different base; compare how negative handling differs (sign prefix vs two's complement)
- [function] `reverse-bits/solution.py:reverseBits` — Another 32-bit manipulation problem that uses the same `0xFFFFFFFF` mask and bit-shifting idioms
- [general] `twos-complement-in-python` — Python's arbitrary-precision integers don't naturally behave like 32-bit values; the `& 0xFFFFFFFF` trick bridges that gap and appears across multiple solutions in this repo

## Beliefs

- `hex-mask-truncates-to-32-bits` — `num &= 0xFFFFFFFF` converts any Python integer (including negative) to its unsigned 32-bit two's complement value
- `zero-special-cased-because-loop-skips-it` — Without the `if num == 0` guard, the while loop body never executes and `"".join(reversed([]))` would return an empty string
- `nibble-extraction-produces-lsb-first` — The loop appends digits from least-significant to most-significant nibble, requiring a final `reversed()` call
- `no-builtin-hex-used` — The solution manually extracts hex digits via bit manipulation rather than delegating to `hex()`, `format()`, or f-string formatting

