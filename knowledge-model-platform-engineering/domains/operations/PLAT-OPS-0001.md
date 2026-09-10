---
id: PLAT-OPS-0001
domain: operations
type: platform-design
status: validated
owner: platform-engineering
relates_to: [PLAT-LZ-0001, PLAT-COMP-0001, PLAT-SEC-0001]
source: "Run 2026-09-10-0000001: approved G7/G8 and approved design-input addendum."
created: "2026-09-10"
tags: [dev, operations, cost]
---

## Summary
Manual operation of a minimal, reproducible development environment.

## Recommendation
Soham Karfa owns access reviews, cost reviews, and operational decisions.
Review consumption weekly during the first month.
Establish a monetary budget from a reviewed Sweden Central estimate before
deployment readiness; no budget amount is inferred.

Accept best-effort development availability and planned downtime.
Make no custom disaster-recovery or recovery-time commitment.
Keep infrastructure configuration in version control and development data
reproducible or disposable.

Defer scheduled automation and dedicated monitoring resources.
Use the kit's staged validation and human deployment handoff.
Require a protected Terraform backend before deployment; do not silently
substitute local state or add backend infrastructure to this scope.

## Best-practice basis
Azure WAF cost optimization and operational excellence: accountable ownership,
cost review, reproducible changes, and proportionate development operations.

## Open items
- [NEEDS HUMAN INPUT: reviewed monthly budget]
- [NEEDS HUMAN INPUT: approved protected Terraform backend configuration]

