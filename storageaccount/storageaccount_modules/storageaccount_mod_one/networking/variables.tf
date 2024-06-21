variable "provisioned_dnszone" {
  type        = string
  description = "Name of an already provisioned private dns zone whaich can be used for storage accounts."
  default     = false
}

variable "dnszone_name" {
  type        = string
  description = "Name of private dns zone"
}
