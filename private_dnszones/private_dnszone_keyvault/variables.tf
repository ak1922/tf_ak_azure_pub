variable "rgnames" {
  description = "Names of provisioned resource groups."
  type        = list(string)
  default = [
    "aoa_rg",
    "tfakazurepub-rg"
  ]
}

variable "activity_log" {
  description = "Activity log alert for private dns zone."
  type = map(object({
    name        = string
    description = optional(string)

    criteria = object({
      category       = string
      operation_name = string
      levels         = optional(list(string))
      statuses       = optional(list(string))
    })
  }))

  default = {
    delete_record = {
      name        = "a_record_deleted_storage_dnszone"
      description = "Alert rule for when an 'A' record is deleted from this dns zone."

      criteria = {
        category       = "Administrative"
        operation_name = "Microsoft.Network/privateDnsZones/A/delete"
        levels         = ["Verbose", "Warning", "Error", "Critical"]
        statuses       = ["Succeeded", "Failed"]
      }
    }

    create_record = {
      name        = "a_record_created_storage_dnszone"
      description = "Alert rule for when an 'A' record is created from this dns zone."

      criteria = {
        category       = "Administrative"
        operation_name = "Microsoft.Network/privateDnsZones/A/write"
        statuses       = ["Succeeded", "Failed"]
      }
    }
  }
}
