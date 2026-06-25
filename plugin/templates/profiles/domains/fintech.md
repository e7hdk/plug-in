# Fintech — domain profile

## What matters (NFRs / priorities, ranked)
1. **Money correctness** — exact arithmetic (integer minor units or decimal — **never floats**);
   totals reconcile to the cent.
2. **Idempotency + an immutable ledger** — double-entry/append-only; replays never double-apply.
3. **Auditability & compliance** — KYC/AML where applicable; full, tamper-evident audit trail.
4. Security & privacy of financial PII; strong authn/authz.

## Recommended org
- Depth: **scale-up → enterprise**.
- Capabilities: **payments** (always); often **compliance/privacy** governance roles.
- Key roster (emphasize): **security**, **compliance**, **privacy**, **data**, backend, reviewer/qa
  (rigorous). Architect records every money/ledger decision.
- De-emphasize / skip: heavy GTM early; visual polish is secondary to correctness.

## Domain gates / concerns
- **Money type:** integer minor units or fixed-decimal — a float touching money is a blocker.
- Ledger integrity (double-entry balances; append-only, no destructive edits); idempotent
  transactions (idempotency keys); reconciliation against the provider/bank source of truth.
- PII encrypted; immutable audit trail; least-privilege access to financial data.

## Role notes
- product/architect: model accounts, ledger, transaction states, refunds/chargebacks, and failure paths first.
- builders/qa: prove idempotency, balance invariants, and rounding behavior with tests.
- security: authz on every money endpoint, replay protection, secret/key management, audit completeness.
