# File: remove-linked-list-elements/solution.py

**Date:** 2026-06-06
**Time:** 18:47

## Purpose

This file is a self-contained solution to [LeetCode #203 — Remove Linked List Elements](https://leetcode.com/problems/remove-linked-list-elements/). It owns three responsibilities: defining the linked list data structure (`ListNode`), implementing the removal algorithm (`remove_elements`), and providing conversion helpers (`to_list`, `from_list`) plus a full test suite. In the broader `leetcode-implementations` repo, it follows the standard per-problem directory layout where `solution.py` holds both implementation and tests.

## Key Components

### `ListNode`
A minimal singly-linked list node. Two fields: `val: int` and `next: Optional[ListNode]`. The default constructor (`val=0, next=None`) makes it usable as a dummy/sentinel without arguments.

### `remove_elements(head, val) -> Optional[ListNode]`
The core algorithm. Removes **all** nodes whose `.val` equals `val` and returns the (possibly new) head. Operates in-place by relinking pointers — no new nodes are allocated.

### `from_list(vals) -> Optional[ListNode]`
Constructs a linked list from a Python list. Uses the same dummy-head pattern as the main algorithm.

### `to_list(head) -> list[int]`
Linearizes a linked list back into a Python list for assertion-friendly comparison.

### `TestRemoveElements`
Nine test cases covering: standard removal, empty list, all-matching, head removal, tail removal, consecutive duplicates, single node (match and no-match), and no matches.

## Patterns

**Dummy head (sentinel node).** The central idiom. `remove_elements` creates a `ListNode(next=head)` and walks from it, so deletions at the head position don't require special-casing — the loop body is uniform for every position. `from_list` uses the same pattern for uniform list construction.

**Two-pointer skip.** `curr` always points to the node *before* the candidate for deletion (`curr.next`). When a match is found, `curr.next` is relinked to `curr.next.next`, effectively skipping the target node. When there's no match, `curr` advances. This is important: on a match, `curr` does **not** advance, because the new `curr.next` might also need removal.

**Test helper `check`.** A single method wraps the `from_list → remove_elements → to_list` pipeline so each test case is one line. This keeps tests declarative — input list, target value, expected output.

## Dependencies

**Imports:** Only stdlib — `unittest`, `typing.Optional`, and `from __future__ import annotations` (for PEP 604-style forward references in the `ListNode` type annotation).

**Imported by:** Hundreds of test files across the repo import from this file (see `Imported By` list). This is surprising — `ListNode`, `from_list`, and `to_list` appear to serve as the repo-wide linked list utilities, reused by every problem that involves linked lists. This makes this file a de facto shared dependency, even though it lives under a single problem's directory.

## Flow

1. `from_list` converts a Python list into a `ListNode` chain.
2. `remove_elements` creates a dummy node pointing to `head`.
3. The while loop inspects `curr.next` on each iteration:
   - **Match:** `curr.next` is bypassed via pointer relink. `curr` stays put to re-check the new `curr.next`.
   - **No match:** `curr` advances one node.
4. Loop terminates when `curr.next` is `None` (end of list).
5. `dummy.next` is returned — this correctly handles the case where the original head was removed.

## Invariants

- **Single pass, O(n) time, O(1) space.** The list is traversed exactly once; only one extra node (the dummy) is allocated.
- **`curr` never points to a node that should be deleted.** It always points to the last "kept" node, inspecting ahead via `.next`.
- **After the loop, no node with `val == target` remains reachable from `dummy.next`.** The non-advance on match ensures consecutive matching nodes are all removed.

## Error Handling

None. The function trusts its inputs (valid linked list, integer `val`). `None` head is handled implicitly — the while loop body never executes, and `dummy.next` (which is `None`) is returned. This is appropriate for a LeetCode solution operating within a controlled input contract.

## Topics to Explore

- [file] `remove-linked-list-elements/test_solution.py` — The separate test file; compare with the inline tests to see if there's divergence or additional coverage
- [function] `reverse-linked-list/solution.py:reverse_list` — Another core linked list operation using similar pointer manipulation; good for comparing iteration patterns
- [function] `merge-two-sorted-lists/solution.py:merge_two_lists` — Uses the same dummy-head sentinel pattern in a different context (merging vs. filtering)
- [file] `palindrome-linked-list/solution.py` — More complex linked list problem that likely reuses `ListNode`/`from_list`/`to_list` from this file
- [general] `dummy-head-pattern` — The sentinel node idiom appears across many linked list solutions in this repo; understanding it once unlocks all of them

## Beliefs

- `remove-elements-dummy-head` — `remove_elements` uses a dummy sentinel node so that head-position deletions require no special case
- `remove-elements-no-advance-on-match` — When a node is removed, `curr` does not advance, ensuring consecutive matching nodes are all deleted in sequence
- `listnode-shared-dependency` — `ListNode`, `from_list`, and `to_list` from this file are imported by hundreds of other problem test files as the repo's de facto linked list utilities
- `remove-elements-single-pass` — The algorithm completes in O(n) time with O(1) extra space, making exactly one pass through the list

