# variable "entity_name" {
#   type        = string
#   description = "Name of front end application or service using storage account."
# }

variable "location" {
  type        = string
  description = "Azure geographic location/region where resource exists."
}

variable "account_tier" {
  type        = string
  description = "The account tier of the storage account."
}

variable "account_replication_type" {
  type        = string
  description = "If data is replicated across regions."
}

variable "enable_https_traffic_only" {
  type        = bool
  description = "Allow only https access to this storage account."
}

variable "default_action" {
  type        = string
  description = "Allow or deny public access to storage account."
}

variable "bypass" {
  description = "List of services allowed through firewall."
  type        = list(string)
}

variable "ip_rules" {
  description = "List of IPs allowed through firewall."
  type        = list(string)
}

variable "container_delete_retention_policy" {
  type        = number
  description = "Number of days to hold continers after they are deleted"
}

variable "delete_retention_policy" {
  type        = number
  description = "Number of days to hold bolbs after the deleted"
}

variable "restore_policy" {
  type        = number
  description = "Number of days a blob can be restored after its deleted."
}

variable "versioning_enabled" {
  description = "Specifies if versioning is enabled ob blobs"
  type        = bool
}

variable "change_feed_enabled" {
  description = "Specifies if change feed is enabled"
  type        = bool
}

variable "last_access_time_enabled" {
  type        = string
  description = "Specifies if last access is enabled."
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  description = "Is infrastructure encryption enabled on storage account"
}

variable "is_manual_connection" {
  type        = bool
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner?"
}

variable "subresource_names" {
  type        = list(string)
  description = "Subresource names which the Private Endpoint is able to connect to endppoint"
}
