resource "random_password" "password" {
  length  = 20
  special = true
}

# Postgres flexible server
resource "azurerm_postgresql_flexible_server" "server" {
  name                          = join("", [local.common_name, "-psqlsrv"])
  version                       = var.server_version
  sku_name                      = var.sku_name
  zone                          = var.zone
  location                      = var.location
  resource_group_name           = data.azurerm_resource_group.resource_group.name

  storage_mb            = var.storage_mb
  auto_grow_enabled     = var.auto_grow_enabled
  backup_retention_days = var.backup_retention_days

  administrator_login    = var.administrator_login
  administrator_password = random_password.password.result

  maintenance_window {
    day_of_week  = var.day_of_week
    start_hour   = var.start_hour
    start_minute = var.start_minute
  }

  tags = local.project_tags
}
