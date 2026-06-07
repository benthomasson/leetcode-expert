# File: detect-capital/solution.py

**Date:** 2026-06-06
**Time:** 16:19

## `detect-capital/solution.py`

### Purpose

This file solves [LeetCode 520 — Detect Capital](https://leetcode.com/problems/detect-capital/). It owns a single responsibility: determining whether a word's capitalization follows one of three valid patterns. It's one of ~400+ problem solutions in the `leetcode-implementations` repo, each isolated in its own directory.

### Key Components

**`detectCapitalUse(word: str) -> bool`** — The sole public function. It returns `True` when the word's capitalization matches any of these three rules:

1. All letters are uppercase (`"USA"`)
2. All letters are lowercase (`"leetcode"`)
3. Only the first letter is uppercase (`"Google"`)

The implementation counts uppercase characters in a single pass, then checks the count against three conditions in a compound boolean expression.

### Patterns

**Counting reduction instead of pattern matching.** Rather than checking `word.isupper()`, `word.islower()`, or `word.istitle()` (Python's built-in string predicates), the solution reduces the problem to a single integer — `upper_count` — and derives all three conditions from it. This is slightly more manual but evaluates the string only once instead of up to three times.

**Single-expression return.** The entire decision logic lives in one `return` statement with three disjuncts:
- `upper_count == 0` → all lowercase
- `upper_count == len(word)` → all uppercase
- `upper_count == 1 and word[0].isupper()` → title case

### Dependencies

**Imports:** None. Pure stdlib — uses only `str` methods (`isupper()`).

**Imported by:** `detect-capital/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the test harness structure — those other test files don't actually import this solution; they share a common test runner pattern.

### Flow

1. Generator expression iterates over every character in `word`, yielding `1` for each uppercase letter.
2. `sum()` aggregates into `upper_count`.
3. A single boolean expression short-circuits through the three valid patterns.

The function is O(n) time, O(1) space.

### Invariants

- `word` is assumed non-empty (per LeetCode constraints: `1 <= word.length <= 100`). The function doesn't guard against empty strings — `word[0]` would raise `IndexError` on empty input, but LeetCode guarantees this won't happen.
- `word` contains only English letters (no digits, whitespace, or special characters). The function doesn't validate this.

### Error Handling

None. The function is a pure predicate with no error paths under valid LeetCode inputs. An empty string would cause an unhandled `IndexError` at `word[0].isupper()`.

## Topics to Explore

- [file] `detect-capital/test_solution.py` — See which edge cases the tests cover (empty string? single char? mixed like `"fLaG"`?)
- [file] `detect-capital/review.md` — The code review may note the tradeoff between the counting approach and Python's built-in `str.isupper()`/`str.islower()`/`str.istitle()`
- [general] `single-pass-counting-vs-predicates` — Compare `sum(c.isupper() for c in word)` against chaining `word.isupper() or word.islower() or word.istitle()` for correctness and readability
- [file] `detect-capital/plan.md` — The problem decomposition and approach selection that led to this implementation

## Beliefs

- `detect-capital-three-valid-patterns` — `detectCapitalUse` accepts exactly three capitalization patterns: all-upper, all-lower, and first-letter-only-upper; all other patterns return `False`.
- `detect-capital-single-pass` — The solution iterates the string once via a generator expression to count uppercase characters, making it O(n) time and O(1) space.
- `detect-capital-no-empty-guard` — The function will raise `IndexError` on an empty string because it accesses `word[0]` without a length check, relying on LeetCode's constraint that `len(word) >= 1`.
- `detect-capital-pure-function` — `detectCapitalUse` has no side effects, no imports, and no mutable state — it's a pure predicate over its input string.

