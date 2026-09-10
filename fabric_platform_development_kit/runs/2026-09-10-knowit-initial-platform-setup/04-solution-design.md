---
run_id: "2026-09-10-0000001"
stage: solution-design
status: approved
approved_by: "soham karfa (user approval in conversation)"
approved_at: "2026-09-10T17:02:41+02:00"
created: "2026-09-10"
---

# Solution Design - Minimal Fabric development environment

## Approval record
User replied "approved" to the separate requests for the four Prompt 00 entity proposals and the Stage 4 design and implementation plan. Both approvals are recorded here. The approved entity content is saved with status validated and registered. No ADR was proposed: the initial choices are reversible. There are no parent entities to cite.

Primary input: approved `03-gap-analysis.md`, including the approved design-input addendum. The run manifest records the separately authorized Stage 5 write-scope exception.

## Design proposal
| Gaps | Domain | Approved design |
|---|---|---|
| G1, G3 | landing-zone / compute | One rg-kd-fabric-dev-swc-001 resource group and fckddevswc001 F2 capacity in swedencentral; approved tags. |
| G2 | compute | One Knowit Datalytics - Dev workspace; assign using Fabric capacity GUID; disable workspace managed identity initially. |
| G4, G5 | identity-security | Supplied guest UPN as capacity administrator; verified target-tenant object ID as User/Admin for workspace. |
| G6 | landing-zone / identity-security | Actual subscription, tenant, principal IDs and credentials excluded from committed files. |
| G7 | composition | Remove deferred networking, storage, Key Vault, and monitoring calls/references from dev root. Keep shared modules for future work. |
| G8 | operations | Manual operations, weekly cost review, fixed F2, disposable development data, best-effort availability, no custom DR commitment. |

CAF basis: consistent resource naming, ownership, and cost attribution.
WAF basis: proportionate development costs, explicit scoped identity access, reproducible changes.
Sources: https://learn.microsoft.com/en-au/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging ; https://learn.microsoft.com/en-us/azure/well-architected/cost-optimization/optimize-environment-costs ; https://learn.microsoft.com/en-us/azure/well-architected/security/identity-access

## Architecture updates
Approved Prompt 00 proposals, saved as validated:
- knowledge-model-platform-engineering/domains/landing-zone/PLAT-LZ-0001.md
- knowledge-model-platform-engineering/domains/compute/PLAT-COMP-0001.md
- knowledge-model-platform-engineering/domains/identity-security/PLAT-SEC-0001.md
- knowledge-model-platform-engineering/domains/operations/PLAT-OPS-0001.md

IDs allocated from an empty index: no prior ID -> 0001 in each domain.
Relationships: COMP -> LZ for placement; SEC -> COMP for workspace access; OPS -> LZ, COMP, SEC for operational responsibility. Storage and networking remain deferred; no future storage or private-connectivity design is established.

## Deployment strategy
Dev only. Sequence resource group -> capacity -> workspace -> RBAC. Protected Terraform backend, verified principal ID, reviewed monetary budget, tenant/deployment access and applicable licensing remain readiness prerequisites. No backend resources are silently added to scope.
The kit performs no real-credential plan/apply. Human deployment follows readiness approval. Failed validation leads to scoped corrections or reversal of this run's edits; unrelated changes are preserved.

## Modular task breakdown
| # | Task | Depends on | Target files | Source gaps |
|---|---|---|---|---|
| 1 | Record approved entities and registry | Prompt 00 approval | Four entity paths above; knowledge-model-platform-engineering/entities.index.yaml | G1-G8 |
| 2 | Generate minimal dev contract with approved source references and explicit unresolved inputs | 1; spec-generator approval gate | platform-spec/environments/dev.yaml | G1-G8 |
| 3 | Retain RG/capacity/workspace/RBAC composition; remove deferred service references; align dev inputs/defaults/outputs | 2; Stage 5 proposal approval | iac/environments/dev/main.tf; iac/environments/dev/locals.tf; iac/environments/dev/variables.tf; iac/environments/dev/outputs.tf | G1-G7 |
| 4 | Provide safe approved example and describe contract mapping and prerequisites | 3 | iac/environments/dev/terraform.tfvars.example; iac/PLATFORM_SPEC_MAPPING.md; iac/README.md; README.md | G1-G8 |
| 5 | Validate references, scope and Terraform; record missing tooling/inputs | 2-4; applicable stage gate | No additional implementation files | G1-G8 |

No new Terraform module is needed. No populated terraform.tfvars is included; actual identifiers remain local deployment inputs. Organization/test/prod specs are not targets of this dev-only proposal. Stage 5 must raise a deviation if the current schema cannot express the approved design.

## Validation strategy
- Check formatting, Terraform validation, references, and approved file scope.
- Confirm exactly one resource group, F2 capacity, workspace and approved User/Admin assignment in intended dev configuration.
- Confirm swedencentral, names/tags, GUID capacity assignment, and workspace identity disabled.
- Confirm deferred resources are absent from dev composition and no references to removed modules remain.
- Confirm PLAT references resolve and no real identifiers/credentials/state enter committed artifacts.
- Missing tooling and unresolved readiness inputs remain explicit blockers, not permission to change deployment method.

## Explicit reuse check
Reuse iac/modules/azure-landing-zone, fabric-capacity, fabric-workspace, fabric-rbac unchanged. Existing inputs provide resource group creation, F2 sizing/administration, capacity assignment and User/Admin access. Shared networking/storage/key-vault/monitoring modules are retained but not invoked by minimal dev. Changes belong in the environment root, covered by the recorded write-scope exception.

## Approved dev-spec schema amendment
User explicitly approved the dev-spec schema extension in conversation. The existing top-level keys remain intact. The following nested extensions are authorized for platform-spec/environments/dev.yaml and documented mapping:
- platform.resourceGroups: approved resource group name.
- platform.tags: approved Azure tags.
- platform.capacity.name and administrationMembers: approved capacity name and administrator UPN.
- platform.identity.assignments[].principalRef and principalType: user reference and User type, replacing groupRef for this assignment.
- platform.storage.enabled and platform.network.enabled: explicitly exclude deferred resources.
- platform.operations: approved operating constraints and unresolved budget/backend inputs.
This resolves the Stage 5 schema deviation. It is not approval of the exact generated spec, Stage 5 file contents, or deployment. Spec-generation and Stage 5 proposal gates remain applicable.
