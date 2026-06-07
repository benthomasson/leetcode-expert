# File: reverse-linked-list/solution.py

**Date:** 2026-06-06
**Time:** 18:53

## `reverse-linked-list/solution.py`

### Purpose

This file is the self-contained solution for [LeetCode #206 — Reverse Linked List](https://leetcode.com/problems/reverse-linked-list/). It owns the problem's data structure (`ListNode`), two solution variants (iterative and recursive), test helpers for conversion between Python lists and linked lists, and a full unit test suite. It follows the repo-wide pattern where each problem directory holds a `solution.py` that serves as both implementation and test module.

### Key Components

**`ListNode`** — The singly linked list node. Two fields: `val: int` and `next: Optional[ListNode]`. This is a local definition (not imported from a shared module), which keeps the solution self-contained but means the class is duplicated across every linked-list problem in the repo.

**`reverse_list(head)`** — Iterative reversal. Uses three pointers (`prev`, `curr`, `next_node`) to reverse links in a single pass. Returns the new head (formerly the tail). O(n) time, O(1) space.

**`reverse_list_recursive(head)`** — Recursive reversal. Base case: empty list or single node returns `head`. Recursive case: reverses everything after `head`, then rewires `head.next.next = head` and `head.next = None` to append the current node at the tail of the already-reversed suffix. O(n) time, O(n) stack space.

**`to_linked_list(vals)`** / **`to_list(head)`** — Bidirectional conversion helpers. `to_linked_list` uses a dummy-head pattern to simplify construction. These exist to bridge between Python lists (easy to assert on) and linked lists (what the solution operates on).

**`TestReverseList`** — Six test cases exercising both implementations via `_run_both`, which uses `unittest.subTest` to run each function variant independently with clear failure attribution.

### Patterns

- **Dual-implementation with shared tests**: `_run_both` avoids duplicating test logic for the iterative vs. recursive variants. `subTest` labels failures by function name.
- **Dummy-head construction**: `to_linked_list` allocates a sentinel `ListNode(0)` and returns `dummy.next`, sidestepping the "is this the first node?" conditional.
- **Reconstruction per test**: Each `_run_both` call builds a fresh linked list, so mutations from reversal don't leak between subtests.

### Dependencies

**Imports**: Only stdlib — `__future__.annotations` (for `Optional[ListNode]` forward-ref syntax), `typing.Optional`, `unittest`. No external or project-internal imports.

**Imported by**: The massive `Imported By` list in the prompt is misleading — those are test files from *other* problems that likely share a test runner harness, not files that import symbols from this module. The real direct consumer is `reverse-linked-list/test_solution.py`.

### Flow

For the iterative path (`reverse_list`):
1. Initialize `prev = None`, `curr = head`.
2. Loop while `curr` is not `None`: save `curr.next`, point `curr.next` back to `prev`, advance `prev` and `curr` forward.
3. When `curr` is `None`, `prev` points to what was the last node — now the new head.

For the recursive path (`reverse_list_recursive`):
1. If `head` is `None` or a lone node, return it (base case).
2. Recurse on `head.next` — this returns the new head of the fully-reversed tail.
3. The current `head.next` still points to the last node of the reversed tail. Set `head.next.next = head` to append `head`, then sever `head.next = None`.
4. Return `new_head` (unchanged through the unwind).

### Invariants

- After `reverse_list` completes, every node's `.next` pointer has been reversed. The original tail is the new head; the original head has `.next == None`.
- `reverse_list_recursive` requires that the list is acyclic — a cycle would cause infinite recursion.
- Both functions are pure with respect to the list topology: they mutate node pointers in-place but don't allocate or destroy nodes.
- `to_linked_list([])` returns `None`, matching the LeetCode convention for empty lists.

### Error Handling

None. Both solutions assume valid input (a well-formed acyclic linked list or `None`). The tests rely on `unittest` assertions — no custom exception types. A cyclic input would hang `reverse_list` and stack-overflow `reverse_list_recursive`, but that's outside the problem's contract.

---

## Topics to Explore

- [file] `reverse-linked-list/test_solution.py` — The external test file that imports this module; check whether it adds cases beyond the inline suite
- [function] `palindrome-linked-list/solution.py:isPalindrome` — Uses reversal as a subroutine (reverse the second half, then compare); shows how `reverse_list` composes
- [file] `middle-of-the-linked-list/solution.py` — The slow/fast pointer technique used there is a common companion to linked list reversal
- [general] `linked-list-node-duplication` — Whether `ListNode` is defined identically in every linked-list problem or if a shared module would reduce drift
- [function] `intersection-of-two-linked-lists/solution.py:getIntersectionNode` — Another classic linked-list pointer manipulation worth comparing

## Beliefs

- `iterative-reversal-is-O1-space` — `reverse_list` uses exactly three local pointer variables regardless of list length; it allocates no heap memory.
- `recursive-reversal-is-On-stack` — `reverse_list_recursive` makes one recursive call per node, so its stack depth equals the list length; lists over ~1000 nodes risk Python's default recursion limit.
- `both-variants-mutate-in-place` — Neither function creates new `ListNode` instances; they rewire existing `.next` pointers, meaning the original head's `.next` is `None` after reversal.
- `test-suite-covers-both-implementations` — Every test case in `TestReverseList` runs against both `reverse_list` and `reverse_list_recursive` via `_run_both`, ensuring behavioral equivalence.

