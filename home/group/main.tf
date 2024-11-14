# Resource group.
resource "azurerm_resource_group" "resource_group" {
  location = "eastus"
  name     = "${local.common_name}_rg"

  tags = local.project_tags
}

# Action group for notifications.
resource "azurerm_monitor_action_group" "action_group" {
  name                = "${local.common_name}_ag"
  resource_group_name = azurerm_resource_group.resource_group.name
  short_name          = "azpubag"

  email_receiver {
    email_address = "hello@terraform.com"
    name          = "adminemail"
  }
  tags = local.project_tags
}
