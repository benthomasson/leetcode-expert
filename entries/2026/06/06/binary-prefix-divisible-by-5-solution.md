# File: binary-prefix-divisible-by-5/solution.py

**Date:** 2026-06-06
**Time:** 15:23

## `binary-prefix-divisible-by-5/solution.py`

### Purpose

This file solves [LeetCode 1018: Binary Prefix Divisible By 5](https://leetcode.com/problems/binary-prefix-divisible-by-5/). Given a binary array `nums`, it determines for each index `i` whether the binary number formed by `nums[0..i]` is divisible by 5. It's a single-responsibility module: one class, one method, one problem.

### Key Components

**`Solution.prefixesDivBy5(self, nums: List[int]) -> List[bool]`** — The sole method. Takes a list of 0s and 1s representing binary digits (MSB first), returns a same-length list of booleans.

### Patterns

**Modular arithmetic accumulator.** The key insight is that you never need to construct the actual binary number — which could grow to millions of bits. Instead, at each step you track only the remainder modulo 5:

```python
remainder = (remainder * 2 + bit) % 5
```

This works because if the current prefix has value `V`, appending bit `b` gives `2V + b`, and `(2V + b) mod 5 = (2(V mod 5) + b) mod 5`. The `% 5` keeps `remainder` bounded to `{0, 1, 2, 3, 4}` regardless of input length.

This is a standard number theory technique — modular arithmetic distributes over addition and multiplication — applied here to avoid arbitrary-precision integer arithmetic.

### Dependencies

**Imports:** Only `typing.List` — no external dependencies.

**Imported by:** The `binary-prefix-divisible-by-5/test_solution.py` file. The "Imported By" list in the prompt is misleading — those are other test files importing from their own `solution.py`, not from this one.

### Flow

1. Initialize `result = []` and `remainder = 0`.
2. For each `bit` in `nums`:
   - Shift the running remainder left by one bit (`* 2`), add the new bit, take mod 5.
   - Append `True` if remainder is 0, `False` otherwise.
3. Return the full results list.

The loop is O(n) time, O(n) space (for the output). Each iteration does constant work — one multiply, one add, one modulo, one comparison.

### Invariants

- **`remainder` is always in `[0, 4]`** — guaranteed by `% 5` on every iteration.
- **Output length equals input length** — one boolean per bit, no early termination.
- **Assumes valid input** — each element of `nums` must be `0` or `1`. No validation is performed; garbage in, garbage out.

### Error Handling

None. The method trusts its caller to provide a valid binary array. An empty `nums` returns an empty list, which is correct. Non-binary values would produce wrong results silently — acceptable for a LeetCode solution where input constraints are guaranteed by the judge.

## Topics to Explore

- [file] `binary-prefix-divisible-by-5/test_solution.py` — See what edge cases (empty array, all zeros, long inputs) are covered
- [file] `binary-prefix-divisible-by-5/review.md` — Read the code review for any noted concerns or alternative approaches
- [function] `convert-binary-number-in-a-linked-list-to-integer/solution.py:getDecimalValue` — Related problem: binary-to-integer via linked list traversal, same bit-accumulation pattern without modular reduction
- [function] `sum-of-root-to-leaf-binary-numbers/solution.py:sumRootToLeaf` — Same `val * 2 + bit` accumulation applied to tree paths
- [general] `modular-arithmetic-in-streaming` — How `(a * b) % m = ((a % m) * (b % m)) % m` enables constant-space processing of unbounded numbers

## Beliefs

- `remainder-bounded` — The `remainder` variable never exceeds 4 because `% 5` is applied on every iteration before any check
- `no-large-integer-constructed` — The solution avoids constructing the actual binary number, making it O(1) auxiliary space (excluding output)
- `linear-time-single-pass` — The algorithm processes each bit exactly once with O(1) work per bit
- `empty-input-safe` — An empty `nums` list produces an empty result list without error

