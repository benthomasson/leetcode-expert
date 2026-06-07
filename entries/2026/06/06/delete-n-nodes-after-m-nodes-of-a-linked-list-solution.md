# File: delete-n-nodes-after-m-nodes-of-a-linked-list/solution.py

**Date:** 2026-06-06
**Time:** 16:16

## Purpose

This file implements LeetCode problem 1474: "Delete N Nodes After M Nodes of a Linked List." It's a self-contained solution module that defines the linked list node type, the core algorithm, conversion helpers, and a full test suite — following the standard layout used across all problems in this repo.

## Key Components

### `ListNode` (class)
Standard singly-linked list node with `val: int` and `next: Optional[ListNode]`. This is defined locally rather than imported from a shared module, making each solution independently runnable.

### `deleteNodes(head, m, n)` (function)
The core algorithm. Operates in-place on the linked list in a repeating two-phase cycle:

1. **Keep phase**: Walk forward `m - 1` steps (keeping `m` nodes total, since `current` is already on the first kept node).
2. **Delete phase**: Walk a separate `skip` pointer forward `n` steps from `current.next`, then splice by setting `current.next = skip`.
3. **Advance**: Move `current` to `skip` (the first node after the deleted section) and repeat.

Returns the original `head` — the head never changes because we always keep the first `m` nodes.

### `list_to_linked(vals)` / `linked_to_list(head)`
Bidirectional conversion between Python lists and linked lists. Used exclusively by tests to set up inputs and assert outputs without manually constructing node chains.

### `TestDeleteNodes` (class)
Eight test cases covering: the two LeetCode examples, single-node lists, `m` exceeding list length, `n` exceeding remaining nodes, alternating keep/delete (m=1, n=1), keeping all nodes, and deleting everything after the first node.

## Patterns

- **In-place linked list surgery**: No new nodes are allocated. The algorithm rewires `.next` pointers to skip over deleted sections. This is O(1) extra space.
- **Cycle-based traversal**: The outer `while current` loop handles the repeating m-keep/n-delete pattern. Each iteration of the outer loop processes one full cycle.
- **Early-return guards**: Both the keep-loop and the post-keep check return `head` immediately if the list is exhausted mid-cycle — avoiding null dereference on `current.next`.
- **Self-contained test harness**: `unittest` is embedded in the solution file itself, runnable via `python solution.py`. The `check` helper method centralizes the list→linked→algorithm→list→assert pipeline.

## Dependencies

**Imports**: Only stdlib — `__future__.annotations` (for `Optional[ListNode]` forward refs), `typing.Optional`, and `unittest`. No external packages.

**Imported by**: The `test_solution.py` in this same directory imports from it. The massive "Imported By" list in the prompt is misleading — those are cross-references from other problems' test files, likely an artifact of the repo's analysis tooling rather than actual imports of this specific file.

## Flow

For input `[1,2,3,4,5,6,7,8,9,10,11,12,13]`, m=2, n=3:

```
Cycle 1: keep [1,2], delete [3,4,5] → wire 2→6
Cycle 2: keep [6,7], delete [8,9,10] → wire 7→11
Cycle 3: keep [11,12], delete [13] → wire 12→None
Result: [1,2,6,7,11,12]
```

The keep-phase loop runs `m - 1` times (not `m`) because `current` starts on the first node to keep. The delete-phase uses a separate `skip` pointer starting at `current.next` and advances `n` times, tolerating early exhaustion via `if not skip: break`.

## Invariants

- **`current` is always the last kept node** when the delete phase begins. This is why the keep loop runs `m - 1` iterations.
- **Head is never modified**. The first `m` nodes are always kept, so the return value is always the original `head`.
- **The delete phase never dereferences a null pointer**. The `if not skip: break` guard inside the delete loop handles lists shorter than `n` remaining nodes.
- **`m >= 1`** is assumed. If `m = 0`, the keep loop would run with `range(-1)` (a no-op), then `current.next = skip` would still be set from `current.next` — effectively deleting nothing. The problem constraints guarantee `m >= 1`.

## Error Handling

There is none beyond the null checks on `current` and `skip`. The function assumes valid inputs per the LeetCode contract (non-null head, m >= 1, n >= 1). No exceptions are raised. If `head` is `None`, the `while current` loop never executes and `None` is returned.

## Topics to Explore

- [file] `delete-n-nodes-after-m-nodes-of-a-linked-list/test_solution.py` — Check whether the external test file duplicates or extends the inline tests
- [function] `remove-linked-list-elements/solution.py:removeElements` — Compare linked list deletion patterns: value-based removal vs. positional removal
- [function] `middle-of-the-linked-list/solution.py:middleNode` — Another linked list traversal pattern (fast/slow pointers) for contrast
- [general] `linked-list-in-place-surgery` — How other solutions in this repo handle node deletion without extra allocation
- [file] `reverse-linked-list/solution.py` — The most common linked list pointer-manipulation pattern; good baseline for comparison

## Beliefs

- `delete-nodes-head-never-changes` — `deleteNodes` always returns the original `head` pointer unchanged; the first node is never deleted
- `delete-nodes-zero-allocation` — The algorithm creates no new `ListNode` instances; it only rewires `.next` pointers on existing nodes
- `delete-nodes-keep-loop-off-by-one` — The keep-phase iterates `m - 1` times because `current` already points to the first node being kept
- `delete-nodes-tolerates-short-lists` — Both the keep and delete phases exit early without error if the list is exhausted before completing `m` or `n` steps

