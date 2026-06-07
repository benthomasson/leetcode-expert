# File: fizz-buzz/solution.py

**Date:** 2026-06-06
**Time:** 16:52

## `fizz-buzz/solution.py`

### Purpose

This file implements LeetCode problem #412 (Fizz Buzz). It owns the single responsibility of generating the FizzBuzz sequence from 1 to `n` as a list of strings, following LeetCode's `Solution` class convention.

### Key Components

**`Solution.fizzBuzz(self, n: int) -> list[str]`** — The sole method. Takes an inclusive upper bound `n` and returns a list where each element is:
- `"FizzBuzz"` if the index (1-based) is divisible by both 3 and 5
- `"Fizz"` if divisible by 3 only
- `"Buzz"` if divisible by 5 only
- The number as a string otherwise

### Patterns

**Check order matters.** The `% 15` check comes first, before `% 3` and `% 5`. This is the standard FizzBuzz idiom — if you checked `% 3` first, multiples of 15 would hit "Fizz" and never reach "FizzBuzz". Using `% 15` instead of `% 3 == 0 and % 5 == 0` is a minor optimization (one modulo vs. two) but mainly a stylistic choice common in LeetCode solutions.

**Accumulator pattern.** Builds a result list via `.append()` in a loop rather than using a list comprehension. Straightforward and readable, though a comprehension with a helper or conditional expression would also work.

**LeetCode class convention.** All solutions in this repo wrap their logic in a `Solution` class with a specifically-named method matching LeetCode's expected signature.

### Dependencies

**Imports:** None. Pure Python, no standard library or third-party dependencies.

**Imported by:** The `fizz-buzz/test_solution.py` file directly. The massive "Imported By" list in the context is misleading — those are test files for *other* problems that happen to share a common test harness pattern importing from their own local `solution.py`, not from this file specifically.

### Flow

1. Initialize empty `result` list
2. Iterate `i` from 1 to `n` inclusive (`range(1, n + 1)`)
3. For each `i`, evaluate divisibility in priority order: 15 → 3 → 5 → fallback
4. Append the corresponding string
5. Return the accumulated list

### Invariants

- Output length is always exactly `n` (one entry per integer from 1 to `n`)
- The 1-based indexing is enforced by `range(1, n + 1)`
- Every 15th element is `"FizzBuzz"`, every 3rd (non-15th) is `"Fizz"`, every 5th (non-15th) is `"Buzz"`
- For `n <= 0`, returns an empty list (the range produces nothing)

### Error Handling

None. No input validation — if `n` is negative or zero, the loop simply doesn't execute and an empty list is returned. If `n` is not an integer, Python's `range()` will raise `TypeError`. This is fine for LeetCode where inputs are guaranteed valid.

## Topics to Explore

- [file] `fizz-buzz/test_solution.py` — See how the solution is validated and what edge cases are covered
- [file] `fizz-buzz/review.md` — The code review notes for this solution, may contain alternative approaches considered
- [file] `fizz-buzz/plan.md` — The planning document showing how the approach was chosen
- [general] `fizzbuzz-variants` — LeetCode has follow-ups (Fizz Buzz Multithreaded #1195) that require concurrency; worth comparing the single-threaded baseline
- [function] `add-digits/solution.py:Solution.addDigits` — Another number-theory problem using modular arithmetic, shows how the repo handles similar math patterns

## Beliefs

- `fizzbuzz-check-order` — The `% 15` divisibility check must precede `% 3` and `% 5` checks; reordering produces incorrect output for multiples of 15
- `fizzbuzz-output-length` — `fizzBuzz(n)` always returns a list of exactly `n` elements for any `n >= 1`
- `fizzbuzz-no-dependencies` — The solution uses no imports; it is pure Python with no external dependencies
- `fizzbuzz-1-indexed` — The output is 1-indexed: `result[0]` corresponds to integer 1, `result[n-1]` to integer `n`

