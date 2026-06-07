# File: element-appearing-more-than-25-in-sorted-array/solution.py

**Date:** 2026-06-06
**Time:** 16:28

## Purpose

This file solves [LeetCode 1287: Element Appearing More Than 25% In Sorted Array](https://leetcode.com/problems/element-appearing-more-than-25-in-sorted-array/). It owns a single function that finds the element whose frequency exceeds 25% in a sorted integer array, guaranteed to have exactly one such element.

## Key Components

### `find_special_integer(arr: list[int]) -> int`

Takes a sorted array and returns the element appearing more than 25% of the time.

**Contract:** The caller guarantees `arr` is sorted and contains exactly one element with frequency > 25%. The function always returns an `int`.

## Patterns

**Sliding window / gap check.** Instead of counting occurrences, the solution exploits the sorted order: if an element appears more than `n/4` times in a sorted array, then there must exist some index `i` where `arr[i] == arr[i + n//4]`. Two equal values that far apart in a sorted array means every value between them is the same — so at least `n//4 + 1` copies exist.

This is an O(n) scan with O(1) space, avoiding hash maps or `Counter`.

**Fallback return.** The `return arr[-1]` on line 16 is a structural guard — given the problem's guarantee, the loop will always find and return inside the `for`. The final return makes the function total (no path exits without a value) but is effectively dead code under valid input.

## Dependencies

**Imports:** None — pure Python, no stdlib or third-party dependencies.

**Imported by:** The `test_solution.py` in the same directory, plus hundreds of other test files across the repo (the "Imported By" list in your context is the test runner's cross-reference, not actual imports of this function — those test files import their own solutions).

## Flow

1. Compute `quarter = len(arr) // 4` — the minimum gap that proves >25% frequency.
2. Iterate `i` from `0` to `len(arr) - quarter - 1`.
3. At each `i`, compare `arr[i]` with `arr[i + quarter]`. If equal, that value spans at least `quarter + 1` positions in the sorted array, so it appears more than 25% of the time. Return it immediately.
4. If the loop exhausts without returning (impossible under valid input), return the last element.

**Example:** `arr = [1, 2, 2, 6, 6, 6, 6, 7, 10]`, `n = 9`, `quarter = 2`. At `i = 3`: `arr[3] = 6 == arr[5] = 6` → return `6`.

## Invariants

- **Sorted input required.** The gap-check logic is only correct when the array is sorted. Unsorted input would produce wrong results silently.
- **Exactly one majority element.** The problem guarantees one element exceeds 25%. If multiple did, the function returns the first one encountered (leftmost in sorted order).
- **Integer division truncation.** `len(arr) // 4` truncates, which is correct: for `n = 5`, `quarter = 1`, and comparing adjacent elements catches anything appearing ≥2 times (>25% of 5).

## Error Handling

None. No input validation, no exceptions. The function trusts the caller to provide a valid sorted list. Empty list input would cause `arr[-1]` to raise `IndexError`; single-element input works correctly (quarter = 0, loop range is empty, returns `arr[-1]`).

## Topics to Explore

- [file] `element-appearing-more-than-25-in-sorted-array/test_solution.py` — See what edge cases the tests cover (single element, all same, threshold boundary)
- [file] `check-if-a-number-is-majority-element-in-a-sorted-array/solution.py` — Related problem using binary search on sorted arrays for frequency queries
- [general] `sorted-array-frequency-tricks` — The broader pattern of exploiting sort order to avoid counting (also seen in majority element, binary search variants)
- [file] `element-appearing-more-than-25-in-sorted-array/review.md` — Code review notes may discuss alternative approaches (binary search on candidates at n/4, n/2, 3n/4)

## Beliefs

- `quarter-gap-correctness` — If `arr[i] == arr[i + len(arr)//4]` in a sorted array, that element appears at least `len(arr)//4 + 1` times
- `find-special-integer-linear-time` — `find_special_integer` runs in O(n) time and O(1) space with a single pass
- `fallback-return-unreachable` — The `return arr[-1]` on line 16 is unreachable given the problem's guarantee of exactly one element exceeding 25%
- `no-input-validation` — The function performs no validation; unsorted input or empty input will produce wrong results or raise exceptions silently

