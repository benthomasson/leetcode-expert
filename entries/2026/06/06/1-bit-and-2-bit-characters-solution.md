# File: 1-bit-and-2-bit-characters/solution.py

**Date:** 2026-06-06
**Time:** 15:11

## Purpose

This file solves [LeetCode 717: 1-bit and 2-bit Characters](https://leetcode.com/problems/1-bit-and-2-bit-characters/). It determines whether the last character in a binary array is necessarily a 1-bit character, given an encoding where `0` is a 1-bit character and `10`/`11` are 2-bit characters. The file owns both the solution and its test suite.

## Key Components

### `is_one_bit_character(bits: list[int]) -> bool`

The sole public function. Contract:
- **Input**: A list of 0s and 1s that always ends with `0` and represents a valid encoding.
- **Output**: `True` if the final `0` *must* be decoded as a standalone 1-bit character (i.e., it cannot be consumed as part of a preceding 2-bit character).

### `TestIsOneBitCharacter`

Nine unit tests covering edge cases: single element, all-zeros, patterns where the final `0` is consumed by a 2-bit character, and longer mixed sequences.

## Patterns

**Greedy left-to-right scan.** The algorithm doesn't backtrack or use DP — it walks from index 0, consuming 2 positions when it sees a `1` (since `1` always starts a 2-bit character) and 1 position when it sees a `0`. This greedy parse is unambiguous because the encoding is prefix-free: a `1` at position `i` always means `bits[i:i+2]` is a single 2-bit character.

The final check `i == len(bits) - 1` asks: did the scan land exactly on the last element? If yes, that last `0` was parsed independently. If the scan overshot (landed at `len(bits)`), the last `0` was consumed as the second bit of a 2-bit character.

## Dependencies

- **Imports**: Only `unittest` from the standard library — no external dependencies.
- **Imported by**: The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that import `unittest`, not this module. This file is self-contained; `test_solution.py` in the same directory likely imports `is_one_bit_character` from it.

## Flow

```
i = 0
while i < len(bits) - 1:       # stop before the last element
    if bits[i] == 1:
        i += 2                  # skip 2-bit character
    else:
        i += 1                  # skip 1-bit character
return i == len(bits) - 1       # did we land on the last element?
```

The loop explicitly excludes the last index (`< len(bits) - 1`), so it never "decides" the last character during iteration — it only checks whether the scan naturally arrives there.

## Invariants

1. **Input ends with `0`** — the problem guarantees this; the code doesn't validate it.
2. **The encoding is prefix-free** — a `1` always begins a 2-bit character. This is what makes the greedy scan correct; there's no ambiguity during parsing.
3. **`i` only takes values in `[0, len(bits)]`** — it advances by 1 or 2 and the loop guard prevents it from starting a parse at the last index, so it ends at either `len(bits) - 1` (last `0` is independent) or `len(bits)` (last `0` was consumed).

## Error Handling

None. The function assumes valid input per the LeetCode contract. Passing an empty list would return `True` (since `0 == -1` is `False` — actually returns `False`). Passing a list not ending in `0` gives undefined but non-crashing behavior.

## Topics to Explore

- [file] `1-bit-and-2-bit-characters/plan.md` — The planning notes may document alternative approaches (e.g., scanning from the right by counting consecutive 1s before the final 0)
- [file] `1-bit-and-2-bit-characters/review.md` — Code review notes likely discuss complexity tradeoffs and edge cases
- [general] `prefix-free-codes` — Understanding why this greedy parse is uniquely decodable (connection to Huffman coding / variable-length encodings)
- [function] `binary-prefix-divisible-by-5/solution.py:prefixesDivBy5` — Another problem that uses a left-to-right greedy scan over a binary array with similar structure

## Beliefs

- `greedy-scan-correctness` — The greedy left-to-right scan produces the unique valid decoding because `{0, 10, 11}` is a prefix-free code; no backtracking or DP is needed.
- `loop-excludes-last-index` — The while loop condition `i < len(bits) - 1` guarantees the last element is never consumed during iteration; it's only checked post-loop.
- `time-complexity-linear` — `is_one_bit_character` runs in O(n) time and O(1) space, visiting each bit at most once.
- `no-input-validation` — The function assumes the input is a valid encoding ending with `0`; it does not guard against empty lists or malformed input.

