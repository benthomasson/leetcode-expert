# File: intersection-of-two-linked-lists/solution.py

**Date:** 2026-06-06
**Time:** 17:07

## Purpose

This file solves [LeetCode 160 — Intersection of Two Linked Lists](https://leetcode.com/problems/intersection-of-two-linked-lists/). It finds the node at which two singly linked lists converge into a shared tail, or returns `None` if they don't intersect. It defines both the `ListNode` data structure and the `Solution` class with the solver method.

## Key Components

**`ListNode`** — A minimal singly linked list node with `val: int` and `next: Optional[ListNode]`. This is the standard LeetCode definition, self-contained here rather than imported from a shared module.

**`Solution.getIntersectionNode(headA, headB) -> Optional[ListNode]`** — The core algorithm. Takes two list heads and returns the first shared node (by identity, not value), or `None`.

## Patterns

The algorithm uses the **two-pointer length-equalizing trick**. Two pointers `a` and `b` start at `headA` and `headB` respectively. When a pointer reaches the end of its list, it jumps to the head of the *other* list. This means:

- Pointer `a` traverses: `listA + listB`
- Pointer `b` traverses: `listB + listA`

Both paths have the same total length (`len(A) + len(B)`), so the pointers are guaranteed to align at the intersection node — or both reach `None` simultaneously if there's no intersection. This eliminates the need to compute list lengths in a separate pass.

The critical detail is the conditional: `a.next if a else headB`. When `a` is `None` (past the tail), it redirects to `headB`. When `a` is a valid node, it advances normally. This is subtly different from redirecting when `a.next is None` — that version would skip the `None` synchronization step and fail on non-intersecting lists.

## Dependencies

**Imports:** Only `typing.Optional` — no external dependencies.

**Imported by:** The massive `imported_by` list is misleading — those test files likely import `ListNode` as a shared fixture, not this solution specifically. The direct consumer is `intersection-of-two-linked-lists/test_solution.py`.

## Flow

```
a = headA, b = headB
  │
  ▼
while a is not b:        ← identity check, not value equality
  a = a.next or headB   ← redirect to other list on exhaustion
  b = b.next or headA
  │
  ▼
return a                 ← intersection node, or None if both exhausted
```

The loop terminates in at most `len(A) + len(B) + 1` iterations. If lists intersect, `a` and `b` meet at the intersection. If they don't, both reach `None` on the same iteration (since both traverse `len(A) + len(B)` nodes total).

## Invariants

- **O(1) space**: No auxiliary data structures — only two pointers.
- **O(m+n) time**: Each pointer traverses at most both lists once.
- **Identity comparison**: `a is not b` checks node identity, not value equality. Two nodes with the same `val` at different memory addresses are not considered an intersection.
- **No mutation**: The input lists are never modified.

## Error Handling

None. The method assumes both `headA` and `headB` are valid `ListNode` instances (or that both lists are non-empty). If either head is `None`, the pointers will cycle through `None → otherHead → ...` and still converge correctly, so the algorithm is implicitly safe for empty inputs.

## Topics to Explore

- [file] `intersection-of-two-linked-lists/test_solution.py` — How the test constructs intersecting lists (building shared tails by node identity is the tricky part of testing this)
- [file] `linked-list-cycle/solution.py` — Floyd's cycle detection is the closest algorithmic sibling — same two-pointer family, different invariant
- [file] `middle-of-the-linked-list/solution.py` — Another two-pointer linked list technique (fast/slow) worth comparing
- [general] `two-pointer-redirect-vs-length-diff` — The alternative approach computes `len(A) - len(B)`, advances the longer list's pointer by the difference, then walks in lockstep — same complexity, more code
- [file] `intersection-of-two-linked-lists/plan.md` — May document why this approach was chosen over the hash-set O(n) space alternative

## Beliefs

- `two-pointer-convergence-correctness` — When two lists intersect, pointers `a` and `b` always meet at the intersection node after at most `len(A) + len(B)` steps because both traverse the same total distance
- `none-termination-on-no-intersection` — When lists do not intersect, both pointers reach `None` on the same iteration, causing the loop to exit and return `None`
- `identity-not-equality` — The `is not` check compares node identity (memory address), not `val` equality — two nodes with `val=5` at different addresses are distinct
- `no-auxiliary-space` — The solution uses exactly two pointer variables regardless of input size, achieving O(1) space complexity

