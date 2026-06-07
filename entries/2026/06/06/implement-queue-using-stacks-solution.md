# File: implement-queue-using-stacks/solution.py

**Date:** 2026-06-06
**Time:** 17:02

## `implement-queue-using-stacks/solution.py`

### Purpose

This file solves [LeetCode 232: Implement Queue using Stacks](https://leetcode.com/problems/implement-queue-using-stacks/). It implements a FIFO queue using only two LIFO stacks (Python lists), which is a classic data structures exercise demonstrating how to simulate one abstract data type with another.

### Key Components

**`MyQueue`** — The sole class. Exposes the standard queue interface required by LeetCode:

| Method | Contract |
|--------|----------|
| `push(x)` | Appends `x` to the back of the queue. O(1). |
| `pop()` | Removes and returns the front element. Amortized O(1). Undefined on empty queue. |
| `peek()` | Returns the front element without removal. Amortized O(1). Undefined on empty queue. |
| `empty()` | Returns whether the queue has zero elements. O(1). |
| `_transfer()` | Internal helper. Moves all elements from `_in_stack` to `_out_stack` (reversing order) only when `_out_stack` is empty. |

### Patterns

**Two-stack amortized queue** — This is the textbook approach. The key insight: pushing onto a stack reverses order, so pushing twice (in → out) restores FIFO order. By lazily deferring the transfer until `_out_stack` is exhausted, each element moves between stacks exactly once across its lifetime, giving amortized O(1) per operation even though a single `pop`/`peek` can take O(n) in the worst case.

The `_transfer` method is guarded by `if not self._out_stack` — this is the lazy transfer invariant. It ensures elements are only moved when necessary, preserving the amortized cost guarantee.

### Dependencies

**Imports**: None. Uses only built-in `list` as the stack primitive (`append` for push, `pop` for pop, `[-1]` for peek).

**Imported by**: The "Imported By" list in the prompt is misleading — it lists hundreds of unrelated test files. The actual consumer is `implement-queue-using-stacks/test_solution.py`, which imports `MyQueue` and exercises the interface.

### Flow

A typical lifecycle:

1. `push(1)`, `push(2)`, `push(3)` → `_in_stack = [1, 2, 3]`, `_out_stack = []`
2. `peek()` → `_transfer()` fires because `_out_stack` is empty → pops 3, 2, 1 from `_in_stack` and appends to `_out_stack` → `_out_stack = [3, 2, 1]` → returns `1` (top of `_out_stack`)
3. `pop()` → `_out_stack` is non-empty, no transfer → pops and returns `1` → `_out_stack = [3, 2]`
4. `push(4)` → goes to `_in_stack = [4]`. The two stacks now coexist: `_out_stack` holds older elements in correct order, `_in_stack` accumulates new arrivals.
5. Two more `pop()` calls drain `_out_stack`, then the next `pop()` triggers another transfer of `_in_stack`.

### Invariants

- **FIFO ordering**: The combination of `_in_stack` (newest-on-top) and `_out_stack` (oldest-on-top) always represents the queue in correct order. The logical queue front is `_out_stack[-1]` when non-empty, otherwise `_in_stack[0]`.
- **Lazy transfer**: `_transfer` only executes the while-loop when `_out_stack` is empty, so elements never get re-reversed.
- **No size tracking**: Emptiness is checked by testing both stacks, not a counter.

### Error Handling

None. Calling `pop()` or `peek()` on an empty queue will raise `IndexError` from the underlying list — the LeetCode contract guarantees valid calls, so no defensive checks are needed.

---

## Topics to Explore

- [file] `implement-queue-using-stacks/test_solution.py` — See what edge cases and operation sequences are tested against this implementation
- [file] `implement-stack-using-queues/solution.py` — The dual problem: implementing a stack with queues, which requires a different cost tradeoff
- [general] `amortized-analysis` — Understanding why the two-stack queue achieves O(1) amortized despite O(n) worst-case transfers (aggregate/potential method argument)
- [file] `implement-queue-using-stacks/plan.md` — The planning document may reveal alternative approaches considered (e.g., eager transfer on push vs. lazy transfer on pop)

## Beliefs

- `two-stack-queue-amortized-o1` — Every element is transferred from `_in_stack` to `_out_stack` exactly once across its lifetime, so `push`, `pop`, and `peek` are all amortized O(1).
- `transfer-guard-is-lazy` — `_transfer` only moves elements when `_out_stack` is empty; it never re-reverses elements already in `_out_stack`.
- `no-defensive-error-handling` — `pop` and `peek` will raise `IndexError` if called on an empty queue; the implementation relies on the caller to check `empty()` first.
- `push-is-always-o1` — `push` always appends to `_in_stack` and never triggers a transfer, making it worst-case O(1), not just amortized.

