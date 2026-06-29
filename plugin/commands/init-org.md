---
description: Onboard this repo to the agent org — scaffold AGENTS.md, issue labels, and nested rules
argument-hint: (none)
allowed-tools: Read, Write, Bash, mcp__github
---
Onboard this repository to the `plug-in` agent org. Work idempotently — never overwrite an
existing file without confirmation; report what was created vs. already present.

1. **Constitution.** If `AGENTS.md` does not exist at the repo root, copy the template from
   `${CLAUDE_PLUGIN_ROOT}/templates/AGENTS.template.md` to `./AGENTS.md`. Then walk the user
   through the `< ... >` placeholders — product one-liner + ICP, **Stack & layout** paths, the
   **verify gate** command, the **human-gate list**, and the **deploy target**. Do not invent
   stack details; ask. Keep the verify-gate line in sync with the `verify_command` plugin setting.
   Also ask the **primary language(s)** and the **domain**. On a greenfield repo with no stack
   yet, have the `architect` propose stack options with trade-offs and let the user confirm.
   Weave the chosen domain profile from `${CLAUDE_PLUGIN_ROOT}/templates/profiles/domains/<domain>.md`
   into the "Domain context" section. Then **set the active roster**: run the `/scale-org` logic for
   the domain's recommended depth (+ any capabilities) to write the `## Active roster` section into
   `AGENTS.md` — the orchestrator routes only to those. `/scale-org <depth>` changes it later as the
   team grows.
   **CLAUDE.md:** ensure a root `CLAUDE.md` exists that imports the constitution with `@AGENTS.md` —
   Claude Code auto-loads `CLAUDE.md`, **not** `AGENTS.md`, for the main session and every subagent,
   so this is what makes the constitution actually load. Append to an existing `CLAUDE.md`; don't replace it.

2. **Nested rules (optional).** For each area declared in Stack & layout, offer to drop the
   matching template from `${CLAUDE_PLUGIN_ROOT}/templates/nested-AGENTS/` as that area's
   `AGENTS.md` (e.g. `backend-AGENTS.md` -> `<backend path>/AGENTS.md`, `web-AGENTS.md` ->
   `<web path>/AGENTS.md`, `infra-AGENTS.md` -> `<infra path>/AGENTS.md`).
   Also weave the language profile from `${CLAUDE_PLUGIN_ROOT}/templates/profiles/languages/<lang>.md`
   into the matching area's nested `AGENTS.md`, so builders/reviewer/security get that language's
   idioms, verify command, and footguns.

3. **Issue labels.** Via the GitHub MCP, create any missing task-bus labels:
   - `agent:<name>` for each agent in the active roster — e.g. orchestrator, product, architect,
     backend-builder, api-builder, data-builder, worker-builder, frontend-builder, mobile-builder,
     mobile-qa, mobile-release, design,
     reviewer, qa, security, e2e-qa, perf-qa, a11y-reviewer, supply-chain-security, devops, sre,
     release-manager, dba, incident-commander, docs, debugger, data-engineer, growth, sales, support,
     data, finance, i18n-engineer, compliance, privacy, legal-review, codebase-analyst.
   - states: `state:spec`, `state:building`, `state:review`, `state:blocked`, `state:done`.

4. **Permissions.** Offer to merge the recommended permissions from
   `${CLAUDE_PLUGIN_ROOT}/templates/settings.template.json` into `.claude/settings.json`
   (deny secrets/force-push, ask on deploy/infra, allow read/test/git). Merge — never clobber
   an existing `permissions` block; show the change first. The verify-on-write hook itself ships
   with the plugin, so it does not go in the host settings.

5. **Verify gate.** If the verify command (default `scripts/verify.sh`) doesn't exist, offer to
   create a stub that runs the repo's formatter + linter + tests, and `chmod +x` it.

6. **(Optional) per-agent memory.** Plugin agents ignore the `memory` field, so to give an agent a
   private, persistent memory you install a project-local copy. Offer to copy the memory-relevant
   agents — `architect`, `debugger`, `reviewer`, `security`, `codebase-analyst` — from
   `${CLAUDE_PLUGIN_ROOT}/agents/` into `.claude/agents/` (they override the plugin versions and gain
   `memory: project` -> `.claude/agent-memory/<name>/`, checked in). Trade-off: copied agents won't
   auto-update with the plugin. The org's primary memory is the checked-in docs (ADRs, postmortems,
   `docs/architecture.md`), which work without any copy.

7. **Report** what was created, what already existed, and exactly which `AGENTS.md` placeholders
   the user still needs to fill in before the agents are ready to run.
