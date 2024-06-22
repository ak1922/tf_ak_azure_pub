# Providers and versions.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.91.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"
}

module "identity" {
  source        = "./identity"
  app_name      = "oaks"
  location      = "eastus"
  keyvault_name = "tfakazurepub-kv"
  role          = "Key Vault Crypto Service Encryption User"
}

module "storage" {
  depends_on                 = [module.identity]
  source                     = "./storage"
  app_name                   = "oaks"
  assigned_id                = module.identity.user_identity_id
  identity_ids               = [module.identity.user_identity_id]
  key_size                   = 2048
  key_type                   = "RSA"
  keyvault_name              = "tfakazurepub-kv"
  preferred_container_delete = null
  preferred_delete_retention = null
  preferred_key_expiration   = null
  preferred_keyname          = null
  preferred_restore_policy   = null
}

module "networking" {
  source     = "./networking"
  depends_on = [module.storage]

  dnszone_name         = "privatelink.blob.core.windows.net"
  app_name             = "oaks"
  connect_resource     = module.storage.storage_id
  is_manual_connection = false
  subresource_names    = ["blob"]
}
