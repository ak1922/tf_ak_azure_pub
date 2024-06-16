variable "rg_name" {
  description = "(optional) describe your variable"
  type        = list(string)
  default     = ["aoa_rg", "tfakazurepub-rg"]
}

variable "activity_log" {
  description = "(optional) describe your variable"
  type = map(object({
    name        = string
    description = optional(string)

    criteria = object({
      category       = string
      operation_name = string
    })
  }))

  default = {
    createA = {
      name        = "a_record_created_alert"
      description = "An alert for when an 'A' record is created in private dns zone"

      criteria = {
        category       = "Administrative"
        operation_name = "Microsoft.Network/privateDnsZones/A/write"
      }
    }

    deleteA = {
      name        = "a_record_deleted_alert"
      description = "An alert for when an 'A' record is deleted in private dns zone"

      criteria = {
        category       = "Administrative"
        operation_name = "Microsoft.Network/privateDnsZones/A/delete"
      }
    }
  }
}
