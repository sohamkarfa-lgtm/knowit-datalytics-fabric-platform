module "landing_zone" {
  source = "../../modules/azure-landing-zone"

  environment                                = local.environment
  location                                   = var.location
  subscription_id                            = var.subscription_id
  management_group_id                        = var.management_group_id
  associate_subscription_to_management_group = var.associate_subscription_to_management_group
  resource_group_names                       = local.resource_group_names
  workload                                   = var.workload_name
  cost_center                                = var.cost_center
  data_classification                        = var.data_classification
  tags                                       = local.common_tags
}

module "fabric_capacity" {
  source = "../../modules/fabric-capacity"

  name                   = local.fabric_capacity_name
  resource_group_name    = module.landing_zone.resource_group_names["platform"]
  location               = module.landing_zone.location
  sku_name               = var.fabric_capacity_sku_name
  administration_members = var.fabric_capacity_administration_members
  tags                   = local.common_tags
}

data "fabric_capacity" "this" {
  count = var.fabric_capacity_id_override == null || var.fabric_capacity_id_override == "" ? 1 : 0

  display_name = module.fabric_capacity.name
  depends_on   = [module.fabric_capacity]
}

module "fabric_workspaces" {
  source = "../../modules/fabric-workspace"

  capacity_id                    = local.fabric_capacity_id
  skip_capacity_state_validation = var.skip_capacity_state_validation
  enable_workspace_identity      = var.enable_workspace_identity
  workspaces                     = local.fabric_workspaces
}

module "fabric_rbac" {
  source = "../../modules/fabric-rbac"

  workspace_ids = module.fabric_workspaces.workspace_ids
  assignments   = var.fabric_workspace_rbac_assignments
}
