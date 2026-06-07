# File: n-repeated-element-in-size-2n-array/solution.py

**Date:** 2026-06-06
**Time:** 18:11

## `n-repeated-element-in-size-2n-array/solution.py`

### Purpose

This file solves [LeetCode 961: N-Repeated Element in Size 2N Array](https://leetcode.com/problems/n-repeated-element-in-size-2n-array/). It owns a single function that identifies the repeated element in an array with a specific structure: length 2n, containing n+1 unique values where exactly one value appears n times.

### Key Components

**`repeated_n_times(nums: list[int]) -> int`** — The sole public function. Takes a 2n-length array and returns the element that appears n times. The contract guarantees exactly one such element exists per the problem constraints.

### Patterns

**Early-return with set membership** — The solution uses a hash set to detect the first duplicate encountered during a linear scan. The moment `num in seen` is true, that element must be the n-repeated one, because all other elements appear exactly once. This is a standard duplicate-detection idiom.

The function returns mid-iteration rather than scanning the entire array. Since the repeated element appears n times in a 2n-length array (i.e., half the elements), by the pigeonhole principle, a duplicate must be found within the first n+1 elements at most.

### Dependencies

**Imports**: None — the solution uses only Python builtins (`set`).

**Imported by**: The "Imported By" list in the prompt is misleading — it lists hundreds of unrelated test files. The actual direct consumer is `n-repeated-element-in-size-2n-array/test_solution.py`, which imports `repeated_n_times` to verify correctness.

### Flow

1. Initialize an empty `set` called `seen`.
2. Iterate through `nums` one element at a time.
3. For each element, check set membership (`O(1)` average).
4. If already seen, return it immediately — this is the answer.
5. Otherwise, add it to the set and continue.

No post-loop return exists. The function relies on the problem guarantee that a duplicate always exists, so the loop always terminates via the early return.

### Invariants

- **Input guarantee**: The array must have exactly 2n elements with n+1 unique values, one repeated n times. Without this, the function could return the wrong element or fail to return at all.
- **No fallback return**: There is no `return` after the loop. If called with an array of all unique elements, the function returns `None` implicitly — this is intentional reliance on the problem constraints.

### Error Handling

None. The function trusts its input completely, consistent with the LeetCode convention where inputs are guaranteed valid. An empty list would cause the function to return `None`; a list with no duplicates would do the same.

### Complexity

- **Time**: O(n) — at most n+1 iterations before a duplicate is found.
- **Space**: O(n) — the set stores up to n unique elements before hitting the duplicate.

## Topics to Explore

- [file] `n-repeated-element-in-size-2n-array/test_solution.py` — See the test cases and edge cases being validated
- [file] `n-repeated-element-in-size-2n-array/review.md` — The code review may discuss alternative approaches (e.g., random sampling, Boyer-Moore)
- [general] `pigeonhole-duplicate-detection` — Why a duplicate is guaranteed within the first n+1 elements, and how randomized O(1)-space solutions exploit adjacency patterns in shuffled arrays
- [function] `majority-element/solution.py:majorityElement` — A related problem where the repeated element appears more than n/2 times, solved with Boyer-Moore voting instead of a set

## Beliefs

- `repeated-n-times-early-return` — `repeated_n_times` always returns inside the loop body; there is no post-loop return statement, relying on the guarantee that a duplicate exists
- `repeated-n-times-linear-time` — The function runs in O(n) time and O(n) space using set-based duplicate detection
- `repeated-n-times-no-imports` — The solution uses no imports; it depends only on Python's built-in `set`
- `repeated-n-times-pigeonhole-bound` — A duplicate is guaranteed within the first n+1 elements of a 2n-length array where one value repeats n times

