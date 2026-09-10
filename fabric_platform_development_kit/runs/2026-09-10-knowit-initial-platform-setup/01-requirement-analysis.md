---
run_id: "2026-09-10-0000001"
stage: requirement-analysis
status: approved
approved_by: "soham karfa (user approval in conversation)"
approved_at: "2026-09-10T16:36:17+02:00"
source: "User request and inline Stage 1 draft; explicit approval: approve this Stage 1"
created: "2026-09-10"
---

# Requirement Analysis - Minimal Fabric development environment

## Business objective
Establish a minimal, accessible development environment for Knowit Datalytics's Fabric platform.

## Functional requirements
- Provision one Microsoft Fabric F2 capacity in `swedencentral`.
- Provision one dev Fabric workspace assigned to that capacity.
- Provision supporting dev resource group(s).
- Assign `soham.karfa_knowit.se#EXT#@knowitsandbox.onmicrosoft.com` as capacity administrator.
- Give that same identity primary workspace access as Workspace Admin, confirmed by approval of the inline draft including this role.
- Use the subscription and tenant supplied in the conversation. Keep their actual IDs out of committed artifacts.

## Non-functional requirements
Dev-only scope and F2 sizing. Budget limits, scaling expectations, availability, security/compliance constraints, and operational ownership remain [NEEDS HUMAN INPUT: non-functional requirements].

## Impacted platform components
| Domain | Impacted? | Existing PLAT-* entity | Notes |
|---|---|---|---|
| landing-zone | yes | None registered | Dev subscription placement and resource group(s) |
| compute | yes | None registered | F2 capacity and assigned workspace |
| identity-security | yes | None registered | Capacity administrator and workspace RBAC |
| operations | yes | None registered | Ownership and cost constraints require clarification |
| storage | no | None registered | No additional resources requested |
| network | no | None registered | No additional resources requested |

Reference: `knowledge-model-platform-engineering/entities.index.yaml` is empty; no registered PLAT-* references are available.

## Assumptions
- The escaped underscore in the request means a literal underscore in the UPN.
- Workspace Admin is the intended primary-access role; confirmed by Stage 1 approval.

## Open questions
- [NEEDS HUMAN INPUT: resource naming requirements and mandatory tags]
- [NEEDS HUMAN INPUT: target-tenant principal object ID, if required for workspace RBAC]
- The inline draft's [NEEDS HUMAN INPUT: confirm Workspace Admin role] is resolved by the user's explicit approval of that draft, including Workspace Admin access.

## Risks
- The supplied identity's eligibility and effective access remain unverified.
- Missing operational constraints remain explicit inputs for later stages.

## Out of scope
Test/prod environments, additional capacities/workspaces, data pipelines, storage, networking, and other supporting services beyond this minimal request.

The kit produces a deployment-readiness handoff; human deployment occurs afterward. Stage 1 approval does not approve any later stage or cloud action.
