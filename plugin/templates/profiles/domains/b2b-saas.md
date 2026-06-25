# B2B SaaS — domain profile

## What matters (NFRs / priorities, ranked)
1. **Tenant isolation** — no cross-tenant data leak, ever; every query is scoped to the tenant/account.
2. **Reliability** — uptime/SLA; graceful degradation; no noisy-neighbor blast radius.
3. **RBAC correctness** — permissions enforced server-side; least privilege per role.
4. Auditability, data export/portability, and predictable billing/usage metering.

## Recommended org
- Depth: **team** (→ scale-up as you add enterprise features).
- Capabilities: i18n if multi-region; payments for self-serve billing.
- Key roster (emphasize): full engineering + gates + core GTM; lean on **security** (tenant
  isolation), **data** (activation/retention), **support**.
- De-emphasize / skip: nothing structural early.

## Domain gates / concerns
- **Tenant scoping** on every read/write (a missing `WHERE tenant_id = …` is a blocker).
- RBAC checked server-side on every privileged endpoint; audit log for sensitive actions.
- No PII in logs; encryption at rest for tenant data; rate limiting / quota per tenant.

## Role notes
- product/architect: model the tenancy boundary and the permission matrix before features.
- builders/qa: prove the cross-tenant access test fails closed; test each role's allow/deny.
- security: tenant isolation, RBAC bypass, IDOR on object ids, secrets per tenant.
