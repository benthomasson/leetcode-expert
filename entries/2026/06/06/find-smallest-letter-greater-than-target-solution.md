# File: find-smallest-letter-greater-than-target/solution.py

**Date:** 2026-06-06
**Time:** 16:42

## Purpose

This file is the solution and test suite for [LeetCode 744 — Find Smallest Letter Greater Than Target](https://leetcode.com/problems/find-smallest-letter-greater-than-target/). It owns the complete implementation: the algorithm in `Solution.nextGreatestLetter` and nine unit tests covering edge cases. Like every other problem directory in this repo, it follows the convention of bundling solution + tests in a single `solution.py`.

## Key Components

### `Solution.nextGreatestLetter(letters, target) -> str`

The core algorithm. Given a **sorted** list of lowercase letters and a target character, returns the smallest letter strictly greater than the target. If no such letter exists (target >= all letters), it wraps around and returns the first letter in the list.

The entire implementation is two lines:

```python
idx = bisect_right(letters, target)
return letters[idx % len(letters)]
```

`bisect_right` returns the insertion point *after* any existing copies of `target`, which is exactly the index of the first element strictly greater than `target`. The modulo handles the wrap-around: when `idx == len(letters)` (target >= everything), `idx % len(letters)` evaluates to `0`, returning `letters[0]`.

### `TestNextGreatestLetter`

Nine test methods covering:
- Standard cases (`test_example1`, `test_example2`, `test_example3`)
- Target smaller than all letters (`test_target_less_than_all`)
- Target equals the last element — forces wrap-around (`test_target_equals_last`)
- Target greater than all letters — forces wrap-around (`test_target_greater_than_all`)
- Duplicate letters (`test_duplicates`)
- Two-element list (`test_two_elements`)
- Target between existing letters (`test_target_between_letters`)

## Patterns

- **Standard library over hand-rolled binary search.** Uses `bisect_right` from the `bisect` module rather than writing a manual binary search loop. This is idiomatic Python for sorted-sequence queries and eliminates off-by-one risk.
- **Modular arithmetic for circular wrap-around.** `idx % len(letters)` is a compact way to express "if past the end, go back to the start" — a common pattern in circular array problems.
- **Single-file solution+test convention.** Consistent with the rest of the repo: each problem directory has `solution.py` containing both the `Solution` class and a `unittest.TestCase` subclass.

## Dependencies

**Imports:**
- `bisect.bisect_right` — the binary search that does all the heavy lifting
- `typing.List` — type annotation (could be replaced with `list` on Python 3.9+)
- `unittest` — test framework

**Imported by:** The `test_solution.py` files listed in the "Imported By" section are other problems' test files — this is likely an artifact of the static analysis tool rather than a real import relationship. The actual reverse dependency is `find-smallest-letter-greater-than-target/test_solution.py`, which imports and runs the tests from this file.

## Flow

1. `bisect_right(letters, target)` performs O(log n) binary search, returning the index where `target` would be inserted to keep `letters` sorted, placed *after* any existing copies of `target`.
2. The modulo maps the index into `[0, len(letters))`, handling the wrap-around case.
3. `letters[idx % len(letters)]` returns the answer in O(1).

Total: **O(log n) time, O(1) space.**

## Invariants

- **`letters` must be sorted.** `bisect_right` assumes sorted input; unsorted input produces undefined results. The problem statement guarantees this.
- **`letters` must be non-empty.** Division by zero in `len(letters)` otherwise. The problem guarantees `letters.length >= 2`.
- **Wrap-around semantics.** When no letter is strictly greater than target, the answer is `letters[0]`. This is enforced by the modulo arithmetic, not by an explicit conditional.

## Error Handling

None — the function trusts its inputs match the LeetCode contract. No validation, no exceptions. This is appropriate for a competitive-programming solution where inputs are guaranteed valid.

---

## Topics to Explore

- [function] `binary-search/solution.py:Solution.search` — Compare this bisect-based approach with the manual binary search implementation elsewhere in the repo
- [file] `first-bad-version/solution.py` — Another binary search variant that finds a boundary rather than an exact match
- [general] `bisect-right-vs-bisect-left` — Understanding when to use `bisect_left` vs `bisect_right` is critical; this solution specifically requires `bisect_right` because equal-to-target must be skipped
- [file] `guess-number-higher-or-lower/solution.py` — A binary search problem with a different API contract (callback-based instead of array-based)
- [file] `kth-missing-positive-number/solution.py` — Binary search on a derived condition rather than direct element comparison

## Beliefs

- `bisect-right-not-left` — `bisect_right` is required here, not `bisect_left`; using `bisect_left` would incorrectly return the target itself when it exists in `letters`
- `modulo-handles-wrap` — The `idx % len(letters)` expression handles wrap-around for all cases: target greater than all elements, target equal to the last element, and target equal to any interior element
- `log-n-time-constant-space` — The solution runs in O(log n) time and O(1) auxiliary space, matching the optimal complexity for searching a sorted array
- `no-input-validation` — The function performs no validation on its inputs; it assumes `letters` is a non-empty sorted list of lowercase characters, per the LeetCode contract

