# File: count-hills-and-valleys-in-an-array/solution.py

**Date:** 2026-06-06
**Time:** 15:58

## Purpose

This file solves [LeetCode 2210: Count Hills and Valleys in an Array](https://leetcode.com/problems/count-hills-and-valleys-in-an-array/). It's a self-contained module holding both the solution function and its unit tests. In the project structure, each LeetCode problem gets its own directory with a `solution.py`, `test_solution.py`, `plan.md`, and `review.md`.

## Key Components

### `count_hills_and_valleys(nums: List[int]) -> int`

The sole public function. Takes an integer array and returns the count of indices that are either a **hill** (strictly greater than both neighbors) or a **valley** (strictly less than both neighbors), after collapsing consecutive equal elements.

**Contract**: `nums` must have at least one element. The function never mutates the input list.

### `TestCountHillsAndValleys`

Eight test cases covering: the two LeetCode examples, all-same elements, alternating values, plateaus, monotonic sequences, and minimal-length hills/valleys.

## Patterns

**Dedup-then-scan**: The solution uses a two-pass approach rather than tracking "last different value" inline. First it builds a `deduped` list by skipping consecutive duplicates (lines 16–19), then it scans the interior of that list checking the hill/valley condition (lines 21–25). This separates the concern of handling plateaus from the geometric check.

This is a common idiom in this repo — preprocess the input to normalize it, then apply straightforward logic on the cleaned data.

**Inline tests**: Tests live in the same file as the solution (rather than only in `test_solution.py`), making it runnable standalone via `python solution.py`.

## Dependencies

**Imports**: `List` from `typing` (type annotation), `unittest` (test framework). No project-internal dependencies.

**Imported by**: The `test_solution.py` in this same directory imports the function. The massive `Imported By` list in the prompt is an artifact of the repo-wide test infrastructure — those other test files don't actually import *this* file; they follow the same structural pattern.

## Flow

1. **Deduplication** — Iterate `nums[1:]`, appending to `deduped` only when the value differs from the last appended value. This collapses runs like `[1, 5, 5, 5, 1]` → `[1, 5, 1]`.

2. **Counting** — For each interior index `i` in `deduped` (i.e., `1` through `len-2`), check if `deduped[i]` is a local maximum (hill) or local minimum (valley) by comparing to both neighbors. Increment `count` for either case.

3. **Return** — The accumulated count.

## Invariants

- **Deduped has no consecutive duplicates**: After the first pass, `deduped[i] != deduped[i+1]` for all valid `i`. This guarantees the hill/valley check on interior elements is sufficient — no plateau ambiguity remains.
- **Boundary elements are never counted**: The loop starts at index 1 and ends at `len(deduped) - 2`, so the first and last elements of `deduped` are always excluded (they have only one neighbor).
- **Input is not mutated**: A new list `deduped` is constructed; `nums` is read-only.

## Error Handling

None. The function assumes valid input per the LeetCode constraint (`2 <= nums.length <= 100`). If `nums` has fewer than 3 distinct-consecutive values, the inner loop simply doesn't execute and returns 0. A single-element input would work fine (deduped has length 1, loop range is empty). An empty input would crash at `nums[0]` — but that's outside the problem's constraints.

## Topics to Explore

- [file] `count-hills-and-valleys-in-an-array/test_solution.py` — The companion test file; may have additional edge cases or a different import structure
- [file] `count-hills-and-valleys-in-an-array/plan.md` — Documents the planning phase and alternative approaches considered before implementation
- [function] `count-hills-and-valleys-in-an-array/solution.py:count_hills_and_valleys` — Try replacing the two-pass approach with a single-pass that tracks `prev_different` to compare space trade-offs
- [file] `valid-mountain-array/solution.py` — Another array-shape problem; compare how it handles the "walk up then walk down" pattern vs. the dedup-then-scan here
- [general] `dedup-before-scan-pattern` — Survey how many solutions in this repo use the same preprocess-then-check structure vs. inline tracking of previous-different-value

## Beliefs

- `dedup-eliminates-plateau-ambiguity` — After deduplication, every interior element in `deduped` is either strictly a hill or strictly a valley or neither; plateaus cannot occur.
- `boundary-exclusion` — The algorithm never counts the first or last element of the original (or deduped) array as a hill or valley.
- `linear-time-linear-space` — The solution runs in O(n) time and O(n) auxiliary space for the `deduped` list; it could be reduced to O(1) space with a single-pass approach.
- `input-immutability` — `count_hills_and_valleys` never modifies the input `nums` list; all work is done on a separately allocated `deduped` list.

