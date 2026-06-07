# File: best-poker-hand/solution.py

**Date:** 2026-06-06
**Time:** 15:21

## Purpose

This file solves [LeetCode 2347 — Best Poker Hand](https://leetcode.com/problems/best-poker-hand/). Given exactly 5 cards (as parallel arrays of ranks and suits), it returns the best hand classification. It's a straightforward classification problem — no game simulation, no hand comparison.

## Key Components

### `best_poker_hand(ranks, suits) -> str`

Takes two parallel lists of length 5 and returns one of four strings in a fixed priority order:

| Priority | Return Value | Condition |
|----------|-------------|-----------|
| 1 (best) | `"Flush "` | All 5 suits identical |
| 2 | `"Three of a Kind "` | Any rank appears 3+ times |
| 3 | `"Pair "` | Any rank appears exactly 2 times |
| 4 (worst) | `"High Card "` | None of the above |

The trailing space in each return value matches the LeetCode expected output format.

## Patterns

**Early-return cascade**: The function checks hands from strongest to weakest and returns the first match. This avoids nested conditionals and makes the priority ordering explicit.

**Frequency analysis via `Counter`**: Rather than writing manual loops to count duplicates, the solution reduces the rank list to a frequency map and inspects only the maximum frequency. This collapses "Three of a Kind" and "Full House" (which the problem treats the same since `max_freq >= 3` catches both), and similarly "Pair" and "Two Pair" (both have `max_freq == 2`, and the problem doesn't distinguish them).

**Set cardinality for uniformity check**: `len(set(suits)) == 1` is the idiomatic Python way to test if all elements are identical.

## Dependencies

**Imports**: `collections.Counter` — the only dependency, used for rank frequency counting.

**Imported by**: `best-poker-hand/test_solution.py` consumes this function. The large "Imported By" list in the prompt is an artifact of the cross-reference tool — those are unrelated test files, not actual consumers of this function.

## Flow

1. Convert `suits` to a set. If the set has exactly one element, all suits match — return `"Flush "`.
2. Build a `Counter` over `ranks`, extract the maximum frequency value.
3. If `max_freq >= 3`: return `"Three of a Kind "`.
4. If `max_freq == 2`: return `"Pair "`.
5. Otherwise (`max_freq == 1`, all ranks distinct): return `"High Card "`.

The flush check comes first because a flush beats all other hands in this simplified ranking. The rank-frequency checks are mutually exclusive by the `>=3` / `==2` / implicit `==1` boundaries.

## Invariants

- Assumes exactly 5 cards (no length validation).
- Assumes ranks are integers in `[1, 13]` and suits are single characters from `{'a', 'b', 'c', 'd'}`.
- The problem guarantees valid input, so no validation is performed.
- The `>= 3` threshold means a hand with 4 or 5 of the same rank still returns `"Three of a Kind "` — correct per the problem statement, which doesn't define "Four of a Kind" as a distinct category.

## Error Handling

None. Invalid input (empty lists, wrong types) would propagate as unhandled exceptions from `set()`, `Counter()`, or `max()`. This is appropriate for a LeetCode solution where inputs are guaranteed valid.

## Topics to Explore

- [file] `best-poker-hand/test_solution.py` — See what edge cases are covered (all same rank, flush + pair overlap, etc.)
- [file] `best-poker-hand/plan.md` — The approach reasoning before implementation
- [file] `best-poker-hand/review.md` — Post-implementation review notes
- [general] `counter-max-frequency-pattern` — This `max(Counter(...).values())` idiom recurs across many LeetCode solutions in this repo for duplicate-detection problems
- [function] `x-of-a-kind-in-a-deck-of-cards/solution.py` — Related card/frequency problem that uses GCD instead of max frequency

## Beliefs

- `flush-beats-all` — Flush is checked before rank-based hands and takes priority over Three of a Kind, matching the problem's hand ranking
- `no-full-house-distinction` — The `>= 3` threshold treats Full House (3+2) identically to Three of a Kind, which is correct per the problem constraints
- `no-two-pair-distinction` — Two Pair and One Pair both return `"Pair "` because the check uses only `max_freq == 2`, not the count of pairs
- `trailing-space-in-output` — All return strings end with a trailing space, matching LeetCode's expected output format
- `five-card-assumption` — The function assumes exactly 5 cards with no length validation; correctness depends on the caller providing valid input

