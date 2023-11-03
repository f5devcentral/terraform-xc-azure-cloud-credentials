output "name" {
  value       = module.azure_creds.name
  description = "Created XC Cloud Credentials name"
}

output "namespace" {
  value       = module.azure_creds.namespace
  description = "The namespace in which the XC Cloud Credentials is created"
}

output "id" {
  value       = module.azure_creds.id
  description = "ID of the created XC Cloud Credentials"
}
