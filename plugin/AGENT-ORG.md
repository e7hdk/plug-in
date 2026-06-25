# Agent Organization — design & roster

How the `plug-in` agent org is structured: an **orchestrator → specialist** topology that a
host SaaS repo can run at a **depth that matches its team size**. This document is the org chart
and the roster spec. Product- and stack-specific details live in the host's `AGENTS.md`; this
file is stack-neutral.

Legend: **✓** ships today · **+** planned (built as we grow the roster).

---

## 1. Principles

1. **Orchestrator–worker is the backbone.** One lead decomposes a goal into tickets, routes
   them to narrow specialists, and assembles results — it never does the work itself.
2. **Single-responsibility, least-privilege, isolated context.** Each agent owns one area, gets
   only the tools it needs, and runs in its own context. The builder can't send email; the
   reviewer can't write code; only devops touches prod.
3. **Rules live in files.** A portable constitution (`AGENTS.md`) + per-area nested rules +
   per-agent charters. The directory *is* the org chart.
4. **Guardrails are mechanical.** Hooks + permission rules block secrets, force-pushes, and
   un-gated prod/money/outbound. Humans gate the irreversible things.
5. **Start minimal, grow into the org.** Turn on a lean core first; add specialists only when
   the team and the product justify them (see §4, depth presets).
6. **Cost discipline.** The lead runs on a strong model; most workers run cheaper (see the
   model column in §3). Delegate deliberately — subagents cost multiples of a linear session.

---

## 2. The pods (org chart)

```
                        ORCHESTRATOR (lead)          routes · gates · assembles
                               │
   ┌───────────────┬───────────┼───────────────┬──────────────────┐
   │ ENGINEERING   │  QUALITY   │  PLATFORM      │       GTM        │
   ├───────────────┼───────────┼───────────────┼──────────────────┤
   │ product       │ reviewer   │ devops         │ growth · sales   │
   │ architect     │ qa         │ + sre          │ support · data   │
   │ backend-bld   │ security   │ + release-mgr  │ finance          │
   │ frontend-bld  │ + e2e-qa   │ + dba          │ + seo · content  │
   │ design        │ + perf-qa  │ + incident-cmd │ + lifecycle · sdr│
   │ docs          │ + a11y-rev │                │ + onboarding ... │
   │ debugger      │ + supply-  │                │ + bizops · revops│
   │ + api/data/   │   chain-sec│                │                  │
   │   worker/web/ │            │                │                  │
   │   mobile bld  │            │                │                  │
   │ + ml/prompt/  │            │                │                  │
   │   data-eng    │            │                │                  │
   └───────────────┴───────────┴───────────────┴──────────────────┘
```

The **task tracker is the message bus** (GitHub Issues): every unit of work is a ticket with an
owner agent, acceptance criteria, and a state. Builders work on branches; reviewer ∥ qa ∥
security gate every PR in parallel; devops ships behind a human gate. (See `AGENTS.md`.)

---

## 3. The roster

Model column is a recommendation (tune per agent): **H**=haiku, **S**=sonnet, **O**=opus.

| Agent | Pod | Owns / does | Tier | Model | Status |
|---|---|---|---|---|---|
| orchestrator | lead | decompose · route · gate | lean | O | ✓ |
| product | eng | ideas → specs + issues | lean | S | ✓ |
| architect | eng | system design, ADRs, contracts | lean | O | ✓ |
| backend-builder | eng | server-side code (generalist) | lean | S | ✓ |
| frontend-builder | eng | web/UI code (generalist) | lean | S | ✓ |
| reviewer | quality | correctness/perf/style review | lean | O | ✓ |
| qa | quality | test plan, write/run tests | lean | O | ✓ |
| security | quality | secrets/injection/authz/CVEs | lean | O | ✓ |
| devops | platform | CI/CD, infra, deploy, rollback | team | S | ✓ |
| docs | eng | technical + user docs, changelog | team | H | ✓ |
| debugger | eng | triage, repro, root-cause, fix | team | S | ✓ |
| design | eng | design system, tokens, themes | team | O | ✓ |
| growth | gtm | top-of-funnel content + landing | team | S | ✓ |
| sales | gtm | prospecting + outreach drafts | team | S | ✓ |
| support | gtm | support replies, onboarding, churn | team | H | ✓ |
| data | gtm | metrics, dashboards, readouts | team | S | ✓ |
| finance | gtm | pricing, unit economics, billing | scaleup | S | ✓ |
| api-builder | eng | HTTP/RPC endpoints + contracts | scaleup | S | ✓ |
| data-builder | eng | schema, migrations, queries | scaleup | S | ✓ |
| worker-builder | eng | jobs, queues, schedulers, pipelines | scaleup | S | ✓ |
| _(web builder)_ | eng | covered by `frontend-builder`; mobile via the **mobile** capability | — | — | — |
| e2e-qa | quality | end-to-end / integration flows | scaleup | S | ✓ |
| perf-qa | quality | load, latency, profiling | scaleup | S | ✓ |
| a11y-reviewer | quality | accessibility (WCAG) gate | scaleup | S | ✓ |
| supply-chain-security | quality | deps, SBOM, provenance | scaleup | S | ✓ |
| sre | platform | observability, alerting, on-call | scaleup | S | ✓ |
| release-manager | platform | release trains, changelogs, flags | scaleup | S | ✓ |
| ml-engineer | eng | ML/AI feature implementation | scaleup (ai) | O | + |
| prompt-engineer | eng | prompts, evals, guardrails | scaleup (ai) | S | + |
| data-engineer | eng | pipelines, ETL, warehouse | scaleup | S | ✓ |
| seo | gtm | search/answer-engine optimization | scaleup | S | + |
| content | gtm | long-form content, docs marketing | scaleup | S | + |
| mobile-builder | eng | native/mobile app | enterprise (mobile) | S | ✓ |
| mobile-qa | quality | device/OS matrix + mobile failure modes | enterprise (mobile) | S | ✓ |
| mobile-release | platform | store submission, signing, phased rollout | enterprise (mobile) | S | ✓ |
| i18n-engineer | eng | localization/internationalization | enterprise (i18n) | S | ✓ |
| dba | platform | database operations/tuning | enterprise | S | ✓ |
| incident-commander | platform | coordinate sev incidents | enterprise | O | ✓ |
| lifecycle | gtm | email/lifecycle marketing | enterprise | S | + |
| sdr | gtm | prospecting / top-of-pipeline | enterprise | S | + |
| ae | gtm | deal drafts / proposals | enterprise | S | + |
| onboarding | gtm | activation / success content | enterprise | H | + |
| bizops | gtm | cross-functional ops analysis | enterprise | S | + |
| revops | gtm | pipeline/revenue operations | enterprise | S | + |
| fp&a | gtm | forecasting / planning | enterprise | S | + |
| compliance | governance | SOC2/GDPR controls evidence | enterprise | S | ✓ |
| privacy | governance | data handling / DPIA review | enterprise | S | ✓ |
| legal-review | governance | ToS/contract draft review | enterprise | S | ✓ |

---

## 4. Depth presets

A host picks the depth that fits its team; the org grows by adding the next tier on top.
**Today this is guidance** (single plugin — all charters ship; you run the subset you want).
A future `/scale-org <preset>` may enforce the active roster and tune models per tier.

| Preset | ~Size | For | Roster |
|---|---|---|---|
| **Lean** | ~8 | solo / MVP | the 8 `lean` agents above (ship fast, fully gated) |
| **Team** | ~16 | small team | + devops, docs, debugger, design, growth, sales, support, data |
| **Scale-up** | ~32 | growth stage | + finance, split builders (api/data/worker/web), quality lenses (e2e/perf/a11y/supply-chain), sre, release-manager, ai (ml/prompt/data-eng), seo, content |
| **Enterprise** | ~60 | large org | + mobile, i18n, dba, incident-commander, lifecycle, sdr, ae, onboarding, bizops, revops, fp&a, compliance, privacy, legal, and further GTM/governance granularity |

### Capability toggles (orthogonal to depth)
Add a capability at any depth: **mobile** (mobile-builder, mobile-qa, mobile-release) · **ai/ml** (ml-engineer,
prompt-engineer, data-engineer) · **i18n** (i18n-engineer, content-localization) · **payments**
(billing-focused finance/revops) · **agency / white-label** (multi-tenant + brand-kit roles).

---

## 5. Per-agent charter template

Every `agents/<name>.md` follows this contract so agents are interchangeable and auditable:

```markdown
---
name: <agent-id>
description: MUST BE USED for <triggers> — this string drives auto-delegation
tools: <least-privilege list>
model: <haiku|sonnet|opus>
---
# Mission        <one sentence>
# Scope — you own <paths / artifacts, per AGENTS.md>
# How you work   <the method, in order>
# What you return <the handoff contract: spec / PR / report / verdict …>
# Boundaries — never do <hard guardrails>
# Escalate when  <ambiguity, irreversible action, a gate trigger>
```

---

## 6. Where things live

| Concern | Location |
|---|---|
| Constitution (product + stack + gates) | host repo `AGENTS.md` (from `templates/AGENTS.template.md`) |
| Per-area rules | nested `AGENTS.md` (from `templates/nested-AGENTS/`) |
| The roster (charters) | `agents/*.md` (flat — subfolders break plugin discovery) |
| Playbooks | `commands/*.md` |
| Guardrails | `hooks/hooks.json` (verify-on-write) + `templates/settings.template.json` (permissions) |
| Install-time config | `plugin.json` → `userConfig` (verify/deploy/branch/tracker) |
| Expertise profiles | `templates/profiles/{languages,domains,capabilities}/*.md` |

---

## 7. Expertise profiles & domain presets

The roles above are **stack-neutral**. Language and domain expertise is supplied as **profiles**
(data, not agents — see `templates/profiles/README.md`), so one `backend-builder` becomes a Rust
HFT engineer or a TypeScript e-commerce engineer depending on what the host selected — no
per-language agent explosion.

- **Language profiles** (`profiles/languages/<lang>.md`) sharpen builders/reviewer/security with
  idioms, the verify command, and footguns. Woven into the relevant nested `AGENTS.md`.
- **Domain profiles** (`profiles/domains/<domain>.md`) carry the vertical's NFRs + gates **and a
  recommended org shape**. Woven into the root `AGENTS.md`.
- **Capability profiles** (`profiles/capabilities/<cap>.md`) turn on a cross-cutting feature
  (mobile, ai, i18n, …): they add the capability's agents to the active roster and weave its
  constraints across the org (e.g. mobile's "no instant rollback").

**Who picks the stack:** existing repo → agents follow `AGENTS.md`; greenfield → the user picks at
onboarding and the `architect` proposes options with trade-offs for the human to confirm (a stack
choice is hard to reverse). `/init-org` then weaves the matching profiles.

### Domain → preset (context-aware org selection)
Selecting a domain configures depth + capabilities + the roster it leans on:

| Domain | Depth | Capabilities | Emphasize | De-emphasize |
|---|---|---|---|---|
| b2b-saas | team | — | full eng + gates + core gtm | — |
| marketing-site | lean→team | — | frontend, design, growth, seo | heavy backend, devops |
| ecommerce | team→scale-up | payments (+i18n/mobile) | frontend, design, security (PCI), data, seo | low-latency/systems |
| hft / low-latency | scale-up→ent | — | systems backend, perf-qa, sre, data-eng | growth, sales, support, design |
| fintech | scale-up→ent | payments | security, compliance, privacy, data | — |
| devtools | team→scale-up | — | backend, docs, dx-focused frontend, growth/content | — |

(Extend by adding a profile under `templates/profiles/domains/`.)

---

## 8. Compute tiers (model selection)

A second user axis, orthogonal to depth: **how much Opus the org spends.** Opus is reserved for
the roles where reasoning quality has the highest blast radius; cheaper models do the rest
(per Anthropic's role-criticality guidance and wshobson's 5-tier scheme). Like depth, this is a
**documented default today** — the shipped `model:` fields match **medium**; a host on another tier
overrides per-agent in `.claude/agents/` (a future `/set-compute <tier>` can automate it).
`O`=opus, `S`=sonnet, `H`=haiku. **Bold** = upgraded at that tier.

| Role group | low | **medium** (default) | high | ultra |
|---|---|---|---|---|
| architect · security | **O** | O | O | O |
| orchestrator · reviewer | S | **O** | O | O |
| supply-chain-security | S | S | **O** | O |
| builders (backend/api/data/worker/frontend) | S | S | **O** | O |
| qa · e2e-qa · perf-qa · a11y-reviewer | S | S | S | **O** |
| design · debugger · incident-commander | S | S | S | **O** |
| product · devops · data · finance · sre · release-manager · dba · data-engineer · mobile-builder · mobile-qa · mobile-release | S | S | S | S |
| i18n-engineer · compliance · privacy · legal-review | S | S | S | S |
| docs · growth · sales · support | H | H | **S** | S |

- **low** — only architect + security on Opus (cheapest; solo/MVP).
- **medium** — + the lead and code review (the shipped default; matches the research's recommended tiering).
- **high** — + dependency security and the code-writers.
- **ultra** — everything that writes or reviews code is Opus; the rest Sonnet (no Haiku).

## 9. Delegation contract & when NOT to fan out

Subagents start in a **fresh, isolated context** — they don't see the conversation. So every
delegation (and every task-bus issue) must hand the specialist four things (Anthropic's
multi-agent spec): **Objective · Output format · Tools/sources · Boundaries**, plus a restatement
of the active expertise profile and any standard the work depends on. Vague delegation → agents
duplicate work and leave gaps.

**When NOT to spawn parallel specialists:** multi-agent runs cost ≈15× the tokens of a single chat
(≈4× for one subagent), and most coding work has few *truly* independent subtasks. Fan out only
when subtasks are genuinely parallel; for sequential, same-file, or dependency-heavy work run a
single specialist. Lean depth defaults to minimal fan-out. **Don't rely on auto-delegation across a
large roster** — "flooding Claude with options makes automatic delegation less reliable"; the
orchestrator routes **explicitly** by name, and each `description` carries a specific trigger.

> Our GitHub-Issues bus is a portable **shared task list** (the pattern Claude Code's experimental
> "agent teams" formalize with a mailbox + file-locking). We don't depend on that experimental
> feature; a future peer-collaboration mode could use it for agents that must challenge each other.
