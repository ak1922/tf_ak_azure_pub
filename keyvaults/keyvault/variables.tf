variable "sku_name" {
  type        = string
  description = "Key vault sku."
}

variable "soft_delete" {
  type        = number
  description = "Number of days to hold items from this Vault when its deleted"
}

variable "purge_protect" {
  type        = bool
  description = "Is purge protection enabled on Key Vault?"
}

variable "disk_encryption" {
  type        = bool
  description = "Is Key Vault enabled for disk encryption?"
}

variable "rbac_authorization" {
  type        = bool
  description = "Is Key Vault enabled for RBAC?"
}

variable "enabled_deployment" {
  type        = bool
  description = "Is Key Vault enabled for deployment?"
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
  description = "A list of IPs allowed access through firewall."
  type        = list(string)
}

variable "template_deployment" {
  type        = string
  description = "Specifies if Key Vault is enabled for Resource Manager."
}

variable "client_role" {
  type        = string
  description = "Role for Key vault administration."
}
