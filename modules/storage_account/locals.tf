# Locals block project tags.
locals {
  tags = {
    managed_by  = "Terraform"
    department  = var.department
    environment = var.environment
  }

  common_name = lower(join("", [local.tags.environment, substr(local.tags.department, 0, 4)]))
}

locals {
  recource_group_name = try(data.azurerm_resource_group.rg[0].name, azurerm_resource_group.group[0].name)
}
