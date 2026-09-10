---
run_id: "2026-09-10-0000001"
stage: current-state-assessment
status: approved
approved_by: "soham karfa (user approval in conversation)"
approved_at: "2026-09-10T16:42:02+02:00"
created: "2026-09-10"
---

# Current State Assessment - Minimal Fabric development environment

## Scope of assessment
Landing zone, compute, identity/security, and operations, as approved in `01-requirement-analysis.md`.

## Platform inventory
The knowledge-model registry (`knowledge-model-platform-engineering/entities.index.yaml`) contains no entities. Domain and ADR folders contain templates only. Terraform's `local.source_entity_ids` in `iac/environments/dev/locals.tf` lists PLAT-* references, but those IDs have no registered entities.

## Spec state
| File / fields | Current recorded values |
|---|---|
| platform-spec/organization.yaml: shared.region, shared.subscriptions.dev, shared.namingConvention | Human-input markers |
| platform-spec/organization.yaml: shared.taggingPolicy.requiredTags | Environment, workload, cost center, data classification |
| platform-spec/environments/dev.yaml: platform.capacity.sku, platform.capacity.capacityId, platform.region | Human-input markers |
| platform-spec/environments/dev.yaml: platform.workspaces[0] | Workspace name, capacity reference, and domain unresolved |
| platform-spec/environments/dev.yaml: platform.identity.assignments | Template group references for administrators/developers; unresolved consumer/operator groups |
| Both specs: entity and approval references | Empty entity/decision lists; approver/date markers |

## IaC state
| Existing module | Current dev configuration |
|---|---|
| iac/modules/azure-landing-zone | Four default resource groups: platform, network, data, monitoring |
| iac/modules/fabric-capacity | Capacity resource with administrator input; SKU validation includes F2 |
| iac/modules/fabric-workspace | Workspaces assigned through capacity_id; example contains one core workspace |
| iac/modules/fabric-rbac | Principal-ID-based assignments; supports User and Admin |
| iac/modules/monitoring | Log Analytics, configurable diagnostics/alerts, and optional budget |

References: module `main.tf` files, `iac/modules/fabric-capacity/variables.tf`, `iac/modules/fabric-rbac/variables.tf`, and `iac/environments/dev/{main.tf,locals.tf,terraform.tfvars.example}`.

The dev example currently specifies `westeurope`, F32, zero-filled subscription/tenant IDs, `soham.karfa@knowit.se` as capacity administrator, and placeholder group IDs for workspace Admin/Contributor access.

## Architecture summary
The dev root connects resource groups, capacity, workspace creation, and workspace RBAC. It resolves the Fabric capacity ID through a data source unless overridden. The same root also invokes networking, storage, Key Vault, and monitoring modules; these calls were observed without expanding this assessment into those excluded domains.

## Known open items already on record
No completed questionnaire answers or build-readiness reports were found. Stage 1 retains unresolved naming/tagging requirements, operational constraints, and the target-tenant principal object ID if required. Repository inspection does not establish deployed cloud state.

No implementation or cloud changes were made during the assessment. Approval records this repository inventory, not deployment validation or approval of later stages.
