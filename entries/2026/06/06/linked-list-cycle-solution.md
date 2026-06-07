# File: linked-list-cycle/solution.py

**Date:** 2026-06-06
**Time:** 17:23

## `linked-list-cycle/solution.py`

### Purpose

This file is a self-contained solution to [LeetCode 141 — Linked List Cycle](https://leetcode.com/problems/linked-list-cycle/). It owns three responsibilities: the `ListNode` data structure, the cycle-detection algorithm, and a test helper that constructs linked lists with optional cycles. It doubles as both the solution module and the test file (tests run inline via pytest).

### Key Components

**`ListNode`** (line 8–10) — Minimal singly-linked list node. The `next` field is typed `Optional[ListNode]` (enabled by `from __future__ import annotations` for forward-reference support). No sentinel, no `__repr__`, no equality — just the bare structure LeetCode expects.

**`hasCycle(head)`** (line 13–24) — The core algorithm. Takes the head of a linked list, returns `bool`. Implements Floyd's cycle detection (tortoise and hare): two pointers start at `head`, `slow` advances one step, `fast` advances two. If they meet, there's a cycle. If `fast` reaches `None`, there isn't.

The loop guard `while fast and fast.next` is the critical safety check — it prevents `fast.next.next` from dereferencing `None`. The `slow` pointer never needs a null check because it's always behind or at `fast`.

**`make_list(vals, pos)`** (line 29–37) — Test helper that builds a linked list from a list of ints. The `pos` parameter controls where the tail's `next` pointer loops back to: `-1` means no cycle, `0` means tail points to head, `pos=k` means tail points to `nodes[k]`. This mirrors LeetCode's own test format where `pos` specifies the cycle entry index.

### Patterns

**Floyd's tortoise and hare** — The classic O(n) time, O(1) space cycle detection. The alternative (hash set of visited nodes) costs O(n) space; this solution deliberately avoids it. The two-pointer technique is also the foundation for finding the cycle entry point (LeetCode 142), though this file only detects existence.

**Identity comparison (`is`)** — Line 21 uses `if slow is fast` rather than `==`. This is correct: we're checking whether both pointers reference the same node object in memory, not whether two nodes happen to have equal values.

**Inline tests with pytest** — Tests are defined as module-level functions following the `test_*` naming convention. The `if __name__ == "__main__"` block runs pytest programmatically, so you can either `python solution.py` or `pytest solution.py`.

### Dependencies

**Imports:** Only stdlib — `__future__.annotations` for PEP 604-style forward refs, `typing.Optional` for the type hint, and `pytest` at runtime for test execution.

**Imported by:** The "Imported By" list in the prompt shows hundreds of test files across the repo. This is likely an artifact of the repo's test infrastructure importing shared utilities or running a common test harness — `solution.py` itself doesn't export anything that other solutions would need. The `ListNode` class and `make_list` helper are local to this problem; other linked-list problems (e.g., `reverse-linked-list`, `palindrome-linked-list`) define their own copies.

### Flow

1. `make_list` materializes all nodes eagerly into a list, chains them via `next` pointers, then optionally creates a cycle by setting `nodes[-1].next = nodes[pos]`.
2. `hasCycle` starts both pointers at `head`. Each iteration: advance `slow` by 1, `fast` by 2, check identity. If `fast` or `fast.next` is `None`, the list is finite — return `False`. If pointers meet, return `True`.
3. The mathematical guarantee: if a cycle of length `C` exists, the pointers meet within at most `C` steps after `slow` enters the cycle. Total time is O(n) where n is the number of nodes.

### Invariants

- **`fast` is always at or ahead of `slow`** in a non-cyclic list. In a cyclic list, once both enter the cycle, `fast` closes the gap by 1 node per iteration.
- **`pos` must be in range `[-1, len(vals)-1]`** for `make_list` to produce a valid structure. No bounds checking is performed — an out-of-range `pos` will raise `IndexError`.
- **The algorithm never modifies the list.** It's purely read-only traversal, which matters for thread safety and idempotency.

### Error Handling

None. The function handles the empty-list case naturally (`fast` is `None`, loop doesn't execute, returns `False`). Invalid inputs to `make_list` (e.g., `pos >= len(vals)`) will raise an unhandled `IndexError`. This is appropriate for a LeetCode solution where inputs are guaranteed valid.

## Topics to Explore

- [file] `linked-list-cycle/plan.md` — The approach analysis and complexity reasoning behind choosing Floyd's over hash-set
- [file] `intersection-of-two-linked-lists/solution.py` — Another two-pointer technique on linked lists, worth comparing the pointer arithmetic
- [file] `palindrome-linked-list/solution.py` — Combines Floyd's (to find the middle) with list reversal — a composition of this same primitive
- [general] `floyd-cycle-entry-point` — Extending this algorithm to find *where* the cycle starts (LeetCode 142), which requires a second phase after detection
- [function] `happy-number/solution.py:isHappy` — Floyd's cycle detection applied to an integer sequence rather than a linked list — same algorithm, different domain

## Beliefs

- `floyd-o1-space` — `hasCycle` uses O(1) auxiliary space; it allocates no data structures beyond two pointer variables
- `identity-not-equality` — Cycle detection relies on `is` (object identity), not `==` (value equality); two distinct nodes with the same `val` will never false-positive
- `make-list-no-bounds-check` — `make_list` does not validate `pos` against `len(vals)`; an out-of-range positive `pos` raises `IndexError`
- `fast-null-guard-protects-slow` — The `while fast and fast.next` guard is sufficient for both pointers because `slow` never advances past `fast` in a non-cyclic list
- `tests-mirror-leetcode-format` — Test cases use the `(vals, pos)` format matching LeetCode's own test case specification for this problem

