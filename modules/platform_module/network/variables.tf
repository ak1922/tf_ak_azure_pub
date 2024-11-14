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

variable "security_rule" {
  type = map(object({
    name              = string
    description       = optional(string)
    priority          = number
    source_address    = string
    destination_range = string
  }))

  default = {
    ssh = {
      name              = "blocksshinternet"
      priority          = 100
      source_address    = "Internet"
      destination_range = "22"
      description       = "Block SSH access from the Internet"
    }

    rdp = {
      name              = "blockrdpinternet"
      priority          = 105
      source_address    = "Internet"
      destination_range = "3389"
      description       = "Block remote desktop access from the Internet"
    }
  }
}
