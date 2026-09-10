---
id: PLAT-COMP-0001
domain: compute
type: platform-design
status: validated
owner: platform-engineering
relates_to: [PLAT-LZ-0001]
source: "Run 2026-09-10-0000001: approved requirements, G1/G2/G7, and approved design-input addendum."
created: "2026-09-10"
tags: [dev, fabric, f2]
---

## Summary
One F2 capacity and one assigned development workspace.

## Recommendation
Create capacity fckddevswc001 in swedencentral in the resource group
defined by PLAT-LZ-0001. Create workspace Knowit Datalytics - Dev and
assign it using the Fabric capacity GUID, not its Azure resource ID.

Keep capacity sizing fixed at F2. Increases require a separate approved change.
No initial performance or concurrency guarantee is made.
Disable workspace managed identity initially; no workload requires it yet.

Reuse the existing capacity and workspace modules.
Additional workspaces and Fabric items are outside this change.

## Best-practice basis
Azure WAF cost optimization: provision only the resources required for development.

## Open items
- Verify capacity availability, tenant settings, and deployment access before readiness.
- Confirm successful capacity discovery and workspace assignment during human deployment.

