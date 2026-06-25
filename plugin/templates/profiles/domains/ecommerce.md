# E-commerce — domain profile

## What matters (NFRs / priorities, ranked)
1. **Payment correctness** — charges are idempotent, never double-charge, money totals tie out.
2. **Conversion + uptime** — checkout availability and page speed are revenue; a slow PDP/cart loses sales.
3. **Inventory consistency** — no overselling under concurrency; reservations and races handled.
4. Trust & compliance (PCI: never store raw card data); accurate pricing/tax/discount logic.

## Recommended org
- Depth: **team** → **scale-up**.
- Capabilities: **payments** (always); i18n if multi-region; mobile if there's an app.
- Key roster (emphasize): frontend-builder, design, **security** (PCI), **data** (funnel/AOV),
  backend-builder, **seo**, support. Finance/revops as it scales.
- De-emphasize / skip: heavy low-latency/systems roles.

## Domain gates / concerns
- **Payments:** use the provider's tokens/SDK — no raw PAN in the repo, logs, or DB (PCI). Charges
  and webhooks are idempotent (idempotency keys); reconcile against the provider as source of truth.
- **Inventory:** decrement under a transaction/lock or reservation; test the oversell race.
- **Pricing integrity:** server is authoritative for price/tax/discount — never trust client totals.
- Funnel analytics and accessibility on the checkout path.

## Role notes
- product/architect: model the cart/checkout/inventory/refund flows and their failure paths first.
- builders/qa: prove idempotency, the oversell race, and price-tampering resistance with tests.
- security: PCI scope, webhook signature verification, auth on account/order endpoints, XSS on UGC.
