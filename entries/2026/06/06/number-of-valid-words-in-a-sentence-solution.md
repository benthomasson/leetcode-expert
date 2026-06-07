# File: number-of-valid-words-in-a-sentence/solution.py

**Date:** 2026-06-06
**Time:** 18:25

## Purpose

This file implements **LeetCode 2047: Number of Valid Words in a Sentence**. It owns the complete solution and its test suite in a single module — the standard structure across this repository where each problem directory contains `solution.py` with both the `Solution` class and `unittest`-based tests.

The problem: given a sentence string, split it into tokens by spaces and count how many tokens qualify as "valid words" under a specific set of lexical rules.

## Key Components

### `Solution.countValidWords(sentence: str) -> int`

The public entry point. Splits the sentence on whitespace, filters out empty tokens, and sums the results of `is_valid()` on each token.

### `is_valid(token: str) -> bool` (nested closure)

The core validation logic. A token is valid if **all** of the following hold:

| Rule | Implementation |
|------|----------------|
| No digits | `c.isdigit()` → immediate `return False` |
| At most one hyphen | `hyphen_count` tracked; >1 → `False` |
| Hyphen not at start/end | `i == 0 or i == len(token) - 1` → `False` |
| Hyphen flanked by letters | `token[i-1].isalpha() and token[i+1].isalpha()` required |
| At most one punctuation (`!`, `.`, `,`) | `punct_count` tracked; >1 → `False` |
| Punctuation only at end | `i != len(token) - 1` → `False` |

### `TestCountValidWords`

14 test cases covering the three LeetCode examples plus edge cases: standalone punctuation, leading/trailing hyphens, multiple hyphens, multiple punctuation, mid-word punctuation, digits, whitespace-only input, single letter, and punctuation-before-hyphen combinations.

## Patterns

- **Single-pass character validation**: `is_valid` iterates the token exactly once, checking all constraints in a single `for` loop with early returns. No regex, no multi-pass scanning.
- **Closure over nothing**: `is_valid` is nested inside `countValidWords` but doesn't capture any state from the enclosing scope — it's a pure function. This is the idiomatic pattern across the repo for keeping helper logic co-located.
- **Generator expression with `sum()`**: `sum(is_valid(t) for t in sentence.split() if t)` — boolean-to-int coercion for counting. The `if t` guard is redundant since `str.split()` without arguments already drops empty strings, but it's defensive.

## Dependencies

**Imports**: Only `unittest` from the standard library. No external packages.

**Imported by**: The "Imported By" list in the prompt is misleading — it lists hundreds of unrelated test files. That's likely an artifact of the analysis tool treating all `test_solution.py` files as importing from every `solution.py`. The actual import graph is self-contained: `number-of-valid-words-in-a-sentence/test_solution.py` imports from this file.

## Flow

1. `sentence.split()` tokenizes on whitespace (one or more spaces)
2. For each non-empty token, `is_valid` walks every character left-to-right
3. Any digit → reject immediately
4. Hyphen rules checked on encounter: count, position, neighbors
5. Punctuation rules checked on encounter: count, must be final character
6. If the loop completes without rejection, the token is valid
7. Valid token count returned as the final integer

## Invariants

- **Hyphen neighbor access is safe**: the guard `i == 0 or i == len(token) - 1` returns `False` before `token[i-1]` or `token[i+1]` is accessed, preventing index-out-of-bounds.
- **Punctuation-at-end is enforced before count check**: the position check (`i != len(token) - 1`) comes before the count would matter, so a mid-word punctuation mark rejects regardless of count.
- **Order of checks matters**: digit check runs first (most common rejection), then hyphen (structural), then punctuation (positional). This isn't a correctness concern but affects early-exit frequency.

## Error Handling

None. The function assumes well-formed input per the LeetCode contract (lowercase letters, digits, hyphens, `!.,`, and spaces). No exceptions are raised or caught. The `unittest` harness uses `assertEqual` assertions — failures surface as test errors, not runtime exceptions.

## Topics to Explore

- [file] `number-of-valid-words-in-a-sentence/plan.md` — The planning doc that preceded this implementation; shows how the validation rules were decomposed
- [file] `number-of-valid-words-in-a-sentence/review.md` — Post-implementation review; may note edge cases or alternative approaches considered
- [function] `shortest-completing-word/solution.py:shortestCompletingWord` — Another string-validation problem with character-counting; compare the validation strategy
- [general] `single-pass-validation-pattern` — Many solutions in this repo use the same single-loop-with-counters pattern for character-level validation; worth cataloging
- [file] `number-of-different-integers-in-a-string/solution.py` — Related string-parsing problem that also splits tokens and applies per-token rules

## Beliefs

- `valid-word-hyphen-safety` — The hyphen boundary check at `i == 0 or i == len(token) - 1` guarantees `token[i-1]` and `token[i+1]` are always in-bounds when accessed
- `valid-word-single-pass` — `is_valid` examines each character exactly once with O(n) time and O(1) space per token
- `valid-word-split-no-empties` — `str.split()` without arguments never produces empty strings, making the `if t` filter in the generator redundant but harmless
- `valid-word-punctuation-position-before-count` — A punctuation character not at the final position causes immediate rejection, independent of `punct_count`

