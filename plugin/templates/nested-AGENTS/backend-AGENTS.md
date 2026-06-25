# Backend — area rules (AGENTS.md)

<!--
Place at your backend root (e.g. apps/api/AGENTS.md). It loads automatically when an agent
edits files here and is more specific than the root AGENTS.md (most-specific wins). Keep it
to the rules that differ from or sharpen the root constitution.
-->

- Stack: <language/framework + datastore>.
- Errors: <idiom, e.g. typed Result / explicit error returns; no panics or unhandled crashes on production paths>.
- Tests: deterministic — no real network, clock, or DB; inject those dependencies. Run `<backend test command>`.
- Migrations: <numbering scheme + how the test schema stays in sync>; ship them in the same PR.
- Never: log secrets; commit credential-shaped literals (a secret scan runs in CI); edit web, infra, or secrets from here.
