**Platform Module.**\
This is a platform module that creates 22 resources including a virtual network with subnets and security groups, a Key Vault for encryption
and a Storage account and endpoints for Key Vault and Storage accounts. The ```variables.tf``` file will be a good place to start to adapt
this module for your purpose. Changing the "department" and "environment" variables should be enough for a common name for all resources.
You will also need a virtual network CIDR and three addresses for subnets. These changes can be added in the ```main.tf``` file before you
run ```terraform plan``` or ```terraform apply```. The Azure resources provisioned are listed below by module and order of creation/apply.

If you have a resource group in Azure already provisioned, and you'd rather use it, replace the ```null``` value in ```existing_rg``` variable 
with your resource group name.

**Terraform Resources**\
```azurerm_resource_group``` if needed

Network submodule\
```azurerm_virtual_network```\
```azurerm_subnet```\
```azurerm_network_security_group```

Key Vault submodule\
```azurerm_private_dns_zone```\
```azurerm_private_dns_zone_virtual_network_link```\
```azurerm_key_vault```\
```azurerm_role_assignment```\
```azurerm_private_endpoint```

Identity submodule\
```azurerm_user_assigned_identity```\
```azurerm_role_assignment```

Storage account submodule\
```azurerm_key_vault_key```\
```azurerm_private_dns_zone```\
```azurerm_private_dns_zone_virtual_network_link```\
```azurerm_storage_account```\
```azurerm_private_endpoint```\
```azurerm_storage_management_policy```

Terraform data sources\
```azurerm_client_config```\
```azurerm_resource_group``` if already provisioned.

The ```locals.tf``` file if a submodule has it can also handle further customization.

Good Luck!!!
