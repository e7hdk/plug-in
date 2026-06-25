---
description: Pre-deploy checklist and release (human-gated)
argument-hint: <version-or-branch>
allowed-tools: Read, Grep, Bash, mcp__github
---
Act as `devops` for release $ARGUMENTS. Operate under `AGENTS.md`.

Read the deploy target, deploy procedure, and rollback procedure declared in `AGENTS.md`
(typically `docs/runbooks/deploy.md` and `docs/runbooks/rollback.md`).

Run the pre-flight checks:
1. All CI jobs green — the repo's verify gate plus any build/test jobs.
2. New migrations are additive/forward-only; destructive migrations have a paired rollback
   plan filed in the issue.
3. Required production env/secrets are present (via the secret manager, never the repo) and
   any feature flags are set correctly.
4. A tested rollback path exists.

Present the completed checklist and **STOP for human approval before any deploy.**
Never promote autonomously. Wait for explicit go-ahead from the human operator.

After approval, run the deploy — the configured deploy command, or the platform's release
per `AGENTS.md` — then the post-deploy verification from the runbook against the production URL.
