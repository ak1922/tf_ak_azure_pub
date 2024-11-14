variable "project_tags" {
  type        = map(string)
  description = "Project tags for resources."
}

variable "rg_name" {
  type        = string
  description = "Name of resource group."
}

variable "location" {
  type        = string
  description = "Name of Azure location."
}

variable "kv_zone_name" {
  type        = string
  description = "Name of key vault private dns zone."
}

variable "kv_link_name" {
  type        = string
  description = "Name of private dns zone virtual network link."
}

variable "client_role" {
  type        = string
  description = "Azure role for client to access key vault."
}

variable "network_id" {
  type        = string
  description = "Virtual network (vnet) ID."
}

variable "common_name" {
  type        = string
  description = "Common name for all resources."
}

variable "tenant_id" {
  type        = string
  description = "AzureRM client ID."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for service subnet."
}

variable "ip_rules" {
  description = "A list of IPv4s allowed through firewall"
  type        = list(string)
}

variable "bypass" {
  description = "Specifies whether traffic is bypassed for AzureServices. Valid options are AzureServices, or None."
  type        = string
}

variable "principal_id" {
  type        = string
  description = "Principal ID for key vault role assignment to client."
}