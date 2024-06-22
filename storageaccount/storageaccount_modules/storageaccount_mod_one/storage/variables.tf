variable "keyvault_name" {
  type        = string
  description = "Name of Key Vault needed to create sustomer managed key"
}

variable "preferred_keyname" {
  type        = string
  description = "Custom name for Key Vault key for encryption."
}

variable "preferred_key_expiration" {
  type        = string
  description = "Custom date when your Key Vault key expires."
  default     = null
}

variable "key_type" {
  type        = string
  description = "Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM"
}

variable "key_size" {
  type        = number
  description = "Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048."
}

variable "app_name" {
  type        = string
  description = "Name of module's application."
}

variable "shared_access_key_enabled" {
  type        = bool
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
  default     = null
}

variable "ip_rules" {
  description = "A list of IPv4s allowed through firewall"
  type        = list(string)
  default     = []
}

variable "bypass" {
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  type        = list(string)
  default     = []
}

variable "preferred_container_delete" {
  type        = number
  description = "Specifies the number of days that the container should be retained, between 1 and 365 days"
}

variable "preferred_delete_retention" {
  type        = number
  description = " Specifies the number of days that the blob should be retained, between 1 and 365"
}

variable "preferred_restore_policy" {
  type        = number
  description = "Specifies the number of days that the blob can be restored, between 1 and 365 days."
  nullable    = true
}

variable "identity_ids" {
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account."
  type        = list(string)
}

variable "assigned_id" {
  type        = string
  description = "The ID of a user assigned identity."
}

variable "rotation_policy" {
  description = "Add a rotation policy to Key Vault key."
  type = object({
    expire_after         = optional(string, "P90D")
    time_before_expire   = optional(string, "P30D")
    notify_before_expire = optional(string, "P20D")
  })

  default = {}
}

variable "lifecycle_rules" {
  description = "Determines life cycle in storage account."
  type = map(object({
    name         = string
    prefix_match = list(string)
    blob_types   = list(string)
    base_blob = object({
      days_to_archive         = optional(number)
      days_since_modification = optional(number)
      days_to_cool            = number
    })
  }))

  default = {
    rule = {
      name         = "storage_rules"
      prefix_match = ["Default/*"]
      blob_types   = ["blockBlob"]

      base_blob = {
        days_to_archive         = 60
        days_since_modification = 90
        days_to_cool            = 30
      }
    }
  }
}

variable "enable_https_traffic_only" {
  type        = bool
  description = "Boolean flag which forces HTTPS traffic."
  default     = true
}
