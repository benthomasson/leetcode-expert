# File: strong-password-checker-ii/solution.py

**Date:** 2026-06-06
**Time:** 19:17

## `strong-password-checker-ii/solution.py`

### Purpose

This file implements LeetCode problem 2299 ("Strong Password Checker II"). It validates whether a password meets all six strength criteria defined by the problem. It's a standalone solution module — one of hundreds in this repo, each solving a single LeetCode problem.

### Key Components

**`Solution.strong_password_checker_ii(self, password: str) -> bool`** — The sole public method. Returns `True` only if `password` satisfies all six rules simultaneously:

1. Length >= 8
2. Contains at least one lowercase letter
3. Contains at least one uppercase letter
4. Contains at least one digit
5. Contains at least one special character from `!@#$%^&*()-+` (and space)
6. No two adjacent characters are the same

### Flow

The method uses an early-return for the length check, then does a **single-pass scan** over the string:

1. **Length gate** (line 11): Rejects passwords shorter than 8 characters immediately.
2. **Single loop** (lines 16–23): Iterates with `enumerate` to get both index and character. For each character:
   - **Adjacent duplicate check** (line 17): If `i > 0` and current char equals previous, returns `False` immediately. This is the only rule that triggers an early exit mid-loop.
   - **Character classification** (lines 19–24): Uses an `elif` chain for lowercase/uppercase/digit, plus a separate `if` for special characters. The `elif` means a special character like `!` won't accidentally set `has_lower`/`has_upper`/`has_digit` — but the special-char check is a standalone `if`, so it runs regardless of the `elif` outcome.
3. **Final conjunction** (line 26): All four boolean flags must be `True`.

### Patterns

- **Flag accumulation**: Four boolean flags start `False` and are flipped to `True` as evidence is found. This is the standard "checklist" idiom — you can't short-circuit because you need to see every character for the adjacent-duplicate rule anyway.
- **Set membership for specials**: `specials = set("!@#$%^&*()-+ ")` gives O(1) lookup per character. The set is rebuilt on every call (it's inside the method), but for a password-length string this is negligible.
- **Early exit on invariant violation**: The adjacent-duplicate check returns `False` immediately rather than setting a flag. This is valid because a single violation is sufficient to fail.

### Dependencies

**Imports**: None — pure Python, no standard library or third-party imports.

**Imported by**: The `strong-password-checker-ii/test_solution.py` file imports this module directly. The large "Imported By" list in the prompt is misleading — those are test files for *other* problems that happen to share a common test harness or import pattern across the repo, not actual consumers of this solution's logic.

### Invariants

- The `elif` chain (lines 19–22) is mutually exclusive for lowercase/uppercase/digit classification: a character can only set one of those three flags. This is safe because no character is simultaneously lowercase, uppercase, and a digit.
- The special-character check (line 23–24) is intentionally **not** part of the `elif` chain. A space character, for example, is not lowercase/uppercase/digit, so it falls through the `elif` without setting any flag — but the standalone `if ch in specials` still catches it. This separation is correct.
- The adjacent-duplicate check at `i > 0` guards against out-of-bounds access to `password[i - 1]` when `i == 0`.

### Error Handling

None. The method is a pure function with no exceptions, no I/O, and no edge cases that could raise. Empty strings are handled correctly (fail the length check). The method always returns a `bool`.

## Topics to Explore

- [file] `strong-password-checker-ii/test_solution.py` — See what edge cases the tests cover (empty string, exactly 8 chars, all-same-char, missing one category)
- [file] `strong-password-checker-ii/review.md` — Read the code review notes for this solution to see if any issues were flagged
- [general] `single-pass-validation-pattern` — This flag-accumulation-in-one-loop pattern recurs across many validation problems in the repo
- [function] `strong-password-checker-ii/solution.py:strong_password_checker_ii` — Compare with the harder variant (Strong Password Checker I, problem 420), which requires computing minimum *edits* to make a password strong

## Beliefs

- `special-char-check-independent-of-elif` — The special character check uses a standalone `if` (not `elif`), so characters that are neither lower/upper/digit can still be recognized as special
- `adjacent-duplicate-is-early-exit` — A single pair of adjacent identical characters causes immediate `False` return, unlike the category flags which are accumulated
- `no-short-circuit-on-category-flags` — Even after all four category flags are `True`, the loop continues to completion because it must still check every adjacent pair for duplicates
- `specials-set-includes-space` — The special characters set includes the space character, which is part of the LeetCode problem's specification

