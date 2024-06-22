variable "provisioned_dnszone" {
  type        = string
  description = "Name of an already provisioned private dns zone whaich can be used for storage accounts."
  default     = false
}

variable "dnszone_name" {
  type        = string
  description = "Name of private dns zone"
}

variable "app_name" {
  type        = string
  description = "Name of module's application."
}

variable "connect_resource" {
  type        = string
  description = "ID of Azure resource using private endpoint."
}

variable "is_manual_connection" {
  type        = bool
  description = "(optional) describe your variable"
}

variable "subresource_names" {
  description = "(optional) describe your variable"
  type        = list(string)
}
