output "server_id" {
  value       = azurerm_postgresql_flexible_server.server.id
  description = "The ID of Postgres flexible server."
}
