# File: build-array-from-permutation/solution.py

**Date:** 2026-06-06
**Time:** 15:28

## Build Array from Permutation — `solution.py`

### Purpose

Solves [LeetCode 1920: Build Array from Permutation](https://leetcode.com/problems/build-array-from-permutation/). Given a zero-based permutation `nums`, construct an array `ans` where `ans[i] = nums[nums[i]]`. The solution does this **in-place** using O(1) extra space, which is the follow-up challenge — the naive approach would just allocate a new array.

### Key Components

**`Solution.buildArray(nums: List[int]) -> List[int]`** — The only method. Mutates `nums` in place and returns it. Takes a permutation (every value in `[0, n)` appears exactly once) and replaces each element with the doubly-dereferenced value.

### Patterns

The core technique is **encoding two values in one integer** using modular arithmetic. Since every value is in `[0, n)`, each slot can store both its original value and its new value simultaneously:

```
encoded = original + n * new_value
```

- `encoded % n` recovers the original value
- `encoded // n` recovers the new value

This is a standard in-place permutation trick that avoids the chicken-and-egg problem: when you overwrite `nums[i]`, you'd lose the original value that some later `nums[j]` might need. By packing both into one integer, nothing is lost.

**Two-pass structure:**

1. **Encode pass** (line 14): For each `i`, compute the new value as `nums[nums[i]] % n` (using `% n` because `nums[nums[i]]` might already be encoded from an earlier iteration), multiply by `n`, and add it to `nums[i]`.
2. **Decode pass** (line 17): Integer-divide each element by `n` to extract just the new value, discarding the original.

### Dependencies

- **Imports**: `typing.List` — standard type hint, no external dependencies.
- **Imported by**: `build-array-from-permutation/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share the same `from solution import Solution` pattern via relative imports, not actual consumers of this module.

### Flow

Given `nums = [0, 2, 1, 5, 3, 4]` (n=6):

| i | original `nums[i]` | `nums[nums[i]] % n` | encoded value |
|---|---|---|---|
| 0 | 0 | 0 | 0 + 6*0 = 0 |
| 1 | 2 | 1 | 2 + 6*1 = 8 |
| 2 | 1 | 8%6=2 | 1 + 6*2 = 13 |
| 3 | 5 | 4 | 5 + 6*4 = 29 |
| 4 | 3 | 29%6=5 | 3 + 6*5 = 33 |
| 5 | 4 | 33%6=3 | 4 + 6*3 = 22 |

After decode (`//6`): `[0, 1, 2, 4, 5, 3]` — which is `[nums[nums[i]]]` for each `i`.

### Invariants

- **Input is a valid permutation**: Every value must be in `[0, n)` and appear exactly once. If this precondition is violated, the modular encoding produces garbage.
- **Values < n**: The encoding scheme relies on `nums[i] < n` so that `original + n * new_value` can be cleanly separated. Python's arbitrary-precision integers mean no overflow, but the math only works because the range is bounded.
- **Order of encoding matters**: The `% n` in the encode step is critical — it strips encoding from elements that were already processed earlier in the loop.

### Error Handling

None. The method trusts that the caller provides a valid permutation per the LeetCode contract. No bounds checking, no validation.

## Topics to Explore

- [file] `build-array-from-permutation/test_solution.py` — See what edge cases are tested (empty array, single element, identity permutation)
- [file] `build-array-from-permutation/plan.md` — Check whether the plan discusses the naive O(n) space approach vs. the in-place encoding
- [general] `in-place-modular-encoding` — This same `a + n*b` trick appears in other LeetCode problems (e.g., Set Matrix Zeroes, First Missing Positive) — worth understanding as a reusable technique
- [file] `concatenation-of-array/solution.py` — Another permutation/array-construction problem in this repo for comparison
- [function] `find-all-numbers-disappeared-in-an-array/solution.py:findDisappearedNumbers` — Likely uses a related in-place marking technique on a `[0, n)` range

## Beliefs

- `build-array-in-place-encoding` — The solution encodes two values per slot as `original + n * new_value`, recoverable via `% n` and `// n`, achieving O(1) extra space
- `build-array-encode-order-safety` — The `% n` in `nums[nums[i]] % n` ensures correctness regardless of whether `nums[nums[i]]` has already been encoded in the current pass
- `build-array-permutation-precondition` — The algorithm is only correct when `nums` is a valid zero-based permutation (all values in `[0, n)`, each appearing exactly once)
- `build-array-mutates-input` — The method mutates and returns `nums` rather than allocating a separate output array

