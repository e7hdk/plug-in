# Marketing site — domain profile

## What matters (NFRs / priorities, ranked)
1. **Page speed** — Core Web Vitals (LCP/CLS/INP); fast first paint is conversion.
2. **Discoverability** — SEO + answer-engine citability (semantic HTML, metadata, structured data).
3. **Conversion** — clear CTAs, fast forms, measurable funnels.
4. Accessibility and content velocity (ship/edit copy without an engineer in the loop where possible).

## Recommended org
- Depth: **lean → team**.
- Capabilities: i18n if multi-region.
- Key roster (emphasize): **frontend-builder**, **design**, **growth**, **seo**, **content**; light docs.
- De-emphasize / skip: heavy backend, devops/infra complexity, low-latency/systems, deep security
  (basics still apply — forms, headers, no secret leakage).

## Domain gates / concerns
- **Performance budget:** Lighthouse/CWV thresholds; no large layout shift; images optimized/lazy.
- Semantic, accessible HTML (AA contrast, keyboard, alt text); meta + Open Graph + structured data.
- Forms validate + protect against spam; no secrets in client bundles.

## Role notes
- product/growth: lead with the buyer's prompt/intent; tie each page to a metric.
- builders/design: hit the performance + a11y budget; keep the system tokenized and consistent.
- security: form abuse/spam, header hardening (CSP), no leaked keys in the static bundle.
