output "user_identity_id" {
  value = module.identity.user_identity_id
}

output "user_identity_role_id" {
  value = module.identity.user_identity_role_id
}

output "private_dnszone_name" {
  value = module.networking.private_dnszone_name
}

output "private_dnszone_id" {
  value = module.networking.private_dnszone_id
}

output "storage_id" {
  value = module.storage.storage_id
}

output "storage_endpoint_id" {
  value = module.networking.storage_endpoint_id
}
