variable "address_space" {
  description = "IP address/cidr for virtual network."
  type        = list(string)
  default     = ["192.168.0.0/22"]
}

variable "subnets" {
  description = "Subnets for virtual network"
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string))

    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
  }))

  default = {
    public = {
      address_prefixes = ["192.168.0.0/24"]
    }

    service = {
      address_prefixes  = ["192.168.1.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.Keyvault"]
    }

    database = {
      address_prefixes  = ["192.168.2.0/24"]
      service_endpoints = ["Microsoft.Storage"]

      delegation = {
        name = "pgfs"
        service_delegation = {
          name    = "Microsoft.DBforPostgreSQL/flexibleServers"
          actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
      }
    }
  }
}

variable "security_rule" {
  description = "Network security rules for security groups"
  type = map(object({
    name              = string
    description       = optional(string)
    priority          = number
    source_address    = string
    destination_range = string
  }))

  default = {
    ssh = {
      name              = "SSH_block_internet"
      priority          = 100
      source_address    = "Internet"
      destination_range = "22"
      description       = "Block SSH access from the Internet"
    }

    rdp = {
      name              = "RDP_block_internet"
      priority          = 110
      source_address    = "Internet"
      destination_range = "3389"
      description       = "Block remote desktop access from the Internet"
    }
  }
}
