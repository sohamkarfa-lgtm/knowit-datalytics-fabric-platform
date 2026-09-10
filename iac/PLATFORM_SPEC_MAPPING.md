# Platform Spec To Terraform Mapping

Use this when converting `platform-spec/organization.yaml` plus `platform-spec/environments/<env>.yaml` into Terraform variables.

## Organization-Level Inputs

| Platform spec path | Terraform target |
|---|---|
| `metadata.project` | `project_name` |
| `shared.region` | `location` |
| `shared.managementGroup` | `management_group_id` after converting name to Azure management group ID |
| `shared.subscriptions.<env>` | `subscription_id` for the matching environment |
| `shared.subscriptions` | environment folder selection under `iac/environments/` |
| `shared.taggingPolicy.requiredTags` | `tags`, `cost_center`, `data_classification`, `workload_name` |
| `shared.network.topology` | `hub_virtual_network_id`, `vnet_address_space`, and `subnets` |
| `shared.network.dnsOwner` | choose whether `create_private_dns_zones` is false and `private_dns_zone_ids` are supplied |
| `shared.network.connectivity` | `hub_virtual_network_id`, peering settings, and route/firewall follow-up variables |

## Environment-Level Inputs

| Platform spec path | Terraform target |
|---|---|
| `metadata.environment` | fixed by folder: `dev`, `test`, or `prod` |
| `platform.capacity.sku` | `fabric_capacity_sku_name` |
| `platform.capacity.capacityId` | `fabric_capacity_id_override` when the capacity already exists |
| `platform.workspaces[*].name` | `fabric_workspaces.<key>.name` |
| `platform.workspaces[*].purpose` | `fabric_workspaces.<key>.purpose` |
| `platform.workspaces[*].domain` | `fabric_workspaces.<key>.domain` |
| `platform.storage.redundancy` | `storage_replication_type` |
| `platform.storage.zones` | storage module `container_names` and `storage_lifecycle_rules` |
| `platform.network.posture` | `storage_public_network_access_enabled`, `key_vault_public_network_access_enabled`, private endpoint inputs |
| `platform.network.publicAccess` | public network and firewall exception variables |
| `platform.identity.assignments[*].groupRef` | resolve to principal IDs before writing `fabric_workspace_rbac_assignments` |
| `platform.identity.assignments[*].role` | map to Fabric roles: `administrator` -> `Admin`, `developer` -> `Contributor`, `operator` -> `Member`, `consumer` -> `Viewer` |
| `approval.approvedAt` | tag or release metadata outside Terraform state, unless an approved tag convention is added |

## Current Deliberate Gaps

- `platform-spec/` uses group display names, while `fabric_workspace_role_assignment` requires principal IDs.
- `platform-spec/` has no explicit budget field; keep budget values in `monthly_budget_amount`, `budget_alert_threshold`, and `budget_contact_emails`.
- Fabric items such as lakehouses, notebooks, pipelines, and semantic models are intentionally excluded until the workspace foundation is deployed.
- Private DNS is modeled as centrally owned by default. Supply `private_dns_zone_ids` unless the platform team is explicitly allowed to create zones.

## Minimal dev contract

For dev, use platform-spec/environments/dev.yaml and its validated
PLAT-LZ-0001, PLAT-COMP-0001, PLAT-SEC-0001, and PLAT-OPS-0001 sources.
Do not fill dev values from unresolved organization-level placeholders.

| Dev spec field | Terraform mapping |
|---|---|
| platform.region | location |
| platform.resourceGroups | resource_group_names |
| platform.tags | tags and workload_name/cost_center/data_classification |
| platform.capacity.name | fabric_capacity_name |
| platform.capacity.sku | fabric_capacity_sku_name |
| platform.capacity.administrationMembers | fabric_capacity_administration_members |
| platform.capacity.capacityId | fabric_capacity_id_override; null enables discovery |
| platform.workspaces[0] | fabric_workspaces.core |
| platform.identity.assignments[0].principalRef | Resolve approved UPN to target-tenant principal_id locally |
| platform.identity.assignments[0].principalType | principal_type = User |
| platform.identity.assignments[0].role | administrator maps to Admin |
| platform.storage.enabled = false | No storage module call in dev |
| platform.network.enabled = false | No networking module call in dev |
| platform.operations | Operating policy and readiness prerequisites; no monitoring/budget resources |

capacityRef identifies the capacity logically; workspace assignment uses
the resolved Fabric GUID, never the Azure resource ID. The initial single
assignment targets workspace key core. Workspace managed identity is
disabled per PLAT-COMP-0001. Workspace domain remains metadata only.

The additional source_entities tag records validated design provenance.
Actual subscription, tenant, and principal IDs remain outside committed files.
