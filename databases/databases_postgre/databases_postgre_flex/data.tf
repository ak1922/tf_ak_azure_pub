data "azurerm_resource_group" "resource_group" {
  for_each = toset(var.rgname)
  name     = each.value
}

data "azurerm_subnet" "private_subnet" {
  name                 = "tfakazurepub-vnet-ppsqldb-sub"
  resource_group_name  = element(var.rgname, 1)
  virtual_network_name = "tfakazurepub-vnet"
}

data "azurerm_storage_account" "storage" {
  name                = "akandromeda"
  resource_group_name = element(var.rgname, 0)
}

data "azurerm_log_analytics_workspace" "log_workspace" {
  name                = "aksheridanknox-law"
  resource_group_name = element(var.rgname, 0)
}

data "azurerm_monitor_action_group" "action_group" {
  name                = "aksheridanknox-ag"
  resource_group_name = element(var.rgname, 0)
}

data "azurerm_key_vault" "keyvault" {
  name                = "tfakazurepub-kv"
  resource_group_name = element(var.rgname, 1)
}

data "azurerm_private_dns_zone" "postgres_dnszone" {
  name = "privatelink.postgres.database.azure.com"
}
