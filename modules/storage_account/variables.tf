variable "existing_rg" {
  type        = string
  description = "Name of resource group."
  default     = null
}

variable "create_rg" {
  type        = bool
  description = "Name of already provisioned resource group."
  default     = true
}

variable "department" {
  type        = string
  description = "Department owners of this storage account, e.g. 'Marketing', 'Credit', 'Human Resources'."
  default     = "Human Resources"
}

variable "environment" {
  type        = string
  description = "Type of project environment for storage account, e.g. 'dev', 'qa', 'prod'."
  default     = "dev"
}
