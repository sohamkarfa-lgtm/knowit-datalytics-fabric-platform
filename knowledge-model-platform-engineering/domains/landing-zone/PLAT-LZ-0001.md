---
id: PLAT-LZ-0001
domain: landing-zone
type: platform-design
status: validated
owner: platform-engineering
relates_to: []
source: "Run 2026-09-10-0000001: approved requirements, G3/G6/G7, and approved design-input addendum."
created: "2026-09-10"
tags: [dev, fabric, minimal]
---

## Summary
One resource group for the initial Knowit Datalytics Fabric development environment.

## Recommendation
Use the supplied dev subscription and tenant, with actual identifiers kept
outside committed artifacts. Create rg-kd-fabric-dev-swc-001 in swedencentral.
Do not associate the subscription with a management group in this change.

Apply these Azure resource tags:
environment=dev, workload=fabric-platform, owner=soham-karfa,
cost_center=knowit-datalytics-dev, data_classification=internal,
managed_by=terraform.

The cost center is an approved allocation label, not a verified finance code.
Test and production are outside this design.

## Best-practice basis
Azure CAF resource organization: consistent naming, ownership, and cost attribution.

## Open items
- Confirm deployment identity permissions and applicable subscription policies before readiness.

