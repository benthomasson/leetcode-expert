# File: majority-element/solution.py

**Date:** 2026-06-06
**Time:** 17:29

## Purpose

This file solves [LeetCode 169 — Majority Element](https://leetcode.com/problems/majority-element/). It implements the Boyer-Moore Voting Algorithm to find the element that appears more than `n/2` times in an array, and includes inline unit tests. Like every other problem directory in this repo, it's a self-contained solution + test pair.

## Key Components

### `majority_element(nums: list[int]) -> int`

The sole function. Takes a non-empty list guaranteed to contain one element with a strict majority (> n/2 occurrences) and returns that element.

The algorithm uses two variables:
- **`candidate`** — the current guess for the majority element
- **`count`** — a running "confidence score" for the candidate

### Test Suite

Nine tests covering: basic LeetCode examples, single-element and uniform arrays, majority at different positions, negative numbers, and a dominant-majority case. No edge case for empty input, consistent with the problem's guarantee that `nums` is non-empty with a valid majority.

## Patterns

**Boyer-Moore Voting Algorithm** — This is the canonical O(n) time, O(1) space solution. The key insight: if you pair each occurrence of the majority element with a different element, at least one occurrence of the majority is left unpaired. The counter tracks this surplus.

The algorithm works in a single pass with no data structures — no hash maps, no sorting. This is the optimal approach for this problem.

**Inline tests** — The `unittest` import and test class live in the same file as the solution, a pattern used across this repo. The `if __name__ == "__main__"` guard means tests run via `python solution.py` directly.

## Dependencies

**Imports**: Only `unittest` from the standard library. No external dependencies.

**Imported by**: The "imported by" list in the prompt is misleading — those 400+ `test_solution.py` files aren't actually importing *this* file. They each import `unittest` independently. The `majority-element/test_solution.py` file likely imports `majority_element` from this module.

## Flow

1. Initialize `candidate = 0`, `count = 0`
2. For each `num` in `nums`:
   - If `count == 0`, adopt `num` as the new `candidate` (previous candidate was "cancelled out")
   - If `num == candidate`, increment `count`; otherwise decrement
3. Return `candidate`

The algorithm never validates that the candidate actually has a majority — it relies on the precondition that one exists. If no majority element exists, the return value is undefined.

## Invariants

- **Precondition**: `nums` is non-empty and contains exactly one element appearing > n/2 times. Violating this makes the output meaningless.
- **Loop invariant**: After processing `nums[0..i]`, the candidate is the majority of the "unmatched" suffix — every non-candidate seen so far has been paired with and cancelled against a candidate occurrence.
- **No verification pass**: Unlike some implementations that add a second pass to confirm the candidate actually exceeds n/2, this one trusts the precondition.

## Error Handling

None. Empty input would return `0` (the initial value of `candidate`) silently. Invalid input (no majority exists) returns an arbitrary element. This is fine for a LeetCode solution where constraints are guaranteed.

## Topics to Explore

- [file] `majority-element/plan.md` — Planning doc that likely discusses algorithm choice (hash map vs. sorting vs. Boyer-Moore)
- [file] `majority-element/review.md` — Code review notes that may cover the missing verification pass tradeoff
- [file] `check-if-a-number-is-majority-element-in-a-sorted-array/solution.py` — Related problem that uses binary search on sorted input; contrasts with the unsorted-array approach here
- [general] `boyer-moore-voting-generalization` — The algorithm generalizes to finding elements appearing > n/k times using k-1 candidates (LeetCode 229 — Majority Element II)
- [function] `majority-element/test_solution.py:TestMajorityElement` — The separate test file may contain additional or different test cases from the inline ones

## Beliefs

- `boyer-moore-no-verification` — `majority_element` does not include a second pass to verify the candidate; it assumes the precondition (majority exists) holds
- `boyer-moore-constant-space` — The algorithm uses exactly two scalar variables (`candidate`, `count`) regardless of input size — O(1) auxiliary space
- `single-pass-linear` — The function iterates through `nums` exactly once, making it O(n) time with no early exits
- `empty-input-returns-zero` — If called with an empty list, the function returns `0` without raising, because the loop body never executes and `candidate` retains its initial value

