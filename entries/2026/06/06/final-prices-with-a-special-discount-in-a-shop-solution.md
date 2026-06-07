# File: final-prices-with-a-special-discount-in-a-shop/solution.py

**Date:** 2026-06-06
**Time:** 16:31

## Final Prices with a Special Discount in a Shop

### Purpose

This file solves [LeetCode 1475](https://leetcode.com/problems/final-prices-with-a-special-discount-in-a-shop/). Given a list of prices, for each item `i`, find the first item `j > i` where `prices[j] <= prices[i]`, and subtract `prices[j]` as a discount. If no such `j` exists, the price stays unchanged.

The file owns exactly one responsibility: the `finalPrices` method on the `Solution` class.

### Key Components

**`Solution.finalPrices(prices: List[int]) -> List[int]`** — Takes a price list, returns a new list with discounts applied. Does not mutate the input (operates on `prices[:]`).

### Patterns

This is a **monotone stack** solution — the classic pattern for "find the next smaller or equal element" problems. The stack holds indices of items still waiting for their discount. When a new price is small enough to serve as a discount for items on the stack, those items get popped and resolved.

The stack maintains a **strictly increasing** invariant on the prices it references: `prices[stack[0]] < prices[stack[1]] < ... < prices[stack[-1]]`. The `while` condition `prices[stack[-1]] >= price` pops everything that the current price can discount, preserving this invariant after the append.

### Dependencies

- **Imports**: `typing.List` only — no external dependencies.
- **Imported by**: `final-prices-with-a-special-discount-in-a-shop/test_solution.py`. The "Imported By" list in the prompt is noise from the repo's shared test harness importing `Solution` generically; only the co-located test file actually imports *this* solution.

### Flow

1. Copy `prices` into `result` so the input isn't mutated.
2. Initialize an empty stack of indices.
3. Iterate through prices left to right. For each `(i, price)`:
   - Pop every stack index whose price is `>= price` — that index has found its discount, so write `prices[idx] - price` into `result[idx]`.
   - Push `i` onto the stack.
4. Indices remaining on the stack never found a discount — they keep their original price (already correct in `result` from the copy).
5. Return `result`.

### Invariants

- The stack is always strictly increasing by referenced price value after each iteration.
- Every index is pushed exactly once and popped at most once — guaranteeing O(n) total work.
- Items left on the stack at termination receive no discount (their `result` entry is unchanged from the original copy).

### Error Handling

None. The method assumes valid input per LeetCode constraints (non-empty list of positive integers). No bounds checking, no exception handling.

## Topics to Explore

- [file] `final-prices-with-a-special-discount-in-a-shop/test_solution.py` — See what edge cases (single element, all decreasing, all equal) the tests cover
- [file] `next-greater-element-i/solution.py` — The closely related "next greater element" problem uses the same monotone stack pattern but with a strict inequality in the opposite direction
- [general] `monotone-stack-pattern` — How the stack invariant (increasing vs decreasing, strict vs non-strict) changes based on whether you're finding next-smaller, next-greater, or next-smaller-or-equal
- [file] `final-prices-with-a-special-discount-in-a-shop/review.md` — The code review may note alternative approaches (brute-force O(n^2) vs this O(n) stack)

## Beliefs

- `final-prices-monotone-stack-linear-time` — `finalPrices` runs in O(n) time because each index is pushed and popped from the stack at most once
- `final-prices-no-input-mutation` — The method copies the input list before modifying, so the caller's list is never changed
- `final-prices-stack-holds-unresolved-indices` — At any point during iteration, the stack contains indices of items that have not yet found a discount (no `j > i` with `prices[j] <= prices[i]` seen so far)
- `final-prices-uses-geq-not-gt` — The `>=` comparison means equal prices qualify as discounts, matching the problem's "less than or equal" condition

