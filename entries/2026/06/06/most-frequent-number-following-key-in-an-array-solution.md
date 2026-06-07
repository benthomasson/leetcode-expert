# File: most-frequent-number-following-key-in-an-array/solution.py

**Date:** 2026-06-06
**Time:** 18:08

## `most-frequent-number-following-key-in-an-array/solution.py`

### Purpose

This file solves [LeetCode 2190](https://leetcode.com/problems/most-frequent-number-following-key-in-an-array/): given an array `nums` and a value `key`, find which number appears most frequently in the position immediately after every occurrence of `key`. It's a single-function module following the repo's convention of one solution per problem directory.

### Key Components

**`most_frequent_number_following_key_in_an_array(nums, key)`** — The sole public function. Takes a list of integers and a key integer, returns the integer that most frequently appears at index `i+1` whenever `nums[i] == key`.

The contract: `key` must appear in `nums` at least once at a non-terminal position. If it doesn't, `counts.most_common(1)` will operate on an empty Counter and raise an `IndexError`.

### Patterns

- **Counter accumulation with linear scan** — A single pass through adjacent pairs, tallying into a `Counter`. This is the idiomatic Python approach for frequency-counting problems.
- **`range(len(nums) - 1)`** — The `- 1` bound prevents an out-of-bounds access on `nums[i + 1]`. This is the standard adjacent-pair iteration idiom.
- **`most_common(1)[0][0]`** — Extracts the element (not the count) from the most frequent `(element, count)` tuple. The double `[0]` is a common Counter pattern: first `[0]` gets the top entry from the list, second `[0]` extracts the key from the `(key, count)` pair.

### Dependencies

**Imports:** `collections.Counter` — used for frequency tracking.

**Imported by:** `most-frequent-number-following-key-in-an-array/test_solution.py` directly. The massive "Imported By" list in the repo context is misleading — those are test files for *other* problems that happen to share the same import structure (each test imports its own problem's solution), not actual consumers of this function.

### Flow

1. Initialize an empty `Counter`.
2. Iterate indices `0` through `len(nums) - 2`.
3. At each index, check if `nums[i] == key`.
4. If so, increment the count for `nums[i + 1]`.
5. After the loop, return the element with the highest count via `most_common(1)[0][0]`.

The entire operation is O(n) time, O(k) space where k is the number of distinct values following `key`.

### Invariants

- The loop never reads `nums[len(nums)]` — guaranteed by the `range(len(nums) - 1)` bound.
- Only values immediately *after* a key occurrence are counted. Non-adjacent matches are ignored.
- Ties are broken arbitrarily by `Counter.most_common`, which uses a heap and doesn't guarantee stable tie-breaking (though CPython's implementation tends to return the first-inserted element among ties).

### Error Handling

None. If `key` never appears before a non-terminal position, `counts` stays empty and `most_common(1)` returns `[]`, causing `IndexError` on `[0][0]`. This is acceptable given the LeetCode constraint that guarantees at least one valid occurrence.

---

## Topics to Explore

- [file] `most-frequent-number-following-key-in-an-array/test_solution.py` — See which edge cases are tested (empty results, ties, key at end of array)
- [file] `most-frequent-number-following-key-in-an-array/review.md` — Check if the review flagged the missing guard on empty Counter
- [function] `most-frequent-even-element/solution.py:most_frequent_even_element` — Similar Counter + most_common pattern, compare approaches
- [general] `counter-most-common-tie-breaking` — Whether tie-breaking behavior matters for LeetCode acceptance across this repo's solutions

## Beliefs

- `counter-linear-scan` — The function performs exactly one pass over `nums` (O(n)) and uses `Counter` for O(1) amortized frequency updates
- `no-terminal-key-guard` — If `key` only appears at the last index of `nums`, the function returns correctly (it simply won't count that occurrence) only if `key` also appears elsewhere; otherwise it raises `IndexError`
- `most-common-single-extraction` — `most_common(1)[0][0]` is the standard two-level unwrap to get the mode element from a Counter, used consistently across this repo's frequency-based solutions
- `adjacent-pair-idiom` — `range(len(nums) - 1)` with `nums[i+1]` is the repo's standard pattern for problems requiring pairwise element comparison

