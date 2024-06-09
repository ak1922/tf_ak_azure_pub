variable "keyvault_name" {
  type        = string
  description = "Name of Key Vault."
}

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
