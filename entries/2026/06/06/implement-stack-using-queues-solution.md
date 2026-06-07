# File: implement-stack-using-queues/solution.py

**Date:** 2026-06-06
**Time:** 17:03

## `implement-stack-using-queues/solution.py`

### Purpose

This solves [LeetCode 225 — Implement Stack using Queues](https://leetcode.com/problems/implement-stack-using-queues/). The constraint is to implement a LIFO stack using only queue operations (enqueue to back, dequeue from front, peek front, size, is-empty). The solution uses a single `deque` as the underlying queue and makes `push` the expensive operation.

### Key Components

**`MyStack`** — A stack backed by one queue.

| Method | Contract | Complexity |
|--------|----------|------------|
| `__init__` | Initializes an empty queue | O(1) |
| `push(x)` | Pushes `x` onto the top of the stack | O(n) |
| `pop()` | Removes and returns the top element | O(1) |
| `top()` | Returns the top element without removing it | O(1) |
| `empty()` | Returns whether the stack is empty | O(1) |

### Patterns

**Costly-push strategy**: The core trick is in `push`. After appending the new element to the back of the queue, it rotates all preceding elements behind it by dequeuing from the front and re-enqueuing n-1 times. After this rotation, the most recently pushed element sits at the front of the queue — exactly where `popleft` and index `[0]` can reach it in O(1).

This is one of two classical approaches to this problem. The alternative is costly-pop (O(1) push, O(n) pop), which defers the rotation work to read time. The costly-push approach is preferred when pops/tops are more frequent than pushes.

**Single-queue variant**: LeetCode's follow-up asks whether you can do it with one queue. This solution already satisfies that — it uses exactly one `deque`.

### Dependencies

**Imports**: `collections.deque` — used strictly as a FIFO queue (only `append`, `popleft`, `len`, and `[0]` indexing are used). Note that `deque` supports O(1) indexed access at position 0, so `top()` doesn't cheat the queue abstraction in any meaningful way — it's equivalent to "peek front."

**Imported by**: `implement-stack-using-queues/test_solution.py` directly. The massive "Imported By" list in the prompt is noise — those test files import `deque` from `collections`, not from this file.

### Flow

A walkthrough of `push(42)` on a stack containing `[30, 20, 10]` (front-to-back of queue: `[10, 20, 30]`):

1. `append(42)` → queue is `[10, 20, 30, 42]`
2. Loop 3 times (`len - 1`):
   - Iteration 1: dequeue `10`, enqueue `10` → `[20, 30, 42, 10]`
   - Iteration 2: dequeue `20`, enqueue `20` → `[30, 42, 10, 20]`
   - Iteration 3: dequeue `30`, enqueue `30` → `[42, 10, 20, 30]`
3. Now `42` is at the front — `pop()` and `top()` will return it.

### Invariants

- **Queue front = stack top**: After every `push`, the front of `self.q` is always the most recently pushed element. This invariant is what makes `pop` and `top` O(1).
- **LIFO ordering maintained in queue**: Elements in `self.q` are always in reverse insertion order (newest first). This is re-established by the rotation loop on every push.

### Error Handling

None. The solution assumes valid usage per LeetCode's guarantees: `pop` and `top` are only called on non-empty stacks. Calling `popleft()` or accessing `[0]` on an empty deque would raise `IndexError`, which is acceptable — there's no defensive guard because the problem states inputs are always valid.

## Topics to Explore

- [file] `implement-queue-using-stacks/solution.py` — The dual problem: implementing a queue with stacks. Compare which operation is made expensive and why the amortized analysis differs.
- [general] `costly-pop-variant` — The alternative approach where push is O(1) and pop rotates elements. Worth understanding when each is preferred (read-heavy vs write-heavy workloads).
- [function] `implement-stack-using-queues/solution.py:push` — Trace the rotation loop with different queue sizes to build intuition for why exactly `len - 1` rotations are needed.
- [file] `implement-stack-using-queues/test_solution.py` — Check which edge cases are covered (empty stack, single element, interleaved push/pop sequences).

## Beliefs

- `stack-queue-single-queue` — MyStack uses exactly one queue, satisfying the LeetCode follow-up constraint.
- `stack-queue-push-is-on` — Push is O(n) due to the rotation loop; pop, top, and empty are all O(1).
- `stack-queue-front-invariant` — After every push, the front of the internal deque is the most recently pushed element (stack top).
- `stack-queue-no-validation` — No bounds checking or empty-state validation; the code assumes callers follow LeetCode's guaranteed-valid-input contract.

