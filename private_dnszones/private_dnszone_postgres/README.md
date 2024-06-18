###### Private dns zone for Postgres.
This is a 1 folder module that creates a private dns zone for Azure Postgres flexible server.
There is also an activity log alert for when A records are created in this private dns zone.
The terraform  resources to be provisioned are listed below. You will need a .tfvars file to run this module.

 - azurerm_private_dns_zone
 - azurerm_private_dns_zone_virtual_network_link
 - azurerm_monitor_activity_log_alert

Example terraform.tfvars file.
