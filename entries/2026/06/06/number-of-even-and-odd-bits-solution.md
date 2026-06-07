# File: number-of-even-and-odd-bits/solution.py

**Date:** 2026-06-06
**Time:** 18:18

## `number-of-even-and-odd-bits/solution.py`

### Purpose

This file solves [LeetCode 2595: Number of Even and Odd Bits](https://leetcode.com/problems/number-of-even-and-odd-bits/). It's one solution module in a large collection (~500+) of LeetCode implementations, each following the same directory convention: `{problem-slug}/solution.py`.

The single function `even_odd_indices` classifies the set bits (1-bits) in the binary representation of `n` by whether they sit at even-indexed or odd-indexed positions (0-indexed from the least significant bit).

### Key Components

**`even_odd_indices(n: int) -> list[int]`** — The sole public function. Contract:
- **Input**: a positive integer `n` in `[1, 1000]`.
- **Output**: `[even_count, odd_count]` where `even_count` is the number of 1-bits at even bit positions (0, 2, 4, ...) and `odd_count` at odd positions (1, 3, 5, ...).

### Patterns

**Bit-walking loop**: Rather than converting to a binary string, the code walks the bits from LSB to MSB using `n & 1` (extract lowest bit) and `n >>= 1` (shift right). A separate counter `i` tracks the current bit index. This is the idiomatic low-level approach — no string allocation, O(log n) iterations.

**Dual accumulator**: `even` and `odd` are accumulated in a single pass, branching on `i % 2`. The final return packs them into a two-element list matching LeetCode's expected output format.

### Dependencies

**Imports**: None. The solution is self-contained with no standard library or third-party dependencies.

**Imported by**: The massive "Imported By" list in the prompt is misleading — those are test files from *other* problems. The actual consumer is `number-of-even-and-odd-bits/test_solution.py`, which imports this function to run test cases. The other listed files likely share a common test harness pattern that imports from a relative `solution` module, not from this specific file.

### Flow

1. Initialize `even = odd = 0` and bit-position counter `i = 0`.
2. While `n` is nonzero (has remaining bits):
   - Check if the current LSB is 1 (`n & 1`).
   - If set, increment `even` or `odd` based on whether `i` is even or odd.
   - Right-shift `n` by 1, increment `i`.
3. Return `[even, odd]`.

For `n = 50` (binary `110010`): bit 1 at index 1 (odd), bit 4 at index 4 (even), bit 5 at index 5 (odd) → `[1, 2]`.

### Invariants

- `i` always equals the number of bits already processed, so it correctly identifies even/odd positions.
- The loop terminates because `n >>= 1` on a positive integer eventually reaches 0.
- The function assumes `n >= 1` per the problem constraints — for `n = 0`, it returns `[0, 0]` (the loop body never executes), which is correct but outside the stated domain.

### Error Handling

None. The function trusts its caller to provide a valid positive integer. No validation, no exceptions. This is appropriate for a LeetCode solution where inputs are guaranteed by the judge.

## Topics to Explore

- [file] `number-of-even-and-odd-bits/test_solution.py` — See how the function is tested and what edge cases are covered
- [function] `counting-bits/solution.py:countBits` — Related bit-manipulation problem that counts set bits across a range
- [function] `number-of-1-bits/solution.py:hammingWeight` — The classic popcount problem; compare bit-walking techniques
- [general] `bit-index-conventions` — Whether "even index" means position 0,2,4 from LSB or MSB matters; verify against LeetCode's definition
- [file] `number-of-even-and-odd-bits/plan.md` — The planning document may capture alternative approaches considered (e.g., `bin()` string conversion)

## Beliefs

- `even-odd-bits-zero-indexed-from-lsb` — Bit index 0 is the least significant bit; the loop processes bits LSB-first via right-shift
- `even-odd-bits-single-pass` — The function classifies all set bits in exactly one pass over the binary representation, with no second traversal or string conversion
- `even-odd-bits-no-dependencies` — The solution imports nothing; it uses only built-in integer operations (`&`, `>>=`, `%`)
- `even-odd-bits-terminates-on-zero` — The while-loop guard `while n` guarantees termination because `n >>= 1` strictly decreases a positive integer toward 0

