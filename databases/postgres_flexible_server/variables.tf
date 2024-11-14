variable "server_version" {
  type        = string
  description = "The version of PostgresSQL Flexible Server to use."
}

variable "administrator_login" {
  type        = string
  description = "The Administrator login for the PostgresSQL Flexible Server."
}

variable "zone" {
  type        = string
  description = "Specifies the Availability Zone in which the PostgresSQL Flexible Server should be located."
}

variable "storage_mb" {
  type        = number
  description = "The max storage allowed for the PostgresSQL Flexible Server. "
}

variable "sku_name" {
  type        = string
  description = "The SKU Name for the PostgresSQL Flexible Server."
}

variable "backup_retention_days" {
  type        = number
  description = "he backup retention days for the PostgresSQL Flexible Server."
}

variable "auto_grow_enabled" {
  type        = bool
  description = "Specifies if storage auto grow for PostgresSQL Flexible Server enabled."
}

variable "day_of_week" {
  type        = number
  description = "The day of week for maintenance window, where the week starts"
}

variable "start_hour" {
  type        = number
  description = "The start hour for maintenance window."
}

variable "start_minute" {
  type        = number
  description = "The start minute for maintenance window"
}

variable "public_access" {
  type        = bool
  description = "Specifies whether this PostgreSQL Flexible Server is publicly accessible."
}

variable "location" {
  type = string
  description = "Azure location for server"
}
