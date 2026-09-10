locals {
  environment = "dev"
  source_entity_ids = [
    "PLAT-LZ-0001",
    "PLAT-COMP-0001",
    "PLAT-SEC-0001",
    "PLAT-OPS-0001",
  ]

  common_tags = merge(var.tags, {
    environment         = local.environment
    workload            = var.workload_name
    cost_center         = var.cost_center
    data_classification = var.data_classification
    owner               = "soham-karfa"
    managed_by          = "terraform"
    source_entities     = join(",", local.source_entity_ids)
  })

  resource_group_names = merge({
    platform = "rg-kd-fabric-dev-swc-001"
  }, var.resource_group_names)

  fabric_capacity_name = (
    var.fabric_capacity_name != null && var.fabric_capacity_name != ""
    ? var.fabric_capacity_name
    : "fckddevswc001"
  )

  fabric_workspaces = length(var.fabric_workspaces) > 0 ? var.fabric_workspaces : {
    core = {
      name        = "Knowit Datalytics - Dev"
      purpose     = "Initial development workspace"
      domain      = "[NEEDS HUMAN INPUT: workspace domain]"
      description = "Initial development workspace"
    }
  }

  fabric_capacity_id = (
    var.fabric_capacity_id_override != null && var.fabric_capacity_id_override != ""
    ? var.fabric_capacity_id_override
    : data.fabric_capacity.this[0].id
  )
}
