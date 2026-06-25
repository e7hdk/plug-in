---
description: Implement a feature ticket through the build -> test -> PR loop
argument-hint: <issue-number>
allowed-tools: Read, Write, Grep, Glob, Bash, Agent, mcp__github
---
Deliver GitHub Issue #$ARGUMENTS. Operate under `AGENTS.md`.

1. Read the issue + acceptance criteria. If unclear, hand back to `product`.
2. Create branch `feat/$ARGUMENTS-<slug>`.
3. Delegate to the right builder per scope (the paths in `AGENTS.md`) — handing it the
   objective, output format, tools/sources, and boundaries (a fresh subagent sees only what you hand it).
4. Ensure the repo's verify gate (`scripts/verify.sh` by default — see `AGENTS.md`) passes. Open
   a PR whose body contains `Fixes #$ARGUMENTS`.
5. Request `reviewer` + `qa` + `security` in parallel.

Stop at the open PR — leave the merge to a human or to `/next-issue`. Do NOT deploy
(production release is human-gated via `/ship`).
