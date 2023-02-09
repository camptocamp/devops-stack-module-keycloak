output "id" {
  description = "ID to pass other modules in order to refer to this module as a dependency."
  value       = resource.null_resource.this.id
}

output "keycloak_admin" {
  description = "Credentials for the administrator user created on deployment."
  value       = data.kubernetes_secret.admin_password.data
  sensitive   = true
}
