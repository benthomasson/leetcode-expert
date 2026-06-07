# File: best-time-to-buy-and-sell-stock/solution.py

**Date:** 2026-06-06
**Time:** 15:22

## `best-time-to-buy-and-sell-stock/solution.py`

### Purpose

This file solves [LeetCode #121 — Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/). It finds the maximum profit from a single buy-sell transaction given a time series of stock prices. It's a standalone solution module following the repo's convention of one problem per directory.

### Key Components

**`maxProfit(prices: list[int]) -> int`** — The sole function. Contract:
- **Input**: A list of integers where `prices[i]` is the stock price on day `i`. Assumes at least one element (indexes into `prices[0]` unconditionally).
- **Output**: The maximum profit from buying on one day and selling on a later day, or `0` if no profitable transaction exists.

### Patterns

The solution uses **Kadane's-style single-pass tracking** — a classic greedy pattern for problems where you need the maximum difference `prices[j] - prices[i]` with `j > i`. Instead of checking all O(n²) pairs, it maintains a running minimum and computes the best profit at each step.

This is the same pattern used in `maximum-difference-between-increasing-elements/solution.py` — track min-so-far, compute max-delta at each position.

### Dependencies

**Imports**: None — pure Python with no library dependencies.

**Imported by**: The `best-time-to-buy-and-sell-stock/test_solution.py` file imports this directly. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those other test files don't actually import this solution; they share a common test harness pattern.

### Flow

1. Initialize `min_price` to the first element and `max_profit` to `0`.
2. Iterate over `prices[1:]`. For each price:
   - Compute `price - min_price` — the profit if we sold today having bought at the cheapest seen so far. Update `max_profit` if this is larger.
   - Update `min_price` if today's price is lower — future days can now buy cheaper.
3. Return `max_profit`.

The order of the two updates inside the loop matters: profit is computed *before* `min_price` is updated, which prevents buying and selling on the same day from inflating the result (though same-day would yield 0 profit anyway, so it's actually safe either way — the ordering is a clarity choice, not a correctness requirement).

### Invariants

- **Single transaction**: Only one buy and one sell. This is not the "unlimited transactions" variant (LeetCode #122).
- **Non-negative result**: Returns `0` when prices are monotonically decreasing — the function implicitly assumes you can choose not to transact.
- **Assumes non-empty input**: `prices[0]` is accessed without a length check. An empty list raises `IndexError`.

### Error Handling

None. The function trusts its caller to provide a valid, non-empty list of integers. This is consistent with LeetCode's constraints where `1 <= prices.length <= 10^5`.

---

## Topics to Explore

- [file] `best-time-to-buy-and-sell-stock/test_solution.py` — See what edge cases the tests cover (empty input, single element, descending prices)
- [file] `maximum-difference-between-increasing-elements/solution.py` — Same min-tracking pattern applied to a closely related problem
- [file] `best-time-to-buy-and-sell-stock/plan.md` — The planning document may show alternative approaches considered (e.g., divide-and-conquer, prefix max/min arrays)
- [general] `kadane-pattern-variants` — Several solutions in this repo use Kadane-style single-pass tracking; comparing them reveals the pattern's adaptability
- [file] `maximum-average-subarray-i/solution.py` — Another sliding-window/single-pass optimization for comparison

## Beliefs

- `buy-sell-stock-is-single-pass-greedy` — `maxProfit` runs in O(n) time and O(1) space by tracking the running minimum price
- `buy-sell-stock-assumes-nonempty-input` — The function accesses `prices[0]` unconditionally and will raise `IndexError` on an empty list
- `buy-sell-stock-returns-zero-for-no-profit` — When no profitable transaction exists (monotonically decreasing prices), the function returns `0`, not a negative number
- `buy-sell-stock-single-transaction-only` — The algorithm finds the best single buy-sell pair, not multiple transactions

