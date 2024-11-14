# Providers and versions.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.91.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy       = true
      purge_soft_deleted_keys_on_destroy = true
    }
  }

  skip_provider_registration = "true"
}
