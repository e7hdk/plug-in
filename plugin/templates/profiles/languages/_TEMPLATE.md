# <Language> — expertise profile

<!-- Woven into the relevant nested AGENTS.md by /init-org. Sharpens builders/reviewer/security
working in this language. Idioms + tooling + gotchas — not a tutorial. -->

## Idioms
- Error handling: <the idiomatic pattern; what to avoid>.
- Concurrency / async: <model + the right primitives>.
- Typing / safety: <strictness, what "no escape hatch" means here>.

## Tooling & verify
- Format: `<cmd>` · Lint: `<cmd>` · Type/compile: `<cmd>` · Test: `<cmd>`.
- The verify gate runs: `<the single command that chains fmt-check + lint + typecheck + tests>`.

## Testing
- Framework: `<x>`. Deterministic — no real network/clock/DB; inject them. <mocking note>.

## Gotchas / never-do
- <common footguns that fail review here>.

## Role notes
- builder: <what to emphasize>.
- reviewer: <what to check first>.
- security: <language-specific hazards>.
