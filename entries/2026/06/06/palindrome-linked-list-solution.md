# File: palindrome-linked-list/solution.py

**Date:** 2026-06-06
**Time:** 18:27

## `palindrome-linked-list/solution.py`

### Purpose

This file solves [LeetCode 234: Palindrome Linked List](https://leetcode.com/problems/palindrome-linked-list/). It determines whether a singly linked list reads the same forwards and backwards. The file is self-contained: it defines the data structure (`ListNode`), the solution, a test helper, and a full test suite.

### Key Components

**`ListNode`** — Standard singly linked list node with `val` and `next`. This is the canonical LeetCode definition, not imported from a shared module.

**`Solution.isPalindrome(head) -> bool`** — The core algorithm. Takes the head of a linked list and returns whether it's a palindrome. Achieves **O(n) time and O(1) space** by mutating the list in-place rather than copying values to an array.

**`make_list(vals) -> Optional[ListNode]`** — Test helper that converts a Python list of ints into a linked list. Uses the dummy-head idiom to avoid special-casing the first node.

### Patterns

**Fast/slow pointer (tortoise and hare)** — Lines 19–22 find the midpoint. `fast` moves two steps per iteration, `slow` moves one. When `fast` can't advance two more steps, `slow` sits at the node just before the second half. This is the same pattern used in `middle-of-the-linked-list` and `linked-list-cycle`.

**In-place reversal** — Lines 25–27 reverse the second half of the list starting from `slow.next`. The triple assignment `curr.next, prev, curr = prev, curr, curr.next` is a Python idiom that performs all three pointer updates atomically (no temp variable needed due to Python's tuple-packing evaluation order).

**Two-pointer comparison** — Lines 30–34 walk `p1` from the head and `p2` from the reversed second half simultaneously. The loop terminates when `p2` is exhausted, which handles both odd and even length lists correctly because the reversed half is always ≤ the first half in length.

### Dependencies

**Imports:** Only stdlib — `annotations` (for PEP 604 style hints in older Pythons), `typing.Optional`, and `unittest`.

**Imported by:** The "Imported By" list in the prompt is misleading — it lists hundreds of test files across the repo. This is likely an artifact of the code-expert tooling treating `ListNode` or `unittest` as a shared symbol. In practice, each solution directory is independent; `palindrome-linked-list/test_solution.py` is the real consumer.

### Flow

1. **Early exit**: empty list or single node → `True`.
2. **Find middle**: slow/fast traversal. For `[1,2,2,1]`, slow ends at index 1 (value 2). For `[1,2,1]`, slow ends at index 1 (value 2).
3. **Reverse second half**: `slow.next` onward gets reversed. The original list is now split: first half is intact, second half is a separate reversed chain pointed to by `prev`.
4. **Compare**: walk both halves node by node. Any mismatch → `False`. Full traversal without mismatch → `True`.

For `[1,2,2,1]`:
- After finding middle: `slow` points to second node (val=2)
- After reversal: `prev` points to chain `1 -> 2 -> None` (reversed from `2 -> 1`)
- Compare: `1==1`, `2==2` → `True`

### Invariants

- **The list is mutated**: after `isPalindrome` returns, the second half of the list is reversed. The solution does not restore it. This is acceptable for LeetCode but would be a bug in production code where the caller expects list integrity.
- **`p2` controls the loop**: the reversed half is always ≤ the first half in length (for odd-length lists, the middle element stays with the first half), so iterating until `p2` is `None` is sufficient.
- **`slow` lands one node before the second half**: the `while fast.next and fast.next.next` guard ensures this. If you used `while fast and fast.next` instead, `slow` would land one step further, breaking the split.

### Error Handling

None. The function assumes valid input per LeetCode constraints (a proper linked list of integers). No `None` checks beyond the early exit. No exception handling. The test suite relies on `unittest` assertions — failures surface as `AssertionError`.

## Topics to Explore

- [file] `linked-list-cycle/solution.py` — Uses the same fast/slow pointer pattern to detect cycles; compare the loop termination conditions
- [file] `reverse-linked-list/solution.py` — Isolated reversal of an entire list; the palindrome solution applies this to only the second half
- [file] `middle-of-the-linked-list/solution.py` — Pure midpoint-finding with the same tortoise/hare approach; compare where `slow` ends up
- [general] `in-place-reversal-restoration` — Whether solutions that mutate linked lists should restore them afterward, and the tradeoffs
- [function] `palindrome-linked-list/solution.py:isPalindrome` — Try tracing through odd-length lists like `[1,2,3,2,1]` to verify the middle-element handling

## Beliefs

- `palindrome-ll-o1-space` — `isPalindrome` uses O(1) extra space by reversing the second half in-place rather than copying to an array
- `palindrome-ll-mutates-input` — After `isPalindrome` returns, the input list's second half is permanently reversed; the original structure is not restored
- `slow-pointer-lands-before-second-half` — The `while fast.next and fast.next.next` guard places `slow` at the last node of the first half, so `slow.next` is the start of the second half
- `reversed-half-leq-first-half` — For odd-length lists the middle node stays with the first half, making the reversed portion strictly shorter, which is why the comparison loop uses `p2` (not `p1`) as the termination condition

