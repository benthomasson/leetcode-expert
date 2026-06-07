# File: root-equals-sum-of-children/solution.py

**Date:** 2026-06-06
**Time:** 18:57



## Purpose

This file is the self-contained solution for [LeetCode 2236: Root Equals Sum of Children](https://leetcode.com/problems/root-equals-sum-of-children/). It owns three things: the `TreeNode` data structure, the `Solution.checkTree` algorithm, and the test suite that validates it. It's one of the simplest problems in the repository — a guaranteed 3-node binary tree where you check if `root.val == left.val + right.val`.

## Key Components

### `TreeNode` (lines 9–14)
Standard binary tree node with `val`, `left`, and `right`. This is the local definition used by both the solution and tests — it mirrors LeetCode's provided definition rather than importing a shared one.

### `Solution.checkTree` (lines 18–26)
Single-expression method: `return root.val == root.left.val + root.right.val`. No null-checking, no recursion, no edge-case handling — the problem guarantees exactly 3 nodes with both children present.

### `TestCheckTree` (lines 29–48)
Seven test cases covering:
- The two LeetCode examples (sum matches / doesn't match)
- All-zeros edge case
- Negative children, mixed signs, boundary values (+/-100)
- False case with negatives

The helper `_make_tree` constructs the fixed 3-node tree from three ints, keeping test setup DRY.

## Patterns

- **Self-contained module**: `TreeNode` is defined locally rather than imported from a shared utility, which is the convention across this repository. Every problem directory is independent.
- **Solution class wrapping**: Follows LeetCode's convention of putting the algorithm in a `Solution` class method, even though a bare function would suffice.
- **Inline tests**: Tests live in the same file as the solution (the `test_solution.py` in the directory likely imports from here). The `if __name__ == "__main__"` guard lets the file run standalone.

## Dependencies

**Imports**: `annotations` (PEP 604-style type hints), `unittest`, `Optional` from `typing`. All stdlib — no external packages.

**Imported by**: The "Imported By" list is enormous (~400+ test files), which almost certainly means those test files import `TreeNode` from this module as a shared fixture — not `Solution` or `checkTree`. This file is effectively the canonical `TreeNode` definition for the entire repository's test infrastructure.

## Flow

1. Caller passes a `TreeNode` root guaranteed to have both `.left` and `.right`.
2. `checkTree` reads three `.val` attributes, computes one addition, one comparison.
3. Returns a `bool`. O(1) time, O(1) space.

## Invariants

- **Root is non-None and has exactly two non-None children.** The method dereferences `root.left.val` and `root.right.val` unconditionally — any violation of this precondition raises `AttributeError`.
- **Values are integers.** The addition and equality check assume numeric types.

## Error Handling

None. The method trusts the caller to satisfy the precondition (3-node tree). A `None` root or missing child causes an unhandled `AttributeError`. This is appropriate given LeetCode's guarantees.

## Topics to Explore

- [file] `evaluate-boolean-binary-tree/solution.py` — Another simple binary tree problem; compare how it handles recursive evaluation vs. this flat check
- [file] `balanced-binary-tree/solution.py` — Shows recursive tree traversal with height computation, a step up in complexity from this single-node check
- [general] `TreeNode-reuse-across-tests` — Investigate why ~400 test files import from this module; is it intentional or an artifact of the test generation script?
- [function] `root-equals-sum-of-children/test_solution.py:TestCheckTree` — Check whether the separate test file duplicates or extends the inline tests
- [file] `run_tests.py` — The project-wide test runner; understanding how it discovers and runs these per-problem test suites

## Beliefs

- `root-equals-sum-no-null-guard` — `checkTree` unconditionally dereferences `root.left` and `root.right` with no null checks, relying on the problem's 3-node guarantee
- `treenode-is-canonical-import` — This file's `TreeNode` class is imported by 400+ test files across the repository, making it the de facto shared tree node definition
- `solution-is-o1` — `checkTree` performs exactly one addition and one comparison with no recursion or iteration, making it O(1) time and space
- `tests-cover-negative-values` — The test suite validates negative and mixed-sign node values, which goes beyond LeetCode's stated constraint of non-negative values

