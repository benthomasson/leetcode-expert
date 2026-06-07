# File: largest-number-after-digit-swaps-by-parity/solution.py

**Date:** 2026-06-06
**Time:** 17:14

## Purpose

This file is a self-contained solution to [LeetCode 2231: Largest Number After Digit Swaps by Parity](https://leetcode.com/problems/largest-number-after-digit-swaps-by-parity/). It owns both the algorithm implementation and its test suite. The problem: given an integer, you can swap any two digits that share the same parity (both even or both odd) any number of times — return the largest value achievable.

## Key Components

### `Solution.largestInteger(num: int) -> int`

The core algorithm. Contract: accepts a positive integer, returns the largest integer obtainable by rearranging digits within their parity group while preserving each digit's parity-slot position.

### `TestLargestInteger`

Eight test cases covering the examples from the problem, single digits, all-even, all-odd, repeated digits, and a large input with many zeros.

## Patterns

**Greedy sort-and-fill.** Rather than simulating pairwise swaps (which could be O(n!) in the worst case), the solution recognizes that unlimited same-parity swaps let you rearrange each parity group freely. So the optimal strategy is: sort each group descending, then greedily assign the largest available same-parity digit to each position left-to-right.

This is the standard idiom for "unlimited swaps within a partition" problems — it reduces to independent sorting of each partition.

**Dual-pointer reconstruction.** Two index counters (`oi`, `ei`) walk through the sorted odd and even pools respectively. The original digit list determines which pointer advances at each position, guaranteeing parity-slot preservation.

## Dependencies

**Imports:** Only `unittest` from the standard library — no external dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — those are test files from *other* problems that import `unittest`, not this file. This solution file is not imported by other solutions.

## Flow

1. **Decompose**: `str(num)` → list of individual digit ints.
2. **Partition & sort**: Filter into odd/even sublists, each sorted descending (largest first).
3. **Reconstruct**: Walk the original digit positions. For each position, check the original digit's parity, pop the next value from the corresponding sorted pool, append to result.
4. **Reassemble**: Join digits into a string, convert back to int.

Example with `num = 1234`:
- digits: `[1, 2, 3, 4]`
- odds sorted desc: `[3, 1]`, evens sorted desc: `[4, 2]`
- Position 0 (odd→3), position 1 (even→4), position 2 (odd→1), position 3 (even→2) → `3412`

## Invariants

- **Parity preservation**: Every digit in the output occupies a position that held a digit of the same parity in the input. The `if d % 2 == 1` branch enforces this — it's impossible for an odd digit to land in an even slot or vice versa.
- **Pool exhaustion**: `oi` and `ei` always exactly consume their respective pools because the number of odd/even positions in the original equals the size of the odd/even sorted lists. No bounds checking is needed.
- **No leading zeros**: The problem guarantees `num` is a positive integer; since we only rearrange within parity groups and the leading digit keeps its parity class, the result is well-formed.

## Error Handling

None. The function trusts its input matches the LeetCode constraint (positive integer). No validation, no exceptions. This is appropriate for a competitive programming solution where the problem guarantees valid input.

## Topics to Explore

- [file] `sort-even-and-odd-indices-independently/solution.py` — Similar partition-and-sort pattern but partitions by index parity rather than value parity
- [file] `sort-array-by-parity/solution.py` — Related parity-based rearrangement problem, different constraint structure
- [general] `greedy-sort-equivalence` — Why "unlimited swaps within a group" is equivalent to sorting that group independently — a recurring LeetCode insight
- [file] `split-with-minimum-sum/solution.py` — Another digit-rearrangement optimization problem using greedy sorting

## Beliefs

- `parity-slot-preservation` — The output digit at position i always has the same parity (odd/even) as the input digit at position i
- `greedy-descending-optimal` — Sorting each parity group in descending order and assigning greedily produces the global maximum, because digit positions are independent across parity groups
- `pool-exactly-consumed` — The odd and even index counters (`oi`, `ei`) each reach exactly the length of their respective sorted list after reconstruction, with no underflow or overflow possible
- `linear-time-after-sort` — The reconstruction loop is O(n) where n is the digit count; total complexity is O(n log n) dominated by the two sorts

