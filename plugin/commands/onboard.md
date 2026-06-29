---
description: Onboard the org onto an EXISTING repo — estimate the analysis cost, get approval, then map the codebase (map-reduce) and wire it up
argument-hint: "[low|medium|high|full]  (omit to be shown an estimate and asked)"
allowed-tools: Read, Write, Bash, Agent, mcp__github
---
Integrate the `plug-in` org into this **existing** codebase. Reading a real codebase costs real
tokens, so the deep analysis is **gated behind a cost estimate + your approval**. Work idempotently;
never overwrite a file without reconciling it. (Use `/init-org` for a fresh/empty repo.)

## Phase 1 — Estimate (cheap; shell only, NO deep reads yet)
Survey the repo with the shell — do not read file contents into context here:
- Inventory the source via `git ls-files` (fallback `find`), **excluding** vendored/generated paths
  (`.git`, `node_modules`, `vendor`, `dist`, `build`, `target`, `.next`, lockfiles, minified/generated,
  and binaries).
- Compute: file count, total source **bytes** and **lines**, a language histogram (by extension), and
  the top-level modules/areas (top-level dirs / packages / services).
- Token estimate: `est_full ≈ source_bytes / 4` (≈4 chars/token; rough).

Map to four **analysis tiers** and their rough cost:

| Tier | What it reads | ~Tokens |
|---|---|---|
| **low** | structure + manifests + entry points + READMEs (a survey) | ~min(est_full, 15k) |
| **medium** | + each module's key/interface files sampled (~30%) | ~0.3 × est_full |
| **high** | + all significant source across modules (~80%), full fan-out | ~0.8 × est_full |
| **full** | exhaustive — essentially every significant file, max fan-out | ~1.1 × est_full (+ synth overhead) |

## Phase 2 — Approve (the gate)
If `$ARGUMENTS` names a tier, use it. Otherwise **present** the inventory (files, LOC, languages,
modules) and the four tiers with their token estimates, and **ask**: *"Which depth? — this will burn
roughly N tokens."* **Do NOT start deep reads until the user picks a tier.**

## Phase 3 — Map (recursive map-reduce, scaled to the tier)

**Map (recursive fan-out).**
- **low** → a single `codebase-analyst` surveys; no fan-out.
- **medium / high / full** → **partition** the repo into the Phase-1 modules and spawn one **scoped**
  worker per module (`codebase-analyst` for the map artifact, or the built-in `Explore` for fast
  breadth), each reading only its subtree at the chosen depth. **If a worker reports its scope is still
  too big for its context, split that subtree and fan out again — recurse until every chunk fits.**
- **At `full` (and `high`) the recursion continues until every significant source file in scope is
  assigned to exactly one worker** — so `full` *guarantees* every such file is read by some agent. (It
  is still a *map*, not a copy, and it excludes the Phase-1 vendored/generated/binary list by design.)

**Reduce (hierarchical / tree synthesis).** Do **not** hand all partial maps to one synthesizer — on a
big repo the partial maps themselves overflow a single context (the hidden ceiling). Instead
**tree-reduce**: group the partial maps into batches that fit one `codebase-analyst`, synthesize each
batch into a combined sub-map, then synthesize those sub-maps the same way — **recursing until a single
root map remains**. Each merge resolves cross-boundary seams, de-duplicates, and **carries every area's
coverage note upward** so nothing is silently dropped in the merge.

## Phase 4 — Artifacts
- `docs/architecture.md` — the merged map: stack, layout, module boundaries, entry points, data flow,
  conventions, and the "dragons". It MUST end with a **Coverage** section that states, per module,
  what was **deeply read** vs **surveyed only** vs **skipped** — never imply full coverage you didn't do.
- A drafted `AGENTS.md` filled FROM the detected reality; a root `CLAUDE.md` with `@AGENTS.md` (Claude
  Code auto-loads CLAUDE.md, not AGENTS.md — this is what makes the constitution load for every subagent).
- Nested `AGENTS.md` + the language/domain/capability profiles per detected area.

## Phase 5 — Wire up
Confirm the product *why* + domain with the human (the code can't tell you). Set the `## Active roster`
for the detected depth + capabilities; create the `agent:<name>` + `state:*` labels; merge the
recommended permissions; ensure the verify gate exists; offer per-agent memory (as `/init-org`
steps 3–6). **Report** what was detected, created vs merged, the coverage achieved, and what the
human still must confirm.
