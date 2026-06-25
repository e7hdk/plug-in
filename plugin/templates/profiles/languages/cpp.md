# C++ — expertise profile

## Idioms
- RAII for every resource; ownership via `std::unique_ptr`/`std::shared_ptr` — no raw `new`/`delete`.
- Const-correctness; prefer references and value semantics; follow the rule of 0 (or 5).
- Errors: `std::optional`/`std::expected` or exceptions at boundaries — be consistent. Modern C++ (17/20).

## Tooling & verify
- Format: `clang-format --dry-run -Werror` · Static: `clang-tidy` · Build: `-Wall -Wextra -Werror` ·
  Sanitizers: asan/ubsan/tsan · Test: `ctest`.
- The verify gate runs: `clang-format --dry-run -Werror && clang-tidy && <cmake build -Werror> && ctest`.

## Testing
- GoogleTest or Catch2; run the suite under AddressSanitizer + UBSan. Deterministic — inject clock/IO.

## Gotchas / never-do
- Raw owning pointers; dangling references/iterators; undefined behavior (signed overflow,
  uninitialized reads); data races; manual memory management where RAII fits.

## Role notes
- builder: RAII + smart pointers, no UB, value semantics by default.
- reviewer: lifetime/ownership, UB, data races (run TSan), exception safety.
- security: buffer/integer overflow, use-after-free, unchecked bounds on untrusted input.
