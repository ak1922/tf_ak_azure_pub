variable "rgname" {
  description = "Names of resource groups"
  type        = list(string)
  default     = ["aoa_rg", "tfakazurepub-rg"]
}

variable "key_size" {
  type        = number
  description = "Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048"
}

variable "key_type" {
  type        = string
  description = "Specifies the key type to use for this Key Vault Key"
}

variable "expire_after" {
  type        = string
  description = "Expire a Key Vault Key after given duration."
}

variable "notify_before_expiry" {
  type        = string
  description = "Notify at a given duration before expirying key"
}

variable "time_before_expiry" {
  type        = string
  description = "Rotate automatically at a duration before expiry."
}

variable "key_opts" {
  description = "A list of JSON web key operations."
  type        = list(string)
}

variable "server_version" {
  type        = number
  description = "The version of PostgreSQL Flexible Server to use."
}

variable "administrator_login" {
  type        = string
  description = "The Administrator login for the PostgreSQL Flexible Server."
}

variable "zone" {
  type        = number
  description = "Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located."
}

variable "storage_mb" {
  type        = number
  description = "The max storage allowed for the PostgreSQL Flexible Server. "
}

variable "sku_name" {
  type        = string
  description = "The SKU Name for the PostgreSQL Flexible Server."
}

variable "backup_retention_days" {
  type        = string
  description = "he backup retention days for the PostgreSQL Flexible Server."
}

variable "auto_grow_enabled" {
  type        = bool
  description = "Specifies if storage auto grow for PostgreSQL Flexible Server enabled."
}

variable "day_of_week" {
  type        = number
  description = "The day of week for maintenance window, where the week starts"
}

variable "start_hour" {
  type        = number
  description = "The start hour for maintenance window."
}

variable "start_miniute" {
  type        = number
  description = "The start minute for maintenance window"
}

variable "location" {
  type        = string
  description = "The Azure Region where the PostgreSQL Flexible Server should exist."
}

variable "role_definition_name" {
  type        = string
  description = "Name of RBAC role for User Identity."

  validation {
    condition     = contains(["Key Vault Crypto Service Encryption User", "Key Vault Administrator"], var.role_definition_name)
    error_message = "You need 'Key Vault Crypto Service Encryption User' or 'Key Vault Administrator' to create a Key Vault key."
  }
}

variable "server_extensions" {
  description = "Server extensions and custom configurations"
  type        = map(any)
  default = {
    extensions = {
      name  = "azure.extensions"
      value = "CUBE,CITEXT,BTREE_GIST"
    }
  }
}

variable "logs" {
  type        = string
  description = "Log category to be collect by diagnostic setting."
}

variable "audit" {
  type        = string
  description = "Audit records to be collected by diagnostic setting."
}

variable "metric" {
  type        = string
  description = "Metrics to be collect by diagnostic setting."
}

variable "metric_enabled" {
  type        = bool
  description = "If metric settings are enabled on diagnostic setting."
}

variable "activity_log" {
  description = "Azure monitor activity log alert rules for postgres server"
  type        = any

  default = {
    server_stop = {
      name        = "psqlsrv_stopped"
      description = "Alert rule if this server is stopped"

      criteria = {
        category       = "Administrative"
        operation_name = "Microsoft.DBforPostgreSQL/flexibleServers/stop/action"
        statuses       = ["Succeeded", "Failed"]
      }
    }

    server_restart = {
      name        = "psqlsrv_restarted"
      description = "Alert rule if this server is restarted"

      criteria = {
        category       = "Administrative"
        operation_name = "Microsoft.DBforPostgreSQL/flexibleServers/restart/action"
        statuses       = ["Succeeded", "Failed"]
      }
    }

    server_delete = {
      name        = "psqlsrv_deleted"
      description = "Alert rule if this server is restarted"

      criteria = {
        category       = "Administrative"
        operation_name = "Microsoft.DBforPostgreSQL/flexibleServers/delete"
        statuses       = ["Succeeded", "Failed"]
      }
    }

    servicehealth = {
      name        = "psqlsrv_servicehealth"
      description = "Alert rule if this server has a service health alert"

      criteria = {
        category = "ServiceHealth"
        events   = ["Incident", "ActionRequired", "Security"]
      }
    }

    resourcehealth = {
      name        = "psqlsrv_servicehealth"
      description = "Alert rule if this server has a resource health alerts"

      criteria = {
        category = "ResourceHealth"
        resource_health = {
          current  = ["Degraded", "Unavailable", "Unknown"]
          previous = ["Available"]
          reason   = ["PlatformInitiated", "UserInitiated", "Unknown"]
        }
      }
    }
  }
}
