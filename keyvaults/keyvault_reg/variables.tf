variable "sku_name" {
  type        = string
  description = "Name of Key Vault sku."
}

variable "location" {
  type        = string
  description = "Teh Azure region where Key Vault exists"
}

variable "soft_delete_retention_days" {
  type        = number
  description = "Number of days to hold items from this Vault when its deleted"
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Is purge protection enabled on Key Vault."
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Is Key Vault enabled for disk encryption"
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "Is Key Vault enabled for RBAC"
}

variable "enabled_for_deployment" {
  type        = bool
  description = "Is Key Vault enabled for deployment."
}

variable "bypass" {
  type        = string
  description = "Services allowed access through firewall."
}

variable "default_action" {
  type        = string
  description = "Allow or deny public access to Key Vault."
}

variable "ip_rules" {
  description = "A list of IPs allowd access through firewall."
  type        = list(string)
}

variable "enabled_for_template_deployment" {
  type        = string
  description = "Specifies if Key Vault is enabled for Resource Manager."
}

variable "rgnames" {
  type        = list(string)
  description = "Names of resource groups."
  default     = ["aoa_rg", "tfakazurepub-rg"]
}

variable "is_manual_connection" {
  type        = string
  description = "Whether approval is required or not."
}

variable "subresource_names" {
  type        = list(string)
  description = "Azure resources allowed to connec to private endpoint."
}

variable "activity_log" {
  description = "Alert rules for Key Vault"
  type = map(object({
    name        = string
    description = optional(string)

    criteria = object({
      operation_name = string
      statuses       = optional(list(string))
    })
  }))

  default = {
    createKey = {
      name        = "keyvault_key_created"
      description = "Alert for for when a Key Vault key is created in this Key Vault."

      criteria = {
        operation_name = "Microsoft.KeyVault/vaults/keys/create/action"
        statuses       = ["Succeeded", "Failed"]
      }
    }

    deleteKey = {
      name        = "keyvault_key_deleted"
      description = "Alert for for when a Key Vault key is deleted from this Key Vault."

      criteria = {
        operation_name = "Microsoft.KeyVault/vaults/keys/delete"
        statuses       = ["Succeeded", "Failed"]
      }
    }

    deleteKeyVault = {
      name        = "keyvault_deleted"
      description = "Alert rule for when this Key Vault is deleted"

      criteria = {
        operation_name = "Microsoft.KeyVault/vaults/delete"
        statuses       = ["Succeeded", "Failed"]
      }
    }
  }
}

variable "category" {
  type        = string
  description = "The category of the operation."
}
