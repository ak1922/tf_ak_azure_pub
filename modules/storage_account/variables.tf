variable "app_name" {
  type = string
  description = "Name of application using this storage account."
}

variable "rg_name" {
  type = string
  description = "Name of resource group."
}

variable "existing_rg" {
  type = string
  description = "Name of already provisioned resource group."
  default = null
}
