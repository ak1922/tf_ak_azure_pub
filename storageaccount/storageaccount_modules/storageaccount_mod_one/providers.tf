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

module "networking" {
  source     = "./networking"
  depends_on = [module.identity]

  dnszone_name = "privatelink.blob.core.windows.net"
}
