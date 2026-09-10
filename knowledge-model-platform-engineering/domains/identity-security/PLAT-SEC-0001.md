---
id: PLAT-SEC-0001
domain: identity-security
type: platform-design
status: validated
owner: platform-engineering
relates_to: [PLAT-COMP-0001]
source: "Run 2026-09-10-0000001: approved requirements, G4/G5/G6, and approved design-input addendum."
created: "2026-09-10"
tags: [dev, entra, rbac]
---

## Summary
Initial administrative access for the approved Entra guest identity.

## Recommendation
Assign soham.karfa_knowit.se#EXT#@knowitsandbox.onmicrosoft.com as capacity
administrator. Assign its verified target-tenant object ID to the workspace
as principal type User with role Admin.

No additional workspace assignments are included initially.
Capacity/workspace roles do not establish Azure deployment permissions.

Use existing approved authentication without embedding credentials in code.
Keep actual tenant, subscription, and principal IDs outside committed artifacts.
Permit synthetic or non-sensitive development data only; exclude production
and regulated data. No new Key Vault or custom encryption configuration is
included in this initial setup.

## Best-practice basis
Azure WAF security: explicit identities, least-privilege scope, and credential protection.
The administrative role is the explicitly approved bootstrap access requirement.

## Open items
- [NEEDS HUMAN INPUT: verified target-tenant principal object ID]
- Verify guest access, deployment permissions, tenant controls, and applicable licensing.

