variable "location" {
  type        = string
  description = "Azure geographic location where user identity exists."
}

variable "role" {
  type        = string
  description = "Role assignment to Key Vault in data source to be granted to user identity."

  validation {
    condition     = contains(["Key Vault Crypto Service Encryption User", "Administrator"], var.role)
    error_message = "Your User Identity needs 'Key Vault Crypto Service Encryption User' or 'Key Vault Adminstrator' to access the Key Vault keys"
  }
}

variable "identity_name" {
  type = string
  description = "Name of user assigned identity."
}

variable "project_tags" {
  type = map(string)
  description = "Project tags for resources."
}

variable "rg_name" {
  type = string
  description = "Name of resource group."
}

variable "keyvault_id" {
  type = string
  description = "Key Vault ID for role assignment."
}
