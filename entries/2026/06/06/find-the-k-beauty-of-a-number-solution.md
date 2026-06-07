# File: find-the-k-beauty-of-a-number/solution.py

**Date:** 2026-06-06
**Time:** 16:47

## `find-the-k-beauty-of-a-number/solution.py`

### Purpose

This file solves [LeetCode 2269: Find the K-Beauty of a Number](https://leetcode.com/problems/find-the-k-beauty-of-a-number/). It implements a single function `divisor_substrings` that counts how many contiguous length-`k` substrings of a number's decimal representation evenly divide that number. It's one of ~500 solutions in the `leetcode-implementations` repo, each isolated in its own directory with a solution, tests, plan, and review.

### Key Components

**`divisor_substrings(num: int, k: int) -> int`** — The sole public function. Contract: given a positive integer `num` and a substring length `k`, returns the count of length-`k` contiguous substrings of `num` (read as a decimal string) that are nonzero and divide `num` evenly.

### Patterns

**Sliding window over string representation.** The solution converts `num` to a string, then slides a window of size `k` across it, converting each substring back to an integer. This is the standard idiom for digit-substring problems — it avoids modular arithmetic entirely and reads clearly.

The loop `for i in range(len(s) - k + 1)` generates exactly the right number of windows: for a string of length `n`, there are `n - k + 1` substrings of length `k`.

### Dependencies

**Imports:** None. Pure stdlib Python with no external dependencies.

**Imported by:** `find-the-k-beauty-of-a-number/test_solution.py` imports `divisor_substrings` for testing. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those test files likely share a common harness or conftest, not direct imports of this function.

### Flow

1. `str(num)` — convert integer to its decimal string representation.
2. Iterate `i` from `0` to `len(s) - k` inclusive — each `i` is the start of a length-`k` window.
3. `int(s[i:i+k])` — extract the substring and convert back to integer. Leading zeros naturally collapse (e.g., `"03"` becomes `3`).
4. Guard `sub != 0` — skip zero-valued substrings to avoid division by zero.
5. Check `num % sub == 0` — the divisibility test.
6. Increment `count` on match; return final count.

### Invariants

- **Zero-guard before modulo.** Substrings like `"00"` parse to `0`; the `sub != 0` check prevents `ZeroDivisionError`. This is the only validation the function performs.
- **k ≤ len(str(num))** is assumed by the problem constraints. If `k` exceeds the digit count, `range(len(s) - k + 1)` produces an empty range and the function returns `0` — safe but vacuously so.

### Error Handling

None. The function trusts its inputs per LeetCode problem constraints (`1 ≤ k ≤ len(str(num))`, `num ≥ 1`). The only defensive check is the zero-substring guard, which is part of the problem's logic rather than error handling.

---

## Topics to Explore

- [file] `find-the-k-beauty-of-a-number/test_solution.py` — See which edge cases (leading zeros, single-digit k, full-length k) are covered
- [file] `find-the-k-beauty-of-a-number/review.md` — Review notes may flag alternative approaches or complexity analysis
- [function] `count-the-digits-that-divide-a-number/solution.py:countDigits` — A related digit-divisibility problem; compare the digit-extraction approach
- [function] `substrings-of-size-three-with-distinct-characters/solution.py:countGoodSubstrings` — Another fixed-size sliding window over a string; compare the windowing idiom
- [general] `string-vs-arithmetic-digit-extraction` — When to use `str()` slicing vs. modular arithmetic (`% 10`, `// 10`) for digit problems

## Beliefs

- `k-beauty-zero-guard` — `divisor_substrings` skips substrings that parse to zero, preventing `ZeroDivisionError` on inputs like `num=100, k=1`
- `k-beauty-leading-zeros` — Leading zeros in a substring are handled implicitly by `int()` conversion (e.g., substring `"04"` becomes `4`), which is correct per the problem spec
- `k-beauty-window-count` — The function evaluates exactly `len(str(num)) - k + 1` substrings, which is the complete set of contiguous length-k windows
- `k-beauty-no-imports` — The solution has zero external dependencies; it uses only Python builtins (`str`, `int`, `range`, `len`)

