# File: convert-binary-number-in-a-linked-list-to-integer/solution.py

**Date:** 2026-06-06
**Time:** 15:52

## Purpose

This file solves [LeetCode 1290: Convert Binary Number in a Linked List to Integer](https://leetcode.com/problems/convert-binary-number-in-a-linked-list-to-integer/). It owns the `ListNode` definition, the conversion algorithm, a linked-list builder helper, and inline unit tests. It's a self-contained solution module following the repo's standard layout.

## Key Components

### `ListNode` (class)
Standard singly-linked list node with `val` (int) and `next` (optional pointer). This is the LeetCode-standard definition — it's defined locally rather than imported from a shared module.

### `min_operations(head)` (function)
Misleading name — this has nothing to do with "minimum operations." It converts a binary-encoded linked list to its decimal integer value. The head node holds the MSB (most significant bit).

**Contract:** Accepts an optional `ListNode` head. Returns an `int`. Assumes every node's `val` is 0 or 1.

### `_make_list(values)` (function)
Test helper that builds a linked list from a Python list of ints. Iterates in reverse to construct the list from tail to head, which is the standard O(n) approach for building a singly-linked list from an array.

### `TestMinOperations` (class)
Seven test cases covering: basic examples, single-element lists, all-zeros, a specific 4-bit pattern (1100 = 12), a 30-bit stress test, and leading zeros.

## Patterns

**Horner's method** — The core algorithm `result = result * 2 + node.val` is Horner's scheme applied to base-2. Instead of computing positional powers of 2 explicitly, it shifts the accumulator left by one bit and adds the current digit on each step. This is both simpler and avoids needing to know the list length upfront.

**Inline tests** — Tests live in the same file as the solution and run via `unittest.main()` when executed directly. The repo also has separate `test_solution.py` files per problem.

## Dependencies

**Imports:** `typing.Optional` (for type hints), `unittest` (for inline tests). No project-internal imports.

**Imported by:** The "Imported By" list is massive (~400+ test files), which is clearly wrong — those test files don't import *this* solution. That list likely reflects a tooling artifact or cross-reference error. The actual dependent is `convert-binary-number-in-a-linked-list-to-integer/test_solution.py`.

## Flow

1. Caller passes the head of a linked list where each node holds 0 or 1 (MSB at head).
2. `result` starts at 0.
3. For each node: shift `result` left (multiply by 2), add current bit.
4. Advance to `node.next`. When `None`, return `result`.

For input `[1, 0, 1]`:
- Step 1: `0 * 2 + 1 = 1`
- Step 2: `1 * 2 + 0 = 2`
- Step 3: `2 * 2 + 1 = 5`

## Invariants

- Nodes must contain only 0 or 1 — no validation enforces this, but correctness depends on it.
- The list is interpreted MSB-first (head = highest-order bit).
- `_make_list` preserves input order: `_make_list([1, 0, 1])` produces head→1→0→1→None.
- An empty list (`head=None`) returns 0, which is correct by the loop's no-op behavior.

## Error Handling

None. The function trusts its input completely — no null checks beyond the natural `while node` loop guard, no validation of node values. This is standard for LeetCode solutions where inputs are guaranteed well-formed.

## Topics to Explore

- [file] `convert-binary-number-in-a-linked-list-to-integer/test_solution.py` — The companion test file; likely imports `min_operations` and `ListNode` from this module
- [file] `sum-of-root-to-leaf-binary-numbers/solution.py` — Same Horner's-method pattern but on a binary tree instead of a linked list; compare the traversal strategies
- [function] `convert-binary-number-in-a-linked-list-to-integer/solution.py:min_operations` — The function name doesn't match its behavior; worth checking if this naming is a repo-wide pattern or a one-off copy-paste error
- [file] `middle-of-the-linked-list/solution.py` — Another linked-list problem; check whether `ListNode` is redefined per-solution or shared

## Beliefs

- `horner-method-for-binary-conversion` — The conversion uses Horner's method (`result * 2 + bit`), processing MSB-first in a single pass with O(1) space
- `min-operations-is-misnamed` — The function `min_operations` performs binary-to-integer conversion, not any "minimum operations" computation; the name doesn't match the problem
- `listnode-defined-per-solution` — `ListNode` is defined locally in each solution file rather than imported from a shared module, meaning each problem is self-contained
- `empty-list-returns-zero` — Passing `None` as `head` returns 0 by the natural behavior of the while loop never executing

