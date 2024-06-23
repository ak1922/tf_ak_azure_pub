variable "location" {
  type        = string
  description = "Azure geographic location for virtual network."
}

variable "address_space" {
  description = "Cidr block for virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "(optional) describe your variable"
  type = map(object({
    name              = string
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
    subnet1 = {
      name             = "tfakazurepub-vnet-pub-sub"
      address_prefixes = ["192.168.0.0/29"]
    }

    subnet2 = {
      name              = "tfakazurepub-vnet-pri-sub"
      address_prefixes  = ["192.168.0.128/25"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.Keyvault"]
    }

    subnet3 = {
      name              = "tfakazurepub-vnet-ppsqldb-sub"
      address_prefixes  = ["192.168.0.16/29"]
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
