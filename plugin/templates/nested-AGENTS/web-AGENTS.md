# Web / UI — area rules (AGENTS.md)

<!-- Place at your web root (e.g. apps/web/AGENTS.md). -->

- Stack: <framework + language + build tool>.
- Types: <typing discipline, e.g. use the typed API client; no `any` without a written reason>.
- States: always cover loading / empty / error — not just the happy path.
- Accessibility: semantic markup, labelled controls, keyboard reachability, AA contrast — a requirement, not a polish step.
- Design system: <tokens/components location, or "none yet">. If one exists, build only from its tokens — no ad-hoc hex/px.
- Never: reach into backend or infra code; weaken the type checker silently.
