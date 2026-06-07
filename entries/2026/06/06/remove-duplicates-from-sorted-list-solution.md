# File: remove-duplicates-from-sorted-list/solution.py

**Date:** 2026-06-06
**Time:** 18:46

## Purpose

This file is the self-contained solution for [LeetCode 83 — Remove Duplicates from Sorted List](https://leetcode.com/problems/remove-duplicates-from-sorted-list/). It owns three concerns: the linked list data structure (`ListNode`), the algorithm (`delete_duplicates`), and the test suite. In the broader `leetcode-implementations` repo, it follows the standard per-problem layout alongside `plan.md`, `review.md`, and `test_solution.py`.

## Key Components

### `ListNode` (lines 7–9)

A minimal singly-linked list node. Fields: `val: int`, `next: Optional[ListNode]`. This is the standard LeetCode `ListNode` definition — no sentinel behavior, no `__eq__` override.

### `delete_duplicates(head)` (lines 12–24)

The core algorithm. Contract: given the head of a **sorted** linked list, returns the head of a list where every distinct value appears exactly once. Operates **in-place** by relinking `.next` pointers — no new nodes are allocated. Returns the same `head` reference (the first node is never removed since there's nothing before it to be a duplicate of).

### `to_list` / `from_list` (lines 28–38)

Conversion helpers between Python lists and `ListNode` chains. `from_list` uses a dummy-head pattern to simplify construction. These exist purely for test ergonomics — they let tests express inputs and expected outputs as plain `list[int]`.

### `TestDeleteDuplicates` (lines 44–72)

Ten test cases covering: both LeetCode examples, empty list, single element, no duplicates, all-same, duplicates at head/tail, negative values, and a large list (601 nodes, values -100..100 each tripled).

## Patterns

**In-place pointer surgery.** The algorithm never creates nodes — it skips duplicates by pointing `current.next` past them. This is the canonical O(1)-space approach for sorted-list dedup.

**Dummy-head construction.** `from_list` uses `dummy = ListNode(0)` as a construction anchor, returning `dummy.next`. This avoids special-casing the first insertion.

**Self-contained test file.** The solution, helpers, and tests live in one file. The `if __name__ == "__main__"` guard makes it runnable standalone, while `test_solution.py` (listed in `Imported By`) imports from it for the repo-wide test harness.

## Dependencies

**Imports:** Only stdlib — `annotations` (for `X | None` style in older Pythons), `Optional` from `typing`, and `unittest`. No external packages.

**Imported by:** `test_solution.py` in this same directory, plus hundreds of other problem directories' `test_solution.py` files. That massive `Imported By` list is misleading — it likely reflects a repo-wide test runner (`run_tests.py`) or shared import pattern, not direct usage of `delete_duplicates` from those files.

## Flow

1. Caller passes a `ListNode` chain (or `None`) to `delete_duplicates`.
2. A `current` pointer walks the list. At each node:
   - If `current.val == current.next.val`: skip the next node by setting `current.next = current.next.next`. **Do not advance `current`** — the new next node might also be a duplicate.
   - Otherwise: advance `current = current.next`.
3. When `current` or `current.next` is `None`, the walk ends. Return the original `head`.

The key subtlety is in step 2a: after skipping a duplicate, the pointer stays put because consecutive runs of the same value (e.g., `[1,1,1]`) need multiple skip iterations at the same `current`.

## Invariants

- **Sorted input required.** The algorithm only compares adjacent nodes. Unsorted input will silently produce incorrect results — no validation is performed.
- **Head stability.** The returned head is always the same object as the input head (or `None` if input was `None`). The first node is never unlinked.
- **No allocation.** The node count can only decrease or stay the same. No `ListNode` constructor calls happen during `delete_duplicates`.

## Error Handling

None. `None` input is handled gracefully (the `while` condition fails immediately, returns `None`). Invalid inputs (non-`ListNode`, unsorted lists) are not detected and will produce silent wrong answers or `AttributeError`.

## Topics to Explore

- [file] `remove-duplicates-from-sorted-list/test_solution.py` — The external test file that imports from this solution; shows how the repo-wide test harness integrates per-problem solutions
- [file] `remove-duplicates-from-sorted-list/review.md` — The code review companion that may document alternative approaches or edge-case analysis
- [function] `merge-two-sorted-lists/solution.py:mergeTwoLists` — Another sorted-list problem using similar pointer-surgery techniques; good for comparing linked list manipulation patterns
- [general] `sorted-list-dedup-variants` — LeetCode 82 (Remove Duplicates II) removes *all* nodes with duplicate values, requiring a dummy head and prev-pointer — a meaningful step up from this approach
- [file] `run_tests.py` — The repo-wide test runner that explains the massive `Imported By` list and how solutions are discovered and executed

## Beliefs

- `delete-duplicates-returns-same-head` — `delete_duplicates` always returns the exact same `head` object it received (or `None` for empty input); it never creates or replaces the head node
- `delete-duplicates-is-in-place-o1-space` — The algorithm allocates zero new `ListNode` objects; all deduplication is done by relinking `.next` pointers
- `delete-duplicates-requires-sorted-input` — Correctness depends on the input list being sorted in non-decreasing order; unsorted input produces silently wrong results with no error raised
- `current-stays-after-skip` — When a duplicate is found, `current` does not advance — it stays at the same node to handle runs of 3+ identical values in sequence

