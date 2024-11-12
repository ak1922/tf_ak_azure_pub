variable "app_name" {
  type        = string
  description = "Name of sample application."
}

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

variable "keyvault_name" {
  type        = string
  description = "Name of Key Vault needed to create customer managed key"
}
