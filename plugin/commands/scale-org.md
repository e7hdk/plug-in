---
description: Set or change this repo's active agent roster by depth (and optionally a compute tier)
argument-hint: <lean|team|scale-up|enterprise> [compute:<low|medium|high|ultra>]
allowed-tools: Read, Write, Bash, mcp__github
---
Scale this repo's agent org to depth **$ARGUMENTS**. Run it at onboarding (via `/init-org`) or any
time the team size changes mid-project — depth is meant to change as the project grows. Work
idempotently; preserve everything else in `AGENTS.md`.

1. Read the depth presets (§4) and the compute-tier table (§8) from
   `${CLAUDE_PLUGIN_ROOT}/AGENT-ORG.md`.
2. Compute the **active roster** for the requested depth = that preset's agent list **intersected
   with the agents actually installed** (never list an agent that doesn't exist yet). Any capability
   toggles already declared in `AGENTS.md` (mobile / ai / i18n / payments / …) add their agents.
3. Write or replace an **`## Active roster`** section in the repo-root `AGENTS.md`:
   ```
   ## Active roster (depth: <depth>, compute: <tier>)
   <comma-separated active agent names>
   <!-- Managed by /scale-org and /init-org. The orchestrator routes ONLY to these agents. -->
   ```
4. If a `compute:<tier>` arg was given, append a short **compute guidance** block — the per-agent
   model map for that tier from §8 — as guidance only (soft: we do NOT rewrite installed plugin
   agents; the shipped default is `medium`). To hard-pin a model, a host overrides that agent in
   `.claude/agents/<name>.md`.
5. Ensure `agent:<name>` issue labels exist for any newly-active agents (via the GitHub MCP).
6. Report: the depth, the active roster (count + names), the compute tier, and exactly what changed
   vs. the previous roster.

This is what makes "depth" actually take effect: the orchestrator routes only to the active roster.
