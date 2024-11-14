variable "rgname" {
  type        = list(string)
  description = "Name of resource group."
  default     = ["tfakazurepub-rg", "aoa_rg"]
}

variable "activity_log" {
  description = "(optional) describe your variable"
  type = map(object({
    name        = string
    description = optional(string)

    criteria = object({
      operation_name = string
      levels         = optional(list(string))
      statuses       = optional(list(string))
    })
  }))

  default = {
    craete_record = {
      name        = "a_record_created_postgres_dnszone"
      description = "Alert rule for private dns zone when an 'A' record is created."

      criteria = {
        operation_name = "Microsoft.Network/privateDnsZones/A/write"
        statuses       = ["Failed", "Succeeded"]
      }
    }

    delete_record = {
      name        = "a_record_deleted_postgres_dnszone"
      description = "Alert rule for private dns zone when an 'A' record is deleted."

      criteria = {
        statuses       = ["Succeeded", "Failed"]
        levels         = ["Verbose", "Warning", "Error", "Critical"]
        operation_name = "Microsoft.Network/privateDnsZones/A/delete"
      }
    }
  }
}
