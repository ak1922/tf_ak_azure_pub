#######################################
# Key Vault key for database server.###
#######################################
resource "azurerm_key_vault_key" "encryption_key" {
  name         = local.module_args.keyname
  key_vault_id = data.azurerm_key_vault.keyvault.id

  key_size = var.key_size
  key_type = var.key_type

  key_opts = var.key_opts

  rotation_policy {
    expire_after         = var.expire_after
    notify_before_expiry = var.notify_before_expiry

    automatic {
      time_before_expiry = var.time_before_expiry
    }
  }

  expiration_date = local.module_args.key_expiration

  tags = local.project_tags
}

###############################
# Random password for server.##
###############################
resource "random_password" "password" {
  length  = 20
  special = true
}

###########################
# User assigned identity.##
###########################
resource "azurerm_user_assigned_identity" "identity" {
  name                = local.module_args.identity_name
  location            = var.location
  resource_group_name = element(var.rgname, 1)

  tags = local.project_tags
}

##############################################
# Role assignment to Key Vault for identity.##
##############################################
resource "azurerm_role_assignment" "identity_roleassignment" {
  scope                = data.azurerm_key_vault.keyvault.id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_user_assigned_identity.identity.principal_id

  depends_on = [
    azurerm_user_assigned_identity.identity
  ]
}

#############################
# Postgres flexible server.##
#############################
resource "azurerm_postgresql_flexible_server" "postgres_server" {
  name                = local.module_args.server_name
  version             = var.server_version
  sku_name            = var.sku_name
  location            = var.location
  zone                = var.zone
  resource_group_name = element(var.rgname, 1)

  delegated_subnet_id = data.azurerm_subnet.private_subnet.id
  private_dns_zone_id = data.azurerm_private_dns_zone.postgres_dnszone.id

  storage_mb                   = var.storage_mb
  auto_grow_enabled            = var.auto_grow_enabled
  backup_retention_days        = var.backup_retention_days

  administrator_login    = var.administrator_login
  administrator_password = random_password.password.result

  maintenance_window {
    day_of_week  = var.day_of_week
    start_hour   = var.start_hour
    start_minute = var.start_miniute
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.identity.id
    ]
  }

  customer_managed_key {
    key_vault_key_id                  = azurerm_key_vault_key.encryption_key.id
    primary_user_assigned_identity_id = azurerm_user_assigned_identity.identity.id
  }

  tags = local.project_tags

  depends_on = [
    azurerm_role_assignment.identity_roleassignment
  ]
}

########################################
# Postgres flexible server extensions ##
########################################
resource "azurerm_postgresql_flexible_server_configuration" "server_config" {
  for_each = var.server_extensions

  name      = each.value.name
  value     = each.value.value
  server_id = azurerm_postgresql_flexible_server.postgres_server.id
}

##########################################
# Diagnostic seeting for Postgres server##
##########################################
resource "azurerm_monitor_diagnostic_setting" "server_diagnostics" {
  name                       = local.module_args.diagnostic_name
  target_resource_id         = azurerm_postgresql_flexible_server.postgres_server.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_workspace.id

  enabled_log {
    category_group = var.logs
  }

  enabled_log {
    category_group = var.audit
  }

  metric {
    enabled  = var.metric_enabled
    category = var.metric
  }

  storage_account_id = data.azurerm_storage_account.storage.id
}

# resource "azurerm_monitor_activity_log_alert" "alert_rule" {
#   for_each = var.activity_log

#   name                = each.value["name"]
#   description         = each.value["description"]
#   scopes              = [azurerm_postgresql_flexible_server.postgres_server.id]
#   resource_group_name = element(var.rgname, 1)

#   criteria {
#     category       = each.value.criteria.category
#     operation_name = each.value.criteria.operation_name
#     statuses       = each.value.criteria.statuses

#     service_health {
#       events = each.value.service_health.events
#     }

#     resource_health {
#       current  = each.value.resource_health.current
#       previous = each.value.resource_health.previous
#       reason   = each.value.resource_health.reason
#     }
#   }

#   action {
#     action_group_id = data.azurerm_monitor_action_group.action_group.id
#   }

#   tags = local.project_tags
# }
