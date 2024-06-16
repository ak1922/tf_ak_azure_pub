# Data source AzureRM client.
data "azurerm_client_config" "current" {}

# Data source resource group.
data "azurerm_resource_group" "resource_group" {
  for_each = toset(var.rgnames)

  name = each.value
}

# Data source service subnet.
data "azurerm_subnet" "servicesub" {
  name                 = "tfakazurepub-vnet-pri-sub"
  resource_group_name  = element(var.rgnames, 1)
  virtual_network_name = "tfakazurepub-vnet"
}

# Data source storage account.
data "azurerm_storage_account" "storage" {
  name                = "akandromeda"
  resource_group_name = element(var.rgnames, 0)
}

# Data source action group.
data "azurerm_monitor_action_group" "actiongroup" {
  name                = "aksheridanknox-ag"
  resource_group_name = element(var.rgnames, 0)
}

# Data source private dns zone.
data "azurerm_private_dns_zone" "keyvault_dnszone" {
  name = "privatelink.vaultcore.azure.net"
}
