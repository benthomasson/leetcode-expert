# File: middle-of-the-linked-list/solution.py

**Date:** 2026-06-06
**Time:** 17:49

## Purpose

This file solves [LeetCode 876 — Middle of the Linked List](https://leetcode.com/problems/middle-of-the-linked-list/). It defines the `ListNode` data structure and a function that finds the middle node of a singly linked list using the slow/fast pointer (tortoise and hare) technique.

## Key Components

### `ListNode`
A minimal singly linked list node with two fields:
- `val: int` — the node's value (defaults to `0`)
- `next: Optional[ListNode]` — pointer to the next node (defaults to `None`)

This class is the shared linked list definition across the repo — the "Imported By" list shows hundreds of test files reference it.

### `middle_of_the_linked_list(head)`
**Contract:** Given the head of a singly linked list, return the middle node. For even-length lists (two middle nodes), return the **second** one.

- **Input:** `Optional[ListNode]` — can be `None` (empty list)
- **Output:** `Optional[ListNode]` — the middle node itself, not a copy
- **Side effects:** None. The list is not modified.

## Patterns

**Slow/fast pointer (tortoise and hare).** Two pointers start at `head`. `slow` advances one step per iteration; `fast` advances two. When `fast` reaches the end, `slow` is at the midpoint. This is the canonical O(n) time, O(1) space approach for finding the middle of a linked list without knowing its length.

The loop condition `while fast and fast.next` handles both odd and even lengths:
- **Odd length** (e.g., 5 nodes): `fast` lands on the last node (`fast.next` is `None`), `slow` is on the exact middle.
- **Even length** (e.g., 4 nodes): `fast` overshoots to `None`, `slow` is on the second of the two middle nodes.

## Dependencies

**Imports:** Only standard library — `annotations` for PEP 604 forward-reference support, `Optional` from `typing`.

**Imported by:** This file is the canonical `ListNode` definition for the project. The massive "Imported By" list (300+ test files) is because test files across unrelated problems import `ListNode` from here to construct linked lists in their test fixtures. The function `middle_of_the_linked_list` is only tested by `middle-of-the-linked-list/test_solution.py`.

## Flow

1. Initialize `slow` and `fast` to `head`.
2. Each iteration: `slow` moves one node forward, `fast` moves two.
3. Loop exits when `fast` is `None` (even length) or `fast.next` is `None` (odd length).
4. Return `slow` — it now points to the middle node.

For a list `1 -> 2 -> 3 -> 4 -> 5`:
| Step | slow | fast |
|------|------|------|
| 0    | 1    | 1    |
| 1    | 2    | 3    |
| 2    | 3    | 5    |
Loop exits (`fast.next` is `None`). Return node 3.

## Invariants

- After each loop iteration, `fast` is always twice as far from `head` as `slow`.
- The function never modifies any node's `val` or `next` — it's purely a read traversal.
- For even-length lists, returns the second middle node (not the first). This matches LeetCode's specification.
- If `head` is `None`, the function returns `None` immediately (the `while` condition fails on the first check).

## Error Handling

None. The function assumes well-formed input (no cycles, valid `ListNode` instances). If the list contains a cycle, this function loops forever — but that's outside the problem's contract. No exceptions are raised or caught.

## Topics to Explore

- [file] `middle-of-the-linked-list/test_solution.py` — See how linked lists are constructed for testing and what edge cases are covered (single node, even/odd lengths)
- [file] `linked-list-cycle/solution.py` — Same slow/fast pointer technique applied to cycle detection — compare the loop conditions
- [file] `palindrome-linked-list/solution.py` — Likely uses middle-finding as a sub-step (find middle, reverse second half, compare)
- [function] `intersection-of-two-linked-lists/solution.py:getIntersectionNode` — Another two-pointer linked list technique worth comparing
- [general] `tortoise-and-hare-variants` — How the slow/fast pointer technique generalizes across linked list problems (cycle detection, cycle start, middle finding)

## Beliefs

- `slow-fast-second-middle` — For even-length lists, `middle_of_the_linked_list` returns the second middle node because `fast` is checked before `fast.next` in the while condition
- `listnode-is-shared-definition` — `ListNode` from this file is the de facto shared linked list node class imported by 300+ test files across the repo
- `single-pass-no-length` — The algorithm finds the middle in exactly one pass (n/2 iterations) without computing the list's length
- `no-mutation-guarantee` — The function performs a read-only traversal; no node's `val` or `next` pointer is modified

