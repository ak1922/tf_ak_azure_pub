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

variable "container_delete" {
  type        = number
  description = "Number of days to hold containers after they are deleted"
}

variable "delete_retention" {
  type        = number
  description = "Number of days to hold bolbs after the deleted"
}

variable "restore_policy" {
  type        = number
  description = "Number of days a blob can be restored after its deleted."
}
