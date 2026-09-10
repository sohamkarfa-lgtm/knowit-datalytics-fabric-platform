---
run_id: "2026-09-10-0000001"
stage: gap-analysis
status: approved
approved_by: "soham karfa (user approval in conversation)"
approved_at: "2026-09-10T16:45:47+02:00"
created: "2026-09-10"
---

# Gap Analysis - Minimal Fabric development environment

Inputs: approved `01-requirement-analysis.md` and `02-current-state-assessment.md` only.

## Gap register
| Gap | Requirement and current coverage | Classification |
|---|---|---|
| G1 | F2 in swedencentral: capacity module supports F2, but dev example specifies F32 in westeurope; spec fields unresolved. | PARTIAL |
| G2 | One dev workspace assigned to capacity: creation and assignment logic exist, but workspace identity and spec references unresolved. | PARTIAL |
| G3 | Supporting dev resource groups: creation logic and four defaults exist; final naming and tagging requirements unresolved. | PARTIAL |
| G4 | Supplied guest UPN as capacity administrator: input exists, but example contains a different UPN. | PARTIAL |
| G5 | Same user as Workspace Admin: module supports User/Admin, but examples use placeholder group IDs. Target principal ID and effective access unverified. | PARTIAL |
| G6 | Supplied subscription/tenant, with actual IDs excluded from committed artifacts: inputs exist, examples contain placeholders; operational configuration not established. | PARTIAL |
| G7 | Minimal scope: dev root also invokes networking, storage, Key Vault, and monitoring beyond approved scope. | CONFLICT - [CONFLICT NEEDS HUMAN RESOLUTION]; disposition recorded below |
| G8 | Budget, scaling, availability, security/compliance, and ownership: requirements unresolved; monitoring code alone does not establish constraints. | PARTIAL |

G1 and G4 example values are configuration gaps, not evidence of competing approved decisions.

### G7 approval disposition
User approved Stage 3 and stated: "if initial setup G7 is not required then hold it". Interpret this as deferring extra services not required for the initial minimal setup. The approved minimal boundary remains capacity, workspace, supporting resource group(s), and access. This does not authorize deployment of the broader scaffold or establish that all extra services are technically unnecessary. Stage 4 must assess dependencies and keep nonessential extras on hold; a necessary extra requires an explicit scope decision. The original conflict marker is preserved for traceability, with this conditional human disposition.

## Architectural impact
- G1-G3 affect compute and landing-zone configuration. Workspace assignment depends on capacity identification; capacity placement depends on resource-group configuration.
- G4-G6 affect identity/security and subscription placement. Incorrect principal or deployment-context values could prevent access or target the wrong environment.
- G7 affects the dev root resource scope. Closing it requires reconciling existing module composition with the approved minimal boundary and conditional hold above.
- G8 affects operations and security constraints.
- Stage 2 found no validated entities. Existing Terraform references lack registered design sources; no validated architectural decision can be identified as affected.

## Risks and dependencies introduced by closing each gap
| Gap | Risk / dependency | Severity |
|---|---|---|
| G1 | Region/SKU configuration must match approved requirement; deployed state remains unverified. | High |
| G2 | Capacity identification and workspace configuration must agree. | High |
| G3 | Resource naming and tagging requirements remain unresolved. | Medium |
| G4 | Identity eligibility and effective capacity access unverified. | High |
| G5 | Correct target-tenant principal ID and effective workspace access unverified. | High |
| G6 | Correct deployment context and exclusion of actual IDs from committed artifacts. | High |
| G7 | Existing root includes extra resources; conditional hold must be respected. | High |
| G8 | Operational and security constraints remain unresolved. | Undetermined pending input |

## Items requiring human input before design
- [NEEDS HUMAN INPUT: resource naming requirements and mandatory tags]
- [NEEDS HUMAN INPUT: non-functional requirements]
- G7 has a conditional human disposition above: hold extras if unnecessary for initial setup.

The target-tenant principal object ID remains an implementation/readiness dependency. It does not prevent describing the already-approved User/Admin relationship.

## Items with no gap
Existing code provides the necessary resource types and supports F2, capacity assignment, and User/Admin RBAC. No complete provisioning requirement is yet verified as satisfied.

Stage 3 approval does not authorize implementation or cloud actions.

## Approved design-input addendum
Approved by soham karfa in conversation ("approved these proposed inputs"), recorded 2026-09-10T16:51:48+02:00. This resolves the naming/tagging and operational-policy questions above to the extent listed; it does not approve Stage 4.

- Resource group: rg-kd-fabric-dev-swc-001.
- Capacity: fckddevswc001; workspace: Knowit Datalytics - Dev.
- Azure resource group and capacity tags: environment=dev, workload=fabric-platform, owner=soham-karfa, cost_center=knowit-datalytics-dev, data_classification=internal, managed_by=terraform. The cost center is an approved allocation label, not a verified finance code.
- One F2 capacity, one workspace, one supporting resource group. G7 extras held unless dependency assessment establishes a need.
- Supplied guest identity remains capacity administrator and Workspace Admin; no additional workspace assignments initially.
- Synthetic or non-sensitive development data only; no production or regulated data.
- Fixed F2; capacity increases need a separate approved change. No initial performance/concurrency guarantee.
- Best-effort development availability; planned downtime acceptable; no custom disaster recovery or recovery-time commitment.
- Soham Karfa owns access reviews, cost reviews, and operational decisions.
- Weekly consumption review during first month. Monetary budget requires a reviewed Sweden Central estimate before deployment readiness; no budget amount is inferred.
- Manual administration initially; scheduled automation and dedicated monitoring resources deferred.
- Version-controlled infrastructure configuration; development data reproducible or disposable.

Remaining inputs include target-tenant principal ID, monetary budget before readiness, and any deployment prerequisites subsequently evidenced. Approval of this addendum does not establish cloud readiness.
