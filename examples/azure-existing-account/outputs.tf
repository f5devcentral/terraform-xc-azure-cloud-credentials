output "name" {
  value       = module.azure_cloud_credentials.name
  description = "Created XC Cloud Credentials name"
}

output "namespace" {
  value       = module.azure_cloud_credentials.namespace
  description = "The namespace in which the XC Cloud Credentials is created"
}

output "id" {
  value       = module.azure_cloud_credentials.id
  description = "ID of the created XC Cloud Credentials"
}
