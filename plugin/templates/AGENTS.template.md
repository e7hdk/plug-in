# <PRODUCT NAME> — Constitution (AGENTS.md)

<!--
This file is the single source of truth every agent and tool reads. Fill in the < ... >
placeholders with your product and stack, and delete the guidance comments. Keep it lean
(≤ ~400 lines) and link out for detail. The generic `plug-in` agents read THIS file for
anything product- or stack-specific — the more precise it is, the better they perform.
Copy it to your repo root as `AGENTS.md` (the `/init-org` command does this for you).
-->

<ONE-LINE PRODUCT PITCH — what it does and for whom.> ICP: <your ideal customer / user>.
Domain: <e.g. b2b-saas | marketing-site | ecommerce | hft | fintech | devtools>.

Roster: the installed `plug-in` agents (or `.claude/agents/`) · Playbooks: `.claude/commands/`

## Active roster
<!-- Written by /init-org, changed by /scale-org. The orchestrator routes ONLY to these agents.
     Until it's set, the full installed roster is active. Format:
     ## Active roster (depth: team, compute: medium)
     orchestrator, product, architect, backend-builder, frontend-builder, reviewer, qa, security, … -->
<set by /init-org for your chosen depth + capabilities>

## Stack & layout
<!-- Agents route and build by these paths — be exact. Delete rows you don't have. -->
- Backend: <language/framework + datastore> — `<path, e.g. apps/api/>`
- Web/UI: <framework + language> — `<path, e.g. apps/web/>`
- <Other component, e.g. a worker / engine / shared package> — `<path>`
- Infra / CI/CD: `<path, e.g. infra/>`
- <Any other top-level areas, e.g. docs/, growth/>

## Domain context
<!-- /init-org weaves your domain profile here (its ranked NFRs + the gates that matter).
     This tells every agent what to optimize for and prove against. -->
<the vertical's top priorities and its non-negotiable gates — e.g. for ecommerce: payment
idempotency, no raw card data (PCI), no oversell; for hft: p99 latency + determinism, no heap
on the hot path>

## Conventions
- <Language idioms: error handling, no panics/crashes on prod paths, typing discipline (e.g. avoid `any` without a reason).>
- Commits: <your commit convention, e.g. Conventional Commits>. NEVER add `Co-Authored-By`.
  NEVER use `--no-verify` or `--no-gpg-sign`. Multi-line messages via HEREDOC.
- **The verify gate:** `<verify command — keep in sync with the `verify_command` plugin setting,
  default scripts/verify.sh>` (formatter + linter + tests) must pass before a PR is mergeable.

## Task bus = GitHub Issues
- Every unit of work is a GitHub Issue with: an owner (`agent:<name>` label), acceptance
  criteria (a checklist), and a state label (`state:spec|building|review|blocked|done`).
- **Claim before you build:** assign yourself and move the issue to `state:building` before
  starting — so two contributors (and their agents) never grab the same issue. Never start on
  an issue already `state:building` or assigned to someone else.
- One branch per issue: `<type>/<issue#>-<slug>`.
- PRs MUST contain `Fixes #<n>` so the issue auto-closes on merge.
- Agents coordinate by reading issues and producing artifacts (specs, PRs, reports) — not by
  ambient chat.
- Each Issue is also the **delegation brief** for its owner: state the **objective**, the
  expected **output format**, the **tools/sources** to use, and the **boundaries** — a fresh
  specialist sees only the Issue, not the chat that created it.

## Definition of Done (global)
1) acceptance criteria checked · 2) tests added/updated and green · 3) reviewer approved ·
4) security clean (or tracked waiver) · 5) docs updated in the same PR · 6) `Fixes #` present.

## Human-in-the-loop gates (never automatic)
Production deploy · money movement (billing/payments) · any external customer email/outbound.
<Add any product-specific irreversible action here.> These route through `ask` in
`.claude/settings.json`.

DB migrations / schema changes and merging a green, reviewed PR to `<default branch>` are
**agent-allowed** (reversible, stop short of customer impact). Deploy — releasing
`<default branch>` to production via `/ship` — stays human-gated.

## Safety
No secrets in the repo — use `.env` + a secret manager. Least privilege per agent. No
force-push to `<default branch>`. Merge is allowed only via PR with green CI + ≥1 passing
review (reviewer + qa + security gates).

## Deploy target
<!-- devops + /ship read this. -->
- Target: <where production runs — a platform / cluster / the host's git integration>.
- Deploy procedure: `<docs/runbooks/deploy.md>` · Rollback: `<docs/runbooks/rollback.md>`.
- Pre-flight invariants: <e.g. migrations are additive/forward-only; required env present;
  destructive migrations carry a paired rollback plan>.
