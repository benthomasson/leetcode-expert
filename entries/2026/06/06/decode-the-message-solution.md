# File: decode-the-message/solution.py

**Date:** 2026-06-06
**Time:** 16:11

## `decode-the-message/solution.py`

### Purpose

This file solves [LeetCode 2325 — Decode the Message](https://leetcode.com/problems/decode-the-message/). It builds a substitution cipher from a key string and applies it to decode a message. The file is self-contained: solution function + inline unit tests, following the repo's standard pattern.

### Key Components

**`valid_selections(key, message) -> str`** — Misleadingly named (likely a copy-paste artifact; should be `decodeMessage`). It does two things:

1. **Builds a substitution table** (lines 14–18): Iterates through `key`, mapping each novel lowercase letter to the next letter of the alphabet (`'a'`, `'b'`, `'c'`, ...). Spaces are skipped, and duplicates are ignored via the `ch not in table` guard. The result is a `dict[str, str]` mapping cipher chars to plaintext chars.

2. **Decodes the message** (line 19): Replaces each character in `message` using the table. `table.get(ch, ch)` passes through any character not in the table (specifically spaces, since those were excluded from table construction).

**`TestValidSelections`** — Seven test cases covering the LeetCode examples, identity key, single character, trailing spaces, and keys with leading duplicates.

### Patterns

- **Single-file solution + test**: Every problem directory follows the same layout (`solution.py` with function + `unittest.TestCase`, `test_solution.py` for external test invocation, `plan.md`, `review.md`).
- **Dict-as-lookup-table**: The substitution table is a plain dict rather than `str.maketrans`/`str.translate`. Functionally equivalent, slightly less idiomatic but more readable for the cipher-building step.
- **Generator expression in `join`**: The decode step (`''.join(table.get(ch, ch) for ch in message)`) is a standard Python idiom for character-level string transformation.

### Dependencies

- **Imports**: Only `unittest` (stdlib). No external dependencies.
- **Imported by**: The massive `imported_by` list is an artifact of the test harness — those test files import from a shared runner, not from this solution specifically. The real consumer is `decode-the-message/test_solution.py`.

### Flow

```
key = "the quick brown fox jumps over the lazy dog"
       ↓
Iterate chars: t→a, h→b, e→c, q→d, u→e, i→f, c→g, k→h, ...
       ↓
table = {'t':'a', 'h':'b', 'e':'c', 'q':'d', ...}  (26 entries)
       ↓
message = "vkbs bs t suepuv"
       ↓
Each char looked up: v→t, k→h, b→i, s→s, ' '→' ', ...
       ↓
result = "this is a secret"
```

The `idx` counter advances from 0 to 25, mapping exactly 26 unique letters. Once all 26 are mapped, subsequent key characters are no-ops.

### Invariants

- The key is guaranteed (per the problem constraints) to contain all 26 lowercase letters at least once, so `idx` will reach 25 and the table will be complete.
- Spaces in the key are skipped — they never enter the substitution table.
- Spaces in the message pass through unchanged via `table.get(ch, ch)`.
- The mapping is deterministic and order-dependent: the first occurrence of each letter in the key determines its mapping.

### Error Handling

None. The function trusts its inputs match LeetCode's constraints. No validation of key completeness, no handling of uppercase or non-alpha characters beyond spaces. This is appropriate for a LeetCode solution where inputs are guaranteed well-formed.

---

## Topics to Explore

- [file] `decode-the-message/test_solution.py` — External test file that imports and exercises this solution; shows how the test harness integrates
- [function] `decrypt-string-from-alphabet-to-integer-mapping/solution.py:valid_selections` — Another cipher/mapping problem; compare substitution approaches
- [general] `function-naming-consistency` — `valid_selections` is used as the function name across many unrelated solutions, suggesting a templating issue worth auditing
- [file] `decode-the-message/review.md` — Code review notes for this solution; may document the naming issue or alternative approaches
- [general] `str-maketrans-alternative` — Python's `str.maketrans`/`str.translate` would be a more idiomatic (and faster for long messages) approach to the same problem

## Beliefs

- `decode-message-builds-26-entry-table` — The substitution table always contains exactly 26 entries when the key contains all 26 lowercase letters, mapping each to a unique letter a–z
- `decode-message-spaces-passthrough` — Spaces are never added to the substitution table and pass through unchanged in both key processing and message decoding
- `decode-message-first-occurrence-wins` — The mapping for each letter is determined by its first occurrence in the key; subsequent duplicates are ignored via the `not in table` check
- `decode-message-misnamed-function` — The function is named `valid_selections` rather than a problem-relevant name like `decodeMessage`, indicating a shared template across all solutions in this repo

