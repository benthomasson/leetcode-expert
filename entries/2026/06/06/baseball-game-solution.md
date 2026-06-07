# File: baseball-game/solution.py

**Date:** 2026-06-06
**Time:** 15:21

## Baseball Game — `baseball-game/solution.py`

### Purpose

This file solves [LeetCode 682: Baseball Game](https://leetcode.com/problems/baseball-game/). It owns the scoring logic for a simplified baseball game where a sequence of string operations builds up a record of scores, and the answer is the final sum. It's a textbook stack problem.

### Key Components

**`calPoints(operations: list[str]) -> int`** — The sole public function. Takes a list of string-encoded operations and returns the total score.

The four operation types:

| Operation | Meaning | Stack effect |
|-----------|---------|-------------|
| Integer string (e.g. `"5"`, `"-3"`) | Record a new score | `push(int(op))` |
| `"C"` | Invalidate the last score | `pop()` |
| `"D"` | Double the last score | `push(top * 2)` |
| `"+"` | Sum of last two scores | `push(top + second)` |

### Patterns

**Stack-based simulation.** The problem maps directly to a stack: `"C"` pops, `"D"` and `"+"` peek at the top elements and push a derived value, and raw integers push directly. The final answer is `sum(stack)` — every element still on the stack is a valid score.

**Exhaustive if/elif/else dispatch.** The operations are handled in a chain with `else` catching the integer case. This is idiomatic for LeetCode solutions with a small fixed set of special tokens.

### Dependencies

**Imports:** None — pure stdlib, no external dependencies.

**Imported by:** `baseball-game/test_solution.py` directly. The "Imported By" list in the prompt shows hundreds of test files, but that's an artifact of the repo's test infrastructure — those other test files don't actually import `calPoints`. Only the co-located test file exercises this function.

### Flow

1. Initialize an empty `stack: list[int]`.
2. Iterate over each `op` in `operations`.
3. Strip whitespace from `op` (defensive — LeetCode inputs don't have trailing whitespace, but it's harmless).
4. Dispatch on the op value: pop, push doubled top, push sum of top two, or push the parsed integer.
5. After processing all operations, return `sum(stack)`.

### Invariants

- **Stack is never empty when accessed.** The problem guarantees that `"C"`, `"D"`, and `"+"` only appear when there are enough elements on the stack (1 for C/D, 2 for +). The code does not validate this — it trusts the LeetCode contract.
- **All stack elements are `int`.** The `int(op)` conversion in the else branch and arithmetic in the other branches ensure this.
- **Order matters.** Operations are processed left-to-right, and each operation can only reference scores already on the stack.

### Error Handling

There is none. If the input violates the problem's preconditions (e.g., `"C"` on an empty stack, or a non-numeric non-operator string), the code will raise an unhandled `IndexError` or `ValueError`. This is intentional — LeetCode guarantees valid input.

---

## Topics to Explore

- [file] `baseball-game/test_solution.py` — See what edge cases are tested (empty ops, negative scores, consecutive C operations)
- [file] `baseball-game/plan.md` — Understand the planning approach and any alternative strategies considered
- [function] `valid-parentheses/solution.py:isValid` — Another stack-based LeetCode solution in this repo for comparison
- [function] `remove-all-adjacent-duplicates-in-string/solution.py:removeDuplicates` — Stack pattern applied to string transformation
- [general] `stack-vs-list-in-python` — Python lists as stacks: `append`/`pop` are O(1) amortized, but `collections.deque` is an alternative worth knowing

---

## Beliefs

- `calpoints-stack-only` — `calPoints` uses a single list as a stack and never indexes into arbitrary positions; it only accesses `[-1]` and `[-2]`
- `calpoints-no-input-validation` — The function assumes all inputs are valid per the LeetCode contract and will raise `IndexError` or `ValueError` on malformed input
- `calpoints-strip-defensive` — The `op.strip()` call is defensive against whitespace; LeetCode inputs never contain it, but the code handles it anyway
- `calpoints-linear-time` — The function runs in O(n) time for n operations, with O(n) space for the stack in the worst case (no `"C"` operations)

