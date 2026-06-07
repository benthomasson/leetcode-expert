# File: remove-outermost-parentheses/solution.py

**Date:** 2026-06-06
**Time:** 18:48

## Purpose

This file is a self-contained solution and test suite for [LeetCode 1021: Remove Outermost Parentheses](https://leetcode.com/problems/remove-outermost-parentheses/). It owns the algorithm for decomposing a valid parentheses string into its primitive components and stripping the outermost layer from each primitive.

## Key Components

### `Solution.removeOuterParentheses(s: str) -> str`

The single method on the `Solution` class. Takes a valid parentheses string `s` and returns a new string with the outermost parentheses of each primitive decomposition removed.

A **primitive** parentheses string is one that cannot be split into two non-empty valid parentheses strings. For example, `(()())` is primitive but `(())(())` is not — it decomposes into `(())` and `(())`.

### `TestRemoveOuterParentheses`

Seven test cases covering the LeetCode examples, edge cases (empty string, single primitive `()`), deeply nested input, and multiple adjacent primitives that all reduce to empty.

## Patterns

**Depth-counter gate.** The algorithm uses a single integer `depth` as a state machine to decide whether each character belongs to an outer or inner layer. The key insight: when you encounter `(` and depth transitions from 0→1, that's an outer open paren — skip it. When you encounter `)` and depth transitions from 1→0, that's an outer close — skip it. Everything else is inner content to keep.

The two conditionals implement this asymmetrically but equivalently:
- For `(`: increment depth *first*, then include only if `depth > 1` (i.e., not the outermost open)
- For `)`: decrement depth *first*, then include only if `depth > 0` (i.e., not the outermost close)

This is an O(n) single-pass algorithm with O(n) space for the result list.

## Dependencies

**Imports:** Only `unittest` from the standard library — no external dependencies.

**Imported by:** The "imported by" list in the prompt is misleading. Those ~400+ test files don't actually import this module — that list appears to be an artifact of the repo's structure where every `test_solution.py` follows the same pattern. The actual test for this solution is inline in the same file.

## Flow

1. Initialize empty `result` list and `depth = 0`
2. For each character in `s`:
   - `(` → increment depth. If depth > 1, this is an inner paren — append it
   - `)` → decrement depth. If depth > 0 after decrement, this is an inner paren — append it
3. Join and return

The depth counter naturally resets to 0 at the boundary between primitives, so multiple primitives in a single string are handled without any explicit delimiter detection.

## Invariants

- **Input must be a valid parentheses string.** The algorithm doesn't validate this — it trusts the caller (LeetCode guarantees it). Invalid input would produce silently wrong results, not errors.
- **Depth is always non-negative** during a correct traversal of a valid string.
- **Depth equals 0 exactly at primitive boundaries** — this is the structural property the algorithm exploits.

## Error Handling

None. The function assumes valid input per the problem constraints. Empty string is handled gracefully (the loop body never executes, returning `""`). There are no exceptions, no assertions, no input validation.

## Topics to Explore

- [file] `valid-parentheses/solution.py` — Classic stack-based parentheses validation; contrasts with the depth-counter approach used here
- [file] `maximum-nesting-depth-of-the-parentheses/solution.py` — Uses the same depth-tracking pattern but extracts the max depth instead of filtering characters
- [general] `primitive-decomposition` — The formal definition of primitive parentheses strings and how decomposition uniqueness is proven
- [function] `remove-outermost-parentheses/solution.py:removeOuterParentheses` — Try modifying to return the list of primitives themselves (before stripping) to verify understanding of the depth-boundary invariant

## Beliefs

- `depth-zero-marks-primitive-boundaries` — The depth counter returns to exactly 0 at the end of each primitive decomposition component, and nowhere else within it
- `increment-before-test-pattern` — The algorithm increments/decrements depth before testing the inclusion condition, which is what makes `> 1` and `> 0` the correct thresholds for open and close parens respectively
- `single-pass-linear-time` — The solution processes each character exactly once with O(1) work per character, achieving O(n) time complexity
- `no-input-validation` — The function silently produces incorrect results on malformed input rather than raising an error; correctness depends entirely on the caller providing a valid parentheses string

