output "resource_group_names" {
  description = "Resource group names keyed by role."
  value       = module.landing_zone.resource_group_names
}

output "fabric_capacity_azure_resource_id" {
  description = "Azure resource ID of the Fabric capacity."
  value       = module.fabric_capacity.id
}

output "fabric_capacity_id" {
  description = "Fabric capacity GUID used by Fabric workspace resources."
  value       = local.fabric_capacity_id
}

output "fabric_workspace_ids" {
  description = "Fabric workspace IDs keyed by logical workspace key."
  value       = module.fabric_workspaces.workspace_ids
}
