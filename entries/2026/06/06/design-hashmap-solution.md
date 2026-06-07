# File: design-hashmap/solution.py

**Date:** 2026-06-06
**Time:** 16:18

## Purpose

This file implements LeetCode problem **706 - Design HashMap**. It provides a from-scratch hash map (dictionary) without using any built-in hash table libraries. The class `MyHashMap` supports `put`, `get`, and `remove` — the three core operations of an associative array. It's a data structure design problem that tests understanding of hashing and collision resolution.

## Key Components

### `MyHashMap`

A hash map backed by a fixed-size array of buckets, using **separate chaining** for collision resolution.

- **`__init__`**: Allocates 1009 empty buckets. Each bucket is a list of `[key, value]` pairs.
- **`_hash(key) -> int`**: Maps a key to a bucket index via `key % 1009`.
- **`put(key, value)`**: Scans the target bucket for an existing entry with the same key. If found, updates the value in place. Otherwise appends a new `[key, value]` pair.
- **`get(key) -> int`**: Linear scan of the target bucket. Returns the value if the key is found, `-1` otherwise (per LeetCode convention, not `None` or an exception).
- **`remove(key)`**: Linear scan with index tracking. Pops the matching pair by index if found; no-op if the key is absent.

### Constants

- **`self._size = 1009`**: A prime number chosen as the bucket count. Prime moduli distribute keys more uniformly than powers of two, reducing clustering when keys share common factors.

## Patterns

**Separate chaining**: Each bucket is an independent list. Colliding keys coexist in the same bucket as separate entries. This is the simplest collision resolution strategy — no probing, no rehashing, no tombstones.

**Mutable pair lists**: Pairs are stored as `[key, value]` (mutable lists, not tuples), which lets `put` do `pair[1] = value` to update in place without removing and re-inserting.

**No dynamic resizing**: The bucket count is fixed at construction. This is acceptable under LeetCode's constraint of at most 10^4 operations — the average chain length stays well under 10.

## Dependencies

**Imports**: None. The implementation is self-contained with no standard library or third-party imports.

**Imported by**: `design-hashmap/test_solution.py` directly, and the "Imported By" list in the prompt shows hundreds of test files — this is an artifact of the repo's test infrastructure pattern, not a real dependency. Only `test_solution.py` in this directory actually exercises `MyHashMap`.

## Flow

1. Constructor creates 1009 empty lists.
2. On `put(key, value)`: hash the key → get the bucket → linear scan for existing key → update or append.
3. On `get(key)`: hash → scan → return value or `-1`.
4. On `remove(key)`: hash → scan with `enumerate` → `pop(i)` on match.

All three operations touch exactly one bucket. The work per operation is O(n/1009) amortized, where n is the number of stored keys.

## Invariants

- **No duplicate keys per bucket**: `put` always checks for an existing key before appending, so each key appears at most once across the entire map.
- **Bucket index stability**: `_hash` is deterministic and never changes, so a key always maps to the same bucket — no rehashing path exists.
- **`get` returns `-1` for missing keys**: This is the LeetCode contract, not Python's typical `KeyError` convention.

## Error Handling

There is none. The code assumes all inputs are valid integers within LeetCode's constraints (0 <= key, value <= 10^6). `get` and `remove` on missing keys silently return `-1` or no-op, respectively — no exceptions are raised.

## Topics to Explore

- [file] `design-hashset/solution.py` — The companion problem; likely uses the same chaining structure but stores keys only, no values
- [file] `design-hashmap/test_solution.py` — See what edge cases are covered (empty map, overwrite, remove-then-get)
- [general] `open-addressing-vs-chaining` — Compare this separate-chaining approach with linear/quadratic probing alternatives and their trade-offs on cache locality
- [function] `design-hashmap/solution.py:_hash` — Explore why 1009 (a prime) was chosen over 1000 or 1024, and how modular arithmetic interacts with key distributions
- [file] `design-hashmap/plan.md` — The problem analysis and approach rationale that preceded this implementation

## Beliefs

- `hashmap-no-duplicate-keys` — `put` guarantees at most one entry per key by scanning before appending, so the map never contains duplicate keys in any bucket
- `hashmap-fixed-1009-buckets` — The bucket array is sized at 1009 (a prime) and never resizes, making the implementation O(n/1009) per operation in the worst case
- `hashmap-missing-key-returns-negative-one` — `get` returns the integer `-1` for absent keys rather than raising an exception or returning `None`
- `hashmap-remove-is-silent-noop` — `remove` on a nonexistent key does nothing and returns `None` implicitly — no error signal

