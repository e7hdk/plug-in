# Infra — area rules (AGENTS.md)  [stricter]

<!-- Place at your infra root (e.g. infra/AGENTS.md). Only the `devops` agent works here. -->

- Everything is code: reviewable, reproducible, least-privilege. No click-ops.
- No secrets in the repo — `.env` + a secret manager; failure alerts route through the human-gated channel.
- Every release has a tested rollback plan; migrations are planned and ordered ahead of the deploy.
- Production changes are human-gated (`/ship`): present the checklist and wait for explicit approval. Never deploy autonomously.
- Keep `<verify command>` the single CI quality gate; fail loudly, never silently skip a check.
