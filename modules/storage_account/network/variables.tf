variable "vnet_name" {
  type        = string
  description = "Name of virtual network."
}

variable "vnet_address" {
  type        = list(string)
  description = "IP address for virtual network."
}

variable "subnet" {
  description = "Subnets for virtual network"
  type = map(object({
    name    = string
    address = list(string)
    service = optional(list(string))
    private = optional(string)
  }))
}

variable "project_tags" {
  type        = map(string)
  description = "Project tags for resources."
}

variable "rg_name" {
  type        = string
  description = "Name of resource group."
}

variable "location" {
  type        = string
  description = "Name of Azure location."
}
