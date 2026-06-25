# TypeScript — expertise profile

## Idioms
- Typing / safety: `strict` tsconfig on. No `any` without a written reason — prefer `unknown` +
  narrowing, generics, and discriminated unions. Type at the boundaries (API responses, env).
- Error handling: throw `Error` subclasses or return typed result objects; never `catch` and
  swallow. Validate external input at the edge (e.g. `zod`) — don't trust `JSON.parse` shapes.
- Async: `async/await`; never leave a floating promise (await or explicitly `void`); avoid mixing
  callbacks and promises.

## Tooling & verify
- Format: `prettier --check .` · Lint: `eslint .` · Types: `tsc --noEmit` · Test: `<vitest|jest>`.
- The verify gate runs: `prettier --check . && eslint . && tsc --noEmit && <test cmd>`.

## Testing
- Framework: `vitest` or `jest`. Deterministic — fake timers, no real network; inject clients.
  Test the loading/empty/error states for UI, not just the happy path.

## Gotchas / never-do
- `any` leaking through a module boundary; non-null `!` to dodge a real null; `==` instead of
  `===`; floating promises; `as` casts that lie about runtime shape.

## Role notes
- builder (web): keep components small + typed; cover loading/empty/error; accessibility by default.
- reviewer: check for `any`/`!` escape hatches, unhandled promise rejections, untyped boundaries.
- security: XSS via `dangerouslySetInnerHTML`/`innerHTML`; prototype pollution; unsanitized inputs.
