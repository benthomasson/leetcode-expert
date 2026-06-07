# File: merge-two-sorted-lists/solution.py

**Date:** 2026-06-06
**Time:** 17:49

## `merge-two-sorted-lists/solution.py`

### Purpose

This file is the canonical solution for **LeetCode #21 — Merge Two Sorted Lists**. It owns three responsibilities: the `ListNode` data structure definition, the merge algorithm itself, and a self-contained test suite. It also serves as an infrastructure dependency across the repo — the `ListNode` class, `to_list`, and `from_list` helpers are imported by hundreds of other problem test files that need linked-list scaffolding.

### Key Components

**`ListNode`** — A singly-linked list node. Constructor takes an optional `val` (default `0`) and optional `next` pointer (default `None`). This is the standard LeetCode linked-list representation.

**`merge_two_lists(list1, list2) -> Optional[ListNode]`** — The core algorithm. Accepts two sorted linked list heads, returns the head of a single merged sorted list. It merges in-place by rewiring `.next` pointers — no new nodes are allocated (except the sentinel).

**`to_list(head) -> list[int]`** — Materializes a linked list into a Python list for easy assertion in tests.

**`from_list(vals) -> Optional[ListNode]`** — Constructs a linked list from a Python list. Both helpers use the same dummy-head pattern as the main algorithm.

### Patterns

**Dummy/sentinel head**: Both `merge_two_lists` and `from_list` allocate a throwaway `ListNode()` as a sentinel, build the result by appending to `tail`, then return `dummy.next`. This eliminates special-casing the first insertion.

**In-place pointer rewiring**: The merge doesn't copy values into new nodes. It relinks existing nodes from `list1` and `list2`, which is O(1) extra space (excluding the sentinel).

**Tail append for remainder**: After the main loop drains one list, `tail.next = list1 or list2` attaches the remaining non-empty list in one step. This works because both inputs are already sorted, so the leftover tail is guaranteed to be >= everything already merged.

**Self-contained test file**: Tests live in the same module behind `if __name__ == "__main__"`, with a separate `test_solution.py` that presumably imports from here.

### Dependencies

**Imports**: Only stdlib — `annotations` (for PEP 604 style forward refs), `Optional` from `typing`, and `unittest`. No external packages.

**Imported by**: This is one of the most-imported files in the repo. The "Imported By" list shows ~400+ test files across the project. Those files import `ListNode`, `from_list`, and/or `to_list` as shared linked-list test infrastructure. This makes the file a de-facto library module, not just a standalone solution.

### Flow

1. A dummy sentinel node is created; `tail` points to it.
2. The `while` loop runs as long as both lists have remaining nodes. On each iteration, the smaller-valued head is spliced onto `tail.next`, and that list's pointer advances.
3. `<=` in the comparison makes the merge **stable** — equal-valued nodes from `list1` appear before those from `list2`.
4. After one list is exhausted, the remaining list is attached wholesale via `tail.next = list1 or list2`.
5. `dummy.next` is returned, skipping the sentinel.

Time: O(n + m) where n, m are the list lengths. Space: O(1) auxiliary.

### Invariants

- **Both inputs must be sorted in non-decreasing order.** The algorithm doesn't validate this; it's a precondition.
- **Stability**: Nodes with equal values preserve their relative input order (`list1` before `list2`) due to the `<=` comparison.
- **No node duplication**: The output reuses the original `ListNode` objects. Mutating the output mutates the inputs' nodes.
- **Null safety**: Both inputs may be `None`. The loop simply won't execute, and the remainder-attach line handles it.

### Error Handling

There is none — the function trusts its inputs. Passing non-sorted lists won't raise an error; it will silently produce an incorrectly ordered result. This is appropriate for a LeetCode solution where inputs are guaranteed valid by the problem contract.

---

## Topics to Explore

- [file] `merge-two-sorted-lists/test_solution.py` — The external test file that imports from this module; shows how the helpers are consumed as shared infrastructure
- [function] `merge-two-sorted-lists/solution.py:from_list` — Used as linked-list test scaffolding by hundreds of other problem files across the repo
- [file] `reverse-linked-list/solution.py` — Another linked-list problem likely sharing the same `ListNode` definition; compare how they handle pointer manipulation
- [general] `linked-list-test-infrastructure` — Why this one file became the shared import for linked-list helpers, and whether that coupling is intentional or should be refactored into a common utils module
- [file] `merge-two-binary-trees/solution.py` — Structurally analogous merge problem on trees instead of lists; compare the recursive vs iterative approach

---

## Beliefs

- `merge-stable-ordering` — `merge_two_lists` is a stable merge: when `list1` and `list2` contain equal values, `list1`'s node appears first in the output due to the `<=` comparison
- `merge-no-allocation` — The merge algorithm allocates exactly one `ListNode` (the dummy sentinel); all other nodes in the output are reused from the inputs
- `shared-linked-list-infra` — `ListNode`, `to_list`, and `from_list` from this file are imported by 400+ test files across the repo, making it de-facto shared linked-list infrastructure
- `merge-linear-time` — `merge_two_lists` visits each node in both inputs exactly once, giving O(n + m) time and O(1) auxiliary space

