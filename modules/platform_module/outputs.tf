output "user_identity_id" {
  value = module.identity.user_identity_id
}

output "service_subnet_id" {
  value = module.network.service_subnet_id
}

output "network_name" {
  value = module.network.vnet_name
}

output "network_id" {
  value = module.network.vnet_id
}

output "vault_id" {
  value = module.keyvault.vault_id
}

output "storage_account_id" {
  value = module.storage.storage_id
}
